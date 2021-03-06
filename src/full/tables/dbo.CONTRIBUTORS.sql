USE [AIDE]
GO
/****** Object:  Table [dbo].[CONTRIBUTORS]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP TABLE [dbo].[CONTRIBUTORS]
GO
/****** Object:  Table [dbo].[CONTRIBUTORS]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTRIBUTORS](
	[FULL_NAME] [nvarchar](50) NOT NULL,
	[IMAGE_PATH] [nvarchar](max) NULL,
	[DEPARTMENT] [nvarchar](20) NULL,
	[DIVISION] [nvarchar](20) NULL,
	[POSITION] [nvarchar](20) NULL,
	[CONTRI_LVL] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
