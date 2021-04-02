 DECLARE @StartDate		date = '20210101';
 DECLARE @EndDate		date = '20210131';

 
 --3.1 ที่เปลี่ยนแปลงข้อมูลสำเร็จออกจากฝ่าย CS ( Pre- Approved ) 
 --กี่ Form ID  และที่ฝ่ายทะเบียนลูกค้าทำเสร็จ (Approved)  กี่ FormID
 --ขอตั้งแต่เดือน ม.ค.2563 ถึงปัจจุบัน

-- Single App
-- Department : CS
-- Action : Update information
-- Satus : Pre-Approved
Select SAlfh_Id, Min(SAlfh_LogDate) SAlfh_LogDate
Into  #His -- Drop Table #His
From SA_Log_FormHeader 
Where SAlfh_SAmfa_Id  = 3 
And SAlfh_Delflag = 0
And SAlfh_SAmfs_Id = 5
And SAlfh_LogDate >=  @StartDate
And SAlfh_LogDate <=  @EndDate
And SAlfh_SAfh_WebId is Null
Group By SAlfh_Id

--select * from #His

Select 
	Year(SAlfh_LogDate) AS [Year]
,	Month(SAlfh_LogDate) AS [Month]
,	Count(*) As AllProduct
From SA_FormHeader 
Inner Join #His On SAfh_Id = SAlfh_Id
Inner Join SA_FormProduct  On SAfpd_SAfh_Id = SAfh_Id And SAfpd_Delflag = 0
Inner Join SA_MProduct On SAfpd_SAmpd_Id = SAmpd_Id
Where SAfh_Delflag = 0
--and SAfh_SAmfa_Id = 3 
--And SAfh_SAmfs_Id = 5
Group By Year(SAlfh_LogDate),Month(SAlfh_LogDate)
Order By Year(SAlfh_LogDate), Month(SAlfh_LogDate)



--==================================================================================


-- Single App
-- Department : Oper
-- Action : Update information
-- Satus : Active ใช้ 6 เพราะ Active มีหลายแบบ
Select SAlfh_Id, Min(SAlfh_LogDate) SAlfh_LogDate
Into  #His_Oper -- Drop Table #His_Oper
From SA_Log_FormHeader 
Where SAlfh_SAmfa_Id  = 3 
And SAlfh_Delflag = 0
And SAlfh_SAmfs_Id = 6
And SAlfh_LogDate >=  @StartDate
And SAlfh_LogDate <=  @EndDate
And SAlfh_SAfh_WebId is Null
Group By SAlfh_Id

--select * from #His_Oper

Select 
	Year(SAlfh_LogDate) AS [Year]
,	Month(SAlfh_LogDate) AS [Month]
,	Count(*) As AllProduct
From SA_FormHeader 
Inner Join #His_Oper On SAfh_Id = SAlfh_Id
Inner Join SA_FormProduct On SAfpd_SAfh_Id = SAfh_Id And SAfpd_Delflag = 0
Inner Join SA_MProduct On SAfpd_SAmpd_Id = SAmpd_Id
Where SAfh_Delflag = 0
And SAfh_SAmfa_Id = 3 
--And SAfh_SAmfs_Id = 6
Group By Year(SAlfh_LogDate),Month(SAlfh_LogDate)
Order By Year(SAlfh_LogDate), Month(SAlfh_LogDate)
