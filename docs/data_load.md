# Data Load

## Overview
The data load script inserts initial data into the `SUBPOP.CONTRACT_TARGETS` and `FINAL_RATES.SUMMARY` tables.

## Data Load Script
You can find the data load script in [02_data_load.sql](../scripts/02_data_load.sql).

## Sample Data

### SUBPOP.CONTRACT_TARGETS

| pop_id | contract_lob | product_id | pop_name  | measure_abbr | submeasure_name | submeasure_bucket | description   | target | stretch_target | contract_yr | contract_yr2 | submeasure_stratification |
|--------|---------------|------------|-----------|--------------|-----------------|-------------------|---------------|--------|----------------|-------------|--------------|---------------------------|
| 1      | Commercial    | 101        | Product A | MA           | Submeasure A    | Bucket A          | Description A | 90.0   | 95.0           | MY24        | MY24         | Stratification A          |
| 2      | Commercial    | 102        | Product B | MB           | Submeasure B    | Bucket B          | Description B | 85.0   | 90.0           | MY24        | MY24         | Stratification B          |

### FINAL_RATES.SUMMARY

| product_id | product_id_desc | measure_abbr | submeasure_name | submeasure_bucket | measure_name | rate | denominator | submeasure_stratification |
|------------|------------------|--------------|-----------------|-------------------|--------------|------|-------------|---------------------------|
| 101        | Product A Desc   | MA           | Submeasure A    | Bucket A          | Measure A    | 88.5 | 200         | Stratification A          |
| 102        | Product B Desc   | MB           | Submeasure B    | Bucket B          | Measure B    | 82.3 | 150         | Stratification B          |
