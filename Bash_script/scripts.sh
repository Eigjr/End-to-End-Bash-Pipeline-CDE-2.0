#!/usr/bin/env bash

LOG="/home/pipeline/scripts.log"
echo "==================== $(date) ====================" >> "$LOG"

# Access the link from .env
""" this code access .env to check if url link exist, and echo succeful if it does and echo 
'Access not successful if not'
"""
if [[ -f .env ]]; then
    echo "Link accessed successfully!" >> "$LOG"
    export $(grep -v '^#' .env | xargs)
else
    echo "Access not successful" >> "$LOG"
    exit 1
fi

# Download file into Raw directory
mkdir -p Raw
curl -fsSL "$URL" -o Raw/Annual_report.csv

# Confirm if the download was successful
if [[ -f Raw/Annual_report.csv ]]; then
    echo "File downloaded successfully!" >> "$LOG"
else
    echo "File download was not successful" >> "$LOG"
    exit 1
fi

# Transform the data
mkdir -p Transformed

# Select columns: 1 (year), 9 (Value), 5 (Units), 6 (Variable_code)
# Change column name from Variable_code to variable_code
cut -d ',' -f1,9,5,6 Raw/Annual_report.csv \
| sed '1s/Variable_code/variable_code/' \
> Transformed/2023_year_finance.csv

# Confirm transformation
if [[ -f Transformed/2023_year_finance.csv ]]; then
    echo "File transformed successfully!" >> "$LOG"
else
    echo "File transformation failed!" >> "$LOG"
    exit 1
fi

# Move to Gold directory
mkdir -p Gold
mv Transformed/2023_year_finance.csv Gold/

if [[ -f Gold/2023_year_finance.csv ]]; then
    echo "File moved successfully into Gold directory" >> "$LOG"
else
    echo "File failed to move into Gold directory" >> "$LOG"
    exit 1
fi
