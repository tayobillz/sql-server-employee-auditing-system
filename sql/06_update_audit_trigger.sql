
USE EmployeeManagementDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_Employees_Audit_Update
ON dbo.Employees
AFTER UPDATE
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
        i.EmployeeID,
        d.FullName,
        i.FullName,
        d.Department,
        i.Department,
        d.Salary,
        i.Salary,
        'UPDATE',
        ORIGINAL_LOGIN(),
        SYSUTCDATETIME()
    FROM deleted AS d
    INNER JOIN inserted AS i
        ON d.EmployeeRowID = i.EmployeeRowID;
END;
GO
