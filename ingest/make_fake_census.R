# =============================================================================
# make_fake_census.R — invent a fall census file for the IPEDS exercise
#
# Writes data/fake_fall_census.csv: 3,000 made-up students, one row each,
# with the columns an IPEDS Fall Enrollment question needs. No real person
# is in it. Re-run to regenerate; the seed makes it identical every time.
# =============================================================================

set.seed(2026)
n <- 3000

race_levels <- c("Nonresident", "Hispanic/Latino", "American Indian or Alaska Native",
                 "Asian", "Black or African American", "Native Hawaiian or Other Pacific Islander",
                 "White", "Two or more races", "Race/ethnicity unknown")

census <- data.frame(
  id             = sprintf("S%05d", seq_len(n)),
  term           = "Fall 2026",
  level          = sample(c("Undergraduate", "Graduate"), n, TRUE, c(0.8, 0.2)),
  attendance     = sample(c("Full-time", "Part-time"), n, TRUE, c(0.85, 0.15)),
  gender         = sample(c("Men", "Women"), n, TRUE),
  race           = sample(race_levels, n, TRUE,
                          c(0.06, 0.05, 0.005, 0.03, 0.07, 0.002, 0.68, 0.04, 0.063)),
  first_time     = sample(c("Y", "N"), n, TRUE, c(0.25, 0.75)),
  degree_seeking = sample(c("Y", "N"), n, TRUE, c(0.97, 0.03)),
  age            = pmax(17, round(rnorm(n, 22, 4))),
  stringsAsFactors = FALSE
)
# Only undergraduates can be first-time.
census$first_time[census$level == "Graduate"] <- "N"

out <- here::here("data", "fake_fall_census.csv")
write.csv(census, out, row.names = FALSE)
cat("Wrote", nrow(census), "rows to", out, "\n")
