# Exercise 4: daydream

You have an hour's worth of report-building in front of you and a dataset
nobody on your campus has opened. Pick one question below, or your own, and
add a section to `01_my_institution.qmd`. Ask the AI for the chunk (see
`05_ai_prompts.md`). Share it at the end.

Every column is described in `data/codebook.csv`. The tables:

| Table | One row per | Use it for |
|---|---|---|
| `ppd_programs.rds` | program | everything about a program today, earnings, debt, the test |
| `ppd_yearly.rds` | program and award year | trends 2015-16 through 2024-25: enrollment, Pell, loans, completers |
| `ppd_institution_yearly.rds` | institution and award year | in-state and out-of-state Title IV enrollment |
| `ppd_cip6_earnings.rds` | program at 6-digit CIP | the finer earnings the official file will use |
| `institutions.csv` | institution | look up a UNITID or OPEID, compare institutions |

## Questions people will ask you in the next year

**Who is at risk?** Programs within 10 percent of the benchmark, either side.
`earnings_margin_pct` is already computed.

**What did the benchmark compare us to?** `which_test_cip2_wageb` names the
comparison group. Table it. Some programs were held to the national
bachelor's median, some to the state high school median.

**Graduate programs.** Master's and doctoral programs are compared with
bachelor's holders in the same field. Filter `credlev` and look at the
margins separately.

**Ten years of Pell.** From `ppd_yearly`, Pell recipients as a share of
Title IV enrollment, by year, by credential level.

**Borrowing.** `loan_vol_total` by year. Parent PLUS versus Grad PLUS. Which
programs carry the loan volume?

**Completion.** `t4noncomplete_rate` by program, trended. Which programs
improved?

**Debt against earnings.** Scatter `debt_all_stgp_eval_mdn` against
`md_earn_wne_p4`, one point per program, colored by credential level.
Remember debt is in 2019 dollars and earnings in 2024 dollars.

**Peers.** Pick five institutions from `institutions.csv` and put the same
program side by side. Or every public university in your state.

**The state.** Filter `programs` by `stabbr`. Pass and fail rates by control
and credential level across your whole state.

**Equity.** Completer demographics (`pct_cwhitt_p1819`, `pct_cbkaat_p1819`,
`pct_chispt_p1819`, `pct_ctotalw_p1819`) against earnings and the test
result.

**Repayment.** Delinquency and default by program for the one cohort that
has it (the 2015-16 repayment cohort, columns starting `p_t4_`), if your
programs are large enough to show.

**The 6-digit preview.** `ppd_cip6_earnings` has three-year earnings at the
level the official file will use. How different is your picture at 6 digits?

**The one-pager.** Four numbers and one chart on one Typst page, for the
person who will ask "so are we okay?"

## Then

Save your file under a new name in `exercises/` so you keep the original.
At 2:40 we will put a few on the screen.
