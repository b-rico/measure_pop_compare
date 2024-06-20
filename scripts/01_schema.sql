-- Drop tables if they exist
DROP TABLE IF EXISTS FINAL_RATES.SUMMARY;
DROP TABLE IF EXISTS SUBPOP.CONTRACT_TARGETS;

-- Create SUBPOP.CONTRACT_TARGETS table
CREATE TABLE SUBPOP.CONTRACT_TARGETS (
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

-- Create FINAL_RATES.SUMMARY table
CREATE TABLE FINAL_RATES.SUMMARY (
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