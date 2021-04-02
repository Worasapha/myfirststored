DECLARE @Start  date = '20210101';
DECLARE @Cutoff date = '20210216';


--DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 1, @StartDate));


;WITH seq(n) AS 
(
  SELECT 0 
  UNION ALL 
  SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @Start, @Cutoff))
,d(d) AS (SELECT DATEADD(DAY, n, @Start) FROM seq)
,src AS
(
  SELECT
    TheDate         = CONVERT(date, d)
    ,TheDay          = DATEPART(DAY,       d)
    ,TheDayName      = DATENAME(WEEKDAY,   d)
    --TheWeek         = DATEPART(WEEK,      d),
    --TheISOWeek      = DATEPART(ISO_WEEK,  d),
    --TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    ,TheMonth        = DATEPART(MONTH,     d)
    ,TheMonthName    = DATENAME(MONTH,     d)
    --TheQuarter      = DATEPART(Quarter,   d),
    ,TheYear         = DATEPART(YEAR,      d)
    --TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    --TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    --,TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
) -- Drop Table #THEDATE
SELECT *  INTO #THEDATE FROM src
  ORDER BY TheDate
  OPTION (MAXRECURSION 0);


--select * from #THEDATE


/* Create 31 Day by Month */
select 
D.TheYear,D.TheDay
,CASE When D.TheMonth = 1  Then '' Else '' End AS 'January'
,CASE When D.TheMonth = 2  Then '' Else '' End AS 'February'
,CASE When D.TheMonth = 3  Then '' Else '' End AS 'March'
,CASE When D.TheMonth = 4  Then '' Else '' End AS 'April'
,CASE When D.TheMonth = 5  Then '' Else '' End AS 'May'
,CASE When D.TheMonth = 6  Then '' Else '' End AS 'June'
,CASE When D.TheMonth = 7 Then '' Else '' End AS 'July'
,CASE When D.TheMonth = 8  Then '' Else '' End AS 'August'
,CASE When D.TheMonth = 9   Then '' Else '' End AS 'September'
,CASE When D.TheMonth = 10  Then '' Else '' End AS 'October'
,CASE When D.TheMonth = 11  Then '' Else '' End AS 'November'
,CASE When D.TheMonth = 12	Then '' Else '' End AS 'December'
INTO #Calendar -- Drop Table #Calendar
from #THEDATE AS D
where D.TheDay between 1 and 31
and D.TheMonth = 1

--select * from #Calendar


--**********************************************************************
-- เงื่อนไข
-- 6.งานที่สำเร็จจากฝ่าย CS ที่ทาง risk  approve  ทั้ง SA และ OA  กี่ FormID  รวมเป็นรายวัน (summary รายเดือน) 
--**********************************************************************

--==================================================================================
-- Single App
--==================================================================================
-- Department : Risk
-- Action : New customer(1),New Product(2),Update Suit(4),Change Program Trade(10)
-- Satus : Check(4)
------------------
-- Action : Update Information(3)
-- Satus : Pre-Approved(5)

Select SAlfh_Id, Min(convert(date,SAlfh_LogDate)) SAlfh_LogDate
Into  #His -- Drop Table #His
from SA_Log_FormHeader 
where SAlfh_SAmfa_Id IN(1,2,3,4,10) 
And SAlfh_SAmfs_Id IN(4,5)
and SAlfh_Delflag = 0
and SAlfh_Id IN (select SAfca_SAfh_Id from sa_formca where SAfca_RiskOpinion IS NOT NULL and SAfca_Delflag = 0 )
And SAlfh_LogDate >=  @Start 
And SAlfh_LogDate <=  @Cutoff
And SAlfh_SAfh_WebId is Null
Group By SAlfh_Id

--select * from #His

-----------------------
-- Detail
-----------------------
Select 
D.TheYear
--,D.TheMonthName
,D.TheMonth
--,D.TheDate
,D.TheDay	
--,D.TheDayName
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 1 Then COUNT(SAlfh_Id) Else '' End AS 'January'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 2 Then COUNT(SAlfh_Id) Else '' End AS 'February'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 3 Then COUNT(SAlfh_Id) Else '' End AS 'March'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 4 Then COUNT(SAlfh_Id) Else '' End AS 'April'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 5 Then COUNT(SAlfh_Id) Else '' End AS 'May'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 6 Then COUNT(SAlfh_Id) Else '' End AS 'June'
------
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 7 Then COUNT(SAlfh_Id) Else '' End AS 'July'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 8 Then COUNT(SAlfh_Id) Else '' End AS 'August'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 9 Then COUNT(SAlfh_Id) Else '' End AS 'September'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 10 Then COUNT(SAlfh_Id) Else '' End AS 'October'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 11 Then COUNT(SAlfh_Id) Else '' End AS 'November'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 12 Then COUNT(SAlfh_Id) Else '' End AS 'December'
--,COUNT(SAlfh_Id) As 'FormOfDate'
INTO #FromTotal -- Drop Table #FromTotal
From SA_FormHeader 
Inner Join #His On SAfh_Id = SAlfh_Id
left join #THEDATE AS D On TheDate = SAlfh_LogDate
Inner Join SA_FormProduct  On SAfpd_SAfh_Id = SAfh_Id And SAfpd_Delflag = 0
Inner Join SA_MProduct On SAfpd_SAmpd_Id = SAmpd_Id And SAmpd_Delflag = 0
Where SAfh_Delflag = 0
group by D.TheYear
,D.TheMonth
,D.TheMonthName
,D.TheDate
,TheDay	
,SAlfh_LogDate
--,D.TheDayName
Order by D.TheMonth,D.TheDate
--,D.TheDayName

--select * from #FromTotal as D Order by D.TheMonth,D.TheDay


select 
D.TheYear,D.TheDay
,CASE WHEN J.January	  IS NULL THEN 0 ELSE	J.January	  End AS 'January'
,CASE WHEN F.February	  IS NULL THEN 0 ELSE	F.February	  End AS 'February'
,CASE WHEN M.March		  IS NULL THEN 0 ELSE	M.March		  End AS 'March'
,CASE WHEN A.April		  IS NULL THEN 0 ELSE	A.April		  End AS 'April'
,CASE WHEN May.May		  IS NULL THEN 0 ELSE	May.May		  End AS 'May'
,CASE WHEN Jun.June		  IS NULL THEN 0 ELSE	Jun.June	  End AS 'June'
--
,CASE WHEN Jul.July		  IS NULL THEN 0 ELSE	Jul.July	  End AS 'July'
,CASE WHEN Aug.August	  IS NULL THEN 0 ELSE	Aug.August	  End AS 'August'
,CASE WHEN Sep.September  IS NULL THEN 0 ELSE	Sep.September End AS 'September'
,CASE WHEN Oct.October	  IS NULL THEN 0 ELSE	Oct.October	  End AS 'October'
,CASE WHEN Nov.November	  IS NULL THEN 0 ELSE	Nov.November  End AS 'November'
,CASE WHEN Dece.December  IS NULL THEN 0 ELSE	Dece.December End AS 'December'
from #Calendar AS D
Left Join #FromTotal AS J On J.TheDay = D.TheDay and J.January != 0
Left Join #FromTotal AS F On F.TheDay = D.TheDay and F.February != 0
Left Join #FromTotal AS M On M.TheDay = D.TheDay and M.March != 0
Left Join #FromTotal AS A On A.TheDay = D.TheDay and A.April != 0
Left Join #FromTotal AS May On May.TheDay = D.TheDay and May.May != 0
Left Join #FromTotal AS Jun On Jun.TheDay = D.TheDay and Jun.June != 0
---
Left Join #FromTotal AS Jul On Jul.TheDay = D.TheDay and Jul.July != 0
Left Join #FromTotal AS Aug On Aug.TheDay = D.TheDay and Aug.August != 0
Left Join #FromTotal AS Sep On Sep.TheDay = D.TheDay and Sep.September != 0
Left Join #FromTotal AS Oct On Oct.TheDay = D.TheDay and Oct.October != 0
Left Join #FromTotal AS Nov On Nov.TheDay = D.TheDay and Nov.November != 0
Left Join #FromTotal AS Dece On Dece.TheDay = D.TheDay and Dece.December != 0
group by D.TheYear,D.TheDay
,J.January,F.February,M.March,A.April,May.May,Jun.June
,Jul.July,Aug.August,Sep.September,Oct.October,Nov.November,Dece.December
order by D.TheYear,D.TheDay


---------------------
---- ToTal
--------------------
Select 
D.TheYear
,D.TheMonth
,D.TheMonthName
,D.TheDate	
,D.TheDayName
,COUNT(SAlfh_Id) As 'FormOfDate'
INTO #FromForSum -- Drop Table #FromForSum
From SA_FormHeader 
Inner Join #His On SAfh_Id = SAlfh_Id
left join #THEDATE AS D On TheDate = SAlfh_LogDate
Inner Join SA_FormProduct  On SAfpd_SAfh_Id = SAfh_Id And SAfpd_Delflag = 0
Inner Join SA_MProduct On SAfpd_SAmpd_Id = SAmpd_Id And SAmpd_Delflag = 0
Where SAfh_Delflag = 0
group by D.TheYear
,D.TheMonth
,D.TheMonthName
,D.TheDate	
,D.TheDayName
Order by D.TheMonth,D.TheDate,D.TheDayName

--select * from #FromForSum as D Order by D.TheMonth,D.TheDate,D.TheDayName

Select 
D.TheYear,D.TheMonthName
,SUM(D.FormOfDate) As 'Total'
,MIN(D.FormOfDate) AS 'Min'
,MAX(D.FormOfDate) AS 'Max'
,AVG(D.FormOfDate) AS 'Average'
--,(MIN(D.FormOfDate) + MAX(D.FormOfDate)) / 2 AS 'Median'
From #FromForSum AS D
group by D.TheYear,D.TheMonth ,D.TheMonthName
Order by D.TheMonth 


--==================================================================================
-- Online App
--==================================================================================
-- Department : Risk
-- Action : Update Information(3)
-- Satus : Pre-Approved(5)

Select SAlfh_Id, Min(convert(date,SAlfh_LogDate)) SAlfh_LogDate
Into  #His_Online -- Drop Table ##His_Online
from SA_Log_FormHeader 
where SAlfh_SAmfa_Id IN(1,2) 
And SAlfh_SAmfs_Id = 6
and SAlfh_Delflag = 0
and SAlfh_Id IN (select SAfca_SAfh_Id from sa_formca where SAfca_RiskOpinion IS NOT NULL and SAfca_Delflag = 0 )
And SAlfh_LogDate >=  '2020-01-01'
And SAlfh_LogDate <=  '2020-06-30'
And SAlfh_SAfh_WebId is Not Null
Group By SAlfh_Id

----select * from #His_Online

-------------------------
---- Detail
-------------------------
Select 
D.TheYear
--,D.TheMonthName
,D.TheMonth
--,D.TheDate
,D.TheDay	
--,D.TheDayName
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 1 Then COUNT(SAlfh_Id) Else '' End AS 'January'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 2 Then COUNT(SAlfh_Id) Else '' End AS 'February'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 3 Then COUNT(SAlfh_Id) Else '' End AS 'March'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 4 Then COUNT(SAlfh_Id) Else '' End AS 'April'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 5 Then COUNT(SAlfh_Id) Else '' End AS 'May'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 6 Then COUNT(SAlfh_Id) Else '' End AS 'June'
------
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 7 Then COUNT(SAlfh_Id) Else '' End AS 'July'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 8 Then COUNT(SAlfh_Id) Else '' End AS 'August'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 9 Then COUNT(SAlfh_Id) Else '' End AS 'September'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 10 Then COUNT(SAlfh_Id) Else '' End AS 'October'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 11 Then COUNT(SAlfh_Id) Else '' End AS 'November'
,CASE When convert(date,SAlfh_LogDate) = D.TheDate and D.TheMonth = 12 Then COUNT(SAlfh_Id) Else '' End AS 'December'
--,COUNT(SAlfh_Id) As 'FormOfDate'
INTO #FromTotalOnline -- Drop Table #FromTotalOnline
From SA_FormHeader 
Inner Join #His_Online On SAfh_Id = SAlfh_Id
left join #THEDATE AS D On TheDate = SAlfh_LogDate
Inner Join SA_FormProduct  On SAfpd_SAfh_Id = SAfh_Id And SAfpd_Delflag = 0
Inner Join SA_MProduct On SAfpd_SAmpd_Id = SAmpd_Id And SAmpd_Delflag = 0
Where SAfh_Delflag = 0
group by D.TheYear
,D.TheMonth
,D.TheMonthName
,D.TheDate
,TheDay	
,SAlfh_LogDate
--,D.TheDayName
Order by D.TheMonth,D.TheDate--,D.TheDayName

--select * from #FromTotalOnline as D Order by D.TheMonth,D.TheDay


select 
D.TheYear,D.TheDay
,CASE WHEN J.January	  IS NULL THEN 0 ELSE	J.January	  End AS 'January'
,CASE WHEN F.February	  IS NULL THEN 0 ELSE	F.February	  End AS 'February'
,CASE WHEN M.March		  IS NULL THEN 0 ELSE	M.March		  End AS 'March'
,CASE WHEN A.April		  IS NULL THEN 0 ELSE	A.April		  End AS 'April'
,CASE WHEN May.May		  IS NULL THEN 0 ELSE	May.May		  End AS 'May'
,CASE WHEN Jun.June		  IS NULL THEN 0 ELSE	Jun.June	  End AS 'June'
--
,CASE WHEN Jul.July		  IS NULL THEN 0 ELSE	Jul.July	  End AS 'July'
,CASE WHEN Aug.August	  IS NULL THEN 0 ELSE	Aug.August	  End AS 'August'
,CASE WHEN Sep.September  IS NULL THEN 0 ELSE	Sep.September End AS 'September'
,CASE WHEN Oct.October	  IS NULL THEN 0 ELSE	Oct.October	  End AS 'October'
,CASE WHEN Nov.November	  IS NULL THEN 0 ELSE	Nov.November  End AS 'November'
,CASE WHEN Dece.December  IS NULL THEN 0 ELSE	Dece.December End AS 'December'
from #Calendar AS D
Left Join #FromTotalOnline AS J On J.TheDay = D.TheDay and J.January != 0
Left Join #FromTotalOnline AS F On F.TheDay = D.TheDay and F.February != 0
Left Join #FromTotalOnline AS M On M.TheDay = D.TheDay and M.March != 0
Left Join #FromTotalOnline AS A On A.TheDay = D.TheDay and A.April != 0
Left Join #FromTotalOnline AS May On May.TheDay = D.TheDay and May.May != 0
Left Join #FromTotalOnline AS Jun On Jun.TheDay = D.TheDay and Jun.June != 0
---
Left Join #FromTotalOnline AS Jul On Jul.TheDay = D.TheDay and Jul.July != 0
Left Join #FromTotalOnline AS Aug On Aug.TheDay = D.TheDay and Aug.August != 0
Left Join #FromTotalOnline AS Sep On Sep.TheDay = D.TheDay and Sep.September != 0
Left Join #FromTotalOnline AS Oct On Oct.TheDay = D.TheDay and Oct.October != 0
Left Join #FromTotalOnline AS Nov On Nov.TheDay = D.TheDay and Nov.November != 0
Left Join #FromTotalOnline AS Dece On Dece.TheDay = D.TheDay and Dece.December != 0
group by D.TheYear,D.TheDay
,J.January,F.February,M.March,A.April,May.May,Jun.June
,Jul.July,Aug.August,Sep.September,Oct.October,Nov.November,Dece.December
order by D.TheYear,D.TheDay

---------------------
---- ToTal
--------------------
Select 
D.TheYear
,D.TheMonth
,D.TheMonthName
,D.TheDate	
,D.TheDayName
,COUNT(SAlfh_Id) As 'FormOfDate'
INTO #FromOnlineForSum -- Drop Table #FromOnlineForSum
From SA_FormHeader 
Inner Join #His_Online On SAfh_Id = SAlfh_Id
left join #THEDATE AS D On TheDate = SAlfh_LogDate
Inner Join SA_FormProduct  On SAfpd_SAfh_Id = SAfh_Id And SAfpd_Delflag = 0
Inner Join SA_MProduct On SAfpd_SAmpd_Id = SAmpd_Id And SAmpd_Delflag = 0
Where SAfh_Delflag = 0
group by D.TheYear
,D.TheMonth
,D.TheMonthName
,D.TheDate	
,D.TheDayName
Order by D.TheMonth,D.TheDate,D.TheDayName

--select * from #FromOnlineForSum as D Order by D.TheMonth,D.TheDate,D.TheDayName


Select 
D.TheYear,D.TheMonthName
,SUM(D.FormOfDate) As 'Total'
,MIN(D.FormOfDate) AS 'Min'
,MAX(D.FormOfDate) AS 'Max'
,AVG(D.FormOfDate) AS 'Average'
--,(MIN(D.FormOfDate) + MAX(D.FormOfDate)) / 2 AS 'Median'
From #FromOnlineForSum AS D
group by D.TheYear,D.TheMonth ,D.TheMonthName
Order by D.TheMonth 

