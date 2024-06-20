
### docs/triggers.md

```markdown
# Triggers

## Overview
This script creates a trigger to log changes in the `FINAL_RATES.SUMMARY` table.

## Trigger Script
You can find the trigger script in [05_triggers.sql](../scripts/05_triggers.sql).

## Trigger: trg_final_rates_summary_changes
The `trg_final_rates_summary_changes` trigger logs changes (INSERT, UPDATE, DELETE) made to the `FINAL_RATES.SUMMARY` table.

### Trigger Definition
```sql
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
