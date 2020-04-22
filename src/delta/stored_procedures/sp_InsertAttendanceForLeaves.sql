USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAttendanceForLeaves]    Script Date: 04/22/2020 5:28:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_InsertAttendanceForLeaves]
	@from DATETIME,
	@to DATETIME,
	@EMP_ID INT,
	@STATUS INT
AS

DECLARE @DEPTID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID),
		@DIVID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)

DECLARE @COUNT FLOAT 

IF @STATUS IN (5, 6, 9, 12, 14) -- For Halfday status count
	SET @COUNT = 0.5 
ELSE 
	SET @COUNT = 1

DECLARE @HOLIDAY_FLG SMALLINT = (SELECT HOLIDAY_FLG FROM CONTACTS c INNER JOIN LOCATION l
								 ON l.LOCATION_ID = c.LOCATION
								 AND EMP_ID = @EMP_ID)
								
WHILE @from <= @to
	BEGIN
		-- For Holiday Status, insert all employee by division and department
		IF @STATUS = 7 
			BEGIN 
				-- Delete attendance for the employees filed leave on holiday
				IF EXISTS (SELECT * FROM ATTENDANCE a
						   INNER JOIN EMPLOYEE e
						   ON e.EMP_ID = a.EMP_ID 
						   INNER JOIN CONTACTS c
						   ON e.EMP_ID = c.EMP_ID 
						   INNER JOIN LOCATION l
						   ON c.LOCATION = l.LOCATION_ID 
						   WHERE DATE_ENTRY = CONVERT(VARCHAR, @from, 101)
						   AND DIV_ID = @DIVID
						   AND DEPT_ID = @DEPTID
						   AND HOLIDAY_FLG = @HOLIDAY_FLG)
					BEGIN
						DELETE FROM ATTENDANCE 
						WHERE DATE_ENTRY = CONVERT(VARCHAR, @from, 101)
						AND EMP_ID IN (SELECT e.EMP_ID FROM EMPLOYEE e
									   INNER JOIN CONTACTS c
									   ON e.EMP_ID = c.EMP_ID 
									   INNER JOIN LOCATION l
									   ON c.LOCATION = l.LOCATION_ID 
									   WHERE DIV_ID = @DIVID AND DEPT_ID = @DEPTID AND HOLIDAY_FLG = @HOLIDAY_FLG) 
					END

					INSERT INTO [dbo].[ATTENDANCE] ([EMP_ID], [DATE_ENTRY], [STATUS], [COUNTS])
					SELECT E.EMP_ID, @from, @STATUS, @COUNT 
					FROM dbo.EMPLOYEE E 
					INNER JOIN CONTACTS C
					ON E.EMP_ID = C.EMP_ID 
					INNER JOIN LOCATION l
					ON c.LOCATION = l.LOCATION_ID 
					WHERE HOLIDAY_FLG = @HOLIDAY_FLG
					AND DEPT_ID =  @DEPTID
					AND DIV_ID = @DIVID
					AND ACTIVE = 1
					AND GRP_ID <> 5
			END
		ELSE
			BEGIN
				DECLARE @COUNT_LEAVES SMALLINT = (SELECT COUNT(DATE_ENTRY) 
												  FROM ATTENDANCE 
												  WHERE EMP_ID = @EMP_ID 
												  AND STATUS = @STATUS 
												  AND DATE_ENTRY = @from)
				
				-- Get date entry for present status
				DECLARE @attDate as DATETIME = (SELECT DATE_ENTRY FROM ATTENDANCE 
												WHERE CONVERT(DATE, DATE_ENTRY) = CONVERT(DATE, @from)
												AND EMP_ID = @EMP_ID
												 AND STATUS IN (1,2,11))

				IF @attDate IS NOT NULL
					SET @from = (SELECT DATEADD(HOUR, 4, @attDate))
				
				IF @COUNT_LEAVES > 0
					BEGIN
						UPDATE ATTENDANCE SET STATUS_CD = 1 
						WHERE EMP_ID = @EMP_ID 
						AND STATUS = @STATUS 
						AND DATE_ENTRY = @from  
					END
				ELSE
					BEGIN
						IF EXISTS (SELECT (1) FROM ATTENDANCE WHERE EMP_ID = @EMP_ID AND DATE_ENTRY = @from AND STATUS = @STATUS)
							UPDATE ATTENDANCE SET STATUS_CD = 1 
							WHERE EMP_ID = @EMP_ID AND DATE_ENTRY = @from AND STATUS = @STATUS 
						ELSE
							-- Insert Leave
							INSERT INTO [dbo].[ATTENDANCE] ([EMP_ID], [DATE_ENTRY], [STATUS], [COUNTS])
							VALUES (@EMP_ID, @from, @STATUS, @COUNT)
					END
			END
			
		SET @from = DATEADD(DAY, 1, @from)
	END
