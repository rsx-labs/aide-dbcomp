USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertTasks]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertTasks]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertTasks]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertTasks] 
			@TASK_ID INT, 
			@PROJ_ID INT, 
			@PROJECT_CODE INT, 
			@REWORK SMALLINT,
			@REF_ID VARCHAR(15), 
			@INC_DESCR VARCHAR(MAX), 
			@SEVERITY SMALLINT, 
			@INC_TYPE SMALLINT,
			@EMP_ID INT,   
			@PHASE SMALLINT, 
			@STATUS SMALLINT, 
			@DATE_STARTED DATE, 
			@TARGET_DATE DATE, 
			@COMPLTD_DATE DATE, 
			@DATE_CREATED DATE, 
			@EFFORT_EST FLOAT, 
			@ACT_EFFORT FLOAT, 
			@ACT_EFFORT_WK FLOAT,
			@COMMENTS VARCHAR(255)
AS

SET NOCOUNT ON

INSERT INTO TASKS
           (
		   [TASK_ID],
		   [PROJ_ID],
		   [PROJECT_CODE],
		   [REWORK],
		   [REF_ID],
		   [INC_DESCR],
		   [SEVERITY],
		   [INC_TYPE],
		   [EMP_ID],
		   [PHASE], 
		   [STATUS],
		   [DATE_STARTED],
		   [TARGET_DATE],
		   [COMPLTD_DATE],
		   [DATE_CREATED],
		   [EFFORT_EST],
		   [ACT_EFFORT],
		   [ACT_EFFORT_WK],
		   [COMMENTS]
		   )
     VALUES
           (
		   @TASK_ID,
		   @PROJ_ID,
		   @PROJECT_CODE,
		   @REWORK,
		   @REF_ID,
		   @INC_DESCR,
		   @SEVERITY,
		   @INC_TYPE,
		   @EMP_ID,
		   @PHASE,
		   @STATUS,
		   @DATE_STARTED,
		   @TARGET_DATE,
		   @COMPLTD_DATE,
		   @DATE_CREATED,
		   @EFFORT_EST,
		   @ACT_EFFORT,
		   @ACT_EFFORT_WK,
		   @COMMENTS
		   );



GO
