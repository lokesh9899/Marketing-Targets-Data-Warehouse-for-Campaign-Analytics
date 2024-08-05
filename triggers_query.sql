use Finance_Info;
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[audit_logs]') AND type in (N'U'))
BEGIN
    CREATE TABLE audit_logs (
        log_id INT IDENTITY(1,1) PRIMARY KEY,
        table_name VARCHAR(255),
        operation VARCHAR(255),
        timestamp DATETIME DEFAULT GETDATE(),
        old_data NVARCHAR(MAX)
    );
END;

CREATE TRIGGER after_customer_deletes
ON customer
AFTER DELETE
AS
BEGIN
    INSERT INTO audit_logs(table_name, operation, timestamp, old_data)
    SELECT 
        'customer', 
        'DELETE', 
        GETDATE(), 
        CONCAT('customer_id: ', CAST(deleted.customer_id AS NVARCHAR))
    FROM deleted;
END;
GO


USE Finance_Info;
GO


CREATE TRIGGER after_contact_deletes
ON contact
AFTER DELETE
AS
BEGIN
    INSERT INTO audit_logs (table_name, operation, timestamp, old_data)
    SELECT 
        'contact', 
        'DELETE', 
        GETDATE(), 
        CONCAT('contact_id: ', CAST(deleted.contact_id AS NVARCHAR), 
               ', customer_id: ', CAST(deleted.customer_id AS NVARCHAR))
    FROM deleted;
END;
GO

USE Finance_Info;
GO

CREATE TRIGGER after_outcome_deletes
ON outcome
AFTER DELETE
AS
BEGIN
    INSERT INTO audit_logs (table_name, operation, timestamp, old_data)
    SELECT 
        'outcome', 
        'DELETE', 
        GETDATE(), 
        CONCAT('outcome_id: ', CAST(deleted.outcome_id AS NVARCHAR), 
               ', result: ', deleted.result)
    FROM deleted;
END;
GO

