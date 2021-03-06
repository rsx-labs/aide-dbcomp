USE [AIDE]
GO
/****** Object:  View [dbo].[vw_WeekRange]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP VIEW [dbo].[vw_WeekRange]
GO
/****** Object:  View [dbo].[vw_WeekRange]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [dbo].[vw_WeekRange] AS
	
	Select wk.WEEK_ID as WeekID,
			wk.WEEK_START as WeekStart,
			wk.WEEK_END as WeekEnd,
			Convert(varchar,wk.WEEK_END,112) as [Range],
			dbo.fn_getFiscalYear(wk.WEEK_START,wk.WEEK_START) as FiscalYear,
			Month(wk.Week_START) as [Month],
			Year(wk.Week_Start) as [Year]

	From WEEK_RANGE wk
		


GO
