USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertMandatoryCourse]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertMandatoryCourse]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertMandatoryCourse]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertMandatoryCourse]
	-- Add the parameters for the stored procedure here
	@EMP_ID INT,
	@COURSE VARCHAR(MAX),
	@DUE_DATE DATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.[MANDATORY_COURSES] (EMP_ID, ASSIGNED_TO, SABA_COURSE, DUE_DATE)
	SELECT @EMP_ID, EMP_ID, @COURSE, @DUE_DATE FROM dbo.EMPLOYEE E 
	WHERE E.DEPT_ID = (SELECT A.DEPT_ID FROM EMPLOYEE A INNER JOIN CONTACTS B
					   ON A.EMP_ID = B.EMP_ID WHERE A.EMP_ID = @EMP_ID) AND
					   E.DIV_ID = (SELECT A.DIV_ID FROM EMPLOYEE A INNER JOIN CONTACTS B
					   ON A.EMP_ID = B.EMP_ID WHERE A.EMP_ID = @EMP_ID) 
END

GO
