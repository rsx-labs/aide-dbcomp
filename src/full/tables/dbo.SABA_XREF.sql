USE [AIDE]
GO
/****** Object:  Table [dbo].[SABA_XREF]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP TABLE [dbo].[SABA_XREF]
GO
/****** Object:  Table [dbo].[SABA_XREF]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SABA_XREF](
	[SABA_XREF_ID] [int] IDENTITY(1,1) NOT NULL,
	[SABA_ID] [int] NOT NULL,
	[EMP_ID] [int] NOT NULL,
	[DATE_COMPLETED] [varchar](25) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
