# Workshop outline and speaker notes

*Using AI and Quarto to Transform Higher Education Data Workflows.*
Planned for 3:00; the slot is 3:30, so there is slack. Projector needed
for the three live segments.

| Time | Segment | Who | Screen | Handout |
|---|---|---|---|---|
| 0:00 | Two doors, same room | both circulate | the cloud link, large | |
| 0:15 | Why: the production model problem; the landscape; the Auburn story | Claire | slides or talk | |
| 0:35 | The toolbox tour, live in RStudio | Claire | RStudio | |
| 0:55 | IPEDS submission, question by question | Cecile | RStudio | |
| 1:10 | Break | | | |
| 1:20 | Hands-on: the STATS report, exercises 1 to 4 | both circulate | exercise steps | |
| 2:10 | AI, safely: the rule, two live prompts, then everyone | Claire | browser + RStudio | |
| 2:40 | Share-out and Quarto Pub | volunteers | their reports | |
| 2:55 | Take it home | both | | |

## 0:00 Two doors (15 min)

Say once, then stop talking: "If your check script said Ready, open
`exercises/00_hello.qmd` and click Render. Then go straight to exercise 1
in the handout. If it did not, raise a hand or open the cloud link on the
board." Fast people never wait. You and Cecile take the hands.

Common fixes: project not opened (double-click the .Rproj); packages not
installed (Source the install script, it takes minutes); R too old; locked
laptop (cloud).

## 0:15 Why (20 min)

Three beats.

1. **More reports, same staff.** Everyone nods.
2. **The landscape**. Spreadsheets and Access: where most
   of us are. BI tools: dashboards, not documents. Stats packages: stop at
   the number. Notebooks: fine, and Quarto renders them too. We chose
   RStudio because it is free, stable, Quarto comes inside it, and the IR
   community is here. Posit Cloud because nothing to install.
3. **The Auburn story.** Twenty years of Access. The logic was read out
   into plain-language rules, re-implemented, and the old and new were run
   on the same cohort and compared figure by figure. The comparison found
   three bugs the Access report had carried for years. Say the principle:
   *the logic is readable, the data never is.* Everything today follows
   from it.

## 0:35 Toolbox tour (20 min)

Live, not slides. In order:

- Open the project. Panes: editor, console, environment, files.
- Open `00_hello.qmd`. Render. Then click Source, then Visual, and say
  the line: people write in Visual, AI writes Source, same file. Then
  Run one chunk with the green arrow and point out nothing was written to
  disk; then Render and point at the file. Run is for thinking, Render is
  for the document, Publish is for the audience.
- Change `format: html` to `typst`. Render. "That is a PDF with nothing
  installed." To `docx`. To `revealjs`.
- Scroll the handout toolbox page and point: SQL chunk, Python
  chunk, Connections pane, Git tab, Terminal. Do not demo each; say they
  exist.
- Show `01_my_institution.qmd` rendered for Auburn. "This is what you are
  about to make for your institution."

## 0:55 Cecile (15 min)

Her segment. Suggested shape: one IPEDS question, the Access query that
answered it, the chunk that answers it now, the number and the query side
by side in the rendered document. Then the folder of questions. If she
wants a peer proof point: the `IPEDSuploadables` package, written at Notre
Dame, is on CRAN.

## 1:20 Hands-on (50 min)

Exercise 1: type the UNITID, render. Budget ten minutes to get everyone
there; fast people are on exercise 3 by then.

Exercise 2: formats. Five minutes. Point out the "Every current program"
section vanishes in PDF, and why (`content-visible`).

Exercise 3: five peers, one click. Let them edit the list.

Exercise 4: daydream. The rest of the block. `solutions/04_daydream_examples.qmd`
is there for anyone who wants code to copy.

Things people will hit: NA is not zero (the data page of the handout); the
margin chart gets tall for big institutions (change `fig-height`); a
program with suppressed earnings is "Not tested", not "Pass".

## 2:10 AI, safely (30 min)

Say the rule and why this dataset is the exception. Then, on the
projector:

1. Prompt 1 live. Paste five codebook lines and ask for a chunk that
   charts Pell share by year. Paste the chunk in. Render. If it fails,
   that is better: do Prompt 2 live.
2. Prompt 3 live. Paste the at-glance table, ask for three sentences for
   a provost. Read the result critically out loud. Check one number.

Then everyone: twenty minutes to extend their own report with one
AI-written section.

Optional, if time and if you have a key: the `ellmer` chunk that writes
the summary paragraph at render time. Show the key coming from `keyring`.

## 2:40 Share-out (15 min)

Three or four volunteers. Anyone who wants to publish: in the Terminal,
`quarto publish quarto-pub exercises/01_my_institution.qmd`. Public data,
so it is safe. Links go in the shared doc.

## 2:55 Take it home (5 min)

- Desktop vs cloud when you connect to your own warehouse: desktop, and
  say why. Posit Cloud is a hosted service on AWS with no FERPA statement
  we could find and no agreement with their institution unless they made
  one. It was right for today because today's data is public. Student
  records never go there without the institution's own review. The `DBI`
  and `odbc` packages are installed; `keyring` for the password.
- February 2027: the ingest script is the one file that changes.
- The repo link, the white paper, our emails.
