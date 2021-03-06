USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNonBillableHours]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetNonBillableHours]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNonBillableHours]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetNonBillableHours]
	-- Add the parameters for the stored procedure here
	@EMAIL_ADDRESS VARCHAR(100),
	@DISPLAY INT, -- 1=weekly; 2=monthly; 3=Fiscal Year
	@MONTH INT,
	@YEAR INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	DECLARE @EMPID INT = (SELECT E.EMP_ID FROM EMPLOYEE E INNER JOIN CONTACTS C ON E.EMP_ID = C.EMP_ID WHERE EMAIL_ADDRESS = @EMAIL_ADDRESS)
	DECLARE @DEPTID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMPID)
	DECLARE @DIVID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMPID)
	DECLARE @FIRSTMONTH DATE
	DECLARE @LASTMONTH DATE
	
	DECLARE @holidayHours FLOAT 
	DECLARE @vlHours FLOAT 
	DECLARE @slHours FLOAT 

	-- GET FISCAL YEAR
	--SET @FIRSTMONTH = CAST('4/1/' + CAST(@YEAR AS VARCHAR) AS DATE)
	--SET @LASTMONTH = DATEADD(DAY, -1, CAST('4/1/' + CAST(@YEAR + 1 AS VARCHAR) AS DATE))

	SET @FIRSTMONTH = (SELECT FY_START FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)
	SET @LASTMONTH = (SELECT FY_END FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)
	
	DECLARE @fiscalYear INT
	IF @MONTH < 4
		--SET @fiscalYear = @YEAR + 1
		SET @fiscalYear	= (SELECT YEAR(FY_END) FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)
	ELSE
		--SET @fiscalYear = @YEAR
		SET @fiscalYear = (SELECT YEAR(FY_START) FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)

	DECLARE @temptable TABLE (FIRST_NAME NVARCHAR(MAX), 
							  LAST_NAME NVARCHAR(MAX), 
							  NICK_NAME NVARCHAR(MAX),
							  HOLIDAYHOURS FLOAT,
							  VLHOURS FLOAT,
							  SLHOURS FLOAT)

	DECLARE @counter INT = 1
	DECLARE @total INT = (SELECT COUNT(EMP_ID) FROM EMPLOYEE WHERE DEPT_ID = @DEPTID AND DIV_ID = @DIVID AND GRP_ID != 5 AND ACTIVE = 1)

	IF @DISPLAY = 1 
		BEGIN
			-- Get the 1st day of MONTH and its NAME
			DECLARE @firstDayMonth DATE = (SELECT DATEADD(month, @MONTH-1, DATEADD(year, @fiscalYear-1900, 0)))
			DECLARE @endDayMonth DATE = (SELECT DATEADD(day, -1, DATEADD(month, @MONTH, DATEADD(year, @fiscalYear-1900, 0))))
			DECLARE @dateName VARCHAR(10) = (SELECT DATENAME(weekday, @firstDayMonth))
			DECLARE @numberOfWeeks INT
			DECLARE @startOfWeek DATE
			DECLARE @endOfWeek DATE

			-- Set the firstDayMonth to the 1st MONDAY of month if it falls into WEEKENDS
			IF @dateName = 'Saturday' OR @dateName = 'Sunday'
				BEGIN
					SET @firstDayMonth = (SELECT DATEADD(wk, DATEDIFF(wk,0,DATEADD(dd,6-DATEPART(DAY,@firstDayMonth),@firstDayMonth)), 0))
				END

			DECLARE @tempFirstDayMonth DATE = @firstDayMonth
			-- Get number of weeks in a month
			;WITH DATES AS (
				SELECT @firstDayMonth monthDate
				UNION ALL
				SELECT DATEADD(day, 1, t.monthDate) 
				FROM dates t
				WHERE DATEADD(day, 1, t.monthDate) <= @endDayMonth
			)
			SELECT @numberOfWeeks = (SELECT TOP 1 COUNT(*) WEEKS
									 FROM DATES d
									 GROUP BY DatePart(WEEKDAY, monthDate)
									 ORDER BY WEEKS DESC);

			WHILE (@counter <= @numberOfWeeks)
				BEGIN
					DECLARE @WeekNum INT, 
							@YearNum char(4),
							@range VARCHAR(10)

					SELECT @WeekNum = DATEPART(WK, @firstDayMonth), 
						   @YearNum = CAST(DATEPART(YY, @firstDayMonth) AS CHAR(4));
						   
					-- Once you have the @WeekNum and @YearNum set, the following calculates the date range.
					SET @startOfWeek = (SELECT DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + @YearNum) + (@WeekNum-1), 7))
					SET @endOfWeek = (SELECT DATEADD(wk, DATEDIFF(wk, 5, '1/1/' + @YearNum) + (@WeekNum-1), 4))

					-- Check if month of start and end of week is equal to month selected
					IF MONTH(@startOfWeek) != MONTH(@firstDayMonth)
						SET @startOfWeek = @firstDayMonth 

					IF MONTH(@endOfWeek) != MONTH(@endDayMonth)
						SET @endOfWeek = @endDayMonth 

					IF @startOfWeek = @endOfWeek 
						SET @range = (SELECT CAST(DAY(@startOfWeek) AS nvarchar))
					ELSE
						SET @range = (SELECT CAST(DAY(@startOfWeek) AS nvarchar)) + '-' + (SELECT CAST(DAY(@endOfWeek) AS nvarchar))
						
					SET @holidayHours = (SELECT COUNT(a.EMP_ID)
										 FROM ATTENDANCE a, EMPLOYEE e 
										 WHERE (DATE_ENTRY BETWEEN @startOfWeek AND @endOfWeek )
										 AND a.EMP_ID = e.EMP_ID 
										 AND e.DEPT_ID = @DEPTID 
										 AND e.DIV_ID = @DIVID 
										 AND e.ACTIVE = 1
										 AND GRP_ID != 5 -- guest Account
										 AND a.STATUS IN (7)) * 8 
										 
					SET @vlHours = (SELECT ISNULL(SUM(COUNTS), 0) 
									FROM ATTENDANCE a, EMPLOYEE e 
									WHERE (DATE_ENTRY BETWEEN @startOfWeek AND @endOfWeek)
									AND a.EMP_ID = e.EMP_ID
									AND e.DEPT_ID = @DEPTID 
									AND e.DIV_ID = @DIVID 
									AND e.ACTIVE = 1
									AND a.STATUS_CD = 1
									AND GRP_ID != 5 -- guest Account
									AND a.STATUS IN (4, 6, 8, 9)) * 8

					SET @slHours = (SELECT ISNULL(SUM(COUNTS), 0) 
									FROM ATTENDANCE a, EMPLOYEE e 
									WHERE (DATE_ENTRY BETWEEN @startOfWeek AND @endOfWeek)
									AND a.EMP_ID = e.EMP_ID
									AND e.DEPT_ID = @DEPTID 
									AND e.DIV_ID = @DIVID 
									AND e.ACTIVE = 1
									AND a.STATUS_CD = 1
									AND GRP_ID != 5 -- guest Account
									AND a.STATUS IN (3, 5)) * 8
					
					DECLARE @dateRange NVARCHAR(MAX) = (SELECT DATENAME(MONTH, @startOfWeek)) + ' ' + @range
				 
					INSERT INTO @temptable (FIRST_NAME, HOLIDAYHOURS, VLHOURS, SLHOURS)
					VALUES (@dateRange, @holidayHours, @vlHours, @slHours)

					-- SET firstDayMonth to next week
					SET @firstDayMonth = (SELECT DATEADD(week, 1, @firstDayMonth))
					SET @counter += 1
				END

			-- Get the Total Hours of the month
			SET @holidayHours = (SELECT COUNT(a.EMP_ID)
								 FROM ATTENDANCE a, EMPLOYEE e 
								 WHERE (DATE_ENTRY BETWEEN @tempFirstDayMonth AND @endOfWeek)
								 AND a.EMP_ID = e.EMP_ID 
								 AND e.DEPT_ID = @DEPTID 
								 AND e.DIV_ID = @DIVID  
								 AND e.ACTIVE = 1 
								 AND GRP_ID != 5 -- guest Account
								 AND a.STATUS IN (7)) * 8 
										 
			SET @vlHours = (SELECT ISNULL(SUM(COUNTS), 0) 
							FROM ATTENDANCE a, EMPLOYEE e
							WHERE (DATE_ENTRY BETWEEN @tempFirstDayMonth AND @endOfWeek)
							AND a.EMP_ID = e.EMP_ID 
							AND e.DEPT_ID = @DEPTID 
							AND e.DIV_ID = @DIVID  
							AND e.ACTIVE = 1
							AND a.STATUS_CD = 1
							AND GRP_ID != 5 -- guest Account
							AND a.STATUS IN (4, 6, 8, 9)) * 8

			SET @slHours = (SELECT ISNULL(SUM(COUNTS), 0) 
							FROM ATTENDANCE a, EMPLOYEE e
							WHERE (DATE_ENTRY BETWEEN @tempFirstDayMonth AND @endOfWeek)
							AND a.EMP_ID = e.EMP_ID 
							AND e.DEPT_ID = @DEPTID 
							AND e.DIV_ID = @DIVID  
							AND e.ACTIVE = 1
							AND a.STATUS_CD = 1
							AND GRP_ID != 5 -- guest Account
							AND a.STATUS IN (3, 5)) * 8

			INSERT INTO @temptable (FIRST_NAME, HOLIDAYHOURS, VLHOURS, SLHOURS)
			VALUES ('TOTAL', @holidayHours, @vlHours, @slHours)

		END
	ELSE 
		BEGIN
			WHILE (@counter <= @total)
				BEGIN
				--Selecting employee ID
				SET @EMPID = (SELECT EMP_ID 
							  FROM (SELECT ROW_NUMBER() OVER (ORDER BY EMP_ID ASC) AS rownumber, EMP_ID 
							  FROM EMPLOYEE 
							  WHERE DEPT_ID = @DEPTID 
							  AND DIV_ID = @DIVID
							  AND GRP_ID != 5 -- guest account
							  AND ACTIVE = 1) as temptablename 
							  WHERE rownumber = @counter)
 
				--Columns insert into temporary table
				IF @DISPLAY = 2 -- MONTHLY
					BEGIN
						SET @holidayHours = (SELECT COUNT(EMP_ID )
											 FROM ATTENDANCE  
											 WHERE EMP_ID = @EMPID 
											 AND STATUS IN (7) 
											 AND MONTH(DATE_ENTRY) = @MONTH  
											 AND YEAR(DATE_ENTRY) = @fiscalYear) * 8 

						SET @vlHours = (SELECT ISNULL(SUM(COUNTS), 0) 
										FROM ATTENDANCE 
										WHERE EMP_ID = @EMPID 
										AND STATUS IN (4, 6, 8, 9) 
										AND STATUS_CD = 1
										AND MONTH(DATE_ENTRY) = @MONTH
										AND YEAR(DATE_ENTRY) = @fiscalYear) * 8

						SET @slHours = (SELECT ISNULL(SUM(COUNTS), 0) 
										FROM ATTENDANCE 
										WHERE EMP_ID = @EMPID 
										AND STATUS IN (3, 5) 
										AND STATUS_CD = 1
										AND MONTH(DATE_ENTRY) = @MONTH
										AND YEAR(DATE_ENTRY) = @fiscalYear) * 8
					END
				ELSE IF @DISPLAY = 3 -- YEAR
					BEGIN
						SET @holidayHours = (SELECT COUNT(EMP_ID )
											 FROM ATTENDANCE  
											 WHERE EMP_ID = @EMPID 
											 AND STATUS IN (7) 
											 AND DATE_ENTRY >= @FIRSTMONTH
											 AND DATE_ENTRY < @LASTMONTH) * 8 

						SET @vlHours = (SELECT ISNULL(SUM(COUNTS), 0) 
										FROM ATTENDANCE 
										WHERE EMP_ID = @EMPID 
										AND STATUS IN (4, 6, 8, 9) 
										AND STATUS_CD = 1
										AND DATE_ENTRY >= @FIRSTMONTH 
										AND DATE_ENTRY < @LASTMONTH) * 8

						SET @slHours = (SELECT ISNULL(SUM(COUNTS), 0) 
										FROM ATTENDANCE 
										WHERE EMP_ID = @EMPID 
										AND STATUS IN (3, 5) 
										AND STATUS_CD = 1
										AND DATE_ENTRY >= @FIRSTMONTH
										AND DATE_ENTRY < @LASTMONTH) * 8
					END

				INSERT INTO @temptable
				SELECT 
					FIRST_NAME, LAST_NAME, NICK_NAME, @holidayHours, @vlHours, @slHours
				FROM EMPLOYEE 
				WHERE EMP_ID = @EMPID

				SET @counter = @counter + 1
			END
		END
	
	SELECT FIRST_NAME AS EMPLOYEE_NAME, HOLIDAYHOURS, VLHOURS, SLHOURS FROM @temptable ORDER BY LAST_NAME
END



GO
