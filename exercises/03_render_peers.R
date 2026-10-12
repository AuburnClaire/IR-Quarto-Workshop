# =============================================================================
# 03_render_peers.R — one template, many reports
#
# Renders exercises/01_my_institution.qmd once per institution in the list
# below and puts the files in output/. Edit the list, click Source.
#
# Find a UNITID: open data/institutions.csv (it opens in Excel or in RStudio's
# viewer) and search by name. Auburn University is 100858.
# =============================================================================

library(quarto)
library(here)

# The institutions in the room, plus two Louisiana universities.
peers <- c(
  "Auburn University"                          = 100858,
  "The University of Texas at San Antonio"     = 229027,
  "Tarleton State University"                  = 228529,
  "Albany State University"                    = 138716,
  "University of Alabama in Huntsville"        = 100706,
  "Gardner-Webb University"                    = 198561,
  "Furman University"                          = 218070,
  "Wiley University"                           = 229887,
  "Louisiana State University"                 = 159391,
  "Northwestern State University of Louisiana" = 160038
)

format <- "html"      # try "typst" for PDF, "docx" for Word

out_dir <- here("output")
dir.create(out_dir, showWarnings = FALSE)

for (nm in names(peers)) {
  file_stem <- gsub("[^A-Za-z0-9]+", "_", nm)
  ext <- switch(format, html = "html", typst = "pdf", docx = "docx", pptx = "pptx", revealjs = "html")
  out_file <- paste0(file_stem, ".", ext)
  cat("Rendering", nm, "...\n")
  quarto_render(
    input            = here("exercises", "01_my_institution.qmd"),
    output_format    = format,
    output_file      = out_file,
    execute_params   = list(unitid = peers[[nm]]),
    quiet            = TRUE
  )
  # Quarto writes next to the .qmd; move the result to output/.
  file.rename(here("exercises", out_file), file.path(out_dir, out_file))
}

cat("\nDone. Open the output/ folder.\n")
