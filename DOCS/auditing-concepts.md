
# SQL Server Auditing: Concepts and Lessons

## 1. SQL Server Audit

SQL Server Audit records database and server-level activities for monitoring, investigation, and security purposes.

I configured an audit destination and explored audit records using `sys.fn_get_audit_file`.

## 2. Change Data Capture (CDC)

CDC captures changes made to tracked tables by reading the transaction log asynchronously.

Important concepts explored:
- LSN (Log Sequence Number)
- Operation codes
- Update masks
- Before-and-after images
- CDC change tables and functions

## 3. DML Triggers

DML triggers execute automatically in response to data modification events.

I created AFTER INSERT, UPDATE, and DELETE triggers to populate a custom audit-history table.

### inserted and deleted logical tables

| Operation | inserted | deleted |
|---|---|---|
| INSERT | New row | No previous row |
| UPDATE | New row image | Old row image |
| DELETE | No new row | Deleted row image |

## 4. Primary Keys and IDENTITY

An IDENTITY column automatically generates values.

A PRIMARY KEY enforces uniqueness and prevents NULL values.

In this project, EmployeeRowID was introduced as an IDENTITY column and primary key because EmployeeID contained duplicate values.

## 5. Set-Based Trigger Logic

SQL Server triggers must account for statements that affect multiple rows.

The UPDATE trigger used an INNER JOIN between inserted and deleted, matching records through EmployeeRowID.

This allowed multiple changes to be captured in one trigger execution.

## 6. Backup and Recovery

I explored database backup, restoration, checksums, recovery models, and backup progress reporting.

These concepts are important for protecting database availability and recovering data.

## 7. Key Takeaway

SQL Server Audit, CDC, and DML triggers serve different purposes.

Understanding their differences helps when deciding how to monitor database activity, capture data changes, and maintain reliable database systems.
