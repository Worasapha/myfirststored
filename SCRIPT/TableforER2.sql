-- Search Tables:
SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%fcBRNID%'
AND		t.name LIKE '%tm%'
AND t.name NOT IN(
'tmAnnountment','tmASG','tmAST','tmAUT','tmBKB','tmCORMember'
,'tmDCT','tmDPT','tmEMP','tmGLB','tmGLP','tmJLUSR','tmMeter'
,'tmMLG','tmPCH','tmPeriodWork','tmPJT','tmPMH','tmPolicyH'
,'tmPostServiceSenderName','tmRoomH'
) -- TABLE USE
-------------------------
AND t.name NOT IN(
'import_tmMeter_Bck_P2020318','Import_tmRoomH','temp_tmmeter'
,'tmAUT_Temp','tmGLB_','tmRoomH_','tmRoomH_Echo','tmRoomH2','ttMobile_ServiceOrder'
,'ttMailmeeting'
) --- TABLE NOT USE
ORDER BY    TableName,ColumnName


SELECT  top 100 * FROM tmVoteDocNo WHERE fcIsActive = 'Y'

SELECT * FROM tmACC WHERE fcIsActive = 'Y' AND fnLevel = 0 AND fcCOMID = 'W8LFMQIB14'

SELECT * FROM tmACC WHERE fcIsActive = 'Y' AND fnLevel = 1

SELECT * FROM tmACCCashStatement WHERE fcIsActive = 'Y' AND fcCOMID = 'W8LFMQIB14'

SELECT TOP 100 * FROM tmMobileSettings  

SELECT * FROM tmCOM WHERE fcID = '00FC8547A1'

SELECT * FROM tmCOM WHERE CONVERT(DATE,ftCreateDate) >= '2021-01-01' AND fcIsActive = 'Y'


