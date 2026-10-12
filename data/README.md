# data/ — the tables the reports read

Built from the Department of Education's raw files by
`ingest/make_ppd_tables.R`. Every column is described in `codebook.csv`.
Nothing here is student-level; it is the Department's public, privacy-
suppressed release, reshaped and nothing more.

| File | One row per | Rows | What for |
|---|---|---|---|
| `ppd_programs.rds` | program (opeid6, credlev, cip4) | 209,321 | the program today: earnings, debt, benchmark, pass/fail, demographics |
| `ppd_yearly.rds` | program and award year | 1,247,059 | trends 2015-16 to 2024-25: enrollment, completers, Pell, loans |
| `ppd_institution_yearly.rds` | institution and award year | 48,890 | in-state and out-of-state Title IV enrollment |
| `ppd_cip6_earnings.rds` | program at 6-digit CIP | 177,526 | three-year earnings at the detail the official file will use |
| `institutions.csv` | institution | 5,096 | find your UNITID; compare institutions |
| `codebook.csv` | column | | what every column means and where it came from |

Read them with:

```r
programs <- readRDS(here::here("data", "ppd_programs.rds"))
yearly   <- readRDS(here::here("data", "ppd_yearly.rds"))
inst     <- readr::read_csv(here::here("data", "institutions.csv"))
```

## Three things to know before you compute anything

1. **NA means suppressed, not zero.** The Department blanks any value built
   from fewer than 10 students (fewer than 16 for earnings, fewer than 30
   for the FAFSA-based columns). Sums over programs undercount.
2. **Counts of 10 to 19 are shown as 15.** Rates computed from them use 15.
3. **Dollars are not all the same year.** Earnings and benchmarks are in
   2024 dollars. Debt is in 2019 dollars. Yearly Pell and loan volumes are
   nominal for their year.

## Where the pass/fail comes from

`earnings_test` is `mstr_obbb_fail_cip2_wageb` spelled out: the program's
`md_earn_wne_p4` (median earnings of completers working four years after the
2017-18 and 2018-19 cohorts) compared with `earn_bnchmrk_cip2_wageb`, the
benchmark named in `which_test_cip2_wageb`. Undergraduate programs are
compared with high school graduates aged 25 to 34 in the same state;
graduate programs with bachelor's holders in the same field. This is the
Department's preview calculation, not the official February 2027 result.

## Rebuilding

Download the eight raw files (links in `PPD-data/README.md`) into
`PPD-data/`, open `ingest/make_ppd_tables.R`, click Source. When the official
STATS file is published, that script is the one file to change.
