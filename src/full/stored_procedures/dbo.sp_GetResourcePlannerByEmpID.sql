USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetResourcePlannerByEmpID]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetResourcePlannerByEmpID]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetResourcePlannerByEmpID]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetResourcePlannerByEmpID]
	-- Add the parameters for the stored procedure here
	@EMP_ID int,
	@DEPT_ID int,
	@MONTH int,
	@YEAR int
		AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select a.DATE_ENTRY,a.STATUS 
from ATTENDANCE a inner join EMPLOYEE b on a.EMP_ID = b.EMP_ID
where b.EMP_ID = @EMP_ID  and Month(DATE_ENTRY) = @MONTH AND Year(DATE_ENTRY) = @YEAR and b.DEPT_ID = @DEPT_ID
END



GO
