# =============================================================================
# 03_render_peers.R — one template, many reports
#
# Renders exercises/02_my_institution.qmd once per institution in the list
# below and puts the files in output/. Edit the list, click Source.
#
# Find any UNITID in data/institutions.csv (search by name). The list below
# is the room, Saturday, October 24, 2026, with two Louisiana universities
# for the attendee whose school is not in the federal file.
#
#   Institution                                  UNITID   OPEID6
#   Auburn University                            100858   1009
#   The University of Texas at San Antonio       229027   10115
#   Tarleton State University                    228529   3631
#   Albany State University                      138716   1544
#   University of Alabama in Huntsville          100706   1055
#   Gardner-Webb University                      198561   2929
#   Furman University                            218070   3434
#   Wiley University                             229887   3669
#   Louisiana State University                   159391   2010
#   Northwestern State University of Louisiana   160038   2021
# =============================================================================

library(quarto)
library(here)

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
    input            = here("exercises", "02_my_institution.qmd"),
    output_format    = format,
    output_file      = out_file,
    execute_params   = list(unitid = peers[[nm]]),
    quiet            = TRUE
  )
  # Quarto writes next to the .qmd; move the result to output/.
  file.rename(here("exercises", out_file), file.path(out_dir, out_file))
}

cat("\nDone. Open the output/ folder.\n")
