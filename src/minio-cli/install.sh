#!/bin/sh
set -e

echo "Installing Minio CLI"

ARCH=$(dpkg --print-architecture)

curl -L "https://dl.min.io/client/mc/release/linux-${ARCH}/mc" -o /usr/local/bin/mc
chmod +x /usr/local/bin/mc
