USE [AIDE]
GO

/****** Object:  View [dbo].[vw_LessonLearnt]    Script Date: 06/25/2020 12:19:35 PM ******/
DROP VIEW [dbo].[vw_LessonLearnt]
GO

/****** Object:  View [dbo].[vw_LessonLearnt]    Script Date: 06/25/2020 12:19:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






	CREATE VIEW [dbo].[vw_LessonLearnt] AS
	
	Select lesson.REF_NO as [ReferenceNo],
			emp.EMP_ID as [EmployeeID],
			(emp.LAST_NAME + ', ' + emp.FIRST_NAME + ' ' +emp.MIDDLE_NAME) as [EmployeeName],
			lesson.PROBLEM as [Problem],
			lesson.RESOLUTION as [Resolution],
			Convert(date,lesson.DATE_CREATED) as [DateCreated],
			Case 
				When act.ACT_MESSAGE is Null Then ''
				Else act.ACTREF + ' : ' + act.ACT_MESSAGE
			End as [Related Action],
			
			emp.DEPT_ID as [DepartmentID],
			dept.DESCR as [Department],
			emp.DIV_ID as [DivisionID],
			div.DESCR as [Division],
			Month(lesson.DATE_CREATED) as [Month],
			Year(lesson.DATE_CREATED) as [Year],
			dbo.fn_getFiscalYear(lesson.DATE_CREATED,lesson.DATE_CREATED) as FiscalYear,
			emp.ACTIVE as [IsActive]
	From LESSON_LEARNT lesson
		inner join EMPLOYEE emp
			on lesson.EMP_ID = emp.EMP_ID
		left outer join ACTIONLIST act
			on lesson.ACTION_NO = act.ACTREF
		inner join DEPARTMENT dept
			on emp.DEPT_ID = dept.DEPT_ID
		inner join DIVISION div
			on emp.DEPT_ID = div.DEPT_ID and emp.DIV_ID = div.DIV_ID









GO


