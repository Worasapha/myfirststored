/*

DOCUMENT BOOK 

*/

---------- BILL/���˹��
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE tmDCB.fcIsActive = 'Y' AND tmDCB.fcCode = 'BILL'


---------- NOTICE/˹ѧ��ͷǧ���
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y' AND fcCode = 'NOTICE'


---------- JOBORDER/��駫���
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'JOB%'


---------- INV/������Ѻ�Թ
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'INV'


---------- INV/������Ѻ�Թ
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'INVCN'


---------- PR/㺢ͫ���
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'PR' 


---------- PO/���觫���
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode = 'PO' 



---------- PI /��ҧ��� 
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'PI%'



---------- PV/��Ѻ��ԡ��/��ҧ���
SELECT DISTINCT
fcCode,fcName
FROM tmDCB
WHERE fcIsActive = 'Y'
AND fcCode LIKE 'PV%'


