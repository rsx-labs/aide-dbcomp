USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetCommendations]    Script Date: 9/14/2020 10:24:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetCommendations]
	-- Add the parameters for the stored procedure here
	@EMP_ID INT
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
	SELECT a.COMMEND_ID,a.EMPLOYEE,a.PROJECT,a.SENT_BY ,a.DATE_SENT,a.REASON
	FROM COMMENDATIONS  A
	INNER JOIN [dbo].[EMPLOYEE] B 
	on A.EMP_ID = B.EMP_ID 
	WHERE Month(DATE_SENT) = Month(GETDATE()) And Year(Date_Sent) =  Year(GetDate())
	AND B.DEPT_ID = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID )
	AND B.DIV_ID = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)
	ORDER BY DATE_SENT DESC
END
GO


