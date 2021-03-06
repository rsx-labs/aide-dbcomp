USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateSabaCourses]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_UpdateSabaCourses]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateSabaCourses]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateSabaCourses] 
@SABA_ID INT,
@EMP_ID INT, 
@TITLE VARCHAR(100), 
@END_DATE DATE
AS

BEGIN

UPDATE SABA_COURSES SET 
EMP_ID = @EMP_ID, 
TITLE =@TITLE, 
END_DATE = @END_DATE 
WHERE SABA_ID = @SABA_ID

END
GO
