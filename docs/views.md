# Views

## Overview
This script creates a view combining data from `SUBPOP.CONTRACT_TARGETS` and `FINAL_RATES.SUMMARY` tables.

## View Script
You can find the view script in [03_views.sql](../scripts/03_views.sql).

## Combined Data View
The `combined_data` view combines data from the contract targets and final rates summary tables to provide a unified dataset for analysis.

### View Definition
```sql
CREATE VIEW combined_data AS
SELECT
    ct.pop_id,
    ct.contract_lob,
    ct.product_id,
    ct.pop_name,
    ct.measure_abbr,
    ct.submeasure_name,
    ct.submeasure_bucket,
    ct.description,
    ct.target,
    ct.stretch_target,
    se.rate,
    se.denominator
FROM SUBPOP.CONTRACT_TARGETS ct
LEFT JOIN FINAL_RATES.SUMMARY se
    ON ct.product_id = se.product_id
    AND ct.measure_abbr = se.measure_abbr
    AND ct.submeasure_name = se.submeasure_name
    AND ct.submeasure_stratification = se.submeasure_stratification
WHERE ct.target IS NOT NULL
UNION ALL
SELECT
    pop_id,
    contract_lob,
    product_id,
    product_id_desc AS pop_name,
    measure_abbr,
    submeasure_name,
    submeasure_bucket,
    measure_name AS description,
    NULL AS target,
    NULL AS stretch_target,
    rate,
    denominator
FROM FINAL_RATES.SUMMARY
WHERE CONCAT(measure_abbr, submeasure_name, submeasure_bucket) IN (
    SELECT DISTINCT CONCAT(measure_abbr, submeasure_name, submeasure_bucket)
    FROM SUBPOP.CONTRACT_TARGETS
    WHERE target IS NOT NULL
);
