
USE EmployeeManagementDB;
GO

-- Create a table to store employee change history
CREATE TABLE dbo.EmployeeChangeHistory
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,

    EmployeeRowID INT NOT NULL,

    OldEmployeeID INT NULL,
    NewEmployeeID INT NULL,

    OldFullName VARCHAR(100) NULL,
    NewFullName VARCHAR(100) NULL,

    OldDepartment VARCHAR(50) NULL,
    NewDepartment VARCHAR(50) NULL,

    OldSalary DECIMAL(12,2) NULL,
    NewSalary DECIMAL(12,2) NULL,

    ChangedBy SYSNAME NULL,
    ChangedAt DATETIME2(3) NULL,

    ActionType VARCHAR(10) NULL
);
GO
