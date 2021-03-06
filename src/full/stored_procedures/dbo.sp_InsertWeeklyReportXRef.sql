USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertWeeklyReportXRef]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertWeeklyReportXRef]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertWeeklyReportXRef]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertWeeklyReportXRef] 
			@WEEK_RANGE INT,
			@EMP_ID INT,
			@STATUS INT,
			@DATE_SUBMITTED DATE
AS

SET NOCOUNT ON

INSERT INTO WEEKLY_REPORT_XREF  
(
	WEEK_RANGE,
	EMP_ID,
	STATUS,
	DATE_SUBMITTED
)
VALUES
(
	@WEEK_RANGE,
	@EMP_ID,
	@STATUS,
	@DATE_SUBMITTED
);



GO
