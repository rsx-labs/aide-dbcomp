USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetAttendanceToday]    Script Date: 5/29/2020 6:27:52 PM ******/
DROP PROCEDURE [dbo].[sp_GetAttendanceToday]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetAttendanceToday]    Script Date: 5/29/2020 6:27:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_GetAttendanceToday]
	-- Add the parameters for the stored procedure here
	@EMP_ID INT,
	@DATE_TODAY DATETIME
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	CREATE TABLE #ATTENDANCE_TODAY (EMP_ID INT,
									EMPLOYEE_NAME VARCHAR(50),
									DESCR VARCHAR(50),
									DATE_ENTRY DATETIME,
									LOGOFF_TIME DATETIME,
									STATUS INT,
									IMAGE_PATH VARCHAR(MAX),
									DSPLY_ORDR INT)

	DECLARE @DEPT_ID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)
	DECLARE @DIV_ID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)

	DECLARE @counter INT = 1
	DECLARE @totalEmployees INT = (SELECT COUNT(DISTINCT A.EMP_ID) FROM ATTENDANCE A INNER JOIN EMPLOYEE E
								   ON A.EMP_ID = E.EMP_ID
								   WHERE CONVERT(DATE,DATE_ENTRY) = CONVERT(DATE, @DATE_TODAY)
								   AND E.DEPT_ID = @DEPT_ID
								   AND E.DIV_ID = @DIV_ID
								   AND E.ACTIVE = 1)
	
	WHILE (@counter <= @totalEmployees)
		BEGIN
			DECLARE @empID INT = (SELECT EMP_ID FROM (
									  SELECT DISTINCT A.EMP_ID, DENSE_RANK() OVER (ORDER BY A.EMP_ID) AS RowNum
									  FROM ATTENDANCE A LEFT JOIN EMPLOYEE E 
									  ON A.EMP_ID = E.EMP_ID
									  WHERE CONVERT(DATE, DATE_ENTRY) = CONVERT(DATE, @DATE_TODAY)
									  AND E.DEPT_ID = @DEPT_ID
									  AND E.DIV_ID = @DIV_ID
									  AND ACTIVE = 1
								  ) Data
								  WHERE RowNum = @counter)
			-- Count employee attendance
			DECLARE @COUNT_ATT SMALLINT = (SELECT COUNT(EMP_ID) FROM ATTENDANCE 
										   WHERE CONVERT(DATE,DATE_ENTRY) = CONVERT(DATE, @DATE_TODAY)
										   AND STATUS_CD = 1
										   AND EMP_ID = @empID)
			
			IF @COUNT_ATT > 1
				BEGIN
					INSERT INTO #ATTENDANCE_TODAY (EMP_ID, EMPLOYEE_NAME, DESCR, DATE_ENTRY, LOGOFF_TIME, STATUS, IMAGE_PATH, DSPLY_ORDR)
					SELECT TOP 1 E.EMP_ID, 
						   LAST_NAME + ', ' + FIRST_NAME + ' ' + SUBSTRING(MIDDLE_NAME,1,1) AS EMPLOYEE_NAME,
						   DESCR, 
						   DATE_ENTRY,
						   LOGOFF_TIME,
						   -- Determine if location is onsite or in office
						   CASE WHEN A.STATUS = 11 AND L.ONSITE_FLG = 0 THEN 110 
								WHEN A.STATUS = 11 AND L.ONSITE_FLG = 1 THEN 111 
								ELSE A.STATUS
						   END AS STATUS,
						   --A.STATUS, 
						   IMAGE_PATH, 
						   CASE WHEN A.STATUS IN (2, 11) THEN 1 -- Present 
								WHEN A.STATUS IN (1, 13, 14) THEN 2 -- Onsite
								WHEN A.STATUS IN (4, 6, 8, 9, 10, 12) THEN 3 -- VL
								WHEN A.STATUS IN (3, 5) THEN 4 -- SL
								WHEN A.STATUS IN (7) THEN 5 -- Holiday
								ELSE 6
						   END AS DSPLAY_ORDER
					FROM ATTENDANCE A
					INNER JOIN EMPLOYEE E on A.EMP_ID = E.EMP_ID
					Inner join CONTACTS C on A.EMP_ID = C.EMP_ID
					INNER JOIN LOCATION L ON C.LOCATION = L.LOCATION_ID
					INNER JOIN DIVISION D ON E.DIV_ID = D.DIV_ID
					WHERE CONVERT(DATE, DATE_ENTRY) = CONVERT(DATE, @DATE_TODAY)
					AND DATE_ENTRY <= @DATE_TODAY				
					AND E.DEPT_ID = @DEPT_ID
					AND D.DEPT_ID = @DEPT_ID
					AND E.DIV_ID = @DIV_ID
					AND A.EMP_ID = @empID
					AND STATUS_CD = 1
					ORDER BY DATE_ENTRY DESC
				END
			ELSE
				BEGIN
					INSERT INTO #ATTENDANCE_TODAY (EMP_ID, EMPLOYEE_NAME, DESCR, DATE_ENTRY, LOGOFF_TIME, STATUS, IMAGE_PATH, DSPLY_ORDR)
					SELECT E.EMP_ID, 
						   LAST_NAME + ', ' + FIRST_NAME + ' ' + SUBSTRING(MIDDLE_NAME,1,1) AS EMPLOYEE_NAME,
						   DESCR, 
						   DATE_ENTRY,
						   LOGOFF_TIME,
						   -- Determine if location is onsite or in office
						    CASE WHEN A.STATUS = 11 AND L.ONSITE_FLG = 0 THEN 110 
								WHEN A.STATUS = 11 AND L.ONSITE_FLG = 1 THEN 111 
								ELSE A.STATUS
						   END AS STATUS,
						   IMAGE_PATH, 
						   CASE WHEN A.STATUS IN (2, 11) THEN 1 -- Present 
								WHEN A.STATUS IN (1, 13, 14) THEN 2 -- Onsite
								WHEN A.STATUS IN (4, 6, 8, 9, 10, 12) THEN 3 -- VL
								WHEN A.STATUS IN (3, 5) THEN 4 -- SL
								WHEN A.STATUS IN (7) THEN 5 -- Holiday
								ELSE 6
						   END AS DSPLAY_ORDER
					FROM ATTENDANCE A
					INNER JOIN EMPLOYEE E on A.EMP_ID = E.EMP_ID
					Inner join CONTACTS C on A.EMP_ID = C.EMP_ID
					INNER JOIN LOCATION L ON C.LOCATION = L.LOCATION_ID
					INNER JOIN DIVISION D ON E.DIV_ID = D.DIV_ID
					WHERE CONVERT(DATE, DATE_ENTRY) = CONVERT(DATE, @DATE_TODAY)
					AND E.DEPT_ID = @DEPT_ID
					AND D.DEPT_ID = @DEPT_ID
					AND E.DIV_ID = @DIV_ID
					AND A.EMP_ID = @empID
					AND STATUS_CD = 1
				END
			
			SET @counter += 1
		END
	--INSERT INTO #ATTENDANCE_TODAY (EMP_ID, EMPLOYEE_NAME, DESCR, DATE_ENTRY, STATUS, IMAGE_PATH, DSPLY_ORDR, VIEW_FLG)
	--SELECT E.EMP_ID, 
	--	   LAST_NAME + ', ' + FIRST_NAME + ' ' + SUBSTRING(MIDDLE_NAME,1,1) AS EMPLOYEE_NAME,
	--	   DESCR, 
	--	   DATE_ENTRY,
	--	   A.STATUS, 
	--	   IMAGE_PATH, 
	--	   CASE WHEN A.STATUS IN (2, 11) THEN  1  
	--			WHEN A.STATUS IN (1, 13, 14) THEN 2
	--			WHEN A.STATUS IN (4, 6, 8, 9, 10, 12) THEN 3
	--			WHEN A.STATUS IN (3, 5) THEN 4
	--			WHEN A.STATUS IN (7) THEN 5
	--			ELSE 6
	--	   END AS DSPLAY_ORDER,
	--	   CASE WHEN DATE_ENTRY <= @DATE_TODAY THEN 1
	--			ELSE 0
	--	   END AS VIEW_FLG
	--FROM ATTENDANCE A
	--INNER JOIN EMPLOYEE E on A.EMP_ID = E.EMP_ID
	--INNER JOIN DIVISION D ON E.DIV_ID = D.DIV_ID
	--WHERE CONVERT(DATE, DATE_ENTRY) = CONVERT(DATE, @DATE_TODAY)
	--AND E.DEPT_ID = @DEPT_ID
	--AND E.DIV_ID = @DIV_ID
	--AND ACTIVE = 1
	--ORDER BY EMP_ID

	SELECT * FROM #ATTENDANCE_TODAY ORDER BY DSPLY_ORDR, EMPLOYEE_NAME ASC

	DROP TABLE #ATTENDANCE_TODAY
	--WHILE (@counter <= @totalEmployees)
	--	BEGIN
			
	--	---date flag 1-morning 2-afternoon
	--		INSERT INTO @ATTENDANCE_TODAY (EMP_ID, EMPLOYEE_NAME, DESCR, DATE_ENTRY, STATUS, IMAGE_PATH, DSPLY_ORDR)
	--			SELECT DISTINCT B.EMP_ID, B.LAST_NAME + ', ' + B.FIRST_NAME + ' ' + SUBSTRING(B.MIDDLE_NAME,1,1) + '' AS EMPLOYEE_NAME, 
	--					D.DESCR, 
	--					a.DATE_ENTRY,
	--					a.STATUS, 
	--					B.IMAGE_PATH, 
	--					CASE when  A.STATUS = 2 OR A.STATUS = 11 OR A.STATUS = 7 THEN  1  
	--						 WHEN  A.STATUS = 1 OR A.STATUS = 13 OR A.STATUS = 14 THEN 2
	--						 WHEN  A.STATUS = 4 OR A.STATUS = 6 OR A.STATUS = 8 OR A.STATUS = 9 OR A.STATUS = 10 OR A.STATUS = 12 THEN 3
	--						 WHEN  A.STATUS = 3 OR A.STATUS = 5 OR A.STATUS = 13 OR A.STATUS = 14 THEN 4	 
	--					ELSE
	--					 5
	--					END  as DSPLAY_ORDER
	--			FROM ATTENDANCE a 
	--			INNER JOIN EMPLOYEE b on a.EMP_ID = b.EMP_ID
	--			INNER JOIN DIVISION D ON B.DIV_ID = D.DIV_ID
	--			WHERE CONVERT(DATE,A.DATE_ENTRY) = CONVERT(DATE,GETDATE())
	--			AND B.DEPT_ID = @DEPT_ID
	--			AND B.DIV_ID = @DIV_ID
	--			AND A.EMP_ID = b.EMP_ID
	--			AND b.ACTIVE <> 2
	--			ORDER BY B.EMP_ID
			
		--	SET @counter += 1
		--END





	--DECLARE @DT_TIME_TODAY TIME = '14:00:00'
	--DECLARE @startdate_today time
	--DECLARE @enddate_today time





	--IF @DT_TIME_TODAY between '00:00:00' and '13:59:59'
	--	BEGIN
	--		SET @startdate_today = '00:00:00'
	--		SET @enddate_today = '13:59:59'
	--	END
	--ELSE
	--	BEGIN
	--		SET @startdate_today = '14:00:00'
	--		SET @enddate_today = '23:59:59'
	--	END 

	--WHILE (@counter <= @totalEmployees)
	--	BEGIN
	--	---date flag 1-morning 2-afternoon
	--		INSERT INTO @ATTENDANCE_TODAY (EMP_ID, EMPLOYEE_NAME, DESCR, DATE_ENTRY, STATUS, IMAGE_PATH, DSPLY_ORDR)
	--			SELECT DISTINCT B.EMP_ID, B.LAST_NAME + ', ' + B.FIRST_NAME + ' ' + SUBSTRING(B.MIDDLE_NAME,1,1) + '' AS EMPLOYEE_NAME, 
	--					D.DESCR, 
	--					a.DATE_ENTRY,
	--					a.STATUS, 
	--					B.IMAGE_PATH, 
	--					CASE when  A.STATUS = 2 OR A.STATUS = 11 OR A.STATUS = 7 THEN  1  
	--						 WHEN  A.STATUS = 1 OR A.STATUS = 13 OR A.STATUS = 14 THEN 2
	--						 WHEN  A.STATUS = 4 OR A.STATUS = 6 OR A.STATUS = 8 OR A.STATUS = 9 OR A.STATUS = 10 OR A.STATUS = 12 THEN 3
	--						 WHEN  A.STATUS = 3 OR A.STATUS = 5 OR A.STATUS = 13 OR A.STATUS = 14 THEN 4	 
	--					ELSE
	--					 5
	--					END  as DSPLAY_ORDER
	--			FROM ATTENDANCE a 
	--			INNER JOIN EMPLOYEE b on a.EMP_ID = b.EMP_ID
	--			INNER JOIN DIVISION D ON B.DIV_ID = D.DIV_ID
	--			WHERE CONVERT(DATE,A.DATE_ENTRY) = CONVERT(DATE,GETDATE())
	--			AND B.DEPT_ID = @DEPT_ID
	--			AND B.DIV_ID = @DIV_ID
	--			AND A.EMP_ID = b.EMP_ID
	--			AND b.ACTIVE <> 2
	--			ORDER BY B.EMP_ID
			
	--		SET @counter += 1
	--	END
	
	--CREATE TABLE #summaryTbl (EMP_ID int, EMPLOYEE_NAME nvarchar(50), DESCR nvarchar(50), DATE_ENTRY datetime, STATUS int, IMAGE_PATH nvarchar(100), DSPLY_ORDR int)
	--CREATE TABLE #summaryTbl2 (EMP_ID int, EMPLOYEE_NAME nvarchar(50), DESCR nvarchar(50), DATE_ENTRY datetime, STATUS int, IMAGE_PATH nvarchar(100), DSPLY_ORDR int)

	--INSERT INTO #summaryTbl 
	--SELECT DISTINCT EMP_ID, EMPLOYEE_NAME, DESCR, DATE_ENTRY, STATUS, IMAGE_PATH,DSPLY_ORDR FROM @ATTENDANCE_TODAY order by DSPLY_ORDR ASC

	--IF @DT_TIME_TODAY between  '00:00:00' and '13:59:59' 
	--	BEGIN
	--		INSERT INTO #summaryTbl2
	--		SELECT DISTINCT at.emp_id, at.EMPLOYEE_NAME,at.DESCR,
	--			CASE 
	--				WHEN EXISTS (SELECT EMP_ID FROM #summaryTbl AA WHERE AA.EMP_ID = AT.EMP_ID GROUP BY AA.EMP_ID, AA.EMPLOYEE_NAME HAVING COUNT(AA.EMP_ID) > 1 ) THEN  (select DATE_ENTRY from #summaryTbl where convert(time, date_entry) between  @startdate_today and @enddate_today and EMP_ID = at.EMP_ID)
	--				ELSE at.DATE_ENTRY
	--			END AS DATE_ENTRY,
	--			CASE 
	--				WHEN EXISTS (SELECT EMP_ID FROM #summaryTbl AA WHERE AA.EMP_ID = AT.EMP_ID GROUP BY AA.EMP_ID, AA.EMPLOYEE_NAME HAVING COUNT(AA.EMP_ID) > 1 ) THEN  (select st.STATUS from #summaryTbl st where  CONVERT(VARCHAR(10), st.DATE_ENTRY, 108)  between '00:00:00' and '13:59:59' and st.EMP_ID = at.EMP_ID) 
	--				ELSE (select STATUS from #summaryTbl where  CONVERT(VARCHAR(10),DATE_ENTRY, 108)  between '00:00:00' and '13:59:59' and EMP_ID = at.EMP_ID )	
	--			END AS STATUS,
	--			at.IMAGE_PATH,
	--			CASE 
	--				WHEN EXISTS (SELECT EMP_ID FROM #summaryTbl AA WHERE AA.EMP_ID = AT.EMP_ID GROUP BY AA.EMP_ID, AA.EMPLOYEE_NAME HAVING COUNT(AA.EMP_ID) > 1 ) THEN  (select st.DSPLY_ORDR from #summaryTbl st where  CONVERT(VARCHAR(10), st.DATE_ENTRY, 108)  between '00:00:00' and '13:59:59' and st.EMP_ID = at.EMP_ID) 
	--				ELSE (select DSPLY_ORDR from #summaryTbl where  CONVERT(VARCHAR(10),DATE_ENTRY, 108)  between '00:00:00' and '13:59:59' and EMP_ID = at.EMP_ID )							
	--			END  as DSPLY_ORDR																
	--		FROM #summaryTbl at INNER JOIN ATTENDANCE a  on AT.EMP_ID = A.EMP_ID 
	--		ORDER BY at.EMPLOYEE_NAME ASC
	--	END
	--ELSE
	--	BEGIN
	--		INSERT INTO #summaryTbl2
	--		SELECT DISTINCT at.emp_id, at.EMPLOYEE_NAME,at.DESCR,
	--			CASE 
	--				WHEN EXISTS (SELECT EMP_ID FROM #summaryTbl AA WHERE AA.EMP_ID = AT.EMP_ID GROUP BY AA.EMP_ID, AA.EMPLOYEE_NAME HAVING COUNT(AA.EMP_ID) > 1 ) THEN  (select DATE_ENTRY from #summaryTbl where convert(time, date_entry) between  @startdate_today and @enddate_today and EMP_ID = at.EMP_ID)
	--				ELSE at.DATE_ENTRY
	--			END as DATE_ENTRY,
	--			CASE 
	--				WHEN EXISTS (SELECT EMP_ID FROM #summaryTbl AA WHERE AA.EMP_ID = AT.EMP_ID GROUP BY AA.EMP_ID, AA.EMPLOYEE_NAME HAVING COUNT(AA.EMP_ID) > 1 ) THEN  (select st.STATUS from #summaryTbl st where  CONVERT(VARCHAR(10), st.DATE_ENTRY, 108)  between  '14:00:00' and '23:59:59' and st.EMP_ID = at.EMP_ID) 
	--				WHEN EXISTS (SELECT EMP_ID FROM #summaryTbl AA WHERE AA.EMP_ID = AT.EMP_ID AND CONVERT(VARCHAR(10), AA.DATE_ENTRY, 108)  BETWEEN '14:00:00' and '23:59:59'  GROUP BY AA.EMP_ID, AA.EMPLOYEE_NAME HAVING COUNT(AA.EMP_ID) = 1 ) THEN  (select st.STATUS from #summaryTbl st where  CONVERT(VARCHAR(10), st.DATE_ENTRY, 108)  between  '14:00:00' and '23:59:59' and st.EMP_ID = at.EMP_ID)
	--				ELSE (SELECT STATUS FROM #summaryTbl WHERE CONVERT(VARCHAR(10),DATE_ENTRY, 108)   between '00:00:00' and '13:59:59' and EMP_ID = at.EMP_ID )	
	--			END  as STATUS,
	--			at.IMAGE_PATH,
	--			CASE 
	--				WHEN EXISTS (SELECT EMP_ID FROM #summaryTbl AA WHERE AA.EMP_ID = AT.EMP_ID GROUP BY AA.EMP_ID, AA.EMPLOYEE_NAME HAVING COUNT(AA.EMP_ID) > 1 ) THEN  (select st.DSPLY_ORDR from #summaryTbl st where  CONVERT(VARCHAR(10), st.DATE_ENTRY, 108)  between '14:00:00' and '23:59:59' and st.EMP_ID = at.EMP_ID) 
	--				WHEN EXISTS (SELECT EMP_ID FROM #summaryTbl AA WHERE AA.EMP_ID = AT.EMP_ID AND CONVERT(VARCHAR(10), AA.DATE_ENTRY, 108)  BETWEEN '14:00:00' and '23:59:59' GROUP BY AA.EMP_ID, AA.EMPLOYEE_NAME HAVING COUNT(AA.EMP_ID) = 1 ) THEN  (select st.DSPLY_ORDR from #summaryTbl st where  CONVERT(VARCHAR(10), st.DATE_ENTRY, 108)  between '14:00:00' and '23:59:59' and st.EMP_ID = at.EMP_ID) 
	--				ELSE (SELECT DSPLY_ORDR FROM #summaryTbl WHERE  CONVERT(VARCHAR(10),DATE_ENTRY, 108)   between '00:00:00' and '13:59:59' and EMP_ID = at.EMP_ID )							
	--			END  as DSPLY_ORDR																
	--		FROM #summaryTbl at INNER JOIN ATTENDANCE a on AT.EMP_ID = A.EMP_ID 
	--		ORDER BY at.EMPLOYEE_NAME ASC
	--	END

	--SELECT * FROM #summaryTbl2 ORDER BY DSPLY_ORDR, EMPLOYEE_NAME ASC
END

GO


