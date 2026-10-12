# Exercise 5: the report you actually owe someone

Everything so far used our data. This one uses the shape of yours.

Think of one report you produce over and over. Not the hardest one; the
most annoying one.

1. Write down its column names and types. Not the data. The names.
2. In the assistant:

> I produce [report] for [audience] every [cadence]. Today I build it in
> [Excel / Access / SPSS] by [the steps]. The data has these columns:
> [names and types, no rows]. Outline a Quarto document that produces it,
> with a parameter for [the thing that changes each time], and write the
> first two chunks.

3. Make a new file, `my_report.qmd`, in this folder. Paste the outline in.
   Change `02_my_institution.qmd`'s YAML header to fit and paste it on top.
4. Render it with no data. Headings and empty chunks are a plan you can
   take home.

At 11:15 we will put a few plans on the screen.

## At home

- The data comes from your warehouse through `DBI::dbGetQuery()`, as in
  exercise 1's last chunk. Password in `keyring`, never in the file.
- The first version only has to match what you produce today. Compare
  them side by side once. Then it is the way.
