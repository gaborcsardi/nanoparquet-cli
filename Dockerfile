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
RUN ::: DEV DEPS && : ------------------------------------------------ && \
    installr -c -p devtools usethis profvis languageserver && \
    ----- # ---------------------------------------------------------------

# SSH server for running the dev container in Positron
RUN ::: SSH && : ----------------------------------------------------- && \
    apk add --no-cache openrc openssh && \
    ssh-keygen -A && \
    rc-status && \
    # touch softlevel because system was initialized without openrc
    touch /run/openrc/softlevel

RUN echo PermitRootLogin yes >> /etc/ssh/sshd_config && \
    echo PermitEmptyPasswords yes >> /etc/ssh/sshd_config && \
    echo Port 2222 >> /etc/ssh/sshd_config && \
    passwd -d root && \
    ----- # ---------------------------------------------------------------

RUN mkdir -p /workspaces
RUN git config --global --add safe.directory '/workspaces/*'
