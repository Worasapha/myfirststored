
/****** Object:  Table [erp].[TRANSACTION_VIEW]    Script Date: 11/03/2564 9:50:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [erp].[TRANSACTION_VIEW](
	[tmCOR_fcName] [varchar](100) NULL,
	[ttODH_ftDate] [date] NULL,
	[ttODH_fnNetAmt] [numeric](18, 2) NULL,
	[tmCOM_fcName] [varchar](100) NULL,
	[tmDCB_fcName] [varchar](100) NULL,
	[tmDCB_fcCode]   [char](10) NULL,
	[ttODH_fcCode] [varchar](100) NULL,
	[tmBRN_fcCOMID] [char](10) NULL
) ON [PRIMARY]
GO

CREATE INDEX TRANSACTION_VIEW ON TRANSACTION_VIEW (ttODH_fcCode);


--INSERT INTO TRANSACTION_VIEW
SELECT   
tmCOR_fcName, 
ttODH_ftDate, 
ttODH_fnNetAmt, 
tmCOM_fcName, 
tmDCB_fcName, 
tmDCB_fcCode,
ttODH_fcCode, 
tmBRN_fcCOMID
FROM dbo.vtODH

