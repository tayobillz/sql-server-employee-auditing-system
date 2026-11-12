
USE EmployeeManagementDB;
GO

-- Get the earliest available LSN for the capture instance
DECLARE @FromLSN BINARY(10);
SET @FromLSN = sys.fn_cdc_get_min_lsn('dbo_Employees');

-- Get the latest LSN
DECLARE @ToLSN BINARY(10);
SET @ToLSN = sys.fn_cdc_get_max_lsn();

-- Retrieve captured changes from the employee table
SELECT
    __$start_lsn,
    __$operation,
    EmployeeID,
    FullName,
    Department,
    Salary,
    __$update_mask
FROM cdc.fn_cdc_get_all_changes_dbo_Employees
(
    @FromLSN,
    @ToLSN,
    'all'
)
ORDER BY __$start_lsn;
GO
