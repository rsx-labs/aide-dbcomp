USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGeneratedRefNo]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_GetGeneratedRefNo]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGeneratedRefNo]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetGeneratedRefNo]

AS
DECLARE		@GENERATEDREF_ID varchar(max),
			@countPlusOne int,
			@GetDateNow varchar(max),
			@num varchar(max),
			@counts varchar(10)=(SELECT COUNT(DATE_RAISED) FROM [dbo].[Concern_Cause_Countermeasure]);
	
	SET @countPlusOne = 1 + CONVERT(int, @counts)		
	SET @num = CONVERT(varchar(max), @countPlusOne)
	SET @GetDateNow = CONVERT(VARCHAR(10), GETDATE(), 101)
	SET @GENERATEDREF_ID = 'C'+ @num +'-' + @GetDateNow


		
	

		BEGIN 

				SELECT 
						@GENERATEDREF_ID  AS GENERATEDREF_ID
	

		END



GO
