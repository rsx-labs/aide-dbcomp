USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllAssetsBySearch]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetAllAssetsBySearch]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllAssetsBySearch]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllAssetsBySearch]
	-- Add the parameters for the stored procedure here
	@EMP_ID INT,
	@INPUT NVARCHAR(MAX)
AS

DECLARE @DEPT_ID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID),
		@DIV_ID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS FULL_NAME, 
		   A.EMP_ID,A.ASSET_ID, 
		   A.ASSET_DESC, 
		   A.MANUFACTURER, 
		   A.MODEL_NO, 
		   A.SERIAL_NO, 
		   A.ASSET_TAG, 
		   A.DATE_PURCHASED, 
		   A.STATUS, 
		   A.OTHER_INFO
	FROM [dbo].[ASSETS] A
	INNER JOIN [dbo].[EMPLOYEE] E
	ON A.EMP_ID = E.EMP_ID
	WHERE E.DEPT_ID = @DEPT_ID AND E.DIV_ID = @DIV_ID
	AND ((a.[ASSET_DESC] LIKE '%' + @INPUT + '%' ) OR
		  (a.[MANUFACTURER] LIKE '%' + @INPUT + '%') OR
		  (a.[MODEL_NO] LIKE '%' + @INPUT + '%') OR
		  (a.[SERIAL_NO] LIKE '%' + @INPUT + '%') OR
		  (a.[ASSET_TAG] LIKE '%' + @INPUT + '%')OR
		  (a.[ASSET_ID] LIKE '%' + @INPUT + '%'))
END

GO
