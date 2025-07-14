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
ln -sf "$(pwd)/lua" "$CONFIG_DIR/lua"

echo "Completed Successfully!"


