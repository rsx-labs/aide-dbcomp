USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAuditSched]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetAuditSched]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAuditSched]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetAuditSched]
       -- Add the parameters for the stored procedure here
       @EMP_ID INT,
       @YEAR INT
AS
BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;

       DECLARE @DEPTID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)
       DECLARE @DIVID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)
       DECLARE @LSTYR INT, @YRTODAY INT
   
       SET @LSTYR =  @YEAR + 1

    -- Insert statements for procedure here
       SELECT	A.AUDIT_SCHED_ID,
				A.EMP_ID,
				A.FY_WEEK,
				A.PERIOD_START,
				A.PERIOD_END,
				(SELECT E.FIRST_NAME FROM EMPLOYEE E WHERE E.EMP_ID = A.DAILY) AS DAILY,
				(SELECT E.FIRST_NAME FROM EMPLOYEE E WHERE E.EMP_ID = A.WEEKLY) AS WEEKLY,
				(SELECT E.FIRST_NAME FROM EMPLOYEE E WHERE E.EMP_ID = A.MONTHLY) AS MONTHLY,
				A.FY_START,
				A.FY_END
		
		 FROM WORKPLACE_AUDIT_SCHEDULE A 
       INNER JOIN EMPLOYEE B ON A.EMP_ID = B.EMP_ID
       WHERE B.DEPT_ID = @DEPTID AND B.DIV_ID = @DIVID 
				AND convert(date, a.FY_START) = convert(date,CONCAT(@year,'-','04','-','01')) 
				AND convert(date, a.FY_END) = convert(date,CONCAT(@LSTYR,'-','03','-','31'))
       ORDER BY PERIOD_END ASC
END


GO
