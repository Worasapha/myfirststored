
SELECT 
object_name = OBJECT_NAME(sm.object_id), 
o.type_desc, 
sm.definition  
FROM sys.sql_modules AS sm  
JOIN sys.objects AS o ON sm.object_id = o.object_id  
WHERE sm.definition like '%tmIDT%'  
ORDER BY  o.type, o.name, o.object_id


SELECT 
ROUTINE_NAME, 
ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE 1=1
AND ROUTINE_DEFINITION LIKE '%ก%' 
AND ROUTINE_TYPE='PROCEDURE'
/*
	FUNCTION
    PROCEDURE
*/

SELECT
* 
FROM SYS.PROCEDURES p 
JOIN SYS.SYSCOMMENTS s on p.object_id = s.id 
WHERE [TEXT] LIKE '%tmBRN%';
