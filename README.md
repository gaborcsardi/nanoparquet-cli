# Parquet CLI via Docker and [nanoparquet](https://github.com/r-lib/nanoparquet)

> [!WARNING]
> This project is experimental.

## Features

* Supports all Parquet files that [https://github.com/r-lib/nanoparquet](
  nanoparquet) does.
* Small size: the Docker image is 34MB compressed.

## Requirements

* Docker, on Windows, macOS or Linux.

## Installation

Download the [`nanoparquet.cmd`](./nanoparquet.cmd) file and save it into
a place that is on your PATH.

### Linux and macOS

You could put the script in `/usr/local/bin` and name it `nanoparquet`.
Make sure that it is executable.

```
curl -L -o /usr/local/bin/nanoparquet \
  https://raw.githubusercontent.com/gaborcsardi/nanoparquet-cli/refs/heads/main/nanoparquet.cmd
chmod +x /usr/local/bin/nanoparquet
```

### Windows

There is no standard place for user-installed scripts on Windows, so
it is up to you where to save `nanoparquet.cmd`. The example below saves
it into `tools` within the user's home directory. Make sure you add this
directory to the `PATH`.

```
Invoke-WebRequest https://raw.githubusercontent.com/gaborcsardi/nanoparquet-cli/refs/heads/main/nanoparquet.cmd -OutFile ~/tools/nanoparquet.cmd
```

## Usage

Call the script without arguments to see the help screen:
```
$ nanoparquet
Error:
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
Execution halted
```

### Input and output files

The nanoparquet script bind mounts the current directory into the
nanoparquet container. So you can call nanoparquet on any file that is
anywhere inside the current working directory.

Output files work the same way: they must reside somewhere within the
working directory. For example:

```
nanoparquet export data/2024-01.parquet data/2024-01.csv
```

You can use backward or forward slashes as path separators on Windows.
Paths will always use forward slashed in nanoparquet output.

## **:blue_book:** Licenses

### GNU R

GPL-2 or GPL-3 © The R Foundation

### The tools in this repo

MIT © [Posit Software, PBC](https://posit.co)
