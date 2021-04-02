/*

--tmGLL
--tmRPT
--tmRUN

*/

-- Search Tables:
SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%fcCOMID%'
AND		t.name LIKE 'tm%'
AND t.name NOT IN(
'tmCOR_','tmCOR_1','tmCOR_11','tmCOR_COMID_IS_NULL','tmCOR_Echo'
,'tmCOR1234','tmCOR2','tmCOR2_Bck20180622','tmPRO2'
) -- TABLE USE
---------------------------
--AND t.name NOT IN(
--'ttINH2','ttINH_Transfer', 'ttINH_xxx','ttINH201812'
--,'ttODH_A','ttODH_Echo','ttODH_temp','ttODH2','ttINH'
--) --- TABLE NOT USE
ORDER BY    TableName
--,ColumnName

SELECT  top 100 * FROM ttINH 

SELECT  top 100 * FROM ttBLH 

SELECT * FROM tmACC WHERE fcIsActive = 'Y' AND fnLevel = 0 AND fcCOMID = 'W8LFMQIB14'

SELECT * FROM tmACC WHERE fcIsActive = 'Y' AND fnLevel = 1

SELECT * FROM tmACCCashStatement WHERE fcIsActive = 'Y' AND fcCOMID = 'W8LFMQIB14'

SELECT TOP 100 * FROM tmMobileSettings  

SELECT * FROM tmCOM WHERE fcID = '00FC8547A1'

SELECT * FROM tmCOM WHERE CONVERT(DATE,ftCreateDate) >= '2021-01-01' AND fcIsActive = 'Y'


