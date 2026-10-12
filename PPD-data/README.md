# Raw files: 2026 Program Performance Data (PPD:2026)

These are the Department of Education's own files, unchanged. They are not
in the git repository because they total about 300 MB. The workshop does
not need them: `data/` holds the slim tables built from them by
`ingest/make_ppd_tables.R`. Download them only to rebuild `data/` yourself.

Source page (AHEAD committee, Session 2 materials and post-session materials):
https://www.ed.gov/laws-and-policy/higher-education-laws-and-policy/higher-education-policy/negotiated-rulemaking-for-higher-education-2025-2026

| # | File on ed.gov | Rows | What it holds |
|---|---|---|---|
| 1 | Institution Characteristics and Completions | 209,321 | institution profile, completers and non-completers by year |
| 2 | Enrollments | 209,321 | Title IV enrollment by year, completer demographics |
| 3 | Financial Aid Part 1 | 209,321 | Pell and subsidized loans by year |
| 4 | Financial Aid Part 2 | 209,321 | unsubsidized and Grad PLUS by year |
| 5 | Financial Aid Part 3 | 209,321 | Grad PLUS and Parent PLUS volume, totals by year |
| 6 | Debt, Earnings, and Earnings Test Metrics | 209,321 | earnings, debt, benchmarks, pass/fail |
| 7 | Program Earnings 3yr (OPEID, credlev, CIP6) | see log | 3-year earnings at 6-digit CIP |
| 8 | RISE Data Request (DRT8244), CSV | 193,714 | program length and loan flags, AY2025 |

Files 1 to 6 join one-to-one on `opeid6`, `credlev`, `cip4`.

Documentation, also on that page: Variable Codebook, Fact Sheet, Technical
Appendix, and the January 8, 2026 Summary of Data Supplements.

`cache/` holds the same files converted to `.rds` so the ingest script does
not re-read 300 MB of Excel every run. Delete it to force a re-read.
