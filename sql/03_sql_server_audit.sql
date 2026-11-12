
USE EmployeeManagementDB;
GO

-- Read SQL Server Audit records
SELECT *
FROM sys.fn_get_audit_file
(
    'C:\SQLAudit\*',
    DEFAULT,
    DEFAULT
);
GO
