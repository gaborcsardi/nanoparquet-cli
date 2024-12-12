# =========================================================================
FROM ghcr.io/r-hub/r-minimal/r-minimal:4.4 AS deps

COPY DESCRIPTION /app/DESCRIPTION
RUN installr -d deps::/app

# =========================================================================
FROM deps AS test-deps
COPY --from=ghcr.io/gaborcsardi/figlet /usr/local /usr/local
RUN ::: TEST DEPS && : ----------------------------------------------- && \
    installr -p -c -a linux-headers && \
    R -q -e 'pak::pkg_install("deps::/app", dependencies = TRUE)' && \
    ----- # ---------------------------------------------------------------

# =========================================================================
FROM test-deps AS test
COPY . /app
WORKDIR /app
RUN ::: TESTS && : --------------------------------------------------- && \
    R -q -e 'testthat::test_local()' && \
    ----- # ---------------------------------------------------------------

# =========================================================================
FROM deps AS prod
COPY --from=test /tmp/dumm[y] /tmp/dummy
ENTRYPOINT ["Rscript", "/app/R/nanoparquet.R"]

COPY . /app
WORKDIR /app

LABEL org.opencontainers.image.description="CLI for Parquet files, https://github.com/gaborcsardi/nanoparquet-cli"
LABEL org.opencontainers.image.licenses=MIT

# =========================================================================
FROM test-deps AS dev
COPY . /app
WORKDIR /app
ENTRYPOINT ["Rscript", "/app/R/nanoparquet.R"]
