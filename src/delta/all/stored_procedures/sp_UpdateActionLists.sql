USE [AIDE]
GO

/****** Object:  StoredProcedure [dbo].[sp_UpdateActionLists]    Script Date: 07/14/2020 4:34:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_UpdateActionLists] 
	@ACTION_TEXT VARCHAR(MAX), 
	@ACTION_ASSIGNEE INT, 
	@ACTION_DUE_DATE DATE, 
	@ACTION_DATE_CLOSED varchar(max), 
	@REFERENCE VARCHAR(30),
	@NICK_NAME VARCHAR(max)
AS
	DECLARE @GetRefID varchar(max)= (select DISTINCT a.REF_ID  from ACTION_REFERNCE_3CS a , ACTIONLIST b where a.ACTREF = @REFERENCE) 
	DECLARE @GetCommonRefID varchar(max)= (select REF_ID from dbo.ACTION_REFERNCE_3CS where ACTREF=@REFERENCE)
	DECLARE @DivId as int = (select DIV_ID from EMPLOYEE where EMP_ID = @ACTION_ASSIGNEE)
	DECLARE @DeptID as int = (select DEPT_ID from EMPLOYEE where EMP_ID = @ACTION_ASSIGNEE)
	--DECLARE @GetAllAction varchar(max)= (select ACTREF from dbo.ACTION_REFERNCE_3CS where REF_ID=@GetCommonRefID)
	DECLARE @CountClosed as int = 0
BEGIN
	UPDATE ACTIONLIST 
	SET ACT_MESSAGE=@ACTION_TEXT, 
	DUE_DATE=@ACTION_DUE_DATE, 
	DATE_CLOSED=@ACTION_DATE_CLOSED,
	NICK_NAME = @NICK_NAME
	WHERE ACTREF=@REFERENCE
	--AND EMP_ID in(select EMP_ID from EMPLOYEE where DEPT_ID =@DeptID AND DIV_ID = @DivId)

	-- closes all actions linked to the same 3C
	--UPDATE ACTIONLIST 
	--Set DATE_CLOSED=@ACTION_DATE_CLOSED
	--FROM ACTIONLIST a 
	--inner join ACTION_REFERNCE_3CS b
	--on a.ACTREF = b.ACTREF 
	--where b.REF_ID = @GetCommonRefID

	if @ACTION_DATE_CLOSED = NULL OR @ACTION_DATE_CLOSED = ''
	return
	else
		BEGIN

		SELECT @CountClosed = COUNT(b.ACTREF)
		FROM  ACTION_REFERNCE_3CS a , ACTIONLIST b
		where a.ACTREF = b.ACTREF
		and a.REF_ID = @GetCommonRefID
		and (b.DATE_CLOSED IS NULL or b.DATE_CLOSED = '')

		UPDATE  CONCERN_CAUSE_COUNTERMEASURE set [STATUS]=2 from CONCERN_CAUSE_COUNTERMEASURE c ,  ACTION_REFERNCE_3CS a 
		where c.REF_ID = a.REF_ID and a.ACTREF = @REFERENCE
		and @CountClosed = 0

		END
END 


GO


