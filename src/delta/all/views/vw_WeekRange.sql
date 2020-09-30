USE [AIDE]
GO

DROP VIEW [dbo].[vw_WeekRange]
GO

/****** Object:  View [dbo].[vw_WeekRange]    Script Date: 09/30/2020 6:29:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



	ALTER VIEW [dbo].[vw_WeekRange] AS
	
	Select wk.WEEK_ID as WeekID,
			wk.WEEK_START as WeekStart,
			wk.WEEK_END as WeekEnd,
			Convert(varchar,wk.WEEK_END,112) as [Range],
			dbo.fn_getFiscalYear(wk.WEEK_START,wk.WEEK_START) as FiscalYear,
			wk.MONTH as [Month],
			Year(wk.Week_Start) as [Year]

	From WEEK_RANGE wk
		

GO


