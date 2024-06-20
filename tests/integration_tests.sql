-- Integration Test Script
-- This script tests the integration and overall functionality of your SQL project

-- Test 1: Verify combined_data view
CREATE OR REPLACE VIEW Test.combined_data AS
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

-- Integration Test: Verify combined_data view
SELECT * FROM Test.combined_data;

-- Test 2: Verify stored procedure sp_z_test_calculations
DECLARE @lob VARCHAR(25) = 'Commercial';
DECLARE @my VARCHAR(2) = 'MY24';
DECLARE @pop_id INT = 1;

EXEC sp_z_test_calculations @lob, @my, @pop_id;

-- Integration Test: Verify trigger trg_final_rates_summary_changes
-- Insert new data to FINAL_RATES.SUMMARY and verify trigger operation
INSERT INTO FINAL_RATES.SUMMARY (product_id, product_id_desc, measure_abbr, submeasure_name, submeasure_bucket, measure_name, rate, denominator, submeasure_stratification)
VALUES (103, 'Product C Desc', 'MC', 'Submeasure C', 'Bucket C', 'Measure C', 75.0, 300, 'Stratification C');

-- Check if the trigger logged the operation
SELECT * FROM final_rates_summary_log WHERE product_id = 103;

-- Clean up test data
DELETE FROM FINAL_RATES.SUMMARY WHERE product_id = 103;
DROP VIEW IF EXISTS Test.combined_data;
