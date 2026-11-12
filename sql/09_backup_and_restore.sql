
USE master;
GO

-- 1. Check the database recovery model
SELECT
    name,
    recovery_model_desc
FROM sys.databases
WHERE name = 'EmployeeManagementDB';
GO


-- 2. Back up the database
BACKUP DATABASE EmployeeManagementDB
TO DISK = 'C:\SQLBackups\EmployeeManagementDB_BeforeIdentity.bak'
WITH
    CHECKSUM,
    STATS = 10;
GO


-- 3. Restore database (REFERENCE ONLY)
-- WARNING:
-- This backup was created before EmployeeRowID was added.
-- Restoring it will revert the database to its earlier state.
-- The commands below are commented out to prevent accidental execution.

/*
ALTER DATABASE EmployeeManagementDB
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

RESTORE DATABASE EmployeeManagementDB
FROM DISK = 'C:\SQLBackups\EmployeeManagementDB_BeforeIdentity.bak'
WITH
    CHECKSUM,
    STATS = 10,
    REPLACE;
GO

ALTER DATABASE EmployeeManagementDB
SET MULTI_USER;
GO
*/
