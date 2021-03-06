USE [AIDE]
GO
/****** Object:  View [dbo].[vw_AccumulatedLeaves]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP VIEW [dbo].[vw_AccumulatedLeaves]
GO
/****** Object:  View [dbo].[vw_AccumulatedLeaves]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [dbo].[vw_AccumulatedLeaves] AS
	Select	EMP_ID as EmployeeID, 
			FISCAL_YEAR.ID as FiscalYear, 
			4 as LeaveType,  
			'Vacation Leave' as LeaveDesc,
			sum(counts) as TotalDays
	from RESOURCE_PLANNER
		inner join FISCAL_YEAR 
			on FISCAL_YEAR.ID = dbo.fn_getFiscalYear(date_entry,date_entry)
	where  status  in (4,8,9,6) 
		and status_cd = 1 
	group by	EMP_ID, 
				FISCAL_YEAR.ID

	union

	select	emp_id as EmployeeID, 
			FISCAL_YEAR.ID as FiscalYear, 
			3 as LeaveType,
			'Sick Leave' as LeaveDesc, 
			sum(counts) as TotalDays
	from RESOURCE_PLANNER
		inner join FISCAL_YEAR 
			on FISCAL_YEAR.ID = dbo.fn_getFiscalYear(date_entry,date_entry)
	where  status  in (3,5) and status_cd = 1 
	group by	EMP_ID,
				FISCAL_YEAR.ID
	




GO
