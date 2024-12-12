#! Rscript

doc <- r"{
Usage:
  nanoparquet ( --help | --version )
  nanoparquet info <parquet-file>
  nanoparquet schema <parquet-file>
  nanoparquet export <parquet-file> [ <csv-file> ]

Commands:
  info    Show information about a Parquet file.
  schema  Show the schema of tha Parquet file.
  export  Export a Parquet file to a CSV file.

Arguments:
  <parquet-file>  Parquet file.
  <csv-file>      CSV file. Uses standard output if missing.

Options:
  --help     Print this help message.
  --version  Print nanoparquet version.
}"

nanoparquet_cli_main <- function(args) {
  opts <- docopt::docopt(doc, args = args)
  # --help is handled automatically
  if (isTRUE(opts[["version"]])) {
    version()
  } else if (isTRUE(opts[["info"]])) {
    info(opts)
  } else if (isTRUE(opts[["schema"]])) {
    schema(opts)
  } else if (isTRUE(opts[["export"]])) {
    export(opts)
  }
}

dq <- function(x) {
  paste0('"', x, '"')
}

version <- function() {
  message("nanoparquet ", packageVersion("nanoparquet"))
}

info <- function(opts) {
  path <- opts[["<parquet-file>"]]
  info <- nanoparquet::read_parquet_info(path)
  old <- options(width = 10000)
  on.exit(options(old), add = TRUE)
  write.dcf(info)
}

schema <- function(opts) {
  path <- opts[["<parquet-file>"]]
  schema <- nanoparquet::read_parquet_schema(path)
  old <- options(width = 10000)
  on.exit(options(old), add = TRUE)
  print(schema, row.names = FALSE, max = 1e8, na.print = "NA")
}

export <- function(opts) {
  ipath <- opts[["<parquet-file>"]]
  opath <- opts[["<csv-file>"]]
  opath <- opath %||% ""
  df <- nanoparquet::read_parquet(ipath)
  write.csv(df, opath, row.names = FALSE)
}

if (is.null(sys.call())) {
  invisible(nanoparquet_cli_main(commandArgs(TRUE)))
}
