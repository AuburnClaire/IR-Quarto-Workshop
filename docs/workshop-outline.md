# Workshop outline and speaker notes

*Using AI and Quarto to Transform Higher Education Data Workflows.*
SAIR 2026, pre-conference workshop A04. Saturday, October 24, 2026,
8:30 to 11:30 a.m., Izard room, Statehouse Convention Center, Little Rock.
Three hours. Projector needed.

| Clock | Segment | Who | Exercise |
|---|---|---|---|
| 8:30 | Getting everyone in | both circulate | 0 |
| 8:45 | Overview: why, the landscape, the Auburn story, the toolbox tour | Claire | |
| 9:15 | One IPEDS question | Cecile | 1 |
| 9:35 | Your institution's report from the federal data | Claire | 2 |
| 10:00 | Break | | |
| 10:10 | The room's institutions, one click | Claire | 3 |
| 10:25 | Improve it with an AI | Claire | 4 |
| 10:55 | The report you owe someone | both | 5 |
| 11:15 | Share-out and take it home | both | |

## 8:30 Getting everyone in (15 min)

Say once, then stop talking: "If your check script said Ready, open
`exercises/00_hello.qmd` and click Render. Then go straight to exercise 1
in the handout. If it did not, raise a hand." Fast people never wait. You
and Cecile take the hands.

Common fixes: project not opened (double-click the .Rproj); packages not
installed (Source the install script, it takes minutes); R too old. A
truly locked laptop: pair them with a neighbor for the morning, and they
leave with the pre-rendered report for their institution.

## 8:45 Overview (30 min)

Five minutes of why, fifteen of show-and-tell, ten of tour, all on the
projector.

**Why (5 min).** More reports, same staff. The landscape (handout):
spreadsheets and Access, where most of us are; BI tools, dashboards not
documents; stats packages, stop at the number; notebooks, fine, and Quarto
renders them too. We chose RStudio because it is free, stable, Quarto
comes inside it, and the IR community is here. Posit Cloud in one
sentence: exists, hosted outside the institution, not used today.

**What Auburn built (15 min).** Five projects, shown from your screen,
not distributed. Open each rendered file locally before the session so
nothing depends on wifi or sign-in. In this order, because the first two
are the headlines and the last three are one point each:

1. **High school feedback reports (5 min).** The before: one Access
   report printed as a single PDF of 3,500-plus pages, cut by hand into
   360-plus files, each named by hand, every year. The after: one Quarto
   template, one parameter, a loop, 360 PDFs with the right names in one
   run. Show one PDF, then the folder of them. Then say what carried
   over: the rules were read out of the Access logic and written down
   before a line was re-implemented, and the old and new were run on the
   same year and compared figure by figure. (The transfer reports got the
   same treatment and the comparison found three errors the Access
   report had carried for years; one sentence, if at all.)
2. **Faculty salary survey (4 min).** The Access-shaped problem everyone
   in the room has. Twenty-two years, forty queries run by hand in order,
   a hire date typed into one each year, last year's table name typed
   into another, ten report headers edited by hand. Say the line: *about
   four rules and thirty-five pieces of scaffolding,* and the scaffolding
   existed because Access cannot group and pivot in one query, hold two
   years in one table, or remember a date. Now: year is a column, views
   instead of make-table-then-update so nothing is ever stale, the hire
   date is computed, one Quarto file prints all ten reports. First run
   matched the published report to the dollar on 79 of 82 lines. Show the
   flagship PDF and, if there is time, the ten-row file list.
3. **Department data packets (2 min).** One PDF per department, the
   "what stands out" box written by rules from the numbers. The point:
   one template, one parameter, one loop, and a paragraph nobody had to
   write sixty times. This is exercise 3 before they have done it.
4. **Parent portal retention (2 min).** On ir-reports.auburn.edu, or the
   HTML saved locally. The same tool makes a web page, and the portal
   decides who sees it.
5. **College of Agriculture major changes (2 min).** The heatmaps, the
   rolling ten-cohort window that advances itself each August, the
   generated "about the data" box. A report that updates and documents
   itself.

Close the three with the principle: *the logic is readable, the data
never is.* Everything they just saw is plain text in a repository; the
students are in Oracle, read at render time.

**The tour (10 min), live in RStudio:**

- Open the project. Panes: editor, console, environment, files.
- Open `00_hello.qmd`. Render. Click Source, then Visual: people write in
  Visual, AI writes Source, same file. Run one chunk with the green arrow,
  nothing written to disk; Render, and point at the file. Run is for
  thinking, Render is for the document, Publish is for the audience.
- Change `format: html` to `typst`. Render. "That is a PDF with nothing
  installed."
- Scroll the handout toolbox page and point: SQL chunk, Python chunk,
  Connections pane, Git tab, Terminal. Say they exist.

## 9:15 Cecile: one IPEDS question (20 min)

Her segment. The headline for the SQL people in the room: **you do not
have to learn R to do this. R is the wrapper that runs your SQL.**

**Her show-and-tell first (5 min).** What it looks like when she builds
reporting: a real survey file on her screen, scrolled top to bottom, the
question sections, the SQL inside the chunks, the rendered page with the
green "no errors" lines, the upload file at the end. Shown, not
distributed. The line to land: this is the Access database, as a document
that runs.

**Then everyone, hands-on (15 min).** Everyone opens `01_ipeds.qmd` and renders it. On the projector she walks
the file top to bottom: the data set (a CSV of invented students), the
question quoted from the form, the rule in words, the chunk, the table.
Then the last two chunks, not run: the same thing with the data coming
from a warehouse, and the counting done in SQL instead of dplyr. Her own
chunk shape, a query in a string and `dbGetQuery()`, is on the handout
page with the Access-to-Oracle-to-Quarto table.

"Try one thing" at the bottom: change the filter and render, which
answers a different line. The point to land: thirty questions is the same
file, longer. A full survey with checks and an upload file is in
`solutions/ipeds_full_template.qmd` for anyone who wants to see it.

## 9:35 The federal data report (25 min)

Exercise 2. Everyone types their UNITID (it is in the email and in a
comment in the file) and renders. Budget ten minutes to get everyone
there. Then the last step: change `format` to `typst`, render, a PDF.
Point out the "Every current program" section vanishes, and why.

Things people will hit: NA is not zero (the data page of the handout); the
margin chart gets tall for big institutions (change `fig-height`); a
program with suppressed earnings is "Not tested", not "Pass". Furman and
Wiley have few tested programs; that is suppression, not absence.

Before the break: Auburn has zero fails. Three institutions in the room
have failing programs. The data is public, but nobody's goes on the
projector uninvited.

## 10:10 The room, one click (15 min)

Exercise 3. The list in `03_render_peers.R` is the room. Click Source,
ten reports in `output/`. Let them edit the list. This is the whole
trick behind one-PDF-per-college and one-profile-per-program.

## 10:25 Improve it with an AI (30 min)

Exercise 4. Say the rule: share the shape of the data, never the rows,
and why today's data is the exception. Then on the projector, once:
copy a chunk from exercise 2, paste it into an assistant, ask for one
change from the list, paste the result back, render. If it fails, paste
the error back. That is the whole move.

Then everyone does it, twice. Keep the asks small: colors, one more
chart, one more column, one summary sentence.
`solutions/improvement_examples.qmd` has finished versions.

## 10:55 The report you owe someone (20 min)

Exercise 5. Column names, not data, into the assistant, with the prompt
on the handout. Out comes an outline and two chunks. A new file, render it
empty, headings and all. That is a plan they take home. Circulate; this is
where the real questions come out.

## 11:15 Share-out and take it home (15 min)

Three or four volunteers, chosen by asking, never by pointing. Then:

- Connecting to your own warehouse: everything stays on your machine,
  which is the point. The `DBI` and `odbc` packages are installed;
  `keyring` for the password. If anyone asks about Posit Cloud: hosted on
  AWS, no FERPA statement we could find, no agreement with their
  institution unless they made one, so student records never go there
  without the institution's own review.
- February 2027: the ingest script is the one file that changes.
- The repo: github.com/AuburnClaire/IR-Quarto-Workshop. The white paper.
  Our emails.
