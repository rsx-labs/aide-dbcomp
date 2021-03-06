USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateKPITargets]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_UpdateKPITargets]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateKPITargets]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateKPITargets]
	@ID INT,
	@EMP_ID INT,
	@SUBJECT varchar(50), 
	@DESCRIPTION varchar(255)
AS

BEGIN
	UPDATE KPI_TARGETS 
	SET SUBJECT=@SUBJECT, 
	DESCRIPTION=@DESCRIPTION
	WHERE ID=@ID
	AND EMP_ID = @EMP_ID
END 


GO
