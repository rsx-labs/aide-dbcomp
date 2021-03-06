USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSendCodeConfig]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetSendCodeConfig]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSendCodeConfig]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetSendCodeConfig]
	-- Add the parameters for the stored procedure here
AS
DECLARE @decryptVar VARCHAR(MAX), @decryptBin VARBINARY(200)
BEGIN

SET @decryptBin = CONVERT(VARBINARY(200),(SELECT SC_SENDER_PASSWORD FROM SEND_CODE_CONFIG),1)
SET @decryptVar = CONVERT(VARCHAR(MAX),DECRYPTBYPASSPHRASE('fujitsu.key.001', @decryptBin))

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

    -- Select statements for procedure here
	
	SELECT SC_SENDER_EMAIL,SC_SUBJECT,SC_BODY,
	SC_PORT,SC_HOST,SC_ENABLE_SSL,SC_TIMEOUT, 
	SC_USE_DFLT_CREDENTIALS,@decryptVar as SC_SENDER_PASSWORD,SC_PASSWORD_EXPIRY 
	FROM SEND_CODE_CONFIG
END 

GO
