IMG=ghcr.io/gaborcsardi/nanoparquet-cli
docker run -v `pwd -P`:`pwd` -w `pwd` ${IMG} "$@"
