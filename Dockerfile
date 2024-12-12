FROM ghcr.io/r-hub/r-minimal/r-minimal:4.4 AS build

COPY DESCRIPTION /app/DESCRIPTION
RUN installr -d deps::/app

COPY . /app
WORKDIR /app

# -------------------------------------------------------------------------
FROM build AS test
COPY --from=ghcr.io/gaborcsardi/figlet /usr/local /usr/local
RUN ::: TEST DEPS && : ----------------------------------------------- && \
    installr -p -c -a linux-headers && \
    R -q -e 'source("https://pak.r-pkg.org")' && \
    R -q -e 'pak::pak()' && \
    ----- # ---------------------------------------------------------------

RUN ::: TESTS && : --------------------------------------------------- && \
    R -q -e 'testthat::test_local()' && \
    ----- # ---------------------------------------------------------------

# -------------------------------------------------------------------------
FROM build AS prod
COPY --from=test /tmp/dumm[y] /tmp/dummy
ENTRYPOINT ["Rscript", "/app/R/nanoparquet.R"]

LABEL org.opencontainers.image.source=https://github.com/gaborcsardi/nanoparquet-cli
LABEL org.opencontainers.image.description="CLI for Parquet files, https://github.com/gaborcsardi/nanoparquet-cli"
LABEL org.opencontainers.image.licenses=MIT
