USE [AIDE]
GO

/****** Object:  Table [dbo].[OPTION]    Script Date: 7/1/2020 11:59:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OPTION]') AND type in (N'U'))
DROP TABLE [dbo].[OPTION]
GO

/****** Object:  Table [dbo].[OPTION]    Script Date: 7/1/2020 11:59:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OPTION](
	[OptionID] [int] NOT NULL,
	[ModuleID] [int] NOT NULL,
	[FunctionID] [int] NOT NULL,
	[Description] [varchar](255) NULL,
	[Value] [varchar](max) NOT NULL,
 CONSTRAINT [PK_OPTION] PRIMARY KEY CLUSTERED 
(
	[OptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


