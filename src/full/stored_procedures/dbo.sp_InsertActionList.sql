USE [AIDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertActionList]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP PROCEDURE [dbo].[sp_InsertActionList]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertActionList]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertActionList] 
@ACTION_TEXT VARCHAR(MAX), 
@ACTION_ASSIGNEE INT, 
@ACTION_DUE_DATE DATE, 
@REFERENCE VARCHAR(30),
@NICK_NAME VARCHAR(max)
AS

BEGIN

INSERT INTO ACTIONLIST(
ACTREF,
ACT_MESSAGE,
EMP_ID,
DUE_DATE,
DATE_CREATED,
ACT_STATUS,
NICK_NAME
)
VALUES
(
@REFERENCE,
@ACTION_TEXT,
@ACTION_ASSIGNEE,
@ACTION_DUE_DATE,
GETDATE(),
0,
@NICK_NAME)

END
GO
