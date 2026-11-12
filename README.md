# SQL Server Employee Database Auditing System

A hands-on SQL Server project focused on database auditing, change tracking, DML triggers, data integrity, and backup and recovery.

## Project Overview

This project documents my practical learning and implementation of database auditing using **Microsoft SQL Server Developer Edition and SQL Server Management Studio (SSMS)**.

I worked with a practice database named `EmployeeManagementDB`, using an employee records table to understand how database changes can be monitored, captured, investigated, and recovered.

The project explores three distinct SQL Server approaches:

1. SQL Server Audit
2. Change Data Capture (CDC)
3. Data Manipulation Language (DML) Triggers

The objective was not just to execute SQL statements, but to understand how these mechanisms work, what information they capture, and how they differ.

## Technologies and Tools

- Microsoft SQL Server Developer Edition
- SQL Server Management Studio (SSMS)
- T-SQL (Transact-SQL)
- SQL Server Audit
- Change Data Capture (CDC)
- DML Triggers

## Database Structure

**Database:** `EmployeeManagementDB`

**Main table:** `dbo.Employees`

The employee table contains:

- `EmployeeID`
- `FullName`
- `Department`
- `Salary`
- `EmployeeRowID`

An important database-design issue emerged during the exercise: `EmployeeID` contained duplicate values, so it could not reliably identify individual employee records.

I introduced `EmployeeRowID` as an `IDENTITY` column and made it the primary key. This provided a unique row identifier for matching records and tracking changes.

This exercise helped me understand the difference between a business identifier, an identity column, and a primary key.

## 1. SQL Server Audit

I configured SQL Server Audit and directed audit output to a local audit-file destination.

I explored how to inspect recorded database activity using:

`sys.fn_get_audit_file`

I also investigated audit event information, including action IDs, action names, success status, statements, and event timestamps.

**Key learning:** SQL Server Audit provides an event and activity auditing mechanism. It is useful for investigating database activity and security-related events, but it is not designed to function as a complete row-by-row old-value/new-value history table.

## 2. Change Data Capture (CDC)

I enabled and explored CDC on the employee table.

I worked with CDC change tables and functions, including:

`cdc.fn_cdc_get_all_changes_dbo_Employees`

I investigated:

- Log Sequence Numbers (LSNs)
- CDC operation codes
- Update masks
- Captured column metadata
- Before-and-after row images for updates

I learned the meaning of the CDC operation codes:

|   | Operation |   | Meaning               |
| - | --------- | - | --------------------- |
|   | 1         |   | Delete                |
|   | 2         |   | Insert                |
|   | 3         |   | Update — before image |
|   | 4         |   | Update — after image  |

I also examined how update masks identify which captured columns were changed.

**Key learning:** CDC captures changes asynchronously from the transaction log and makes the captured change data available for querying. It is different from a DML trigger and does not write to my custom audit-history table.

## 3. DML Triggers

I created custom `AFTER` triggers on `dbo.Employees` to capture INSERT, UPDATE, and DELETE operations.

The triggers write change information into a separate table:

`dbo.EmployeeChangeHistory`

The history table stores:

- `EmployeeRowID`
- Old and new EmployeeID
- Old and new FullName
- Old and new Department
- Old and new Salary
- ActionType
- ChangedBy
- ChangedAt

### Understanding inserted and deleted

One of the most important concepts I learned was how SQL Server uses the special logical tables `inserted` and `deleted` inside DML triggers.

| Operation | inserted      | deleted           |
| --------- | ------------- | ----------------- |
| INSERT    | New row       | No previous row   |
| UPDATE    | New row image | Old row image     |
| DELETE    | No new row    | Deleted row image |

For the UPDATE trigger, I joined `inserted` and `deleted` using `EmployeeRowID` to match the old and new versions of each row.

For the INSERT trigger, I selected the newly inserted records from `inserted`.

For the DELETE trigger, I used `deleted` to access the records removed from the employee table.

### Important trigger concepts explored

- `CREATE OR ALTER TRIGGER`
- `AFTER INSERT`
- `AFTER UPDATE`
- `AFTER DELETE`
- `SET NOCOUNT ON`
- `ORIGINAL_LOGIN()`
- `SYSUTCDATETIME()`
- Table aliases
- `INNER JOIN`
- Set-based trigger logic

I also tested a multi-row UPDATE operation and examined how one trigger execution can process multiple affected rows rather than just one.

**Key learning:** DML triggers allow custom logic to execute automatically when specified data modifications occur. They can capture old and new row values in a user-defined audit table.

## 4. Backup and Recovery

I practised database backup and restoration using SQL Server.

I explored:

- Creating database backups with `BACKUP DATABASE`
- Restoring databases with `RESTORE DATABASE`
- Using `WITH CHECKSUM`
- Monitoring operations with `STATS`
- Checking database recovery models through system catalog views
- Understanding the difference between a backup and a restore operation

I also examined how database recovery models affect backup and recovery strategies.

## Important Lessons

Through this project, I developed a clearer understanding of:

1. The difference between SQL Server Audit, CDC, and DML triggers.
2. How SQL Server captures old and new row images during updates.
3. Why primary keys matter when matching records.
4. Why an `IDENTITY` column and a primary key are related concepts but not the same thing.
5. How multi-row operations affect trigger design.
6. How to investigate database changes instead of relying only on the current state of a table.
7. Why backup and recovery are essential parts of database administration.

## Project Structure

The repository is intended to contain the SQL scripts and learning documentation organised as follows:

```text
sql-server-employee-auditing-system/
│
├── README.md
│
├── sql/
│   ├── 01_employee_table_setup.sql
│   ├── 02_audit_history_table.sql
│   ├── 03_insert_audit_trigger.sql
│   ├── 04_update_audit_trigger.sql
│   ├── 05_delete_audit_trigger.sql
│   ├── 06_audit_investigation_queries.sql
│   └── 07_backup_restore.sql
│
└── docs/
    └── auditing-concepts.md
```

## Scope and Learning Status

This was a practical learning project built by extending an existing local practice database. It was not a production banking database or a complete enterprise database deployment.

The INSERT and UPDATE triggers were tested, including a multi-row UPDATE. The DELETE trigger was corrected to use the `deleted` logical table; its final verification should be confirmed before presenting it as fully tested.

The SQL Server Audit, CDC, trigger, and backup exercises were explored in a local development environment.

## Future Improvements

- Build a complete relational database from requirements and an ER diagram.
- Add foreign keys and related tables.
- Explore stored procedures and views.
- Improve audit-history reporting.
- Investigate trigger error handling and transaction behaviour.
- Explore indexing and query performance.
- Connect the database to a backend API.

---

**Author:** Olapade Omotayo Habeeb

**Focus:** Database auditing, SQL Server fundamentals, data integrity, and database administration.
