USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllSabaXref]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetAllSabaXref]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllSabaXref]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetAllSabaXref]
	@EMP_ID INT,
	@SABA_ID INT
AS

	DECLARE @DEPTID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID),
			@DIVID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)
	
	DECLARE @guestAccount SMALLINT = 5

	BEGIN			
		SELECT  SABA_ID , 
				s.EMP_ID, 
				DATE_COMPLETED, 
				FIRST_NAME + ' ' + LAST_NAME as IMAGE_PATH 
		FROM SABA_XREF s INNER JOIN EMPLOYEE e
		ON s.EMP_ID = e.EMP_ID
		WHERE DEPT_ID = @DEPTID 
		AND DIV_ID = @DIVID 
		AND SABA_ID = @SABA_ID
		AND ACTIVE = 1
		AND GRP_ID != @guestAccount
	END
GO
