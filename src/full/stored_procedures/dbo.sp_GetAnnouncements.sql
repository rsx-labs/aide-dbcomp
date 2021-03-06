USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAnnouncements]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetAnnouncements]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAnnouncements]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetAnnouncements]
	-- Add the parameters for the stored procedure here
	@EMP_ID INT
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
			SELECT A.ANNOUNCEMENT_ID, A.EMP_ID, A.MESSAGE, A.TITLE, A.END_DATE
			FROM ANNOUNCEMENTS A
			INNER JOIN [dbo].[EMPLOYEE] B 
			on A.EMP_ID = B.EMP_ID 
			WHERE A.END_DATE >= DATEADD(MONTH, -1, GETDATE()) 
			AND B.DEPT_ID = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)
			AND B.DIV_ID = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @EMP_ID)
			AND A.DELETED_FG <> 1
			ORDER BY A.END_DATE DESC
END


GO
