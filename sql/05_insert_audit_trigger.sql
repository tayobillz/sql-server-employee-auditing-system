
USE EmployeeManagementDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_Employees_Audit_Insert
ON dbo.Employees
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.EmployeeChangeHistory
    (
        EmployeeRowID,
        OldEmployeeID,
        NewEmployeeID,
        OldFullName,
        NewFullName,
        OldDepartment,
        NewDepartment,
        OldSalary,
        NewSalary,
        ActionType,
        ChangedBy,
        ChangedAt
    )
    SELECT
        i.EmployeeRowID,
        NULL,
        i.EmployeeID,
        NULL,
        i.FullName,
        NULL,
        i.Department,
        NULL,
        i.Salary,
        'INSERT',
        ORIGINAL_LOGIN(),
        SYSUTCDATETIME()
    FROM inserted AS i;
END;
GO
