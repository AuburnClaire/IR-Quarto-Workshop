# =============================================================================
# 02_shape_of_my_data.R — the shape of a table, without the data
#
# shape_of() prints a Markdown table of column names, types, how many rows
# are missing, and how many distinct values each column has. It never
# prints a value. Paste the output into an AI assistant, a data request, or
# a README: it says what the data looks like without saying what is in it.
#
# Open in RStudio, click Source, then in the Console:
#
#   shape_of(mtcars)                                   # any data frame
#   shape_of(read.csv("data/fake_fall_census.csv"))    # a file
#   shape_of(DBI::dbGetQuery(con, "SELECT * FROM my_schema.my_table WHERE ROWNUM <= 1000"))
#   shape_of(con, "my_schema.my_table")                # a database table, no rows read
#
# Read the output once before pasting it anywhere. A column NAMED ssn is
# itself a fact about your data.
# =============================================================================

shape_of <- function(x, table = NULL, name = deparse(substitute(x))) {

  # A database connection and a table name: describe without reading rows.
  if (inherits(x, "DBIConnection")) {
    stopifnot(!is.null(table))
    df <- DBI::dbGetQuery(x, paste("SELECT * FROM", table, "WHERE 1 = 0"))
    cat(sprintf("\n**%s**: %d columns (types from the driver; counts need rows)\n\n", table, ncol(df)))
    cat("| column | type |\n|---|---|\n")
    for (v in names(df)) cat(sprintf("| %s | %s |\n", v, class(df[[v]])[1]))
    return(invisible(df))
  }

  df <- as.data.frame(x)
  cat(sprintf("\n**%s**: %s rows, %d columns\n\n", name, format(nrow(df), big.mark = ","), ncol(df)))
  cat("| column | type | missing | distinct | note |\n|---|---|---|---|---|\n")
  for (v in names(df)) {
    col  <- df[[v]]
    type <- class(col)[1]
    miss <- sum(is.na(col))
    dist <- length(unique(col[!is.na(col)]))
    note <- if (is.numeric(col) && dist > 2) {
      sprintf("range %s to %s", format(min(col, na.rm = TRUE), big.mark = ","), format(max(col, na.rm = TRUE), big.mark = ","))
    } else if (dist == nrow(df) && nrow(df) > 1) {
      "unique per row (an identifier?)"
    } else if (dist <= 2) {
      "two or fewer values (a flag?)"
    } else ""
    cat(sprintf("| %s | %s | %s | %s | %s |\n", v, type, format(miss, big.mark = ","), format(dist, big.mark = ","), note))
  }
  invisible(df)
}

cat("shape_of() is ready. Try: shape_of(mtcars)\n")
