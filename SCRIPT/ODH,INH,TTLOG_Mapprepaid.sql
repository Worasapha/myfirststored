
/*

���˹�� BILL

*/

SELECT TOP 1000  
tmCOM.fcCode TMCOM_FCCODE,
TMCOM.fcName,
TTODH.fcCode,
TTODH.ftDate,
TTODH.fcIsCancel,
--- != C
TTODH.fcPostStep,
--- P = PRINT, A = GL
TTODH.fcIsPaid,
--- D = ���ºҧ��ǹ, F = FINISH
tmPROODH.fcCode,
tmPROODH.fcName,
TTODD.fnUnitPrice,
TTODD.fnQty,
TTODD.fnTotAmt,
TTODD.fcRemark,
TTODD.fnPadAmt
FROM tmCOM
INNER JOIN tmBRN ON tmBRN.fcCOMID = tmCOM.fcID AND TMBRN.fcIsActive = 'Y'
INNER JOIN tmDCT ON tmDCT.fcBRNID = TMBRN.fcID 
INNER JOIN tmDCB ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'BILL'
INNER JOIN ttODH ON ttODH.fcDCBID = TMDCB.fcID 
INNER JOIN ttODD ON TTODD.fcODHID = TTODH.fcID AND TTODH.fcIsCancel != 'C'
INNER JOIN tmPRO AS tmPROODH ON tmPROODH.fcID = ttODD.fcPROID
WHERE tmCOM.fcIsActive = 'Y'


/*

����� INV

*/

SELECT 
tmCOM.fcCode TMCOM_FCCODE,
TMCOM.fcName,
ttINH.fcCode,
ttINH.ftDate,
ttINH.fcIsCancel,
ttINH.fcPostStep,
--- P = PRINT, A = GL
ttINH.fcIsPaid,
TMPRO.fcCode,
TMPRO.fcName,
ttIND.fnUnitPrice,
ttIND.fnQty,
ttIND.fnTotAmt,
ttIND.fcRemark,
ttIND.fnPadAmt
FROM tmCOM
INNER JOIN tmBRN ON tmBRN.fcCOMID = tmCOM.fcID AND TMBRN.fcIsActive = 'Y'
INNER JOIN tmDCT ON tmDCT.fcBRNID = TMBRN.fcID 
INNER JOIN tmDCB ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'INV'
INNER JOIN ttINH ON ttINH.fcDCBID = tmDCB.fcID 
INNER JOIN ttIND ON ttIND.fcINHID = ttINH.fcID 
INNER JOIN tmPRO ON tmPRO.fcID = ttIND.fcPROID
WHERE tmCOM.fcIsActive = 'Y'

--==========================================================================================================
--==========================================================================================================
--==========================================================================================================
/*
	���˹�� ����Ѻ ����� 
	--- �óշ���ҽ�觵��˹���ҡ����
*/

SELECT TOP 1000  
tmCOM.fcCode TMCOM_FCCODE,
TMCOM.fcName,
TTODH.fcCode,
TTODH.ftDate,
TTODH.fcIsCancel,
--- != C
TTODH.fcPostStep,
--- P = PRINT, A = GL
TTODH.fcIsPaid,
--- D = ���ºҧ��ǹ, F = FINISH
tmPROODH.fcCode,
tmPROODH.fcName,
TTODD.fnUnitPrice,
TTODD.fnQty,
TTODD.fnTotAmt,
TTODD.fcRemark,
TTODD.fnPadAmt
FROM tmCOM
INNER JOIN tmBRN ON tmBRN.fcCOMID = tmCOM.fcID AND TMBRN.fcIsActive = 'Y'
INNER JOIN tmDCT ON tmDCT.fcBRNID = TMBRN.fcID 
INNER JOIN tmDCB ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'BILL'
INNER JOIN ttODH ON ttODH.fcDCBID = tmDCB.fcID AND ttODH.fcIsCancel != 'C' 
INNER JOIN ttODD ON ttODD.fcODHID = ttODH.fcID 
LEFT JOIN ttIND  ON ttIND.fcREFID = ttODD.fcID
LEFT JOIN ttINH  ON ttINH.fcID = TTIND.fcINHID AND ttINH.fcIsCancel != 'C'
INNER JOIN tmPRO AS tmPROODH ON tmPROODH.fcID = ttODD.fcPROID
WHERE tmCOM.fcIsActive = 'Y'

--select  top 10 * from ttODD
--select  top 10 * from ttIND


/*
	���˹�� ����Ѻ ����� 
	--- �óշ���ҽ��������ҡ����
*/

SELECT TOP 1000
tmCOM.fcCode TMCOM_FCCODE,
TMCOM.fcName,
ttINH.fcCode,
ttINH.ftDate,
ttINH.fcIsCancel,
ttINH.fcPostStep,
--- P = PRINT, A = GL
ttINH.fcIsPaid,
TMPRO.fcCode,
TMPRO.fcName,
ttIND.fnUnitPrice,
ttIND.fnQty,
ttIND.fnTotAmt,
ttIND.fcRemark,
ttIND.fnPadAmt
FROM tmCOM
INNER JOIN tmBRN ON tmBRN.fcCOMID = tmCOM.fcID AND TMBRN.fcIsActive = 'Y'
INNER JOIN tmDCT ON tmDCT.fcBRNID = TMBRN.fcID 
INNER JOIN tmDCB ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'INV'
INNER JOIN ttINH ON ttINH.fcDCBID = tmDCB.fcID AND ttINH.fcIsCancel != 'C'
INNER JOIN ttIND ON ttIND.fcINHID = ttINH.fcID 
LEFT  JOIN ttODD ON ttODD.fcREFID = ttIND.fcID
LEFT  JOIN ttODH ON ttODH.fcID = ttODD.fcODHID AND ttODH.fcIsCancel != 'C'
INNER JOIN tmPRO ON tmPRO.fcID = ttIND.fcPROID
WHERE tmCOM.fcIsActive = 'Y'

--=======================
/*
	��������Ѻ��ǧ˹��
*/

SELECT DISTINCT TOP 1000  
tmCOM.fcCode TMCOM_FCCODE,
TMCOM.fcName,
ttODH.fcCode,
ttODH.ftDate,
ttODH.fcIsCancel,
--- != C
ttODH.fcPostStep,
--- P = PRINT, A = GL
ttODH.fcIsPaid,
--- D = ���ºҧ��ǹ, F = FINISH
tmPRO.fcCode,
tmPRO.fcName,
ttODD.fnUnitPrice,
ttODD.fnQty,
ttODD.fnTotAmt,
ttODD.fcRemark,
ttODD.fnPadAmt,
ttIND.fnTotAmt
FROM tmCOM
INNER JOIN tmBRN ON tmBRN.fcCOMID = tmCOM.fcID AND TMBRN.fcIsActive = 'Y'
INNER JOIN tmDCT ON tmDCT.fcBRNID = TMBRN.fcID 
INNER JOIN tmDCB ON tmDCB.fcDCTID = tmDCT.fcID AND tmDCB.fcCode = 'BILL' AND tmDCB.fcIsActive = 'Y' 
INNER JOIN ttODH ON ttODH.fcDCBID = tmDCB.fcID AND ttODH.fcIsCancel != 'C' 
INNER JOIN ttODD ON ttODD.fcODHID = ttODH.fcID
INNER JOIN ttLOG_MapPrepaid ON ttLOG_MapPrepaid.fcODDID = ttODD.fcID 
INNER JOIN ttIND  ON ttIND.fcID = ttLOG_MapPrepaid.fcINDID  
LEFT JOIN  ttINH  ON ttINH.fcID = TTIND.fcINHID AND ttINH.fcIsCancel != 'C'
INNER JOIN tmPRO ON tmPRO.fcID = ttIND.fcPROID AND tmPRO.fcCode = 'D001'
WHERE tmCOM.fcIsActive = 'Y'
--AND CONVERT(DATE,TTODH.ftDate) BETWEEN '2020-01-01' AND '2020-12-31'  
AND CONVERT(DATE,TTODH.ftDate) BETWEEN '2021-03-01' AND '2021-03-31'  
ORDER BY tmCOM.fcName ASC


/*
	������ҧ�ҡ����
*/
select top 1000 * 
from tmCOM with (nolock)
inner join tmBRN with (nolock) on tmBRN.fcCOMID = tmCOM.fcID
inner join tmDCT with (nolock) on tmDCT.fcBRNID = tmBRN.fcID
inner join tmDCB with (nolock) on tmDCB.fcDCTID = tmDCT.fcID
inner join ttODH with (nolock) on ttODH.fcDCBID = tmDCB.fcID
inner join ttODD with (nolock) on ttODD.fcODHID = ttODH.fcID
inner join ttLOG_MapPrepaid as a with (nolock) on a.fcODDID = ttODD.fcID
inner join ttIND with (nolock) on ttIND.fcID = a.fcINDID
where tmDCB.fcCode = 'BILL' and tmCOM.fcIsActive = 'Y' and ttODH.fcIsCancel <> 'C'

--=============================
