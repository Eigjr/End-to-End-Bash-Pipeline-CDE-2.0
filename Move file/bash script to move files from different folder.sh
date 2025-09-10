#!/usr/bin/env bash

# Create destination folder if it doesn't exist
mkdir -p json_and_CSV

# Move all CSV and JSON files
mv scripts/*.csv *.json json_and_CSV/ 2>/dev/null

echo "All CSV and JSON files moved!"
