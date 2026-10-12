# =============================================================================
# make_ppd_tables.R — from the Department's eight raw files to four tidy tables
#
# This is the ONLY file that has to change when the Department publishes the
# official STATS results in February 2027. The reports read the tables this
# script writes to data/, never the raw files. New layout? Fix it here once;
# every report re-renders unchanged.
#
# Input:  PPD-data/*.xlsx and *.csv  (see PPD-data/README.md for the links)
# Output: data/ppd_programs.rds       one row per program (opeid6 x credlev x cip4)
#         data/ppd_yearly.rds         one row per program per award year, 2016-2025
#         data/ppd_institution_yearly.rds  institution-level enrollment by year
#         data/ppd_cip6_earnings.rds  3-year earnings at 6-digit CIP
#         data/institutions.csv       one row per institution: the UNITID lookup
#
# Run: open in RStudio, click Source. About 3 minutes the first time (it caches
# the Excel reads in PPD-data/cache/), under a minute after that.
#
# What it does to the data, and nothing else:
#   1. "privacy suppressed" (the Department's text marker) becomes NA.
#   2. Columns that should be numbers become numbers.
#   3. Yearly columns (name_2016 ... name_2025) are stacked into long form.
#   4. Four derived columns are added and documented in data/codebook.csv:
#      cip4_code, earnings_test, earnings_margin, earnings_margin_pct.
#   5. Commas lost from CIP titles in the raw files are restored.
# The Department's own privacy rounding (counts of 10-19 shown as 15) is
# left exactly as published.
# =============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(readxl)
  library(stringr)
  library(here)
})

raw_dir   <- here("PPD-data")
cache_dir <- here("PPD-data", "cache")
out_dir   <- here("data")
dir.create(cache_dir, showWarnings = FALSE)
dir.create(out_dir,   showWarnings = FALSE)

# ---- 1. Read (cached) ---------------------------------------------------------

read_cached <- function(pattern) {
  f <- list.files(raw_dir, pattern = pattern, full.names = TRUE)
  if (length(f) != 1) stop("Expected one file matching '", pattern, "' in PPD-data/, found ", length(f))
  rds <- file.path(cache_dir, sub("\\.xlsx$", ".rds", basename(f)))
  if (file.exists(rds)) return(readRDS(rds))
  message("Reading ", basename(f), " (slow the first time) ...")
  d <- read_excel(f, guess_max = 300000)
  saveRDS(d, rds, compress = "xz")
  d
}

f_inst  <- read_cached("institution-characteristics-and-completions")
f_enrl  <- read_cached("enrollments")
f_aid1  <- read_cached("financial-aid-part-1")
f_aid2  <- read_cached("financial-aid-part-2")
f_aid3  <- read_cached("financial-aid-part-3")
f_earn  <- read_cached("debt-earnings-and-earnings-test-metrics")
f_cip6  <- read_cached("program-earnings-3yr")

keys <- c("opeid6", "credlev", "cip4")

# ---- 2. Suppression marker -> NA, numbers -> numeric ----------------------------

# Columns that are genuinely text. Everything else is numeric in the codebook.
text_cols <- c("instnm", "city", "stabbr", "zip5", "preddeg", "control",
               "cip2_title", "cip4_title", "cip6_title", "credlev",
               "which_test_cip2_wageb", "ge_earn_test_2023_fail", "ge_earn_test_algn_fail")

n_suppressed <- 0L
to_numeric <- function(d) {
  for (v in setdiff(names(d), text_cols)) {
    x <- d[[v]]
    if (is.character(x)) {
      sup <- !is.na(x) & str_detect(str_to_lower(x), "suppress")
      n_suppressed <<- n_suppressed + sum(sup)
      x[sup] <- NA
      bad <- !is.na(x) & is.na(suppressWarnings(as.numeric(x)))
      if (any(bad)) stop("Column ", v, " has unexpected text: ", paste(head(unique(x[bad]), 3), collapse = " | "))
      d[[v]] <- as.numeric(x)
    }
  }
  d
}

f_inst <- to_numeric(f_inst)
f_enrl <- to_numeric(f_enrl)
f_aid1 <- to_numeric(f_aid1)
f_aid2 <- to_numeric(f_aid2)
f_aid3 <- to_numeric(f_aid3)
f_earn <- to_numeric(f_earn)
f_cip6 <- to_numeric(f_cip6)
message(format(n_suppressed, big.mark = ","), " cells were 'privacy suppressed' and are now NA")

# ---- 3. Check the keys before joining ----------------------------------------------

check_keys <- function(d, nm) {
  if (nrow(d) != 209321) warning(nm, ": expected 209,321 rows, got ", nrow(d))
  if (anyDuplicated(d[keys])) stop(nm, ": duplicate opeid6 x credlev x cip4 keys")
  invisible(TRUE)
}
check_keys(f_inst, "institution file"); check_keys(f_enrl, "enrollment file")
check_keys(f_aid1, "aid 1"); check_keys(f_aid2, "aid 2"); check_keys(f_aid3, "aid 3")
check_keys(f_earn, "earnings file")

# The five repeated identifier columns are identical across files; keep one copy.
shared <- c("instnm", "stabbr", "fips", "exists_in_2024_or_2025", "cip2", "cip2_title", "cip4_title")
drop_shared <- function(d) d %>% select(-any_of(shared))

wide <- f_inst %>%
  left_join(drop_shared(f_enrl), by = keys) %>%
  left_join(drop_shared(f_aid1), by = keys) %>%
  left_join(drop_shared(f_aid2), by = keys) %>%
  left_join(drop_shared(f_aid3), by = keys) %>%
  left_join(drop_shared(f_earn), by = keys)
stopifnot(nrow(wide) == 209321)

# ---- 4. The yearly table (long) ---------------------------------------------------------

yearly_measures <- c(
  "t4enrl_prg", "t4completers", "t4noncompleters", "t4noncomplete_rate",
  "pell_stu_count", "pell_vol",
  "loan_stu_count", "loan_vol_total",
  "loan_stu_count_sub_ug", "loan_vol_sub_ug",
  "loan_stu_count_unsub_ug", "loan_vol_unsub_ug",
  "loan_stu_count_unsub_gr", "loan_vol_unsub_gr",
  "loan_stu_count_grad_plus_gr", "loan_vol_grad_plus_gr",
  "loan_stu_count_par_plus_ug", "loan_vol_par_plus_ug"
)
yearly_cols <- grep(paste0("^(", paste(yearly_measures, collapse = "|"), ")_20[0-9]{2}$"), names(wide), value = TRUE)

ppd_yearly <- wide %>%
  select(all_of(keys), all_of(yearly_cols)) %>%
  pivot_longer(all_of(yearly_cols), names_to = c("measure", "award_year"),
               names_pattern = "^(.*)_(20[0-9]{2})$", values_to = "value") %>%
  filter(!is.na(value)) %>%
  pivot_wider(names_from = measure, values_from = value) %>%
  mutate(award_year = as.integer(award_year),
         award_year_label = paste0(award_year - 1, "-", substr(award_year, 3, 4)),
         across(c(opeid6, cip4, award_year), as.integer),
         across(all_of(setdiff(yearly_measures, "t4noncomplete_rate")), as.integer)) %>%
  select(opeid6, credlev, cip4, award_year, award_year_label, any_of(yearly_measures)) %>%
  arrange(opeid6, credlev, cip4, award_year)

# Institution-level enrollment by year (repeated on every program row in the raw file).
inst_yearly_cols <- grep("^t4enrl_(ug|gr)_inst_(instate|outstate)_20[0-9]{2}$", names(wide), value = TRUE)
ppd_institution_yearly <- wide %>%
  select(opeid6, all_of(inst_yearly_cols)) %>%
  distinct() %>%
  pivot_longer(-opeid6, names_to = c("measure", "award_year"),
               names_pattern = "^(.*)_(20[0-9]{2})$", values_to = "value") %>%
  filter(!is.na(value)) %>%
  pivot_wider(names_from = measure, values_from = value) %>%
  mutate(award_year = as.integer(award_year), opeid6 = as.integer(opeid6)) %>%
  arrange(opeid6, award_year)

# ---- 5. The program table (one row per program) ----------------------------------------------

ppd_programs <- wide %>%
  select(-all_of(yearly_cols), -all_of(inst_yearly_cols), -matches("^yes_ge_20")) %>%
  mutate(
    across(c(opeid6, unitid, cip2, cip4, fips), as.integer),
    cip4_code = sprintf("%02d.%02d", cip4 %/% 100, cip4 %% 100),
    # The raw files dropped the commas from CIP titles and left two spaces
    # behind ("Education  Other"). Put the commas back, drop the final period.
    cip4_title = str_remove(str_replace_all(cip4_title, "  ", ", "), "\\.$"),
    cip2_title = str_remove(str_replace_all(cip2_title, "  ", ", "), "\\.$"),
    # latest-year snapshot, pulled back from the yearly columns for convenience
    t4enrl_prg_2025   = wide$t4enrl_prg_2025,
    t4enrl_prg_2024   = wide$t4enrl_prg_2024,
    t4completers_2025 = wide$t4completers_2025,
    pell_stu_count_2025 = wide$pell_stu_count_2025,
    loan_stu_count_2025 = wide$loan_stu_count_2025,
    loan_vol_total_2025 = wide$loan_vol_total_2025,
    # the four derived columns
    earnings_test = case_when(
      mstr_obbb_fail_cip2_wageb == 1 ~ "Fail",
      mstr_obbb_fail_cip2_wageb == 0 ~ "Pass",
      TRUE                           ~ "Not tested"),
    earnings_margin     = md_earn_wne_p4 - earn_bnchmrk_cip2_wageb,
    earnings_margin_pct = earnings_margin / earn_bnchmrk_cip2_wageb
  ) %>%
  relocate(cip4_code, .after = cip4) %>%
  relocate(earnings_test, earnings_margin, earnings_margin_pct, .after = mstr_obbb_fail_cip2_wageb) %>%
  arrange(opeid6, credlev, cip4)

# ---- 6. Institutions: the lookup table ------------------------------------------------------------

institutions <- ppd_programs %>%
  group_by(opeid6, unitid, instnm, city, stabbr, control, preddeg, hbcu, tribal) %>%
  summarise(
    n_programs      = n(),
    n_programs_2025 = sum(exists_in_2024_or_2025 == 1, na.rm = TRUE),
    t4enrl_2025     = sum(t4enrl_prg_2025, na.rm = TRUE),
    n_tested        = sum(earnings_test != "Not tested"),
    n_fail          = sum(earnings_test == "Fail"),
    .groups = "drop") %>%
  arrange(stabbr, instnm)
if (anyDuplicated(institutions$opeid6)) warning("an opeid6 maps to more than one institution row")

# ---- 7. CIP6 earnings ---------------------------------------------------------------------------------

ppd_cip6_earnings <- f_cip6 %>%
  mutate(across(c(opeid6, cip2, cip4, cip6), as.integer),
         cip6_code = sprintf("%02d.%04d", cip6 %/% 10000, cip6 %% 10000)) %>%
  relocate(cip6_code, .after = cip6) %>%
  arrange(opeid6, credlev, cip6)

# ---- 8. Write -------------------------------------------------------------------------------------------

saveRDS(ppd_programs,           file.path(out_dir, "ppd_programs.rds"),           compress = "xz")
saveRDS(ppd_yearly,             file.path(out_dir, "ppd_yearly.rds"),             compress = "xz")
saveRDS(ppd_institution_yearly, file.path(out_dir, "ppd_institution_yearly.rds"), compress = "xz")
saveRDS(ppd_cip6_earnings,      file.path(out_dir, "ppd_cip6_earnings.rds"),      compress = "xz")
write_csv(institutions,         file.path(out_dir, "institutions.csv"), na = "")

mb <- function(x) sprintf("%5.1f MB in memory", as.numeric(object.size(x)) / 1e6)
fmb <- function(f) sprintf("%5.1f MB on disk", file.size(file.path(out_dir, f)) / 1e6)
cat("\nWritten to data/:\n")
cat(sprintf("  %-28s %9s rows %3d cols  %s  %s\n", "ppd_programs.rds",           format(nrow(ppd_programs), big.mark = ","),           ncol(ppd_programs),           mb(ppd_programs),           fmb("ppd_programs.rds")))
cat(sprintf("  %-28s %9s rows %3d cols  %s  %s\n", "ppd_yearly.rds",             format(nrow(ppd_yearly), big.mark = ","),             ncol(ppd_yearly),             mb(ppd_yearly),             fmb("ppd_yearly.rds")))
cat(sprintf("  %-28s %9s rows %3d cols  %s  %s\n", "ppd_institution_yearly.rds", format(nrow(ppd_institution_yearly), big.mark = ","), ncol(ppd_institution_yearly), mb(ppd_institution_yearly), fmb("ppd_institution_yearly.rds")))
cat(sprintf("  %-28s %9s rows %3d cols  %s  %s\n", "ppd_cip6_earnings.rds",      format(nrow(ppd_cip6_earnings), big.mark = ","),      ncol(ppd_cip6_earnings),      mb(ppd_cip6_earnings),      fmb("ppd_cip6_earnings.rds")))
cat(sprintf("  %-28s %9s rows %3d cols\n",         "institutions.csv",           format(nrow(institutions), big.mark = ","),           ncol(institutions)))

cat("\nEarnings test, all programs:\n"); print(table(ppd_programs$earnings_test))
cat("\nSpot check, Auburn University (opeid6 1009):\n")
print(as.data.frame(institutions %>% filter(opeid6 == 1009)))
print(as.data.frame(ppd_programs %>% filter(opeid6 == 1009, earnings_test != "Not tested") %>%
  select(cip4_code, cip4_title, credlev, t4enrl_prg_2025, md_earn_wne_p4, earn_bnchmrk_cip2_wageb, earnings_test) %>%
  arrange(credlev, cip4_code) %>% head(12)))
cat("\nDone.\n")
