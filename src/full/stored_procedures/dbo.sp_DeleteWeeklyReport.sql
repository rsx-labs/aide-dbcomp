USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteWeeklyReport]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_DeleteWeeklyReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteWeeklyReport]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeleteWeeklyReport]
	@WR_ID INT,
	@WR_RANGE_ID INT,
	@EMP_ID INT,
	@TASK_ID INT,
	@CURR_WEEK_ID INT
AS

BEGIN
	IF EXISTS (SELECT * FROM WEEKLY_REPORT WHERE WR_EMP_ID = @EMP_ID AND WR_WEEK_RANGE_ID = @WR_RANGE_ID AND WR_TASK_ID = @TASK_ID)
		BEGIN
			UPDATE WEEKLY_REPORT SET WR_DELETE_FG = 1
			WHERE WR_ID = @WR_ID
			AND WR_WEEK_RANGE_ID = @WR_RANGE_ID
			AND WR_EMP_ID = @EMP_ID
		END
	ELSE
		BEGIN
			INSERT INTO WEEKLY_REPORT (WR_WEEK_RANGE_ID, 
									   WR_PROJ_ID, 
									   WR_REWORK, 
									   WR_REF_ID, 
									   WR_SUBJECT, 
									   WR_SEVERITY, 
									   WR_INC_TYPE,
									   WR_EMP_ID, 
									   WR_PHASE,
									   WR_STATUS,
									   WR_DATE_STARTED,
									   WR_DATE_TARGET,
									   WR_DATE_FINISHED,
									   WR_EFFORT_EST,
									   WR_ACT_EFFORT_WK,
									   WR_ACT_EFFORT,
									   WR_COMMENTS,
									   WR_INBOUND_CONTACTS,
									   WR_PROJ_CODE,
									   WR_TASK_ID, 
									   WR_DELETE_FG)
			SELECT @CURR_WEEK_ID, PROJ_ID, REWORK, REF_ID, INC_DESCR, SEVERITY, INC_TYPE, @EMP_ID, PHASE, STATUS, 
				   DATE_STARTED, TARGET_DATE, COMPLTD_DATE,
				   EFFORT_EST, ACT_EFFORT_WK, ACT_EFFORT, COMMENTS, 0, PROJECT_CODE, TASK_ID, 1
			FROM TASKS 
			WHERE EMP_ID = @EMP_ID  
			AND TASK_ID = @TASK_ID
		END
	
END
GO
