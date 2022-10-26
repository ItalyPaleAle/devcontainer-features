#!/bin/sh
set -e

# Clean up
rm -rf /var/lib/apt/lists/*

apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

## psql

echo "Installing psql…"
apt_get_update
apt-get -y install postgresql-client libpq-dev

## pgcli

echo "Installing pgcli from pip…"

apt_get_update
# python3-pip is likely already installed
apt-get -y install python3-pip
pip3 install -U pgcli

# Clean up
rm -rf /var/lib/apt/lists/*
