USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActionListByActionNo]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetActionListByActionNo]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActionListByActionNo]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetActionListByActionNo] 
	@ACT_ID VARCHAR(50),
	@EMP_ID INT
AS

BEGIN
	DECLARE @DEPT_ID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID),
			@DIV_ID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)

	SELECT * FROM ACTIONLIST a
	INNER JOIN EMPLOYEE e
	ON a.EMP_ID = e.EMP_ID
	WHERE ACTREF LIKE '%' + @ACT_ID + '%'
	AND DEPT_ID = @DEPT_ID
	AND DIV_ID = @DIV_ID
	ORDER BY A.DATE_CREATED DESC
END

GO
