USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertYearDates]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertYearDates]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertYearDates]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertYearDates]
	-- Add the parameters for the stored procedure here
@From dateTIME,
@To dateTIME,
@EMP_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

    WHILE(@From<= @To) 
		BEGIN
			if DATENAME(DW,@From) = 'Saturday' or DATENAME(DW,@From) = 'Sunday'
				BEGIN
					SET @From = DATEADD(DAY, 1, @From)
				END
			ELSE
				BEGIN
					INSERT INTO [dbo].[ATTENDANCE] VALUES (@EMP_ID,@From,NULL)
					SET @From = DATEADD(DAY, 1, @From)
				END
		END 
END

GO
