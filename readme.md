# SQL Project

## Overview
This project showcases SQL skills through various scripts and queries. It includes schema creation, data loading, views, stored procedures, and sample queries.

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/username/sql-project.git
   cd sql-project
2. Create the database schema:
    \i scripts/01_schema.sql
3. Load initial data:
    \i scripts/02_data_load.sql
4. Create views, stored procedures, triggers, functions and indexes:
    \i scripts/03_views.sql
    \i scripts/04_cdf_normal_function.sql
    \i scripts/05_stored_procedures.sql
    \i scripts/06_triggers.sql
    \i scripts/07_indexes.sql
   
6. Run create function queries:
    \i scripts/08_pop_compare.sql

## Documentation
    Schema Design
    Data Load
    Views
    Stored Procedures
    Triggers
    Indexes

## Testing
1. To run unit and integration tests:
    \i tests/unit_tests.sql
    \i tests/integration_tests.sql

## Directory Structure
    hedis-measure-pop-compare/
    │
    ├── data/
    │   ├── initial_data_load.sql
    │   └── sample_data.csv
    │
    ├── docs/
    │   ├── data_load.md
    │   ├── indexes.md
    │   ├── schema_design.md
    │   ├── stored_procedures.md
    │   ├── triggers.md
    │   └── views.md
    │
    ├── scripts/
    │   ├── 01_schema.sql
    │   ├── 02_data_load.sql
    │   ├── 03_views.sql
    │   ├── 04_cdf_normal_function.sql
    │   ├── 05_stored_procedures.sql
    │   ├── 06_triggers.sql
    │   ├── 07_indexes.sql
    │   └── 08_queries.sql
    │
    ├── tests/
    │   ├── integration_tests.sql
    │   └── unit_tests.sql
    │
    ├── .gitattributes
    ├── .gitignore
    ├── LICENSE
    └── README.md

## Contact

For any questions or issues, please contact Bert Rico at brico.git@gmail.com.
