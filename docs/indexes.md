
### docs/indexes.md

```markdown
# Indexes

## Overview
This script creates indexes to optimize queries on the `SUBPOP.CONTRACT_TARGETS` and `FINAL_RATES.SUMMARY` tables.

## Index Script
You can find the index script in [06_indexes.sql](../scripts/06_indexes.sql).

## Indexes

### Index on SUBPOP.CONTRACT_TARGETS
This index optimizes queries involving product_id, measure_abbr, submeasure_name, and submeasure_stratification columns.

```sql
CREATE INDEX idx_contract_targets
ON SUBPOP.CONTRACT_TARGETS (product_id, measure_abbr, submeasure_name, submeasure_stratification);
