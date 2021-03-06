USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetBillableSummary]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetBillableSummary]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetBillableSummary]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Batongbacal, Aevan Camille N.
-- Create date: Aug. 1, 2018
-- Description:	Get Billable hours per Dept and Div
-- ================================================
CREATE PROCEDURE [dbo].[sp_GetBillableSummary]
	-- Add the parameters for the stored procedure here
	@MONTH int,
	@YEAR int
AS
	
DECLARE @EMPID INT = 220002256
DECLARE @DEPTID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMPID),
		@DIVID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMPID)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	
DECLARE @temptable TABLE (EMPID int, 
							NICK_NAME NVARCHAR(MAX), 
							SL DECIMAL, 
							VL DECIMAL,
							HOLIDAY DECIMAL,
							HALFDAY DECIMAL,
							HALFVL DECIMAL,
							HALFSL DECIMAL,
							TOTAL DECIMAL)
DECLARE @counter INT = 1
WHILE (@counter <= (SELECT COUNT(EMP_ID) FROM EMPLOYEE WHERE DEPT_ID = @DEPTID AND DIV_ID = @DIVID))
BEGIN
	--Selecting employee ID
	SET @EMPID = (SELECT EMP_ID FROM (SELECT ROW_NUMBER() OVER (ORDER BY EMP_ID ASC) AS rownumber,
	EMP_ID FROM EMPLOYEE)  as temptablename WHERE rownumber = @counter)
 
	--Columns insert into temporary table
	INSERT INTO @temptable
	--for name
	SELECT 
	(SELECT EMP_ID FROM EMPLOYEE WHERE EMP_ID = @EMPID) AS 'EMPID',
	RTrim(Coalesce(FIRST_NAME + ' ','') + Coalesce(LAST_NAME + ' ', '')) AS Name,
	(SELECT ISNULL(SUM(COUNTS),0) FROM RESOURCE_PLANNER WHERE EMP_ID = @EMPID AND STATUS = 4) AS 'VL',
	(SELECT ISNULL(SUM(COUNTS),0) FROM RESOURCE_PLANNER WHERE EMP_ID = @EMPID AND STATUS = 3) AS 'SL',
	(SELECT ISNULL(SUM(COUNTS),0) FROM RESOURCE_PLANNER WHERE EMP_ID = @EMPID AND STATUS = 4) AS 'HOLIDAY',
	(SELECT ISNULL(SUM(COUNTS),0) FROM RESOURCE_PLANNER WHERE EMP_ID = @EMPID AND STATUS = 3) AS 'HALFDAY',
	(SELECT ISNULL(SUM(COUNTS),0) FROM RESOURCE_PLANNER WHERE EMP_ID = @EMPID AND STATUS = 5) AS 'HALFVL',
	(SELECT ISNULL(SUM(COUNTS),0) FROM RESOURCE_PLANNER WHERE EMP_ID = @EMPID AND STATUS = 6) AS 'HALFSL',
	(SELECT ISNULL(SUM(COUNTS),0) FROM RESOURCE_PLANNER WHERE EMP_ID = @EMPID) AS 'TOTAL'
	
	FROM EMPLOYEE WHERE EMP_ID = @EMPID
	SET @counter = @counter + 1
END

SELECT * FROM @temptable
END

--EXEC	[dbo].[sp_GetBillableHoursByMonth]	@EMPID = 101010
GO
