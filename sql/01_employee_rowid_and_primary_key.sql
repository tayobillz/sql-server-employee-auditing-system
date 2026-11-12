
USE EmployeeManagementDB;
GO

-- Check whether EmployeeID contains duplicate values
SELECT
    EmployeeID,
    COUNT(*) AS DuplicateCount
FROM dbo.Employees
GROUP BY EmployeeID
HAVING COUNT(*) > 1;
GO

-- Check whether EmployeeID is already an IDENTITY column
SELECT
    COLUMNPROPERTY(
        OBJECT_ID('dbo.Employees'),
        'EmployeeID',
        'IsIdentity'
    ) AS IsEmployeeIDIdentity;
GO

-- Add a new identity column to uniquely identify each row
ALTER TABLE dbo.Employees
ADD EmployeeRowID INT IDENTITY(1,1) NOT NULL;
GO

-- Add a primary key using EmployeeRowID
ALTER TABLE dbo.Employees
ADD CONSTRAINT PK_Employees
PRIMARY KEY (EmployeeRowID);
GO
