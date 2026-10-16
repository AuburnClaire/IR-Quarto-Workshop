# Using AI and Quarto to Transform Higher Education Data Workflows

Workshop materials. Cecile Gleizes and Claire Heacox, Auburn University
Office of Institutional Research. SAIR 2026, Little Rock, Saturday
October 24, 8:30 to 11:30 a.m.

Download: https://github.com/AuburnClaire/IR-Quarto-Workshop/archive/refs/heads/main.zip
(then rename the unzipped folder to `IR-Quarto-Workshop`).

You will answer an IPEDS question from a data set, then build a report
about your own institution from the U.S. Department of Education's **2026
Program Performance Data**, the preview of the earnings-accountability
results that become official in February 2027. Then you will ask an AI to
improve it, and sketch the report you actually owe someone.

## Before the workshop

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

If your laptop will not let you install anything, come fifteen minutes
early and we will work something out. (A browser-based RStudio exists,
Posit Cloud, but it is a hosted service outside your institution's control
and we do not use or support it in this workshop.)

**Then:** find your institution's UNITID. The pre-session email lists
them for everyone registered; otherwise search `data/institutions.csv`
by name.

## The exercises

| | File | What you do |
|---|---|---|
| 0 | `exercises/00_hello.qmd` | Render. See that it works. |
| 1 | `exercises/01_ipeds.qmd` | A data set, an IPEDS question, Quarto gets the answer. |
| 2 | `exercises/02_my_institution.qmd` | Type your UNITID. Render. Your institution's report. Then change one line and get a PDF. |
| 3 | `exercises/03_render_peers.R` | The room's institutions, one click. |
| 4 | `exercises/04_improve_with_ai.md` | Paste your code into an AI. Ask for one improvement. |
| 5 | `exercises/05_your_own_data.md` | Outline the report you owe someone, from your column names. |

## What is where

| Folder | Holds |
|---|---|
| `setup/` | the install script and the check script |
| `data/` | the tables the reports read, the fake census file, and the codebook. See `data/README.md`. |
| `ingest/` | the script that turns the Department's files into those tables, and the one that invents the census file |
| `exercises/` | the workshop |
| `solutions/` | a full IPEDS survey template with checks and an upload file; worked AI improvements |
| `handout/` | the printed handout and the primer, both Quarto documents |
| `docs/` | speaker notes, the IPEDS pattern explained, GitHub and email drafts |
| `PPD-data/` | the raw federal files (not in git; links in its README) |

## The idea in one sentence

The logic is readable, the data never is: keep the queries, the code, the
documentation and the output in one plain-text file under version control,
and keep student records in the systems of record, read at render time.

## After the workshop

Everything here is yours to take. The data is public. When the official
STATS file arrives, change `ingest/make_ppd_tables.R` and re-render.
Questions: ir@auburn.edu
