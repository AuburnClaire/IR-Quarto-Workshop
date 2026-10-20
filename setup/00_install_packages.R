# =============================================================================
# 00_install_packages.R — the IR starter kit
#
# Open this file in RStudio and click Source (top right of this pane).
# It installs every package the workshop uses, plus the ones an IR office
# is likely to want in the next year. Already-installed packages are skipped,
# so it is safe to run again. Allow 3 to 10 minutes on a normal connection.
#
# Nothing here costs money. Rtools / Xcode are NOT needed: CRAN ships
# ready-built packages for Windows and Mac.
# =============================================================================

kit <- c(

  # --- Core: data wrangling and plotting -------------------------------------
  "tidyverse",     # dplyr, tidyr, readr, ggplot2, stringr, purrr, forcats, lubridate
  "janitor",       # clean_names(), tabyl(), remove_empty()
  "scales",        # number formats: percent(), dollar(), comma()
  "glue",          # paste() that reads like a sentence
  "here",          # file paths that work on every machine and in the cloud
  "fs",            # file system helpers

  # --- Reading and writing files ---------------------------------------------
  "readxl",        # Excel in
  "writexl",       # Excel out, light
  "openxlsx",      # Excel out with formatting
  "haven",         # SAS, SPSS, Stata files
  "jsonlite",      # JSON
  "httr2",         # web APIs

  # --- Quarto and tables -----------------------------------------------------
  "quarto",        # render from R; quarto_render()
  "knitr",
  "rmarkdown",
  "gt",            # publication tables (HTML, PDF, Word)
  "gtExtras",      # sparklines and extras for gt
  "kableExtra",    # tables for PDF / LaTeX
  "flextable",     # tables for Word and PowerPoint
  "officer",       # build or edit Word and PowerPoint files from R
  "reactable",     # interactive tables, sortable and filterable
  "DT",            # interactive tables, DataTables

  # --- Charts --------------------------------------------------------------------
  "patchwork",     # combine ggplots: p1 + p2
  "ggrepel",       # labels that do not overlap
  "plotly",        # interactive charts from ggplot
  "leaflet",       # maps

  # --- Databases -----------------------------------------------------------------
  "DBI",           # the database interface
  "odbc",          # ODBC drivers: Oracle, SQL Server, Snowflake, Access
  "dbplyr",        # write dplyr, it writes the SQL
  "keyring",       # passwords in the OS credential store, never in a file

  # --- Workflow --------------------------------------------------------------
  "renv",          # lock package versions per project
  "usethis",       # project and git helpers
  "styler",        # tidy your code (RStudio Addin)
  "esquisse",      # point-and-click ggplot builder (RStudio Addin)
  "shiny",         # interactive apps

  # --- Higher education data -------------------------------------------------
  "educationdata", # IPEDS and more from the Urban Institute API
  "tidycensus",    # Census and ACS (needs a free API key to use)

  # --- AI from R (optional; needs an API key from a provider) ------------------
  "ellmer"         # chat with Claude, OpenAI, Gemini, Ollama from R code
)

# Never try to compile from source. CRAN ships ready-built binaries for
# Windows and Mac; if a binary for the very newest version is not out yet,
# this takes the newest one that is, instead of failing for want of Rtools
# or Xcode. (Rtools matters for installing packages from GitHub or for
# writing your own; not today.)
options(install.packages.compile.from.source = "never")

installed <- rownames(installed.packages())
todo      <- setdiff(kit, installed)

if (length(todo) == 0) {
  cat("\nEverything is already installed. Open setup/01_check_setup.R next.\n\n")
} else {
  cat(sprintf("\nInstalling %d package(s): %s\n\n", length(todo), paste(todo, collapse = ", ")))
  install.packages(todo, dependencies = TRUE)
  # Extras that nothing in the workshop uses. If only these fail, you are fine.
  optional <- c("tidycensus", "ellmer", "esquisse", "shiny", "leaflet", "plotly",
                "officer", "flextable", "openxlsx", "haven", "httr2", "styler", "usethis")
  still <- setdiff(kit, rownames(installed.packages()))
  if (length(still) == 0) {
    cat("\nDone. Open setup/01_check_setup.R next.\n\n")
  } else if (all(still %in% optional)) {
    cat("\nDone. These extras did not install:", paste(still, collapse = ", "),
        "\nNothing in the workshop uses them, so you are fine. Open setup/01_check_setup.R next.\n\n")
  } else {
    cat("\nThese did not install:", paste(setdiff(still, optional), collapse = ", "),
        "\nThe workshop needs them. Read the red text above for the reason, run this once more,",
        "\nor ask us at the workshop. (Extras that also failed, which do not matter:",
        paste(intersect(still, optional), collapse = ", "), ")\n\n")
  }
}
