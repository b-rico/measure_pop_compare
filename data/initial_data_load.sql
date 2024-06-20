-- Initial Data Load Script

-- Load data into SUBPOP.CONTRACT_TARGETS
INSERT INTO SUBPOP.CONTRACT_TARGETS (pop_id, contract_lob, product_id, pop_name, measure_abbr, submeasure_name, submeasure_bucket, description, target, stretch_target, contract_yr, contract_yr2, submeasure_stratification)
VALUES
(1, 'Commercial', 101, 'Product A', 'MA', 'Submeasure A', 'Bucket A', 'Description A', 90.0, 95.0, 'MY24', 'MY24', 'Stratification A'),
(2, 'Commercial', 102, 'Product B', 'MB', 'Submeasure B', 'Bucket B', 'Description B', 85.0, 90.0, 'MY24', 'MY24', 'Stratification B'),
(3, 'Commercial', 103, 'Product C', 'MC', 'Submeasure C', 'Bucket C', 'Description C', 88.0, 93.0, 'MY24', 'MY24', 'Stratification C'),
(4, 'Commercial', 104, 'Product D', 'MD', 'Submeasure D', 'Bucket D', 'Description D', 92.0, 97.0, 'MY24', 'MY24', 'Stratification D'),
(5, 'Commercial', 105, 'Product E', 'ME', 'Submeasure E', 'Bucket E', 'Description E', 87.0, 92.0, 'MY24', 'MY24', 'Stratification E'),
(6, 'Commercial', 106, 'Product F', 'MF', 'Submeasure F', 'Bucket F', 'Description F', 89.0, 94.0, 'MY24', 'MY24', 'Stratification F'),
(7, 'Commercial', 107, 'Product G', 'MG', 'Submeasure G', 'Bucket G', 'Description G', 91.0, 96.0, 'MY24', 'MY24', 'Stratification G'),
(8, 'Commercial', 108, 'Product H', 'MH', 'Submeasure H', 'Bucket H', 'Description H', 84.0, 89.0, 'MY24', 'MY24', 'Stratification H'),
(9, 'Commercial', 109, 'Product I', 'MI', 'Submeasure I', 'Bucket I', 'Description I', 86.0, 91.0, 'MY24', 'MY24', 'Stratification I'),
(10, 'Commercial', 110, 'Product J', 'MJ', 'Submeasure J', 'Bucket J', 'Description J', 83.0, 88.0, 'MY24', 'MY24', 'Stratification J');

-- Load data into FINAL_RATES.SUMMARY
INSERT INTO FINAL_RATES.SUMMARY (product_id, product_id_desc, measure_abbr, submeasure_name, submeasure_bucket, measure_name, rate, denominator, submeasure_stratification)
VALUES
(101, 'Product A Desc', 'MA', 'Submeasure A', 'Bucket A', 'Measure A', 88.5, 200, 'Stratification A'),
(102, 'Product B Desc', 'MB', 'Submeasure B', 'Bucket B', 'Measure B', 82.3, 150, 'Stratification B'),
(103, 'Product C Desc', 'MC', 'Submeasure C', 'Bucket C', 'Measure C', 85.7, 180, 'Stratification C'),
(104, 'Product D Desc', 'MD', 'Submeasure D', 'Bucket D', 'Measure D', 91.2, 220, 'Stratification D'),
(105, 'Product E Desc', 'ME', 'Submeasure E', 'Bucket E', 'Measure E', 87.4, 210, 'Stratification E'),
(106, 'Product F Desc', 'MF', 'Submeasure F', 'Bucket F', 'Measure F', 89.6, 230, 'Stratification F'),
(107, 'Product G Desc', 'MG', 'Submeasure G', 'Bucket G', 'Measure G', 90.1, 240, 'Stratification G'),
(108, 'Product H Desc', 'MH', 'Submeasure H', 'Bucket H', 'Measure H', 83.9, 170, 'Stratification H'),
(109, 'Product I Desc', 'MI', 'Submeasure I', 'Bucket I', 'Measure I', 86.5, 190, 'Stratification I'),
(110, 'Product J Desc', 'MJ', 'Submeasure J', 'Bucket J', 'Measure J', 81.7, 160, 'Stratification J');
