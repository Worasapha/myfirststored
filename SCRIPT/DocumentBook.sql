/*

DOCUMENT BOOK 

*/

---------- BILL/愫屺椐斯臻
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'BILL'


---------- NOTICE/斯学首头千兑?
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y' AND fcCode = 'NOTICE'


---------- JOBORDER/愫屺椐土
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'JOB%'


---------- INV/愫嗍苗押唰怨
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'INV'


---------- INV/愫嗍苗押唰怨
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'INVCN'


---------- PR/愫⑼橥
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'PR' 


---------- PO/愫恃瑙橥
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'PO' 



---------- PI /愫且Ш耘 
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'PI%'



---------- PV/愫醚汉迷∫?/愫且Ш耘
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'PV%'


