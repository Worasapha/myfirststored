/*

DROP TABLE #BILLTemp
DROP TABLE #NOTICETemp
DROP TABLE #JOBORDERTemp
DROP TABLE #POSTTemp
DROP TABLE #INVTemp
DROP TABLE #INVCNTemp
DROP TABLE #PRTemp
DROP TABLE #POTemp
DROP TABLE #PITemp
DROP TABLE #PVTemp

*/


CREATE TABLE #BILLTemp
(
  BILLtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  BILLTOTAL			INT
)

CREATE TABLE #NOTICETemp
(
  NOTICEtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  NOTICETOTAL			INT
)

CREATE TABLE #JOBORDERTemp
(
  JOBtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  JOBTOTAL			INT
)

CREATE TABLE #POSTTemp
(
  POSTtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  POSTTOTAL			INT
)

CREATE TABLE #INVTemp
(
  INVtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  INVTOTAL			INT
)


CREATE TABLE #INVCNTemp
(
  INVCNtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  INVCNTOTAL			INT
)


CREATE TABLE #PRTemp
(
  PRtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  PRTOTAL			INT
)


CREATE TABLE #POTemp
(
  POtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  POTOTAL			INT
)


CREATE TABLE #PITemp
(
  PItmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  PITOTAL			INT
)


CREATE TABLE #PVTemp
(
  PVtmCOMfcID		CHAR(10) COLLATE Thai_CI_AS,
  PVTOTAL			INT
)




INSERT INTO #BILLTemp
SELECT 
tmCOM.fcID,
COUNT(ttODH.fcID) AS BILLTOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmDCT WITH (NOLOCK) ON TMDCT.fcBRNID = tmBRN.fcID
INNER JOIN tmDCB WITH (NOLOCK) ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'BILL'
INNER JOIN ttODH WITH (NOLOCK) ON TTODH.fcDCBID = tmDCB.fcID AND ttODH.fcIsCancel != 'C' 
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID





INSERT INTO #NOTICETemp
SELECT 
tmCOM.fcID,
COUNT(ttODH.fcID) AS NOTICETOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmDCT WITH (NOLOCK) ON TMDCT.fcBRNID = tmBRN.fcID
INNER JOIN tmDCB WITH (NOLOCK) ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'NOTICE'
INNER JOIN ttODH WITH (NOLOCK) ON TTODH.fcDCBID = tmDCB.fcID AND ttODH.fcIsCancel != 'C' 
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID

--SELECT * FROM #NOTICETemp



INSERT INTO #JOBORDERTemp
SELECT 
tmCOM.fcID,
COUNT(ttODH.fcID) AS JOBTOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmDCT WITH (NOLOCK) ON TMDCT.fcBRNID = tmBRN.fcID
INNER JOIN tmDCB WITH (NOLOCK) ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode LIKE 'JOB%'
INNER JOIN ttODH WITH (NOLOCK) ON TTODH.fcDCBID = tmDCB.fcID AND ttODH.fcIsCancel != 'C'   
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID


INSERT INTO #POSTTemp
SELECT 
tmCOM.fcID,
COUNT(ttPostService.fcID) AS POSTTOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmRoomH WITH (NOLOCK) ON tmRoomH.fcBRNID = tmBRN.fcID AND tmRoomH.fcIsActive = 'Y'
INNER JOIN ttPostService WITH (NOLOCK) ON ttPostService.fcROOMID =tmRoomH.fcID
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID



INSERT INTO #INVTemp
SELECT 
tmCOM.fcID,
COUNT(ttINH.fcID) AS INVTOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmDCT WITH (NOLOCK) ON TMDCT.fcBRNID = tmBRN.fcID
INNER JOIN tmDCB WITH (NOLOCK) ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'INV' 
INNER JOIN ttINH WITH (NOLOCK) ON ttINH.fcDCBID = tmDCB.fcID AND ttINH.fcIsCancel != 'C'  
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID



INSERT INTO #INVCNTemp
SELECT 
tmCOM.fcID,
COUNT(ttINH.fcID) AS INVCNTOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmDCT WITH (NOLOCK) ON tmDCT.fcBRNID = tmBRN.fcID
INNER JOIN tmDCB WITH (NOLOCK) ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'INVCN'
INNER JOIN ttINH WITH (NOLOCK) ON ttINH.fcDCBID = tmDCB.fcID AND ttINH.fcIsCancel != 'C'  
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID



INSERT INTO #PRTemp
SELECT 
tmCOM.fcID,
COUNT(ttRQH.fcID) AS PRTOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmDCT WITH (NOLOCK) ON TMDCT.fcBRNID = tmBRN.fcID
INNER JOIN tmDCB WITH (NOLOCK) ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode LIKE 'PR%'
INNER JOIN ttRQH WITH (NOLOCK) ON ttRQH.fcDCBID = tmDCB.fcID AND ttRQH.fcIsCancel != 'C'  
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID


INSERT INTO #POTemp
SELECT 
tmCOM.fcID,
COUNT(ttODH.fcID) AS POTOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmDCT WITH (NOLOCK) ON TMDCT.fcBRNID = tmBRN.fcID
INNER JOIN tmDCB WITH (NOLOCK) ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode LIKE 'PO%'
INNER JOIN ttODH WITH (NOLOCK) ON ttODH.fcDCBID = tmDCB.fcID AND ttODH.fcIsCancel != 'C'  
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID


INSERT INTO #PITemp
SELECT 
tmCOM.fcID,
COUNT(ttINH.fcID) AS PITOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmDCT WITH (NOLOCK) ON TMDCT.fcBRNID = tmBRN.fcID
INNER JOIN tmDCB WITH (NOLOCK) ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode LIKE 'PI%'
INNER JOIN ttINH WITH (NOLOCK) ON ttINH.fcDCBID = tmDCB.fcID AND ttINH.fcIsCancel != 'C'  
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID




INSERT INTO #PVTemp
SELECT 
tmCOM.fcID,
COUNT(ttVCH.fcID) AS PITOTAL
FROM tmCOM WITH (NOLOCK)
INNER JOIN tmBRN WITH (NOLOCK) ON tmCOM.fcID = tmBRN.fcCOMID
INNER JOIN tmGLB WITH (NOLOCK) ON tmGLB.fcBRNID = tmBRN.fcID
INNER JOIN ttVCH WITH (NOLOCK) ON ttVCH.fcGLBID = tmGLB.fcID AND ttVCH.fcIsCancel != 'C'  
WHERE tmCOM.fcIsActive = 'Y'
GROUP BY tmCOM.fcID



SELECT
tmCOM.fcCode,
tmCOM.fcName,
BILLTOTAL
,NOTICETOTAL
,JOBTOTAL
,POSTTOTAL
,INVTOTAL
,INVCNTOTAL
,PRTOTAL
,POTOTAL
,PITOTAL
,PVTOTAL
FROM tmCOM WITH (NOLOCK)
LEFT JOIN #BILLTemp  ON BILLtmCOMfcID  = tmCOM.fcID
LEFT JOIN #NOTICETemp ON NOTICEtmCOMfcID  = tmCOM.fcID
LEFT JOIN #JOBORDERTemp ON JOBtmCOMfcID  = tmCOM.fcID
LEFT JOIN #POSTTemp ON POSTtmCOMfcID = tmCOM.fcID
LEFT JOIN #INVTemp ON INVtmCOMfcID = tmCOM.fcID
LEFT JOIN #INVCNTemp ON INVCNtmCOMfcID = tmCOM.fcID
LEFT JOIN #PRTemp ON PRtmCOMfcID = tmCOM.fcID
LEFT JOIN #POTemp ON POtmCOMfcID = tmCOM.fcID
LEFT JOIN #PITemp ON PItmCOMfcID = tmCOM.fcID
LEFT JOIN #PVTemp ON PVtmCOMfcID = tmCOM.fcID
WHERE tmCOM.fcIsActive = 'Y'

----- COLLATE SQL_Latin1_General_CP1_CI_AS


SELECT * FROM tmCOM WHERE tmCOM.fcIsActive = 'Y'

/*

DROP TABLE #BILLTemp
DROP TABLE #NOTICETemp
DROP TABLE #JOBORDERTemp
DROP TABLE #POSTTemp
DROP TABLE #INVTemp
DROP TABLE #INVCNTemp
DROP TABLE #PRTemp
DROP TABLE #POTemp
DROP TABLE #PITemp
DROP TABLE #PVTemp

*/




