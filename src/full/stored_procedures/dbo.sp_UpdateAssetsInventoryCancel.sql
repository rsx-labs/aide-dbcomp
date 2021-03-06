USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAssetsInventoryCancel]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_UpdateAssetsInventoryCancel]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAssetsInventoryCancel]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateAssetsInventoryCancel] 
	-- Add the parameters for the stored procedure here
	@ASSET_ID INT,
	@EMP_ID INT,
	@DATE_ASSIGNED DATETIME,
	@STATUS int,
	@APPROVAL int,
	@COMMENTS text
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	UPDATE [dbo].[ASSETS_INVENTORY]
	SET [EMP_ID] = @EMP_ID,
		[STATUS] = @STATUS,
		[APPROVAL] = @APPROVAL,
		[COMMENTS]=@COMMENTS
	WHERE ASSET_ID = @ASSET_ID

	UPDATE [dbo].[ASSETS]
	SET [STATUS] = @STATUS
	WHERE [ASSET_ID] = @ASSET_ID

	
	DECLARE @DATE DATETIME= GETDATE()

	EXEC sp_InsertAssetHistory
		 @EMPID = @EMP_ID,
		 @ASSETID = @ASSET_ID,
		 @STATS = @APPROVAL,
		 @DATEASSIGNED = @DATE,
		 @TABLENAME = N'ASSETS_INVENTORY'
END

GO
