-- Create stored procedure for z-test calculations
CREATE PROCEDURE sp_z_test_calculations
    @lob VARCHAR(25),
    @my VARCHAR(2),
    @pop_id INT
AS
BEGIN
    WITH pooled_proportion AS (
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
END;
