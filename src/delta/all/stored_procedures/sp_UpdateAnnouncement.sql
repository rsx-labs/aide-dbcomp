USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_UpdateAnnouncement]    Script Date: 08/06/2020 3:38:15 PM ******/
DROP PROCEDURE [dbo].[sp_UpdateAnnouncement]
GO

/****** Object:  StoredProcedure [dbo].[sp_UpdateAnnouncement]    Script Date: 08/06/2020 3:38:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_UpdateAnnouncement] 
@ANNOUNCEMENT_ID INT, 
@EMP_ID INT, 
@TITLE varchar(150), 
@MESSAGE varchar(max), 
@END_DATE DATE,
@DELETED_FG tinyint
AS
DECLARE @DivId as int = (select DIV_ID from EMPLOYEE where EMP_ID = @EMP_ID)
DECLARE @DeptID as int = (select DEPT_ID from EMPLOYEE where EMP_ID = @EMP_ID)

BEGIN

IF @DELETED_FG = 1
	BEGIN
		UPDATE ANNOUNCEMENTS
		SET DELETED_FG = @DELETED_FG
		WHERE ANNOUNCEMENT_ID=@ANNOUNCEMENT_ID
		AND EMP_ID in(select EMP_ID from EMPLOYEE where DEPT_ID =@DeptID AND DIV_ID = @DivId)
	END

ELSE
	BEGIN
		UPDATE ANNOUNCEMENTS 
		SET EMP_ID=@EMP_ID, 
		TITLE=@TITLE, 
		MESSAGE=@MESSAGE,
		END_DATE = @END_DATE
		WHERE ANNOUNCEMENT_ID=@ANNOUNCEMENT_ID
		AND EMP_ID in(select EMP_ID from EMPLOYEE where DEPT_ID =@DeptID AND DIV_ID = @DivId)
	END

END 
GO


