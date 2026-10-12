# IPEDS, one question at a time: a Quarto pattern

*A starting point for Cecile. The template that goes with this is
`templates/ipeds/EF_fall_enrollment.qmd`; it renders on fake data so the
shape is visible before any real table is involved.*

## The idea

An IPEDS survey is a list of questions. Each question has a rule ("count
students enrolled for credit on October 15, by level, by gender, by race")
and an answer (a number, or a small table of numbers). Today the rule
lives in a query, the explanation lives in someone's head or a Word
document, and the answer lives in a spreadsheet that gets typed into the
portal.

Literate programming puts the three in one place. One Quarto document per
survey component. One section per question. Inside each section: the
question as IPEDS words it, the rule in plain English, the code that
applies the rule, and the answer the code produced. Render it and you get
the submission and its documentation at once. Render it next year with the
year changed and you get next year's.

This is what the Access-to-Oracle ports in IR-SQL already do for ACHE and
the feedback reports, applied to the survey that has the most questions.

## The shape of one survey file

```
---
title: "IPEDS Fall Enrollment (EF), 2026-27"
params:
  report_year: 2026
  census_term: "202710"
---

# Setup            <- connection, parameters, the one population query
# Part A, line 1   <- question text, rule, chunk, answer
# Part A, line 2
# ...
# Checks           <- totals reconcile, prior year comparison
# Upload file      <- write what the portal wants
# Appendix         <- sessionInfo, run date, who ran it
```

Every question section has the same four pieces, always in the same
order:

1. **The question**, quoted from the survey form, in a callout box. Word
   for word, with the part and line number. When IPEDS changes the wording,
   the change is visible in the diff.
2. **The rule**, in prose. What counts, what does not, where the edge
   cases go. Written for the person who will do this after you.
3. **The chunk**, which applies the rule to the population table and
   produces the answer. Named for the question (`ef-a-1`), so an error
   says which question broke.
4. **The answer**, which is just the chunk's output: a small table in the
   rendered document, and a row appended to the upload data frame.

## Why one population query, then many small chunks

The temptation is one query per question, each with its own `WHERE`. The
pattern that holds up is one query that builds the **population** for the
survey (every student who could count, with every column any question
needs), then each question filters and counts that population in R. Two
reasons:

- Every question is guaranteed to be counting the same students. When the
  Part A total and the Part B total disagree, it is a rule difference, not
  a query difference.
- The expensive part runs once. The thirty question chunks run in
  milliseconds, and you can re-render while writing prose without hitting
  the database.

The population query is the one place the database schema appears. The
questions never mention a table name. When the SIS changes, the population
query changes; the questions do not. This is the layering argument from
the white paper, inside one file.

## Checks are chunks too

Three kinds, all cheap:

- **Internal.** The sum of the by-race rows equals the total row.
  `stopifnot()` stops the render if not, which is the point: a submission
  that does not reconcile should not render.
- **Against last year.** Read last year's upload file; show the two side
  by side with the percent change; flag anything over, say, ten percent.
  Not an error, a table a person reads before submitting.
- **Against the census.** The population count should match the frozen
  census table's count for the same term. One number, one `stopifnot()`.

The checks section is what makes the document trustworthy enough to
submit from, and it is the section that a reviewer reads first.

## The upload file

Each IPEDS component has an upload format. Two routes:

- The `IPEDSuploadables` package (Alison Lanski, Notre Dame; on CRAN)
  takes a data frame in a documented shape per component and writes the
  key-value text file the portal imports. Worth trying first; it covers
  Fall Enrollment, Completions, 12-Month Enrollment, Graduation Rates,
  Outcome Measures, HR and more.
- Or write the format yourself in the last chunk. The portal's import
  specification is a short document. A `writeLines()` call per line.

Either way the file is produced by the render, so the number in the file
is the number in the document is the number the chunk computed.

## The year rolls over in one line

`params: report_year: 2026`. Every chunk that needs the year reads
`params$report_year`. Next fall, change the one line (or pass it from a
loop) and render. The document's title, the census term, the file name,
and the prior-year comparison all follow.

## Working with ChatGPT or Claude on this

The assistant is good at exactly the step that is tedious: turning a
question and a column list into a chunk. The prompt that works:

> I am building an IPEDS Fall Enrollment submission as a Quarto document
> in R. I have a data frame `pop`, one row per enrolled student on census
> day, with these columns: [names and types, no rows]. Write one R chunk
> using dplyr that answers this question: "[paste the IPEDS question text]".
> Return a small data frame with the columns [what the upload needs]. Add
> a comment stating the rule you applied. Do not install packages.

Then read the comment. The assistant will state its interpretation of the
rule, and that is where the IR judgment goes: is "first-time" the IPEDS
definition or the Banner flag, does "full-time" mean twelve hours for
undergraduates and nine for graduates, do non-degree students count here.
Correct the comment, correct the code, keep both.

What goes in the prompt: the question text (public), column names and
types (not sensitive), the IPEDS definition if it is subtle. What never
goes in: rows from `pop`. The shape, never the data.

## A project, not just a file

Put every component in one folder with a `_quarto.yml`:

```yaml
project:
  type: website
  title: "IPEDS 2026-27"
  render:
    - EF_fall_enrollment.qmd
    - C_completions.qmd
    - E12_twelve_month.qmd
    - GR_graduation_rates.qmd
    - OM_outcome_measures.qmd
    - HR_human_resources.qmd
```

`quarto render` produces one documentation site, one page per component,
every question explained, every number shown, every check passed. That
site is the office's IPEDS documentation, and it was produced as a side
effect of doing the submission. Put it on the portal behind the IR role.

## What to build first

1. Take the component with the fewest questions. Twelve-Month Enrollment
   is small.
2. Write the population query. Just that. Run it, look at it, make it a
   chunk.
3. Pick the first question. Write the four pieces. Render. One question
   done.
4. The second question is a copy of the first with a different filter.
   The tenth is the same.
5. When the component is done, add the checks, then the upload chunk.
6. Submit from it once, by hand, comparing to what you would have
   submitted the old way. Then it is the way.

The template file shows steps 2 through 5 for three Fall Enrollment
questions on fake data. Replace the fake-data chunk with the population
query and the shape is the same.
