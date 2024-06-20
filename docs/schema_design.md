
### docs/schema_design.md

```markdown
# Schema Design

## Overview
The schema design includes two main tables: `SUBPOP.CONTRACT_TARGETS` and `FINAL_RATES.SUMMARY`. These tables store contract targets and final rates summary information respectively.

## Tables

### SUBPOP.CONTRACT_TARGETS
This table stores the contract targets for various products and measures.

| Column                   | Type         | Description                             |
|--------------------------|--------------|-----------------------------------------|
| pop_id                   | INT          | Primary key                             |
| contract_lob             | VARCHAR(25)  | Line of business                        |
| product_id               | INT          | Product ID                              |
| pop_name                 | VARCHAR(100) | Population name                         |
| measure_abbr             | VARCHAR(10)  | Measure abbreviation                    |
| submeasure_name          | VARCHAR(100) | Submeasure name                         |
| submeasure_bucket        | VARCHAR(100) | Submeasure bucket                       |
| description              | VARCHAR(255) | Description                             |
| target                   | DECIMAL(10,2)| Target value                            |
| stretch_target           | DECIMAL(10,2)| Stretch target value                    |
| contract_yr              | VARCHAR(2)   | Contract year                           |
| contract_yr2             | VARCHAR(2)   | Secondary contract year                 |
| submeasure_stratification| VARCHAR(100) | Submeasure stratification               |

### FINAL_RATES.SUMMARY
This table stores the summary of final rates for various products and measures.

| Column                   | Type         | Description                             |
|--------------------------|--------------|-----------------------------------------|
| product_id               | INT          | Product ID                              |
| product_id_desc          | VARCHAR(100) | Product description                     |
| measure_abbr             | VARCHAR(10)  | Measure abbreviation                    |
| submeasure_name          | VARCHAR(100) | Submeasure name                         |
| submeasure_bucket        | VARCHAR(100) | Submeasure bucket                       |
| measure_name             | VARCHAR(255) | Measure name                            |
| rate                     | DECIMAL(10,2)| Rate value                              |
| denominator              | INT          | Denominator value                       |
| submeasure_stratification| VARCHAR(100) | Submeasure stratification               |

## Schema Creation Script
You can find the schema creation script in [01_schema.sql](../scripts/01_schema.sql).
