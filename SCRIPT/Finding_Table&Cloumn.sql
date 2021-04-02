-- Search Tables:
SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%fcDCBID%'
--WHERE		t.name LIKE '%tt%'
ORDER BY    TableName,ColumnName


-- Search Tables and Views:
SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE '%tmDCB_fcCode%'
ORDER BY    TableName,ColumnName


