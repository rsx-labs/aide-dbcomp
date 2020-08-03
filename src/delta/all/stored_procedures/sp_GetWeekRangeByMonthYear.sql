USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetWeekRangeByMonthYear]    Script Date: 7/2/2020 11:07:37 PM ******/
DROP PROCEDURE [dbo].[sp_GetWeekRangeByMonthYear]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetWeekRangeByMonthYear]    Script Date: 7/2/2020 11:07:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_GetWeekRangeByMonthYear]
	@EMP_ID INT,
	@MONTH INT,
	@YEAR INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @temptable TABLE (WEEKRANGEID INT, 
							  STARTWEEK DATE, 
							  ENDWEEK DATE,
							  DATERANGE VARCHAR(50))

	DECLARE @fiscalYear VARCHAR(10)
	DECLARE @prevMonth int = @Month
	--SET @fiscalYear = CAST(@year AS VARCHAR) + '-' + CAST((@year + 1) AS VARCHAR)
	SET @fiscalYear = CAST((SELECT YEAR(FY_START) FROM FISCAL_YEAR WHERE YEAR(FY_START) = @year) AS VARCHAR) + '-' + CAST((SELECT YEAR(FY_END) FROM FISCAL_YEAR WHERE YEAR(FY_START) = @year) AS VARCHAR)


	If Day(GetDate()) < 7 
	Begin
		Set @prevMonth = @MONTH -1
	End

	INSERT INTO @temptable (WEEKRANGEID, STARTWEEK, ENDWEEK, DATERANGE)
	SELECT WEEK_ID, WEEK_START, WEEK_END, 
		   CONVERT(varchar, WEEK_START, 101) + ' - ' + 
		   CONVERT(varchar, WEEK_END, 101)
	FROM WEEK_RANGE 
	WHERE MONTH in ( @MONTH, @prevMonth)
	AND FISCAL_YEAR = @fiscalYear 

	SELECT * FROM @temptable
END


GO


