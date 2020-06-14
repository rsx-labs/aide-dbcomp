USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_UpdateComcellMeeting]    Script Date: 10/06/2020 18:50:44 ******/
DROP PROCEDURE [dbo].[sp_UpdateComcellMeeting]
GO

/****** Object:  StoredProcedure [dbo].[sp_UpdateComcellMeeting]    Script Date: 10/06/2020 18:50:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_UpdateComcellMeeting]
	-- Add the parameters for the stored procedure here
	@COMCELL_ID INT,
	@MONTH VARCHAR(10),
	@FACILITATOR VARCHAR(25),
	@MINUTES_TAKER VARCHAR(25),
	@YEAR INT,
	@WEEK INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FIRSTMONTH DATE, @LASTMONTH DATE

	-- Set Current Fiscal Year
	--SET @FIRSTMONTH = CAST('4/1/' + Cast(@YEAR as varchar) AS DATE)
	--SET @LASTMONTH = CAST('3/31/' + Cast(@YEAR + 1 as varchar) AS DATE)

	SET @FIRSTMONTH = (SELECT FY_START FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)
	SET @LASTMONTH = (SELECT FY_END FROM FISCAL_YEAR WHERE YEAR(FY_START) = @YEAR)
	
    -- Insert statements for procedure here
	UPDATE dbo.[COMCELL_MEETING]
	SET [MONTH] = @MONTH,
		[FACILITATOR] = @FACILITATOR,
		[MINUTES_TAKER] = @MINUTES_TAKER,
		[FY_START] = @FIRSTMONTH,
		[FY_END] = @LASTMONTH,
		[WEEK]=@WEEK
	WHERE [COMCELL_ID] = @COMCELL_ID

END

GO


