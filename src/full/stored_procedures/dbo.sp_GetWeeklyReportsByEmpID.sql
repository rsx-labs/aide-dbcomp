USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetWeeklyReportsByEmpID]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetWeeklyReportsByEmpID]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetWeeklyReportsByEmpID]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetWeeklyReportsByEmpID]
@EMP_ID INT,
@MONTH INT,
@YEAR INT

AS
BEGIN

	DECLARE @temptable TABLE (WEEKRANGEID INT, 
							  STARTWEEK DATE, 
							  ENDWEEK DATE,
							  STATUS INT,
							  DATE_SUBMITTED DATE)

	DECLARE @fiscalYear VARCHAR(10)
	SET @fiscalYear = CAST(@year AS VARCHAR) + '-' + CAST((@year + 1) AS VARCHAR)

	
	INSERT INTO @temptable (WEEKRANGEID, STARTWEEK, ENDWEEK, STATUS, DATE_SUBMITTED)
	SELECT WEEK_ID, WEEK_START, WEEK_END, STATUS, DATE_SUBMITTED 
	FROM WEEKLY_REPORT_XREF x 
	INNER JOIN WEEK_RANGE r
	ON x.WEEK_RANGE = r.WEEK_ID 
	WHERE EMP_ID = @EMP_ID
	AND MONTH = @MONTH
	AND FISCAL_YEAR = @fiscalYear 
	ORDER BY WEEK_ID 


	SELECT * FROM @temptable ORDER BY WEEKRANGEID ASC 
END
 



GO
