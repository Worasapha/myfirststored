-- Search Tables:
SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%fcComID%'
AND		t.name LIKE '%tm%'
AND t.name NOT IN(
'tmCOM','tmBRN','tmODT','tmODB','tmACC'
,'tmACCCashStatement','tmArticle','tmBNK','tmCGP'
,'tmCOM_Firebase','tmCOM_GetPending','tmCOR'
,'tmCUR','tmJOB','tmMasterRemark','tmMobileSettings','tmMOD'
,'tmJuristicSettings','tmLabelConditionSearch','tmLbReceptionCard','tmLbReceptionSum'
,'tmNotifyEmailUser','tmPenaltyRateStep','tmPeriodCondo','tmPKH','tmPOS','tmPRJ'
,'tmPRO','tmPTY','tmRFID','tmRLT','tmRSA','tmTAX','tmUNT'
) -- TABLE USE
-------------------------
AND t.name NOT IN(
'Import_tmPro','tmBRN_Temp','tmCOR_','tmCOR_1','tmCOR_11'
,'tmCOR_COMID_IS_NULL','tmCOR1234','tmCOR2','tmCOR2_Bck20180622','tmCOR_Echo'
,'Import_tmPro','tmCOR_1','tmPRO2'
) --- TABLE NOT USE
ORDER BY    TableName,ColumnName


SELECT  * FROM tmVisitorCard WHERE fcIsActive = 'Y'

SELECT * FROM tmACC WHERE fcIsActive = 'Y' AND fnLevel = 0 AND fcCOMID = 'W8LFMQIB14'

SELECT * FROM tmACC WHERE fcIsActive = 'Y' AND fnLevel = 1

SELECT * FROM tmACCCashStatement WHERE fcIsActive = 'Y' AND fcCOMID = 'W8LFMQIB14'

SELECT TOP 100 * FROM tmMobileSettings  

SELECT * FROM tmCOM WHERE fcID = '00FC8547A1'

SELECT * FROM tmCOM WHERE CONVERT(DATE,ftCreateDate) >= '2021-01-01' AND fcIsActive = 'Y'


