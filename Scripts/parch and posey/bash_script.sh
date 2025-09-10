#!/usr/bin/env bash

# -------------------------------------------
# Load .env variables
# -------------------------------------------

if [[ -f .env ]]; then
""" This code access the .env and checks if the postgres credential exist.
if it does, it will echo access successful 
if it doesn't it i'll echo access not successful
"""
    export $(grep -v '^#' .env | xargs)
    echo ".env accessed successfully"
else
    echo ".env variable was not accessed successfully!"
    exit 1
fi # end the for loop

# -------------------------------------------
# Path to CSV folder
# -------------------------------------------
file_path="/c/Users/Admin/Desktop/CDE/linux_Git/SQL"

# -------------------------------------------
# Export password so psql doesn’t prompt
# -------------------------------------------
export PGPASSWORD="$password_db"

# -------------------------------------------
# Create schemas (run once)
# -------------------------------------------
psql -h "$host_db" -p "$port_db" -U "$user_db" -d "$db_name" <<'EOF'
""" This connects to the database through the credential
create schema, truncate table to ensure accurate data is loaded into the database
"""
TRUNCATE  TABLE accounts;

CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY,
    name TEXT,
    website TEXT,
    lat FLOAT,
    long FLOAT,
    primary_poc TEXT,
    sales_rep_id INT
);
TRUNCATE  TABLE orders;
CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY,
    account_id INT,
    occurred_at TIMESTAMP,
    standard_qty INT,
    gloss_qty INT,
    poster_qty INT,
    total INT,
    standard_amt_usd FLOAT,
    gloss_amt_usd FLOAT,
    poster_amt_usd FLOAT,
    total_amt_usd FLOAT
);

TRUNCATE  TABLE sales_reps;
CREATE TABLE IF NOT EXISTS sales_reps (
    id INT PRIMARY KEY,
    name TEXT,
    region_id INT
);

TRUNCATE  TABLE region;
CREATE TABLE IF NOT EXISTS region (
    id INT PRIMARY KEY,
    name TEXT
);

TRUNCATE  TABLE web_events;
CREATE TABLE IF NOT EXISTS web_events (
    id INT PRIMARY KEY,
    account_id INT,
    occurred_at TIMESTAMP,
    channel TEXT
);
EOF

# -------------------------------------------
# Import CSV files into tables
# -------------------------------------------

for file in *.csv; do
 """ access the file inside the folder, though bash was opened directly in the folder 
 reason for no long file_path
 locate all file with extension csv and load with their unqiue name into the postgres 
 """
 table_name=$(basename "$file" .csv | tr '[:upper:]' '[:lower:]' | tr -d ' ')
    echo "Importing into table: $table_name"

    if psql -h "$host_db" -p "$port_db" -U "$user_db" -d "$db_name" \
        -c "\COPY $table_name FROM '$file' CSV HEADER"; then
        echo "Imported $file into $table_name"
    else
        echo "Failed to import $file. Check schema, path, or data format."
    fi
done

echo " load successfully!"
