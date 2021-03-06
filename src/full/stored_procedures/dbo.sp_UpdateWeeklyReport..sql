USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateWeeklyReport]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_UpdateWeeklyReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateWeeklyReport]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateWeeklyReport] 
			@WR_ID INT,
			@WR_RANGE_ID INT, 
			@PROJ_ID INT, 
			@REWORK SMALLINT, 
			@REF_ID VARCHAR(10),
			@SUBJECT VARCHAR(MAX),
			@SEVERITY SMALLINT,
			@INC_TYPE SMALLINT,
			@EMP_ID INT, 
			@PHASE SMALLINT,
			@STATUS SMALLINT, 
			@DATE_STARTED DATE,  
			@DATE_TARGET DATE,  
			@DATE_FINISHED DATE,
			@EFFORT_EST FLOAT, 
			@ACT_EFFORT FLOAT, 
			@ACT_EFFORT_WK FLOAT, 
			@COMMENTS VARCHAR(MAX),
			@INBOUND_CONTACTS SMALLINT,
			@TASK_ID INT,
			@PROJ_CODE INT
AS

SET NOCOUNT ON
	
	BEGIN
		IF EXISTS (SELECT WR_ID FROM WEEKLY_REPORT WHERE WR_ID = @WR_ID)
			BEGIN
				UPDATE WEEKLY_REPORT SET 
					[WR_PROJ_ID] = @PROJ_ID,
					[WR_REWORK] = @REWORK,
					[WR_REF_ID] = @REF_ID,
					[WR_SUBJECT] = @SUBJECT,
					[WR_SEVERITY] = @SEVERITY,
					[WR_INC_TYPE] = @INC_TYPE,
					[WR_PHASE] = @PHASE,
					[WR_STATUS] = @STATUS,
					[WR_DATE_STARTED] = @DATE_STARTED,
					[WR_DATE_TARGET] = @DATE_TARGET,
					[WR_DATE_FINISHED] = @DATE_FINISHED,
					[WR_EFFORT_EST] = @EFFORT_EST,
					[WR_ACT_EFFORT] = @ACT_EFFORT,
					[WR_ACT_EFFORT_WK] = @ACT_EFFORT_WK,
					[WR_COMMENTS] = @COMMENTS,
					[WR_INBOUND_CONTACTS] = @INBOUND_CONTACTS,
					[WR_PROJ_CODE] = @PROJ_CODE
				WHERE
					[WR_ID] = @WR_ID AND
					[WR_WEEK_RANGE_ID] = @WR_RANGE_ID AND
					[WR_EMP_ID] = @EMP_ID
			END
		ELSE
			INSERT INTO WEEKLY_REPORT (
				[WR_WEEK_RANGE_ID],
				[WR_PROJ_ID],
				[WR_REWORK],
				[WR_REF_ID],
				[WR_SUBJECT],
				[WR_SEVERITY],
				[WR_INC_TYPE],
				[WR_EMP_ID],
				[WR_PHASE],
				[WR_STATUS],
				[WR_DATE_STARTED],
				[WR_DATE_TARGET],
				[WR_DATE_FINISHED],
				[WR_EFFORT_EST],
				[WR_ACT_EFFORT],
				[WR_ACT_EFFORT_WK],
				[WR_COMMENTS],
				[WR_INBOUND_CONTACTS],
				[WR_TASK_ID],
				[WR_PROJ_CODE]
			)
			VALUES (
				@WR_RANGE_ID,
				@PROJ_ID,
				@REWORK,
				@REF_ID,
				@SUBJECT,
				@SEVERITY,
				@INC_TYPE,
				@EMP_ID,
				@PHASE,
				@STATUS,
				@DATE_STARTED,
				@DATE_TARGET,
				@DATE_FINISHED,
				@EFFORT_EST,
				@ACT_EFFORT,
				@ACT_EFFORT_WK,
				@COMMENTS,
				@INBOUND_CONTACTS,
				@TASK_ID,
				@PROJ_CODE 
			);
		END

		BEGIN
		-- Update task
			IF @TASK_ID != 0
				BEGIN
					EXEC [dbo].[sp_UpdateTasks] @TASKS_ID = @TASK_ID, 
												@PROJ_ID = @PROJ_ID,
												@PROJECT_CODE = @PROJ_CODE,
												@REWORK = @REWORK,
												@REF_ID = @REF_ID,
												@INC_DESCR = @SUBJECT,
												@SEVERITY = @SEVERITY,
												@INC_TYPE = @INC_TYPE,
												@EMP_ID = @EMP_ID,
												@PHASE = @PHASE,
												@STATUS = @STATUS,
												@DATE_STARTED = @DATE_STARTED,
												@TARGET_DATE = @DATE_TARGET,
												@COMPLTD_DATE = @DATE_FINISHED,
												@EFFORT_EST = @EFFORT_EST,
												@ACT_EFFORT = @ACT_EFFORT,
												@ACT_EFFORT_WK = @ACT_EFFORT_WK,
												@COMMENTS = @COMMENTS 
				END
		END
	

	

GO
