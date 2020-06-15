USE [AIDE]
GO

--Option Modules

--Option Function

Delete From OPTION_FUNCTION
Where FunctionID in (17, 18)

INSERT INTO [dbo].[OPTION_FUNCTION]([Description])
VALUES("Update feed url")

INSERT INTO [dbo].[OPTION_FUNCTION]([Description])
VALUES("Minimum version")

--Option
Delete From [Option]
Where OptionID in (47, 48)

INSERT INTO [dbo].[OPTION]([ModuleID],[FunctionID],[Description],[Value])
VALUES (4 ,17,"Update feed url","http://10.158.47.100:8010/Installers/")


INSERT INTO [dbo].[OPTION]([ModuleID],[FunctionID],[Description],[Value])
VALUES (4 ,18,"Minimum version","3.3.5.0")
GO


