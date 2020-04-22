USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertProject]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertProject]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertProject]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertProject]
	@PROJ_ID int ,
	@PROJ_CD nvarchar(10) ,
	@PROJ_NAME varchar(20) ,
	@CATEGORY smallint ,
	@BILLABILITY smallint 

AS

INSERT [dbo].[PROJECT]
(
	[PROJ_ID],
	[PROJ_CD],
	[PROJ_NAME],
	[CATEGORY],
	[BILLABILITY]

)
VALUES
(
	@PROJ_ID,
	@PROJ_CD,
	@PROJ_NAME,
	@CATEGORY,
	@BILLABILITY

)





GO
