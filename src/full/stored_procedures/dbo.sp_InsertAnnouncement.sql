USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAnnouncement]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertAnnouncement]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAnnouncement]    Script Date: 04/22/2020 2:29:00 PM ******/
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
	@TITLE VARCHAR(50),
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
