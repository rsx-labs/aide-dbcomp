USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEmployeeEmail]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetEmployeeEmail]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEmployeeEmail]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetEmployeeEmail]
	-- Add the parameters for the stored procedure here
	@EMAIL varchar(100)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT C.EMAIL_ADDRESS AS WORK_EMAIL,E.FIRST_NAME AS FNAME, E.LAST_NAME AS LNAME FROM CONTACTS C INNER JOIN EMPLOYEE E ON C.EMP_ID = E.EMP_ID WHERE C.EMAIL_ADDRESS = @EMAIL
END 

GO
