USE [AIDE]
GO

/****** Object:  View [dbo].[vw_ContactList]    Script Date: 6/19/2020 12:22:47 AM ******/
DROP VIEW [dbo].[vw_ContactList]
GO

/****** Object:  View [dbo].[vw_ContactList]    Script Date: 6/19/2020 12:22:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



	CREATE VIEW [dbo].[vw_ContactList] AS
	SELECT  
		emp.EMP_ID as EmployeeID,
		(emp.LAST_NAME + ' ,' + emp.FIRST_NAME + ' ' + emp.MIDDLE_NAME) as EmployeeName,
		Case when contact.LOCAL > 0 Then Convert(nvarchar(20),contact.LOCAL) 
		Else ''
		End As LocalNo,
		contact.CEL_NO as MobileNo, 
		contact.HOMEPHONE as HomePhone,
		contact.OTHER_PHONE as OtherPhone,
		contact.EMAIL_ADDRESS as OfficeEmail,
		contact.EMAIL_ADDRESS2 as OtherEmail,
		emp.ACTIVE as IsActive,
		emp.DEPT_ID as DepartmentID,
		emp.DIV_ID as DivisionID,
		dept.DESCR as Department,
		div.DESCR as Division
	FROM Employee emp
		INNER JOIN Contacts contact
			ON contact.EMP_ID = emp.EMP_ID
		INNER JOIN DEPARTMENT dept
			ON emp.DEPT_ID = dept.DEPT_ID
		INNER JOIN DIVISION div
			ON emp.DIV_ID = div.DIV_ID and emp.DEPT_ID = div.DEPT_ID
	WHERE emp.EMP_ID >0

	





GO


