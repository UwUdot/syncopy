#!/usr/bin/env bash

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

echo "Cloning syncopy..."
git clone -q https://github.com/UwUdot/syncopy.git "$TEMP_DIR"

echo "Moving files..."
mv "$TEMP_DIR/syncopy" .
mv "$TEMP_DIR/.syncopy" .

echo "Setting permissions..."
chmod +x ./syncopy

echo "Done! Running syncopy..."
./syncopy