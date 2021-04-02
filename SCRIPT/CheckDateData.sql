/*
	check date data backup
*/


select top 5 * from ttLOG  
where convert(date,ftWHEN) = '2021-03-16'
order by ftWHEN desc

----Success RecID:WAH)ZB4ZI1 Code:6311000015

----select * from vtVCH where ttVCH_fcID = 'WAH)ZB4ZI1'
----WA1ZMR290P

----select * from tmUSR where fcID = 'WA1ZMR290P'
