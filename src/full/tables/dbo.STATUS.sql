USE [AIDE]
GO
/****** Object:  Table [dbo].[STATUS]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP TABLE [dbo].[STATUS]
GO
/****** Object:  Table [dbo].[STATUS]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[STATUS](
	[STATUS_ID] [smallint] NOT NULL,
	[STATUS_NAME] [varchar](20) NOT NULL,
	[DESCR] [varchar](50) NOT NULL,
	[STATUS] [smallint] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
