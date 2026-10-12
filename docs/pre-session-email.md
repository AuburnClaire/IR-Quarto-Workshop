# Pre-session email (draft)

**Subject:** Before our workshop: 20 minutes of setup, and one number to look up

Hello,

Thank you for signing up for *Using AI and Quarto to Transform Higher
Education Data Workflows*. Here is what to do before we meet so the hands-on
part starts on time. Twenty minutes, mostly waiting for downloads.

**What we will build.** A report about *your* institution from the
Department of Education's new Program Performance Data, the preview of the
program-level earnings results that become official in February 2027. You
will leave with the report, the code, and a way to re-run it when the
official file lands.

**There are two ways in. Pick one. Both work, and you can switch on the day.**

*Door 1: on your laptop (what you will use at home).*

1. Install R: https://cran.r-project.org (pick your operating system, then
   the newest version).
2. Install RStudio Desktop: https://posit.co/download/rstudio-desktop/
3. Download the workshop project: [LINK TO ZIP]. Unzip it so the folder
   sits at `C:\IR-Quarto-Workshop` (Windows) or `~/IR-Quarto-Workshop`
   (Mac). Everyone in the same place makes the day simpler. Double-click
   `IR-Quarto-Workshop.Rproj`.
4. In RStudio's Files pane, open `setup/00_install_packages.R` and click
   **Source**. Wait for "Done". This takes a few minutes.
5. Open `setup/01_check_setup.R`, click **Source**. It should end with
   "Ready". If it says FIX, read the line; if it is not obvious, come
   fifteen minutes early and we will fix it together.

Nothing costs money, and you do not need administrator rights beyond
installing R and RStudio. If your laptop is locked down and even that
fails, use Door 2.

*Door 2: in a browser, nothing to install.*

1. Make a free account at https://posit.cloud
2. Open this link: [POSIT CLOUD SPACE LINK]. Click the workshop project.
   Everything is already installed.

A word on Door 2: the workshop data is public, so the cloud is fine for the
day. It is a hosted service outside your institution's control, so it is
not where student records go. For FERPA work at home, use Door 1.

**One number.** Find your institution's IPEDS UNITID. It is in the file
`data/institutions.csv` inside the project (open it in Excel and search by
name), or at https://nces.ed.gov/ipeds/datacenter/. Write it down.

**One login.** Make sure you can sign into an AI assistant of some kind:
ChatGPT, Claude, Copilot, Gemini. Any of them. The free tier is fine.

**One report.** Think of a report you produce over and over. Bring the
column names, not the data. Part of the afternoon is yours to apply this to
it.

See you on [DATE] at [TIME] in [ROOM]. Bring a laptop and a charger.

Cecile Gleizes and Claire Heacox
Office of Institutional Research, Auburn University

---

*Checklist before sending: zip link live, Posit Cloud space link live and
tested from a non-Auburn account, date/time/room filled in.*
