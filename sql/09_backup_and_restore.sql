
USE master;
GO

-- Check the database recovery model
SELECT
    name,
    recovery_model_desc
FROM sys.databases
WHERE name = 'EmployeeManagementDB';
GO

-- Back up the database
BACKUP DATABASE EmployeeManagementDB
TO DISK = 'C:\SQLBackups\EmployeeManagementDB_BeforeIdentity.bak'
WITH
    CHECKSUM,
    STATS = 10;
GO

-- Restore the database
-- Run this section only when intentionally restoring
-- and after confirming the backup file exists.

ALTER DATABASE EmployeeManagementDB
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

RESTORE DATABASE EmployeeManagementDB
FROM DISK = 'C:\SQLBackups\EmployeeManagementDB_BeforeIdentity.bak'
WITH
    CHECKSUM,
    STATS = 10;
GO

ALTER DATABASE EmployeeManagementDB
SET MULTI_USER;
GO
