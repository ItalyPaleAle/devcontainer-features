#!/bin/sh
set -e

GOLANGCILINT_VERSION="${VERSION:-latest}"
INSTALL_PATH="/usr/local/bin"

echo "Installing golangci-lint"

if [ "$GOLANGCILINT_VERSION" = "latest" ]; then
    curl -fsSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | \
        sh -s -- -b "$INSTALL_PATH"
else
    curl -fsSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | \
        sh -s -- -b "$INSTALL_PATH" "v${GOLANGCILINT_VERSION}"
fi
