# Exercise 4: improve it with an AI

You have a report that renders. Now make it better without writing the
code yourself. Use whatever assistant you have: ChatGPT, Claude, Copilot,
Gemini.

## The one rule

**Share the shape of the data, never the rows.** Column names, types, the
codebook, your code: yes. Student records: never.

Today's data set is public federal data with no student-level rows, so
pasting from it is fine. That is unusual. Your own warehouse is not like
this.

## The move

1. Open `02_my_institution.qmd`. Select a chunk, or the whole file. Copy.
2. In the assistant, paste it and ask for **one** change:

> Here is a chunk from a Quarto report in R: [paste]. Change it so that
> [one thing]. Return only the chunk.

3. Paste the result back over the old chunk. Render.
4. If it fails, paste the chunk and the red error text back to the
   assistant: "Here is the error: [paste]. Fix it."

Pick one thing from this list:

- Change the chart colors to my institution's colors (give it two hex
  codes).
- Make the margin chart horizontal bars sorted the other way.
- Add a column to the test table showing the margin as a percent.
- Add a bar chart of Pell recipients by year under the enrollment chart.
- Add a section at the end with a sentence summarizing the results.
- Make the at-a-glance table two columns side by side instead of a list.

Then pick another. Each one is five minutes.

## When it answers

Read the code before you paste it. The assistant will produce confident
code that runs and is wrong. Rendering is the first test; reading the
number is the second.

Finished examples of several improvements are in
`solutions/improvement_examples.qmd`.
