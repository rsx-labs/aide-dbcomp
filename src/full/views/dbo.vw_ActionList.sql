USE [AIDE]
GO
/****** Object:  View [dbo].[vw_ActionList]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP VIEW [dbo].[vw_ActionList]
GO
/****** Object:  View [dbo].[vw_ActionList]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [dbo].[vw_ActionList] AS
	
	Select act.ACTREF as ActionID,
			act.ACT_MESSAGE as [Action],
			emp.EMP_ID as EmployeeID,
			(emp.LAST_NAME + ', ' + emp.FIRST_NAME + ' ' + emp.MIDDLE_NAME) as EmployeeName,
			act.DATE_CREATED as DateCreated,
			act.DUE_DATE as DueDate,
			act.DATE_CLOSED as DateClosed,
			emp.DIV_ID as DivisionID,
			div.DESCR as Division,
			emp.DEPT_ID as DepartmentID,
			div.DESCR as Department,
			act.ACT_STATUS as [Status],
			emp.ACTIVE as IsActive,
			Month(act.DUE_DATE) as [Month],
			Year(act.DUE_DATE) as [Year],
			dbo.fn_getFiscalYear(act.DUE_DATE, act.DUE_DATE) as FiscalYear
	From ACTIONLIST act
		inner join EMPLOYEE emp 
			on act.EMP_ID = emp.EMP_ID
		inner join DEPARTMENT dept
			on dept.DEPT_ID = emp.DEPT_ID
		inner join DIVISION div
			on emp.DIV_ID = div.DIV_ID



GO
