USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertLeaveCredits]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertLeaveCredits]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertLeaveCredits]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertLeaveCredits]
	@EMPID INT,
	@YEAR INT
AS
BEGIN

	DECLARE @DEPTID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMPID)
	DECLARE @DIVID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMPID)
	DECLARE @FIRSTMONTH DATE, @PREVFIRSTMONTH DATE
	DECLARE @LASTMONTH DATE, @PREVLASTMONTH DATE
	DECLARE @VLUSEDLEAVES FLOAT, @SLUSEDLEAVES FLOAT
	DECLARE @VLBALANCE FLOAT, @SLBALANCE FLOAT

	-- Set Previous Fiscal Year
	--SET @PREVFIRSTMONTH = CAST('4/1/' + Cast(@YEAR - 1 as varchar) AS DATE)
	--SET @PREVLASTMONTH = CAST('3/31/' + Cast(@YEAR as varchar) AS DATE)

	SET @PREVFIRSTMONTH = (SELECT FY_START FROM FISCAL_YEAR WHERE YEAR(FY_END) = @YEAR)
	SET @PREVLASTMONTH = (SELECT FY_END FROM FISCAL_YEAR WHERE YEAR(FY_END) = @YEAR)

	-- Set Current Fiscal Year
	--SET @FIRSTMONTH = CAST('4/1/' + Cast(@YEAR as varchar) AS DATE)
	--SET @LASTMONTH = CAST('3/31/' + Cast(@YEAR + 1 as varchar) AS DATE)

	DECLARE @guestAccount SMALLINT = 5
	SET @FIRSTMONTH = (SELECT FY_START FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)
	SET @LASTMONTH = (SELECT FY_END FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)
	
	DECLARE @counter INT = 1
	DECLARE @total INT = (SELECT COUNT(EMP_ID) FROM EMPLOYEE WHERE DEPT_ID = @DEPTID AND DIV_ID = @DIVID AND ACTIVE = 1 AND GRP_ID != @guestAccount)
	
	WHILE (@counter <= @total)
	BEGIN
		-- Get employee ID
		SET @EMPID = (SELECT EMP_ID 
					  FROM (SELECT ROW_NUMBER() OVER (ORDER BY LAST_NAME ASC) AS rownumber, EMP_ID 
							FROM EMPLOYEE 
							WHERE DEPT_ID = @DEPTID 
							AND DIV_ID = @DIVID
							AND ACTIVE = 1
							AND GRP_ID != @guestAccount) as temptablename 
					  WHERE rownumber = @counter)

		-- Get total used VL of employee last fiscal year
		SET @VLUSEDLEAVES = (SELECT ISNULL(SUM(COUNTS), 0) 
							 FROM RESOURCE_PLANNER 
							 WHERE EMP_ID = @EMPID 
							 AND STATUS IN (4, 6, 8, 9) 
							 AND STATUS_CD = 1
							 AND DATE_ENTRY BETWEEN @PREVFIRSTMONTH AND @PREVLASTMONTH) 
							 
		-- Get total used SL of employee last fiscal year
		SET @SLUSEDLEAVES = (SELECT ISNULL(SUM(COUNTS), 0)
							 FROM RESOURCE_PLANNER
							 WHERE EMP_ID = @EMPID 
							 AND STATUS IN (3, 5)
							 AND STATUS_CD = 1
							 AND DATE_ENTRY BETWEEN @PREVFIRSTMONTH AND @PREVLASTMONTH) 
		
		-- VL Balance
		SET @VLBALANCE = (SELECT LEAVE_CREDITS - @VLUSEDLEAVES
						  FROM LEAVE_CREDITS
						  WHERE STATUS = 4 AND EMP_ID = @EMPID 
						  AND FY_START = @PREVFIRSTMONTH)

		-- SL Balance
		SET @SLBALANCE = (SELECT LEAVE_CREDITS - @SLUSEDLEAVES
						  FROM LEAVE_CREDITS
						  WHERE STATUS = 3 AND EMP_ID = @EMPID
						  AND FY_START = @PREVFIRSTMONTH)
		
		-- Verify if leave credits already created for current fiscal year
		DECLARE @credits INT = (SELECT COUNT(*) FROM LEAVE_CREDITS WHERE FY_START = @FIRSTMONTH AND EMP_ID = @EMPID)
		
		IF @credits = 0
			BEGIN
				IF @VLBALANCE < 0
					SET @VLBALANCE = 0
				IF @VLBALANCE > 10
					SET @VLBALANCE = 10
					
				IF @SLBALANCE < 0
					SET @SLBALANCE = 0
					
				DECLARE @totalSLBalance FLOAT = @SLBALANCE + 15
				DECLARE @totalVLBalance FLOAT = @VLBALANCE + 15

				IF @totalSLBalance > 45
					SET @totalSLBalance = 45
		
				INSERT INTO LEAVE_CREDITS VALUES (@EMPID, @totalVLBalance, 4, @FIRSTMONTH, @LASTMONTH) -- Insert VL credits
				INSERT INTO LEAVE_CREDITS VALUES (@EMPID, @totalSLBalance, 3, @FIRSTMONTH, @LASTMONTH) -- Insert SL credits
			END

		SET @counter = @counter + 1
	END
END

GO
