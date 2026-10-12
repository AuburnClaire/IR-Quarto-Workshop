# Using AI and Quarto to Transform Higher Education Data Workflows

Workshop materials. Cecile Gleizes and Claire Heacox, Auburn University
Office of Institutional Research.

You will build a report about your own institution from the U.S. Department
of Education's **2026 Program Performance Data**, the preview of the
earnings-accountability results that become official in February 2027. One
Quarto file, one parameter (your UNITID), and it renders as a web page, a
PDF, a Word document, or slides. Then you will ask an AI to extend it.

## Before the workshop

Two doors into the same room. Pick one; both work.

**Door 1: RStudio Desktop on your laptop.**

1. Install R from https://cran.r-project.org (current version).
2. Install RStudio Desktop from https://posit.co/download/rstudio-desktop/
3. Download this project as a zip and unzip it so the folder is at
   `C:\IR-Quarto-Workshop` on Windows or `~/IR-Quarto-Workshop` on a Mac.
   Same place for everyone means every instruction we give is the same for
   everyone. Double-click `IR-Quarto-Workshop.Rproj`. RStudio opens.
4. In the Files pane (bottom right) open `setup/00_install_packages.R` and
   click **Source** (top right of the editor). Wait for "Done".
5. Open `setup/01_check_setup.R`, click **Source**. It should end with
   "Ready". If it does not, read the FIX lines; we will help at the door.

**Door 2: Posit Cloud, in a browser, nothing to install.**

1. Make a free account at https://posit.cloud
2. Open the workshop link in the email. Click the project. It is already set up.

Door 2 is for this workshop's public data only. Posit Cloud is a hosted
service on servers your institution does not control. Do not put student
records there unless your institution has reviewed and approved it. The
desktop is the door you take home for FERPA work.

**Either way:** find your institution's UNITID. Open `data/institutions.csv`
and search by name, or look it up at https://nces.ed.gov/ipeds/datacenter/
Write it down. You will type it once.

## The exercises

| | File | What you do |
|---|---|---|
| 0 | `exercises/00_hello.qmd` | Render. See that it works. |
| 1 | `exercises/01_my_institution.qmd` | Type your UNITID in `params`. Render. Your institution's report. |
| 2 | `exercises/02_formats.md` | Change one line. Get Word, PDF, slides. |
| 3 | `exercises/03_render_peers.R` | Five institutions, five reports, one click. |
| 4 | `exercises/04_daydream.md` | Pick a question. Add a section. |
| 5 | `exercises/05_ai_prompts.md` | Ask an AI for the chunk. Safely. |
| 6 | `templates/ipeds/EF_fall_enrollment.qmd` | The IPEDS pattern: one question per section, checks, upload file. Tutorial in `docs/ipeds-tutorial-for-cecile.md`. |

## What is where

| Folder | Holds |
|---|---|
| `setup/` | the install script and the check script |
| `data/` | the tables the reports read, and the codebook. See `data/README.md`. |
| `ingest/` | the one script that turns the Department's files into those tables |
| `exercises/` | the workshop |
| `solutions/` | finished versions of the exercises |
| `handout/` | the printed handout, itself a Quarto document |
| `PPD-data/` | the raw files (not in git; links in its README) |

## The idea in one sentence

The logic is readable, the data never is: keep the queries, the code, the
documentation and the output in one plain-text file under version control,
and keep student records in the systems of record, read at render time.

## After the workshop

Everything here is yours to take. The data is public. When the official
STATS file arrives, change `ingest/make_ppd_tables.R` and re-render.
Questions: ir@auburn.edu
