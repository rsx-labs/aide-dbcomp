USE [AIDE]
GO
DELETE FROM [dbo].[OPTION_FUNCTION]
GO
SET IDENTITY_INSERT [dbo].[OPTION_FUNCTION] ON 

INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (1, N'Enable Sending Email')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (2, N'Missing Daily Entry')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (3, N'Missing Weekly Report')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (4, N'Check Afternoon Time')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (5, N'Check Afternoon Time End')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (6, N'Event Startup ID')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (7, N'Event Login ID')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (8, N'Default Email Address')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (9, N'Asset Movement (Assign)')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (10, N'Asset Movement (Verify)')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (11, N'Asset Movement (Approval)')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (12, N'Default Number of records in Datagrid')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (13, N'Update Contact List')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (14, N'Update Skills Matrix')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (15, N'Update Workplace Audit')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (16, N'Default employee photo path')
INSERT [dbo].[OPTION_FUNCTION] ([FunctionID], [Description]) VALUES (17, N'AIDE Update feed URL')
SET IDENTITY_INSERT [dbo].[OPTION_FUNCTION] OFF

GO
