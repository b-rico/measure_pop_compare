-- Unit Test Script
-- This script tests individual components of your SQL project

-- Drop test tables if they exist
DROP TABLE IF EXISTS Test.SUBPOP_CONTRACT_TARGETS;
DROP TABLE IF EXISTS Test.FINAL_RATES_SUMMARY;

-- Create test tables
CREATE TABLE Test.SUBPOP_CONTRACT_TARGETS (
    pop_id INT PRIMARY KEY,
    contract_lob VARCHAR(25),
    product_id INT,
    pop_name VARCHAR(100),
    measure_abbr VARCHAR(10),
    submeasure_name VARCHAR(100),
    submeasure_bucket VARCHAR(100),
    description VARCHAR(255),
    target DECIMAL(10, 2),
    stretch_target DECIMAL(10, 2),
    contract_yr VARCHAR(2),
    contract_yr2 VARCHAR(2),
    submeasure_stratification VARCHAR(100)
);

CREATE TABLE Test.FINAL_RATES_SUMMARY (
    product_id INT,
    product_id_desc VARCHAR(100),
    measure_abbr VARCHAR(10),
    submeasure_name VARCHAR(100),
    submeasure_bucket VARCHAR(100),
    measure_name VARCHAR(255),
    rate DECIMAL(10, 2),
    denominator INT,
    submeasure_stratification VARCHAR(100)
);

-- Insert test data
INSERT INTO Test.SUBPOP_CONTRACT_TARGETS (pop_id, contract_lob, product_id, pop_name, measure_abbr, submeasure_name, submeasure_bucket, description, target, stretch_target, contract_yr, contract_yr2, submeasure_stratification)
VALUES (1, 'Commercial', 101, 'Product A', 'MA', 'Submeasure A', 'Bucket A', 'Description A', 90.0, 95.0, 'MY24', 'MY24', 'Stratification A');

INSERT INTO Test.FINAL_RATES_SUMMARY (product_id, product_id_desc, measure_abbr, submeasure_name, submeasure_bucket, measure_name, rate, denominator, submeasure_stratification)
VALUES (101, 'Product A Desc', 'MA', 'Submeasure A', 'Bucket A', 'Measure A', 88.5, 200, 'Stratification A');

-- Unit Test: Verify data insertion into SUBPOP_CONTRACT_TARGETS
SELECT * FROM Test.SUBPOP_CONTRACT_TARGETS;

-- Unit Test: Verify data insertion into FINAL_RATES_SUMMARY
SELECT * FROM Test.FINAL_RATES_SUMMARY;

-- Unit Test: Verify JOIN operation
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
FROM Test.SUBPOP_CONTRACT_TARGETS ct
LEFT JOIN Test.FINAL_RATES_SUMMARY se
    ON ct.product_id = se.product_id
    AND ct.measure_abbr = se.measure_abbr
    AND ct.submeasure_name = se.submeasure_name
    AND ct.submeasure_stratification = se.submeasure_stratification;

-- Clean up test data
DROP TABLE IF EXISTS Test.SUBPOP_CONTRACT_TARGETS;
DROP TABLE IF EXISTS Test.FINAL_RATES_SUMMARY;
