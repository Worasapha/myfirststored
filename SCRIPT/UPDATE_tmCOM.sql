
UPDATE  tmCOM 
SET fcIsActive = 'N'
WHERE fcID In (
SELECT 
*
FROM tmCOM_InActive
)



