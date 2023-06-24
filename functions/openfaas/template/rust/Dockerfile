FROM openfaas/classic-watchdog:0.18.0 as watchdog

# Build Stage
FROM rust:1-slim-bullseye as builder

# RUN rustup target add x86_64-unknown-linux-musl

RUN USER=root
WORKDIR /usr/src/openfaas

RUN apt-get update -qy \
    && apt-get install -qy curl ca-certificates pkg-config libssl-dev

COPY function ./function
COPY main ./main

# ENV PKG_CONFIG_SYSROOT_DIR=/
RUN cd main && cargo build --release

# RUN cd main && cargo install --target x86_64-unknown-linux-musl --path .
RUN cd main && cargo install --path .

# Runner stage
# FROM alpine:3.17 as runner 
FROM debian:bullseye-slim as runner 

RUN apt-get update -qy \
    && apt-get install -qy ca-certificates && apt-get clean

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

COPY --from=builder /usr/local/cargo/bin/main /usr/bin/main
# COPY --from=builder /usr/src/openfaas/main/target/release/main /usr/bin/main

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1

ENV fprocess="main"

CMD ["fwatchdog"]
