SELECT *
FROM sys.databases
WHERE name = DB_NAME();

DBCC useroptions