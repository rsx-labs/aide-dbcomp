USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllPermission]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetAllPermission]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllPermission]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllPermission]
	-- Add the parameters for the stored procedure here
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

			SELECT GRP_ID, DESCR as 'GRP_DESCR' from PERMISSION_GROUP
END


GO
