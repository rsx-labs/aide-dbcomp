USE [AIDE]
GO
DELETE FROM [dbo].[OPTION_MODULE]
GO
SET IDENTITY_INSERT [dbo].[OPTION_MODULE] ON 

INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (1, N'Email Notification')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (2, N'Resource Planner')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (3, N'Weekly Report')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (4, N'App Config')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (5, N'Assets')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (6, N'Contact List')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (7, N'Task Monitoring')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (8, N'3Cs')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (9, N'Action List')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (10, N'Lessons Learnt')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (11, N'Success Registers')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (12, N'Assets')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (13, N'Assets History')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (14, N'Assets Borrowing')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (15, N'Projects')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (16, N'Tracker')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (17, N'Skills Matrix')
INSERT [dbo].[OPTION_MODULE] ([ModuleID], [Description]) VALUES (18, N'Workplace Audit')
SET IDENTITY_INSERT [dbo].[OPTION_MODULE] OFF

GO
