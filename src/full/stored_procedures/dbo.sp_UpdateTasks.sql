USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTasks]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_UpdateTasks]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTasks]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateTasks] 
	@TASKS_ID INT, 
	@PROJ_ID INT,
	@PROJECT_CODE INT,
	@REWORK SMALLINT,
	@REF_ID VARCHAR(15),
	@INC_DESCR VARCHAR(255),
	@SEVERITY SMALLINT,
	@INC_TYPE SMALLINT,
	@EMP_ID INT, 
	@PHASE SMALLINT,
	@STATUS SMALLINT, 
	@DATE_STARTED DATE,
	@TARGET_DATE DATE, 
	@COMPLTD_DATE DATE, 
	@EFFORT_EST FLOAT,
	@ACT_EFFORT FLOAT, 
	@ACT_EFFORT_WK FLOAT, 
	@COMMENTS VARCHAR(255) 
AS

SET NOCOUNT ON

	UPDATE TASKS
    SET 
		PROJ_ID = @PROJ_ID,
		PROJECT_CODE = @PROJECT_CODE,
		REWORK = @REWORK,
		REF_ID = @REF_ID,
		INC_DESCR = @INC_DESCR,
		SEVERITY = @SEVERITY,
		INC_TYPE = @INC_TYPE,
		PHASE = @PHASE, 
		STATUS = @STATUS, 
		DATE_STARTED = @DATE_STARTED,
		TARGET_DATE = @TARGET_DATE,
		COMPLTD_DATE =  @COMPLTD_DATE,
		EFFORT_EST = @EFFORT_EST,
		ACT_EFFORT = @ACT_EFFORT,
		ACT_EFFORT_WK = @ACT_EFFORT_WK,
		COMMENTS = @COMMENTS 
    WHERE EMP_ID = @EMP_ID 
	AND TASK_ID = @TASKS_ID

	-- UPDATE WEEKLY REPORT DATA
	UPDATE WEEKLY_REPORT 
	SET 
		WR_REF_ID = @REF_ID,
		WR_PROJ_ID = @PROJ_ID,
		WR_SUBJECT = @INC_DESCR, 
		WR_SEVERITY = @SEVERITY,
		WR_INC_TYPE = @INC_TYPE 
	WHERE WR_TASK_ID = @TASKS_ID
	AND WR_EMP_ID = @EMP_ID
	AND WR_DELETE_FG = 0
GO
