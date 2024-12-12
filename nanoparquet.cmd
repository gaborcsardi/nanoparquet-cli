: # Command line Docker app to query and transform Parquet files
: # Requires Docker installed and on the PATH
: # Start with --help for more information
: # Or see docs at https://github.com/gaborcsardi/nanoparquet-cli

: # This is for Unix
:; exec docker run -v `pwd -P`:`pwd` -w `pwd` ghcr.io/gaborcsardi/nanoparquet-cli "$@"

: # This is for Windows
@ECHO OFF
SET IMG=ghcr.io/gaborcsardi/nanoparquet-cli
SET DRIVE=%CD:~0,1%
SET UCD=%cd:~2%
: # Docker needs / in paths
SET UCD=%UCD:\=/%
docker run -v /%DRIVE%/%UCD%:%UCD% -w %UCD% %IMG% %*
