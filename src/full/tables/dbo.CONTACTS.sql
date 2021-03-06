USE [AIDE]
GO
ALTER TABLE [dbo].[CONTACTS] DROP CONSTRAINT [FK_CONTACTS_CONTACTS]
GO
/****** Object:  Table [dbo].[CONTACTS]    Script Date: 04/22/2020 2:29:00 PM ******/
DROP TABLE [dbo].[CONTACTS]
GO
/****** Object:  Table [dbo].[CONTACTS]    Script Date: 04/22/2020 2:29:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONTACTS](
	[EMP_ID] [int] NOT NULL,
	[EMAIL_ADDRESS] [varchar](50) NOT NULL,
	[EMAIL_ADDRESS2] [varchar](50) NULL,
	[LOCATION] [varchar](50) NULL,
	[CEL_NO] [varchar](11) NULL,
	[LOCAL] [int] NULL,
	[HOMEPHONE] [varchar](11) NULL,
	[OTHER_PHONE] [varchar](11) NULL,
	[DT_REVIEWED] [datetime] NOT NULL,
 CONSTRAINT [PK_CONTACTS] PRIMARY KEY CLUSTERED 
(
	[EMP_ID] ASC,
	[EMAIL_ADDRESS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CONTACTS]  WITH CHECK ADD  CONSTRAINT [FK_CONTACTS_CONTACTS] FOREIGN KEY([EMP_ID], [EMAIL_ADDRESS])
REFERENCES [dbo].[CONTACTS] ([EMP_ID], [EMAIL_ADDRESS])
GO
ALTER TABLE [dbo].[CONTACTS] CHECK CONSTRAINT [FK_CONTACTS_CONTACTS]
GO
