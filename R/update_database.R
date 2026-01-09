#' @export
#' @importFrom rlang .data
update_database <- function(publications, database, tb_name = "publications") {
  # Justify dbplyr use
  tmp <- dbplyr::sql("SELECT")
  rm(tmp)

  # Database connection
  con <- DBI::dbConnect(duckdb::duckdb(), database)
  # con <- DBI::dbConnect(duckdb::duckdb(), "teste.duckdb")

  # Check if table exists
  table_check <- DBI::dbExistsTable(conn = con, name = tb_name)

  if (isFALSE(table_check)) {
    # Write publications to database
    DBI::dbWriteTable(conn = con, name = tb_name, value = publications)

    # Database disconnect
    DBI::dbDisconnect(conn = con)

    # Return publications
    message("New table.")
    return(NULL)
  } else {
    # Pull current publication ids
    pubids <- dplyr::tbl(con, tb_name) |>
      dplyr::select(.data$pubid) |>
      dplyr::distinct(.data$pubid) |>
      dplyr::pull(.data$pubid)

    # Filter new publications
    new_publications <- publications |>
      dplyr::filter(!(.data$pubid %in% pubids))

    if (nrow(new_publications) == 0) {
      message("No new publications.")
      return(NULL)
    } else {
      # Write new publications to database
      DBI::dbWriteTable(
        conn = con,
        name = tb_name,
        value = new_publications,
        append = TRUE
      )

      # Database disconnect
      DBI::dbDisconnect(conn = con)

      # Return new publications
      message("Table already exists. New publications are returned.")
      return(new_publications)
    }
  }
}
