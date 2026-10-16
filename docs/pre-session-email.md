# Pre-session email (draft)

**Subject:** SAIR workshop A04, Saturday morning: 20 minutes of setup, and one number to look up

Hello,

Thank you for signing up for *Using AI and Quarto to Transform Higher
Education Data Workflows*, Saturday, October 24, 8:30 to 11:30 a.m., in
the Izard room at the Statehouse Convention Center. Here is what to do
before we meet so the hands-on part starts on time. Twenty minutes, mostly
waiting for downloads.

**Questions for you.** Please reply by Wednesday, October 21, so we can
shape the morning to the room. Five minutes; short answers are fine.

*1. Rate yourself on each, 1 to 4:*
1 = never used it; 2 = I can read it or edit someone else's; 3 = I write
it myself for routine work; 4 = other people come to me for it.

- Excel formulas and pivot tables
- Microsoft Access queries
- SQL
- R
- Python
- SAS, SPSS, or Stata
- Building dashboards (Tableau, Power BI, Qlik)
- Git or GitHub

*2. How do you get at your institution's data?* (choose all that apply)

- I write SQL directly against a warehouse or the student system
- Through Access linked to the database
- Through a reporting tool (Argos, Cognos, WebFOCUS, Banner reports)
- Someone else runs the extract and sends me a file
- Through dashboards built by others
- Other: ___

*3. What tools do you use to analyze and report today?* (choose all that
apply) Excel, Access, SQL Developer or similar, R, Python, SAS, SPSS,
Stata, Tableau, Power BI, Qlik, Word for the final report, other: ___

*4. Which AI assistant do you use, if any, and does your institution have
a policy on using them for work?* (ChatGPT, Claude, Copilot, Gemini,
none; policy yes / no / not sure)

*5. Are you here to convert reports you already produce, build new ones,
both, or not sure yet?*

*6. In a sentence or two, what would you most like to leave with?* A
report you want to automate, a question about the tools, a skeptical
question: anything.

*7. The laptop you will bring:* Windows, Mac, or other, and can you
install software on it?

**What we will build.** Three things. An overview of how to streamline
IPEDS and other recurring reporting. A report about *your* institution
from the Department of Education's new Program Performance Data, the
preview of the program-level earnings results that become official in
February 2027; you will leave with the report, the code, and a way to
re-run it when the official file lands. And how to use an AI to modify
code to get the reports you want.

**Setup, on the laptop you will bring.**

1. Install R: https://cran.r-project.org (pick your operating system, then
   the newest version).
2. Install RStudio Desktop: https://posit.co/download/rstudio-desktop/
3. Download the workshop project:
   https://github.com/AuburnClaire/IR-Quarto-Workshop/archive/refs/heads/main.zip
   Unzip it, rename the folder from `IR-Quarto-Workshop-main` to
   `IR-Quarto-Workshop`, and put it at `C:\IR-Quarto-Workshop` (Windows) or
   `~/IR-Quarto-Workshop` (Mac). Everyone in the same place makes the
   morning simpler. Double-click `IR-Quarto-Workshop.Rproj`.
4. In RStudio's Files pane, open `setup/00_install_packages.R` and click
   **Source**. Wait for "Done". This takes a few minutes.
5. Open `setup/01_check_setup.R`, click **Source**. It should end with
   "Ready". If it says FIX, read the line; if it is not obvious, come at
   8:15 and we will fix it together.

Nothing costs money, and you do not need administrator rights beyond
installing R and RStudio. If your laptop is locked down and even that
fails, tell us by reply so we can plan, and come at 8:15.

**One number.** You will type your institution's IPEDS UNITID once. We
looked them up for everyone registered:

| Institution | UNITID | OPEID |
|---|---|---|
| Auburn University | 100858 | 001009 |
| The University of Texas at San Antonio | 229027 | 010115 |
| Tarleton State University | 228529 | 003631 |
| Albany State University | 138716 | 001544 |
| University of Alabama in Huntsville | 100706 | 001055 |
| Gardner-Webb University | 198561 | 002929 |
| Furman University | 218070 | 003434 |
| Wiley University | 229887 | 003669 |

LSMSA is not in the federal file (it is not a Title IV institution), so
Victoria, pick a Louisiana university to stand in: LSU is 159391 and
Northwestern State in Natchitoches is 160038. Anyone else can find any
institution in `data/institutions.csv` inside the project, or at
https://nces.ed.gov/ipeds/datacenter/.

**One login.** Make sure you can sign into an AI assistant of some kind:
ChatGPT, Claude, Copilot, Gemini. Any of them. The free tier is fine.

**One report.** Think of a report you produce over and over. Bring the
column names, not the data. Part of the morning is yours to apply this to
it.

**If you work ahead,** good. Everything is in the project, including the
handout and a primer on R, Python and Quarto in the `handout` folder.
Bring what you built.

**We will not have time to get through all the details,** so you might
enjoy reading the primer once you have the project: it is at
`handout/primer.pdf` inside the folder. It covers YAML, Markdown, R in
twelve minutes, R next to Python, how Quarto chunks work, and git. About
an hour to work through, or fifteen minutes if you skim for an overview.
If you read only one section, read "R in twelve minutes."

See you Saturday, October 24th at 8:30. Bring a laptop and a charger; Bring
a short extension cord and power strip if you are able. Lunch is provided.

Cecile Gleizes and Claire Heacox
Office of Institutional Research, Auburn University

---

*Checklist before sending: decide whether to replace the GitHub zip link
with a Release zip that unzips to the right folder name (see
`docs/github-setup.md`, Step 6), which removes the rename step.*
