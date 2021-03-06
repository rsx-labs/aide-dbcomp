USE [AIDE]
GO
/****** Object:  Table [dbo].[ACTIONLIST]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP TABLE [dbo].[ACTIONLIST]
GO
/****** Object:  Table [dbo].[ACTIONLIST]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ACTIONLIST](
	[ACTREF] [varchar](30) NOT NULL,
	[ACT_MESSAGE] [varchar](max) NOT NULL,
	[EMP_ID] [int] NOT NULL,
	[DUE_DATE] [date] NULL,
	[DATE_CREATED] [date] NULL,
	[ACT_STATUS] [int] NULL,
	[DATE_CLOSED] [varchar](50) NULL,
	[NICK_NAME] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ACTREF] ASC,
	[EMP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
