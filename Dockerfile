FROM erlang:27-alpine

# Install dependencies
RUN apk update && apk add --no-cache \
    curl \
    build-base \
    wget \
    gnupg \
    sudo

# Install Erlang (full package)
RUN apk update && apk add --no-cache erlang-dev rebar3

# Define an ARG for the Gleam version
ARG GLEAM_VERSION=1.8.1

# Download and install the precompiled Gleam binary for x86_64 Linux with musl libc
RUN curl -fsSL https://github.com/gleam-lang/gleam/releases/download/v${GLEAM_VERSION}/gleam-v${GLEAM_VERSION}-x86_64-unknown-linux-musl.tar.gz \
    | tar -xzC /usr/local/bin gleam

WORKDIR /app

CMD gleam run