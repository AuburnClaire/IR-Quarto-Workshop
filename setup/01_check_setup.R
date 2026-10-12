# =============================================================================
# 01_check_setup.R — is this machine ready for the workshop?
#
# Open this file in RStudio and click Source. It changes nothing on your
# machine except one throwaway folder in your temp directory. Each line
# prints OK or FIX with what to do. It ends with "Ready" or tells you what
# to fix. Takes about a minute (it renders two small test documents).
# =============================================================================

ok    <- function(what, detail = "") cat(sprintf("  OK   %-26s %s\n", what, detail))
fix   <- function(what, how)         cat(sprintf("  FIX  %-26s %s\n", what, how))
info  <- function(what, detail = "") cat(sprintf("  --   %-26s %s\n", what, detail))
ready <- TRUE

cat("\nIR + Quarto workshop: setup check\n\n")

# 1. R ---------------------------------------------------------------------------
rv <- getRversion()
if (rv >= "4.3.0") ok("R", paste(R.version.string, "at", R.home())) else {
  ready <- FALSE
  fix("R", paste("you have", rv, "- install the current R from https://cran.r-project.org"))
}

# 2. RStudio ---------------------------------------------------------------------
if (nzchar(Sys.getenv("RSTUDIO"))) {
  ok("RStudio", if (nzchar(Sys.getenv("RSTUDIO_VERSION"))) Sys.getenv("RSTUDIO_VERSION") else "running")
} else {
  info("RStudio", "not running inside RStudio (fine for a terminal; the workshop uses RStudio)")
}

# 3. Project folder ----------------------------------------------------------------
root <- tryCatch(here::here(), error = function(e) getwd())
if (file.exists(file.path(root, "IR-Quarto-Workshop.Rproj"))) ok("Project folder", root) else {
  ready <- FALSE
  fix("Project folder", "open IR-Quarto-Workshop.Rproj first (File > Open Project), then Source this again")
}

# 4. Packages ------------------------------------------------------------------------
need <- c("tidyverse", "janitor", "scales", "glue", "here", "readxl", "writexl",
          "quarto", "knitr", "rmarkdown", "gt", "gtExtras", "kableExtra", "flextable",
          "reactable", "DT", "patchwork", "ggrepel", "plotly", "leaflet",
          "DBI", "odbc", "dbplyr", "keyring", "renv", "educationdata")
missing <- need[!vapply(need, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing) == 0) ok("Packages", sprintf("%d checked", length(need))) else {
  ready <- FALSE
  fix("Packages", paste("missing:", paste(missing, collapse = ", "), "- Source setup/00_install_packages.R"))
}

# 5. Quarto ----------------------------------------------------------------------------
qp <- if (requireNamespace("quarto", quietly = TRUE)) quarto::quarto_path() else NULL
if (is.null(qp)) {
  ready <- FALSE
  fix("Quarto", "not found. RStudio ships it; update RStudio from https://posit.co/download/rstudio-desktop/")
} else {
  qv <- tryCatch(system2(qp, "--version", stdout = TRUE), error = function(e) "?")
  if (package_version(qv, strict = FALSE) >= "1.4") ok("Quarto", paste(qv, "at", qp)) else {
    ready <- FALSE
    fix("Quarto", paste("version", qv, "is old; update RStudio or install Quarto 1.4+ from https://quarto.org"))
  }
}

# 6. Data files -----------------------------------------------------------------------
dat <- c("data/ppd_programs.rds", "data/ppd_yearly.rds", "data/ppd_cip6_earnings.rds", "data/institutions.csv")
gone <- dat[!file.exists(file.path(root, dat))]
if (length(gone) == 0) {
  n <- tryCatch(nrow(readRDS(file.path(root, "data/ppd_programs.rds"))), error = function(e) NA)
  if (is.na(n)) { ready <- FALSE; fix("Data", "data/ppd_programs.rds would not open; re-download the project zip") }
  else ok("Data", sprintf("%s programs in data/ppd_programs.rds", format(n, big.mark = ",")))
} else {
  ready <- FALSE
  fix("Data", paste("missing:", paste(gone, collapse = ", "), "- re-download the project zip"))
}

# 7. Render test: HTML and PDF (Typst, nothing extra to install) -----------------------
if (!is.null(qp) && !("quarto" %in% missing)) {
  tmp <- file.path(tempdir(), "quarto-check"); dir.create(tmp, showWarnings = FALSE)
  qmd <- file.path(tmp, "check.qmd")
  writeLines(c("---", "title: 'Setup check'", "format:", "  html: default", "  typst: default", "---",
               "", "If you can read this, Quarto works.", "",
               "```{r}", "summary(cars)", "```"), qmd)
  res <- tryCatch({ quarto::quarto_render(qmd, output_format = "all", quiet = TRUE); TRUE },
                  error = function(e) conditionMessage(e))
  if (isTRUE(res) && file.exists(file.path(tmp, "check.html"))) ok("Render HTML", "test document rendered") else {
    ready <- FALSE; fix("Render HTML", paste("failed:", if (is.character(res)) res else "no output"))
  }
  if (isTRUE(res) && file.exists(file.path(tmp, "check.pdf"))) ok("Render PDF (Typst)", "test document rendered") else {
    ready <- FALSE; fix("Render PDF (Typst)", "HTML worked but PDF did not; tell us at the workshop, HTML is enough to start")
  }
}

# 8. For information only ------------------------------------------------------------------
if (requireNamespace("odbc", quietly = TRUE)) {
  drv <- tryCatch(unique(odbc::odbcListDrivers()$name), error = function(e) character())
  info("ODBC drivers", if (length(drv)) paste(head(drv, 6), collapse = "; ") else "none found (only matters for connecting to your own warehouse)")
}
info("Git", if (nzchar(Sys.which("git"))) Sys.which("git") else "not installed (optional)")
info("Python", if (nzchar(Sys.which("python"))) Sys.which("python") else "not found (optional; Python chunks need it)")

cat(if (ready) "\nReady. See you at the workshop. Open exercises/00_hello.qmd and click Render to try it.\n\n"
    else       "\nNot ready yet. Fix the FIX lines above, then Source this file again.\n\n")
