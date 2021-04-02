SELECT *
OBJECT_NAME(id) 
FROM SYSCOMMENTS 
WHERE [text] LIKE '%เสร็จ%' 
AND OBJECTPROPERTY(id, 'IsProcedure') = 1 
GROUP BY OBJECT_NAME(id)


SELECT *
OBJECT_NAME(object_id)
FROM SYS.SQL_MODULES
WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1
AND definition LIKE '%เสร็จ%'




