ddb_read_tsv <- function(con, data_dir, table_type, verbose = TRUE) {
  files <- fs::dir_ls(data_dir, glob = paste0("*", table_type, "*.tsv"))
  if (verbose) {
    rlang::inform(c("Building table:", "*" = table_type))
    rlang::inform(c("Reading files", "*" = files))
  }
  duckdb::duckdb_read_csv(con, table_type, files = files, delim = "\t", nrow.check = 2000)
}

#' Create a duckdb database using the community notes dataset.
#'
#' @param data_dir the directory where the data files are
#' @param dbdir the directory where to create the data files
#'
#' @return the connection
#' @export
#'
build_cn_db <- function(data_dir, dbdir = data_dir) {
  db <- duckdb::duckdb(fs::path(dbdir, "cndb", ext = "duckdb"), bigint = "integer64")
  con <- duckdb::dbConnect(db)
  ddb_read_tsv(con, data_dir, "notes")
  ddb_read_tsv(con, data_dir, "ratings")
  ddb_read_tsv(con, data_dir, "noteStatusHistory")
  ddb_read_tsv(con, data_dir, "userEnrollment")
  con
}
