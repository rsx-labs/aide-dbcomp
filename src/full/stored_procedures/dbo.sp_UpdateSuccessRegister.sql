USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateSuccessRegister]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_UpdateSuccessRegister]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateSuccessRegister]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateSuccessRegister] 
	-- Add the parameters for the stored procedure here
	@DATE_INPUT DATE,
	@ID INT,
	@DETAILSOFSUCCESS TEXT,
	@WHOSINVOLVE TEXT,
	@ADDITIONALINFORMATION TEXT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[SUCCESSREGISTER]
	SET [DATE_INPUT] = @DATE_INPUT,
		[DETAILSOFSUCCESS] = @DETAILSOFSUCCESS,
		[WHOSINVOLVE] = @WHOSINVOLVE,
		[ADDITIONALINFORMATION] = @ADDITIONALINFORMATION
	WHERE ID = @ID
END

GO
