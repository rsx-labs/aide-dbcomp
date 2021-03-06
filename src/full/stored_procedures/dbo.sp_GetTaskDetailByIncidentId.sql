USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTaskDetailByIncidentId]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetTaskDetailByIncidentId]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTaskDetailByIncidentId]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetTaskDetailByIncidentId]
	-- Add the parameters for the stored procedure here
	@EMP_ID INT
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM TASKS A
	INNER JOIN STATUS B ON A.STATUS = B.STATUS
	WHERE EMP_ID = @EMP_ID 
	AND A.STATUS <> 3 
	AND B.STATUS_ID = 3 
	--AND DATEPART(wk, A.DATE_CREATED) = DATEPART(wk, GETDATE())
END 

GO
