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
  loadNamespace("pillar")
  opts <- docopt::docopt(doc, args = args, help = FALSE)
  if (isTRUE(opts[["--help"]])) {
    help()
  } else if (isTRUE(opts[["version"]])) {
    version()
  } else if (isTRUE(opts[["info"]])) {
    info(opts)
  } else if (isTRUE(opts[["schema"]])) {
    schema(opts)
  } else if (isTRUE(opts[["export"]])) {
    export(opts)
  }
}

# handle here, because doctopt calls quit(), which is not great in tests
help <- function() {
  helptxt <- gsub("^\\s*|\\s*$", "", doc, perl = TRUE)
  cat(helptxt, "\n")
  stop(call. = FALSE)
}

version <- function() {
  message("nanoparquet ", packageVersion("nanoparquet"))
}

as_path <- function(x) {
  if (is.null(x)) return(x)
  gsub("\\", "/", x, fixed = TRUE)
}

info <- function(opts) {
  path <- as_path(opts[["<parquet-file>"]])
  info <- nanoparquet::read_parquet_info(path)
  old <- options(width = 10000)
  on.exit(options(old), add = TRUE)
  write.dcf(info)
}

schema <- function(opts) {
  path <- as_path(opts[["<parquet-file>"]])
  schema <- nanoparquet::read_parquet_schema(path)
  old <- options(width = 10000)
  on.exit(options(old), add = TRUE)
  print(schema, row.names = FALSE, max = 1e8, na.print = "NA")
}

export <- function(opts) {
  ipath <- as_path(opts[["<parquet-file>"]])
  opath <- as_path(opts[["<csv-file>"]])
  opath <- opath %||% ""
  df <- nanoparquet::read_parquet(ipath)
  write.csv(df, opath, row.names = FALSE)
}

if (is.null(sys.call())) {
  invisible(nanoparquet_cli_main(commandArgs(TRUE)))
}
