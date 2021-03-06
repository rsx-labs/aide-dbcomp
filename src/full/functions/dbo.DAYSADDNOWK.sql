USE [AIDE]
GO
/****** Object:  UserDefinedFunction [dbo].[DAYSADDNOWK]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP FUNCTION [dbo].[DAYSADDNOWK]
GO
/****** Object:  UserDefinedFunction [dbo].[DAYSADDNOWK]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE FUNCTION [dbo].[DAYSADDNOWK](@addDate AS DATE, @numDays AS INT)
	RETURNS DATETIME
	AS
	BEGIN
		SET @addDate = DATEADD(d, @numDays, @addDate)
		IF DATENAME(DW, @addDate) = 'sunday'   SET @addDate = DATEADD(d, 1, @addDate)
		IF DATENAME(DW, @addDate) = 'saturday' SET @addDate = DATEADD(d, 2, @addDate)
 
		RETURN CAST(@addDate AS DATETIME)
	END
GO
