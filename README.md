# CDE 2.0 Assignment On Linux and Git

### NOTE: This README is broken down into three segment
####        First Segment: Core Data Engineering End to End Data pipeline 
####        Second Segment: Bash scripting to move different from format across folders
####        Third Segment: Parch and Posey End To End data pipeline


## First Segment

### Core Data Engineering End to End Data pipeline
    This project is a robust and scalable end-to-end data pipeline designed to run automatically at 12 AM daily via cron jobs.
    It streamlines data ingestion, transformation, and storage, enabling reliable, production-read workflows that support 
    downstream analytics and decision-making.
    
### Features
    *-* The whole end to end pipeline was built solely using bash scripting
    *-* The process involoed A complete ETL 
            *1* Data ingestion from source 
            *2* Data Transformation
            *3* Loading the Processed Data into Gold layer ready for analysis
            *4* The whole process is schedule to run at a set time 12am
    
## Second: Segment
Basic Bash script that moves difereent from formate across folders

## Third: Parch and Posey End To End data pipeline
This project demonstrates how to automatically load CSV files into PostgreSQL tables using a 
Bash script (conn.sh) with environment variables stored in a .env file. It is designed for data engineering practice and
follows a clear, reproducible workflow.

### Features
    Automated CSV-to-PostgreSQL loading via \COPY.
    Creates tables if they don’t already exist.
    Schema includes Accounts, Orders, Sales Reps, Regions, Web Events.
    Handles errors gracefully with clear messages.
    Uses .env for secure database credentials.
