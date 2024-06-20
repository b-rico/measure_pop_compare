-- Create trigger to log changes in FINAL_RATES.SUMMARY
CREATE TRIGGER trg_final_rates_summary_changes
ON FINAL_RATES.SUMMARY
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @operation CHAR(1);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @operation = 'U'; -- Update
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @operation = 'I'; -- Insert
    ELSE
        SET @operation = 'D'; -- Delete

    -- Insert log entry
    INSERT INTO final_rates_summary_log (operation, product_id, timestamp)
    SELECT @operation, ISNULL(i.product_id, d.product_id), GETDATE()
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.product_id = d.product_id;
END;
