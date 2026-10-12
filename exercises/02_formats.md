# Exercise 2: the same report, four ways

Open `01_my_institution.qmd`. Near the top is this block:

```yaml
format:
  html:
    toc: true
    toc-depth: 2
    embed-resources: true
```

Change it, click Render, look at what you get. Change it back when you are done.

## Word

```yaml
format: docx
```

Hand it to someone who wants to edit the text. Later, add
`reference-doc: my-template.docx` under it and the output picks up your
institution's fonts, colors and heading styles.

## PDF, with nothing extra to install

```yaml
format: typst
```

Quarto ships Typst, a modern replacement for LaTeX. The first render takes a
few extra seconds. If a table is too wide for the page, the `gt` tables
still work; shorten the column labels or drop a column.

## Slides

```yaml
format: revealjs
```

Every `##` heading becomes a slide. The long tables will overflow, which is
the point: slides want fewer rows. Try adding `smaller: true` under it.

## All of them at once

```yaml
format:
  html:
    embed-resources: true
  docx: default
  typst: default
```

Then, in the RStudio Terminal tab (not the Console):

```
quarto render exercises/01_my_institution.qmd
```

One command, three files.

## What just happened

You did not change a line of code or a word of text. The content and the
container are separate. That is the whole idea.
