USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAssetsInventory]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertAssetsInventory]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAssetsInventory]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertAssetsInventory]
	-- Add the parameters for the stored procedure here
	@EMPID int,
	@ASSET_ID int,
	@STATUS int,
	@DATE_ASSIGNED DATETIME,
	@COMMENTS text

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 
	INSERT [dbo].[ASSETS_INVENTORY]
	(
		[EMP_ID],
		[ASSET_ID],
		[STATUS],
		[DATE_ASSIGNED],
		[COMMENTS],
		[APPROVAL]
	)
	VALUES
	(
		@EMPID,
		@ASSET_ID,
		@STATUS,
		@DATE_ASSIGNED,
		@COMMENTS,
		0
	)

	DECLARE @DATE DATETIME= GETDATE(),
			@EMP_ID_ INT = @EMPID

	EXEC sp_InsertAssetHistory
		 @EMPID = @EMP_ID_,
		 @ASSETID = @ASSET_ID,
		 @STATS = @STATUS,
		 @DATEASSIGNED = @DATE,
		 @TABLENAME = N'ASSETS_INVENTORY'
END

GO
