USE [AIDE]
GO
/****** Object:  User [aide-user]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP USER [aide-user]
GO
/****** Object:  User [aide-user]    Script Date: 04/22/2020 2:29:00 PM ******/
CREATE USER [aide-user] FOR LOGIN [aide-user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [aide-user]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [aide-user]
GO
