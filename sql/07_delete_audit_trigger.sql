
USE EmployeeManagementDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_Employees_Audit_Delete
ON dbo.Employees
AFTER DELETE
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
        d.EmployeeRowID,
        d.EmployeeID,
        NULL,
        d.FullName,
        NULL,
        d.Department,
        NULL,
        d.Salary,
        NULL,
        'DELETE',
        ORIGINAL_LOGIN(),
        SYSUTCDATETIME()
    FROM deleted AS d;
END;
GO

