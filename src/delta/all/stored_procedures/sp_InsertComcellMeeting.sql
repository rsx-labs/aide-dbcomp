USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_InsertComcellMeeting]    Script Date: 10/06/2020 18:18:46 ******/
DROP PROCEDURE [dbo].[sp_InsertComcellMeeting]
GO

/****** Object:  StoredProcedure [dbo].[sp_InsertComcellMeeting]    Script Date: 10/06/2020 18:18:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_InsertComcellMeeting]
	-- Add the parameters for the stored procedure here
	@EMP_ID INT,
	@MONTH VARCHAR(10),
	@FACILITATOR VARCHAR(10),
	@MINUTES_TAKER VARCHAR(10),
	@YEAR INT,
	@WEEK INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FIRSTMONTH DATE, @LASTMONTH DATE
	DECLARE @DSPLY_ORDR AS INT

    -- Insert statements for procedure here
		IF @MONTH = 'April'
			BEGIN
				SET @DSPLY_ORDR = 1
			 END
		ELSE IF  @MONTH = 'May'
			BEGIN
				SET @DSPLY_ORDR = 2
			 END
		ELSE IF  @MONTH = 'June'
			BEGIN
				SET @DSPLY_ORDR = 3
			 END
		ELSE IF  @MONTH = 'July'
			BEGIN
				SET @DSPLY_ORDR = 4
			 END
		ELSE IF  @MONTH = 'August'
			BEGIN
				SET @DSPLY_ORDR = 5
			 END
		ELSE IF  @MONTH = 'September'
			BEGIN
				SET @DSPLY_ORDR = 6
			 END
		ELSE IF  @MONTH = 'October'
			BEGIN
				SET @DSPLY_ORDR = 7
			 END
		ELSE IF  @MONTH = 'November'
			BEGIN
				SET @DSPLY_ORDR = 8
			 END
		ELSE IF  @MONTH = 'December'
			BEGIN
				SET @DSPLY_ORDR = 9
			 END
		ELSE IF  @MONTH = 'January'
			BEGIN
				SET @DSPLY_ORDR = 10
			 END
		ELSE IF  @MONTH = 'February'
			BEGIN
				SET @DSPLY_ORDR = 11
			 END
		ELSE IF  @MONTH = 'March'
			BEGIN
				SET @DSPLY_ORDR = 12
			 END


	-- Set Current Fiscal Year
	--SET @FIRSTMONTH = CAST('4/1/' + Cast(@YEAR as varchar) AS DATE)
	--SET @LASTMONTH = CAST('3/31/' + Cast(@YEAR + 1 as varchar) AS DATE)

	SET @FIRSTMONTH = (SELECT FY_START FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)
	SET @LASTMONTH = (SELECT FY_END FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)

	Declare @existing as Int = 0

	Select @existing = Count(*) From COMCELL_MEETING Where EMP_ID=@EMP_ID and [Month] = @MONTH and FY_START = @FIRSTMONTH and FY_END=@LASTMONTH and [Week]=@WEEK

	IF (@existing > 0 )
	BEGIN
		Update COMCELL_MEETING
		Set FACILITATOR =@FACILITATOR , MINUTES_TAKER=@MINUTES_TAKER
		Where EMP_ID=@EMP_ID and [Month] = @MONTH and FY_START = @FIRSTMONTH and FY_END=@LASTMONTH and [Week]=@WEEK
	END
	ELSE
	BEGIN
		INSERT INTO COMCELL_MEETING
		VALUES (@EMP_ID, @MONTH, @FACILITATOR, @MINUTES_TAKER, @FIRSTMONTH, @LASTMONTH, @DSPLY_ORDR, @WEEK)
	END
END

GO


