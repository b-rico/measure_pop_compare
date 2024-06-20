/*** Basic Data Retrieval Queries ***/

-- Query 1: Retrieve all records from SUBPOP.CONTRACT_TARGETS
SELECT * FROM SUBPOP.CONTRACT_TARGETS;

-- Query 2: Retrieve all records from FINAL_RATES.SUMMARY
SELECT * FROM FINAL_RATES.SUMMARY;

/*** Joins ***/

-- Query 3: Join SUBPOP.CONTRACT_TARGETS with FINAL_RATES.SUMMARY on product_id, measure_abbr, submeasure_name, and submeasure_stratification
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
    AND ct.submeasure_stratification = se.submeasure_stratification;

/*** Aggregation Queries ***/

-- Query 4: Calculate the average target and stretch_target for each contract_lob
SELECT
    contract_lob,
    AVG(target) AS avg_target,
    AVG(stretch_target) AS avg_stretch_target
FROM SUBPOP.CONTRACT_TARGETS
GROUP BY contract_lob;

-- Query 5: Calculate the total denominator for each measure_abbr
SELECT
    measure_abbr,
    SUM(denominator) AS total_denominator
FROM FINAL_RATES.SUMMARY
GROUP BY measure_abbr;

/*** Analytical Queries ***/

-- Query 6: Calculate the pooled rate for each measure_abbr
WITH pooled_proportion AS (
    SELECT
        measure_abbr,
        SUM(rate * denominator) / SUM(denominator) AS pooled_rate,
        SUM(denominator) AS total_denominator
    FROM FINAL_RATES.SUMMARY
    GROUP BY measure_abbr
)
SELECT
    measure_abbr,
    pooled_rate,
    total_denominator
FROM pooled_proportion;

-- Query 7: Perform a z-test between different populations
WITH combined_data AS (
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
    )
),
pooled_proportion AS (
    SELECT
        measure_abbr,
        SUM(rate * denominator) / SUM(denominator) AS pooled_rate,
        SUM(denominator) AS total_denominator
    FROM combined_data
    GROUP BY measure_abbr
),
z_test_calculations AS (
    SELECT
        c1.measure_abbr,
        c1.pop_id,
        c1.rate AS rate1,
        c1.denominator AS denominator1,
        c2.pop_id AS pop_id2,
        c2.rate AS rate2,
        c2.denominator AS denominator2,
        pp.pooled_rate,
        pp.total_denominator,
        (pp.pooled_rate * (1 - pp.pooled_rate) * (1.0 / c1.denominator + 1.0 / c2.denominator)) AS variance,
        (c1.rate - c2.rate) / SQRT(pp.pooled_rate * (1 - pp.pooled_rate) * (1.0 / c1.denominator + 1.0 / c2.denominator)) AS z_score,
        2 * (1 - dbo.CDF_Normal(ABS((c1.rate - c2.rate) / SQRT(pp.pooled_rate * (1 - pp.pooled_rate) * (1.0 / c1.denominator + 1.0 / c2.denominator))))) AS p_value
    FROM combined_data c1
    JOIN combined_data c2 
        ON c1.measure_abbr = c2.measure_abbr
        AND c1.pop_id != c2.pop_id
    JOIN pooled_proportion pp 
        ON c1.measure_abbr = pp.measure_abbr
)
SELECT
    pop_id,
    measure_abbr,
    ROUND(rate1, 3) AS rate1,
    denominator1,
    pop_id2,
    ROUND(rate2, 3) AS rate2,
    denominator2,
    ROUND(z_score, 3) AS z_score,
    ROUND(p_value, 3) AS p_value
FROM z_test_calculations
WHERE p_value < 0.05
  AND pop_id2 = @pop_id
ORDER BY pop_id, measure_abbr;

/*** Advanced Data Manipulation ***/

-- Query 8: Identify products with rates significantly lower than the pooled rate
WITH pooled_proportion AS (
    SELECT
        measure_abbr,
        SUM(rate * denominator) / SUM(denominator) AS pooled_rate,
        SUM(denominator) AS total_denominator
    FROM FINAL_RATES.SUMMARY
    GROUP BY measure_abbr
),
significant_deviation AS (
    SELECT
        fs.product_id,
        fs.measure_abbr,
        fs.rate,
        pp.pooled_rate,
        ABS(fs.rate - pp.pooled_rate) AS deviation
    FROM FINAL_RATES.SUMMARY fs
    JOIN pooled_proportion pp
        ON fs.measure_abbr = pp.measure_abbr
)
SELECT
    product_id,
    measure_abbr,
    rate,
    pooled_rate,
    deviation
FROM significant_deviation
WHERE deviation > 5.0 -- Example threshold for significant deviation
ORDER BY deviation DESC;

/*** Parameterized Query ***/

-- Query 9: Retrieve contract targets for a specific line of business and year
DECLARE @lob VARCHAR(25) = 'Commercial';
DECLARE @year VARCHAR(2) = 'MY24';

SELECT
    pop_id,
    contract_lob,
    product_id,
    pop_name,
    measure_abbr,
    submeasure_name,
    submeasure_bucket,
    description,
    target,
    stretch_target
FROM SUBPOP.CONTRACT_TARGETS
WHERE contract_lob = @lob
  AND contract_yr = @year;

  /*** Summary Query ***/

-- Query 10: Generate a summary report of target vs. actual rates
SELECT
    ct.pop_id,
    ct.contract_lob,
    ct.product_id,
    ct.pop_name,
    ct.measure_abbr,
    ct.submeasure_name,
    ct.target,
    se.rate,
    se.denominator,
    (se.rate - ct.target) AS target_variance
FROM SUBPOP.CONTRACT_TARGETS ct
LEFT JOIN FINAL_RATES.SUMMARY se
    ON ct.product_id = se.product_id
    AND ct.measure_abbr = se.measure_abbr
    AND ct.submeasure_name = se.submeasure_name
    AND ct.submeasure_stratification = se.submeasure_stratification
WHERE ct.target IS NOT NULL
ORDER BY ct.pop_id, ct.measure_abbr;
