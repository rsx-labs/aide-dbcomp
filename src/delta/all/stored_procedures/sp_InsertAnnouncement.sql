USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_InsertAnnouncement]    Script Date: 08/06/2020 3:38:29 PM ******/
DROP PROCEDURE [dbo].[sp_InsertAnnouncement]
GO

/****** Object:  StoredProcedure [dbo].[sp_InsertAnnouncement]    Script Date: 08/06/2020 3:38:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertAnnouncement]
	-- Add the parameters for the stored procedure here
	@EMP_ID INT,
	@TITLE VARCHAR(150),
	@MESSAGE VARCHAR(MAX),
	@END_DATE DATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ANNOUNCEMENTS] (EMP_ID, TITLE, MESSAGE, END_DATE)
	VALUES (@EMP_ID, @TITLE, @MESSAGE, @END_DATE)
END
GO


