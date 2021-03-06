USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllActionReferencesinConcern]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetAllActionReferencesinConcern]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllActionReferencesinConcern]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllActionReferencesinConcern]
@REF_ID varchar(max)

AS

BEGIN 

	SELECT b.ACT_MESSAGE AS ACTION_REFERENCES, a.ACTREF AS ACTREF
	FROM [dbo].[ACTION_REFERNCE_3CS] a INNER JOIN ACTIONLIST b
	ON b.ACTREF = a.ACTREF
	WHERE a.REF_ID = @REF_ID 
	ORDER BY B.DATE_CREATED DESC
	
END
			

GO
