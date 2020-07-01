USE [AIDE]
GO

/****** Object:  View [dbo].[vw_SuccessRegisters]    Script Date: 06/25/2020 12:20:45 PM ******/
DROP VIEW [dbo].[vw_SuccessRegisters]
GO

/****** Object:  View [dbo].[vw_SuccessRegisters]    Script Date: 06/25/2020 12:20:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




	CREATE VIEW [dbo].[vw_SuccessRegisters] AS
	
	Select success.ID as SuccessID,
			success.EMP_ID as RaisedByID,
			(emp.LAST_NAME + ', '+ emp.FIRST_NAME + ' ' + emp.MIDDLE_NAME) as RaisedBy,
			success.DATE_INPUT as DateSubmitted,
			success.WHOSINVOLVE as Participants,
			success.DETAILSOFSUCCESS as Details,
			success.ADDITIONALINFORMATION as AdditionalInformation,
			emp.DIV_ID as DivisionID,
			div.DESCR as Division,
			emp.DEPT_ID as DepartmentID,
			div.DESCR as Department,
			emp.ACTIVE as IsActive,
			Month(success.DATE_INPUT) as [Month],
			Year(success.DATE_INPUT) as [Year],
			dbo.fn_getFiscalYear(success.DATE_INPUT, success.DATE_INPUT) as FiscalYear
	From SUCCESSREGISTER success
		inner join EMPLOYEE emp 
			on success.EMP_ID = emp.EMP_ID
		inner join DEPARTMENT dept
			on dept.DEPT_ID = emp.DEPT_ID
		inner join DIVISION div
			on emp.DEPT_ID = div.DEPT_ID and emp.DIV_ID = div.DIV_ID





GO


