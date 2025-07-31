#!/bin/bash

set -e

CONFIG_DIR="$HOME/.config/nvim"

echo "Creating config directory..."
mkdir -p "$CONFIG_DIR"

echo "Linking init.lua"
ln -sf "$(pwd)/init.lua" "$CONFIG_DIR/init.lua"

echo "Linking lazy-lock.json"
ln -sf "$(pwd)/lazy-lock.json" "$CONFIG_DIR/lazy-lock.json"

echo "Linking lua directory"
# Remove if exists
if [ -e "$CONFIG_DIR/lua" ] || [ -L "$CONFIG_DIR/lua" ]; then
    rm -rf "$CONFIG_DIR/lua"
fi
ln -sf "$(pwd)/lua" "$CONFIG_DIR/lua"

echo "Completed Successfully!"
