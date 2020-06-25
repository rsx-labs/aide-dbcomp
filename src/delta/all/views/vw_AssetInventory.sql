USE [AIDE]
GO

/****** Object:  View [dbo].[vw_AssetInventory]    Script Date: 06/25/2020 12:05:59 PM ******/
DROP VIEW [dbo].[vw_AssetInventory]
GO

/****** Object:  View [dbo].[vw_AssetInventory]    Script Date: 06/25/2020 12:05:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



	CREATE VIEW [dbo].[vw_AssetInventory] AS
	SELECT 
			I.EMP_ID AS 'EmployeeID',
			CASE WHEN I.STATUS = 2 THEN 
				CONCAT(E.LAST_NAME, ', ', E.FIRST_NAME) 
				ELSE 'SPARE'
			END AS 'EmployeeName', 
			D.DESCR AS Department, 
			A.ASSET_DESC AS [Description], 
			A.MANUFACTURER as Manufacturer, 
			A.MODEL_NO as Model, 
			A.SERIAL_NO as 'SerialNumber', 
			A.ASSET_TAG as 'AssetTag',
			CONVERT(VARCHAR, A.DATE_PURCHASED, 101) as 'DatePurchased',
			CONVERT(VARCHAR, I.DATE_ASSIGNED, 101) as 'DateAssigned',
			A.OTHER_INFO AS 'OtherInfo',
			CASE WHEN I.COMMENTS IS NULL THEN 
				'' ELSE I.COMMENTS
			END AS Comments,
			E.DEPT_ID as 'DepartmentID',
			E.DIV_ID as 'DivisionID',
			A.STATUS as StatusID,
			S.DESCR as StatusDesc
	FROM ASSETS A
		INNER JOIN ASSETS_INVENTORY I
			ON A.ASSET_ID = I.ASSET_ID
		INNER JOIN EMPLOYEE E
			ON I.EMP_ID = E.EMP_ID
		INNER JOIN DEPARTMENT D
			ON E.DEPT_ID = D.DEPT_ID
		INNER JOIN [STATUS] S
			ON A.STATUS = S.STATUS AND S.STATUS_NAME='ASSETS'
	



GO


