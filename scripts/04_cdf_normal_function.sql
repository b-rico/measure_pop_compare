CREATE FUNCTION dbo.CDF_Normal(@z FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @sign INT;
    DECLARE @x FLOAT;
    DECLARE @t FLOAT;
    DECLARE @y FLOAT;

    SET @sign = CASE WHEN @z < 0 THEN -1 ELSE 1 END;
    SET @x = ABS(@z) / SQRT(2.0);
    SET @t = 1.0 / (1.0 + 0.3275911 * @x);
    SET @y = 1.0 - (((((1.061405429 * @t - 1.453152027) * @t) + 1.421413741) * @t - 0.284496736) * @t + 0.254829592) * @t * EXP(-@x * @x);
    RETURN 0.5 * (1.0 + @sign * @y);
END;
GO