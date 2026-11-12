
USE EmployeeManagementDB;
GO

-- View all employee change history
SELECT *
FROM dbo.EmployeeChangeHistory
ORDER BY AuditID DESC;
GO

-- View INSERT operations
SELECT *
FROM dbo.EmployeeChangeHistory
WHERE ActionType = 'INSERT'
ORDER BY AuditID DESC;
GO

-- View UPDATE operations
SELECT *
FROM dbo.EmployeeChangeHistory
WHERE ActionType = 'UPDATE'
ORDER BY AuditID DESC;
GO

-- View DELETE operations
SELECT *
FROM dbo.EmployeeChangeHistory
WHERE ActionType = 'DELETE'
ORDER BY AuditID DESC;
GO

-- Investigate changes involving a specific employee
SELECT *
FROM dbo.EmployeeChangeHistory
WHERE EmployeeRowID = 1
ORDER BY AuditID DESC;
GO
