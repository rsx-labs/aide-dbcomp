USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_Status_SelectByPrimaryKey]    Script Date: 6/30/2020 7:04:35 PM ******/
DROP PROCEDURE [dbo].[sp_Status_SelectByPrimaryKey]
GO

/****** Object:  StoredProcedure [dbo].[sp_Status_SelectByPrimaryKey]    Script Date: 6/30/2020 7:04:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Status_SelectByPrimaryKey]
@STATUS_ID smallint
AS

	If @Status_ID >0
	Begin
		SELECT 
			[STATUS_ID], [STATUS_NAME], [DESCR], [STATUS]
		FROM [dbo].[STATUS]
		WHERE 
			STATUS_ID = @STATUS_ID
		ORDER BY DESCR ASC
	End
	Else
	Begin
		SELECT 
			[STATUS_ID], [STATUS_NAME], [DESCR], [STATUS]
		FROM [dbo].[STATUS]
		ORDER BY DESCR ASC
	End
GO


