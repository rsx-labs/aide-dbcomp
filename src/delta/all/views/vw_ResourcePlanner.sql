USE [AIDE]
GO

/****** Object:  View [dbo].[vw_ResourcePlanner]    Script Date: 06/25/2020 12:28:19 PM ******/
DROP VIEW [dbo].[vw_ResourcePlanner]
GO

/****** Object:  View [dbo].[vw_ResourcePlanner]    Script Date: 06/25/2020 12:28:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







	CREATE VIEW [dbo].[vw_ResourcePlanner] AS
	


	Select planner.EMP_ID as EmployeeID,
			(emp.LAST_NAME + ', '+ emp.FIRST_NAME + ' ' + emp.MIDDLE_NAME) as EmployeeName,
			planner.STATUS as [StatusID],
			stat.DESCR as StatusDesc,
			Case 
				when planner.STATUS=1 then 'O'
				when planner.STATUS=11 then 'L'
				when planner.STATUS=2 then 'P'
				when planner.STATUS=3 then 'SL'
				when planner.STATUS=4 then 'VL'
				when planner.STATUS=5 then 'HSL'
				when planner.STATUS=6 then 'HVL'
				when planner.STATUS=7 then 'H'
				when planner.STATUS=8 then 'EL'
				when planner.STATUS=9 then 'HEL'
				when planner.STATUS=10 then 'OL'
				when planner.STATUS=13 then 'OBA'
				when planner.STATUS=12 then 'HOL'
				when planner.STATUS=14 then 'HOBA'
			End as ShortStatusDesc,
			convert(date,planner.DATE_ENTRY,10) as DateEntry,
			emp.DEPT_ID as DepartmentID,
			dept.DESCR as Department,
			emp.DIV_ID as DivisionID,
			div.DESCR as Division,
			emp.ACTIVE as IsActive,
			month(planner.DATE_ENTRY) as MonthID,
			Year(planner.DATE_ENTRY) as YearID,
			dbo.fn_getFiscalYear(planner.DATE_ENTRY, planner.DATE_ENTRY) as FiscalYear
	From ATTENDANCE planner
		inner join EMPLOYEE emp 
			on planner.EMP_ID = emp.EMP_ID
		inner join DEPARTMENT dept
			on dept.DEPT_ID = emp.DEPT_ID
		inner join DIVISION div
			on emp.DEPT_ID = div.DEPT_ID and emp.DIV_ID = div.DIV_ID
		inner join [Status] stat
			on planner.STATUS = stat.STATUS and stat.STATUS_NAME in ('ATTENDANCE','RESOURCE PLANNER')
	













GO


