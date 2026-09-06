# Retail-Data-Migration-Project

Overview

This project demonstrates an end-to-end data migration from raw source files into a structured SQL Server target database.

The source data consists of 12 related retail datasets covering customers, orders, products, stores, employees, suppliers, payments, shipments and returns.

The project focuses on the migration process rather than analytics or reporting.

Project Architecture
Kaggle CSV Files
       |
       v
SQL Server Flat Import
       |
       v
Pre-Stage Tables
       |
       | Data Profiling & Validation
       v
Target Relational Database
       |
       v
Transactional Migration
       |
       v
Data Reconciliation
Source Tables

The source dataset contains:

Customers
Stores
Employees
Categories
Suppliers
Products
Promotions
Orders
Order Items
Payments
Shipments
Returns
Migration Approach
1. Pre-Stage

The source CSV files were initially imported into SQL Server using a flat import process.

The Pre-Stage layer uses flexible NVARCHAR columns to preserve the incoming source data before transformation.

2. Source Profiling

The source data was profiled to establish:

Record counts
Candidate primary keys
Duplicate records
NULL values
Foreign-key relationships
Data-type compatibility
3. Target Database

A structured relational target database was created using appropriate SQL Server data types.

Examples include:

INT for identifiers and whole-number quantities
DATE for date-only values
VARCHAR for textual attributes
DECIMAL(18,2) for monetary values

Primary and foreign key constraints were implemented to enforce relational integrity.

4. Transactional Migration

All 12 source tables are migrated within a single SQL Server transaction.

If any insert fails, the transaction is rolled back so that the target database is not left in a partially migrated state.

The migration procedure also captures and returns SQL Server error information when a failure occurs.

5. Migration Reconciliation

The migration was validated by comparing source and target record counts.

Table	Source	Target
Categories	30	30
Customers	50,000	50,000
Employees	1,000	1,000
Order Items	600,000	600,000
Orders	300,000	300,000
Payments	300,000	300,000
Products	10,000	10,000
Promotions	50	50
Returns	30,000	30,000
Shipments	300,000	300,000
Stores	100	100
Suppliers	200	200

Result: 12/12 tables reconciled successfully.

Additional validation confirmed:

No duplicate candidate primary keys
No NULL values in candidate primary keys
No orphan foreign-key relationships in the validated relationships
Source values successfully converted to target data types
Customer, Order and Order Item values reconciled successfully
SQL Procedures
dbo.CreateTables

Creates the target relational database tables and their primary and foreign key constraints. The procedure is rerunnable and only creates tables that do not already exist.

dbo.usp_MigratePreStage

Migrates all data from the Pre-Stage tables into the target database within a single transaction. If a migration step fails, the entire transaction is rolled back and SQL Server error information is returned.

Technologies
SQL Server
T-SQL
SQL Server Management Studio
Kaggle dataset
Relational database design
Data migration / ETL concepts
Key Concepts Demonstrated
Source data profiling
Pre-staging
Data type transformation
Relational database design
Primary and foreign keys
Referential integrity
Transaction management
Error handling
Migration reconciliation
Data validation
Idempotent table creation
Project Status

Phase 1 — Data Migration: Complete

The source data has been successfully migrated from the Pre-Stage layer into the structured SQL Server target database and reconciled.

Future Development

Potential future phases include:

Data warehouse design
Dimensional modelling
Fact and dimension tables
Surrogate keys
Incremental ETL
Slowly Changing Dimensions
ETL auditing
Power BI reporting
