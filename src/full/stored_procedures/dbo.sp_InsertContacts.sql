USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertContacts]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertContacts]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertContacts]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertContacts] 
	-- Add the parameters for the stored procedure here
	@EMP_ID INT,
	@LAST_NAME VARCHAR(50),
	@FIRST_NAME VARCHAR(50),
	@MIDDLE_NAME VARCHAR(50),
	@NICK_NAME VARCHAR(50),
	@ACTIVE SMALLINT,
	@BIRTHDATE DATE,
	@DT_HIRED Date,
	@IMAGE_PATH VARCHAR(255),
	@SHIFT VARCHAR(50),
	@EMAIL_ADDRESS VARCHAR(50),
	@EMAIL_ADDRESS2 VARCHAR(50),
	@LOCATION VARCHAR(50),
	@CEL_NO VARCHAR(50),
	@LOCAL INT,
	@HOMEPHONE VARCHAR(50),
	@OTHERPHONE VARCHAR(50),
	@DT_REVIEWED DATE,
	@MARITAL_STATUS_ID VARCHAR(50),
	@POSITION_ID SMALLINT,
	@PERMISSION_GROUP_ID SMALLINT,
	@OLD_EMP_ID INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DIV_ID INT = (SELECT DIV_ID FROM EMPLOYEE WHERE EMP_ID = @OLD_EMP_ID)
	DECLARE @DEPT_ID INT = (SELECT DEPT_ID FROM EMPLOYEE WHERE EMP_ID = @OLD_EMP_ID)


	INSERT INTO [dbo].[EMPLOYEE]
	VALUES(@EMP_ID,
			@EMP_ID,
			@LAST_NAME,
			@FIRST_NAME,
			@MIDDLE_NAME,
			@NICK_NAME,
			@BIRTHDATE,
			@POSITION_ID,
			@DT_HIRED,
			@MARITAL_STATUS_ID,
			@IMAGE_PATH,
			@PERMISSION_GROUP_ID,
			@DEPT_ID,
			@ACTIVE,
			@DIV_ID,
			@SHIFT,
			1)
    -- Insert statements for procedure here
	INSERT INTO [dbo].[CONTACTS]
	VALUES( @EMP_ID,
			@EMAIL_ADDRESS,
			ISNULL(@EMAIL_ADDRESS2, NULL),
			@LOCATION,
			@CEL_NO,
			ISNULL(@LOCAL, NULL),
			ISNULL(@HOMEPHONE, NULL),
			ISNULL(@OTHERPHONE, NULL),
			GETDATE())


	----To mark as Onsite
	--IF @LOCATION != 'Eco Tower, BGC'
	--	BEGIN
	--		exec dbo.[sp_UpdateResourcePlanner] @from = @DT_REVIEWED, @to = @DT_REVIEWED, @EMP_ID = @EMP_ID, @STATUS = 1 
	--	END
	--ELSE IF @LOCATION = 'Eco Tower, BGC'
	--	BEGIN
	--		exec dbo.[sp_UpdateResourcePlanner] @from = @DT_REVIEWED, @to = @DT_REVIEWED, @EMP_ID = @EMP_ID, @STATUS = 2 
	--	END
			
END

GO
