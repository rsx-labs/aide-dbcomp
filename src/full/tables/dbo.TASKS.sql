USE [AIDE]
GO
/****** Object:  Table [dbo].[TASKS]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP TABLE [dbo].[TASKS]
GO
/****** Object:  Table [dbo].[TASKS]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TASKS](
	[TASK_ID] [int] NOT NULL,
	[EMP_ID] [int] NOT NULL,
	[REF_ID] [varchar](10) NULL,
	[INC_TYPE] [smallint] NOT NULL,
	[PROJ_ID] [int] NOT NULL,
	[INC_DESCR] [varchar](max) NOT NULL,
	[DATE_STARTED] [date] NULL,
	[TARGET_DATE] [date] NULL,
	[COMPLTD_DATE] [date] NULL,
	[DATE_CREATED] [date] NOT NULL,
	[STATUS] [smallint] NOT NULL,
	[COMMENTS] [varchar](200) NULL,
	[EFFORT_EST] [float] NULL,
	[ACT_EFFORT] [float] NULL,
	[ACT_EFFORT_WK] [float] NULL,
	[PROJECT_CODE] [int] NOT NULL,
	[REWORK] [smallint] NULL,
	[PHASE] [smallint] NOT NULL,
	[OTHERS_1] [varchar](100) NULL,
	[OTHERS_2] [varchar](100) NULL,
	[OTHERS_3] [varchar](100) NULL,
	[SEVERITY] [smallint] NULL,
 CONSTRAINT [PK_TASKS] PRIMARY KEY CLUSTERED 
(
	[TASK_ID] ASC,
	[EMP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
