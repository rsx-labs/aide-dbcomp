USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllMessage]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetAllMessage]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllMessage]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllMessage]
@MESSAGE_ID INT,
@SEC_ID INT
AS
BEGIN							
	
	SELECT  MESSAGE_DESCR,TITLE 
	FROM [DBO].[AIDE_MESSAGE]
	WHERE MESSAGE_ID = @MESSAGE_ID AND SEC_ID = @SEC_ID
	ORDER BY ORDER_BY ASC

END

GO
