/*

DOCUMENT BOOK 

*/

---------- BILL/ใบแจ้งหนี้
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'BILL'


---------- NOTICE/หนังสือทวงถาม
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y' AND fcCode = 'NOTICE'


---------- JOBORDER/ใบแจ้งซ่อม
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'JOB%'


---------- INV/ใบเสร็จรับเงิน
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'INV'


---------- INV/ใบเสร็จรับเงิน
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'INVCN'


---------- PR/ใบขอซื้อ
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'PR' 


---------- PO/ใบสั่งซื้อ
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'PO' 



---------- PI /ใบวางบิล 
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'PI%'



---------- PV/ใบรับบริการ/ใบวางบิล
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'PV%'


