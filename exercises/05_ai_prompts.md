# Exercise 5: asking an AI for help, safely

Use whatever assistant you have: ChatGPT, Claude, Copilot, Gemini. The
prompts below work in any of them.

## The one rule

**Share the shape of the data, never the rows.** Column names, types, a
description, the codebook: yes. Student records: never. Aggregates can still
identify someone when groups are small, so think before pasting a table.

Today's dataset is the exception that proves the rule. PPD:2026 is a public
federal file with no student-level data, so you may paste rows from it. That
is unusual. Your own warehouse is not like this.

## Prompt 1: describe, then ask

Paste the lines from `data/codebook.csv` for the columns you want, then:

> I am writing a Quarto report in R using dplyr, ggplot2 and gt. I have a
> data frame called `tested` with one row per academic program and these
> columns: [paste]. Write one R chunk that [what you want]. Use
> `theme_minimal()`. Do not install packages. Return only the chunk.

Paste the chunk into your qmd. Render. If it fails, go to Prompt 2.

If you think in SQL, ask for SQL instead: "Write one Oracle SQL query
against a table `population` with these columns that returns ...". Put it
in a string, hand it to `dbGetQuery()`, and the rest is the same.

## Prompt 2: the error

> Here is my R chunk: [paste chunk]. Here is the error: [paste the red
> text]. What is wrong and what is the fix?

Paste only the chunk and the error. The AI does not need your whole file.

## Prompt 3: make it say something

> Here is a small table of results: [paste a table with 5 to 15 rows from
> this public dataset]. Write three sentences for a provost that state the
> main finding plainly, with no adjectives, and name the one program that
> most needs attention.

Read what comes back as a draft, not a finding. Check every number against
the table.

## Prompt 4: the report you actually owe someone

> I produce a [recurring report] for [audience] every [cadence]. Today I
> build it in [Excel / Access / SPSS] by [steps]. The data has these
> columns: [names and types, no rows]. Outline a Quarto document that
> produces it, with a parameter for [the thing that changes each time],
> and list the chunks I would need.

This one is the point of the workshop. Bring the answer home.

## What not to paste

- Student names, IDs, birthdates, or any table with a cell under 10.
- Passwords, API keys, connection strings. The assistant does not need them
  and should never see them.
- Anything under a data use agreement that says so.

## If you have an API key (optional)

The `ellmer` package calls a model from inside an R chunk, so the summary
paragraph can be generated when the report renders. It costs money per call
and the key must be stored in `keyring`, not in a file. Ask us and we will
show it on the screen.
