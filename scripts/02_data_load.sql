-- Load data into SUBPOP.CONTRACT_TARGETS
INSERT INTO SUBPOP.CONTRACT_TARGETS (pop_id, contract_lob, product_id, pop_name, measure_abbr, submeasure_name, submeasure_bucket, description, target, stretch_target, contract_yr, contract_yr2, submeasure_stratification)
VALUES
(1, 'Commercial', 101, 'Product A', 'MA', 'Submeasure A', 'Bucket A', 'Description A', 90.0, 95.0, 'MY24', 'MY24', 'Stratification A'),
(2, 'Commercial', 102, 'Product B', 'MB', 'Submeasure B', 'Bucket B', 'Description B', 85.0, 90.0, 'MY24', 'MY24', 'Stratification B');

-- Load data into FINAL_RATES.SUMMARY
INSERT INTO FINAL_RATES.SUMMARY (product_id, product_id_desc, measure_abbr, submeasure_name, submeasure_bucket, measure_name, rate, denominator, submeasure_stratification)
VALUES
(101, 'Product A Desc', 'MA', 'Submeasure A', 'Bucket A', 'Measure A', 88.5, 200, 'Stratification A'),
(102, 'Product B Desc', 'MB', 'Submeasure B', 'Bucket B', 'Measure B', 82.3, 150, 'Stratification B');
