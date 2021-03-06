USE [AIDE]
GO
DELETE FROM [dbo].[KPI_TARGETS]
GO
SET IDENTITY_INSERT [dbo].[KPI_TARGETS] ON 

INSERT [dbo].[KPI_TARGETS] ([ID], [EMP_ID], [FY_START], [FY_END], [KPI_REF], [SUBJECT], [DESCRIPTION], [DATE_CREATED]) VALUES (1, 915000121, CAST(N'2019-04-01' AS Date), CAST(N'2020-03-31' AS Date), N'KPI-2019-01', N'KPI 1 - Incident Fixing', N'-> 4 bugs x 95% = 3.8 bugs in 5 days', CAST(N'2019-09-12' AS Date))
INSERT [dbo].[KPI_TARGETS] ([ID], [EMP_ID], [FY_START], [FY_END], [KPI_REF], [SUBJECT], [DESCRIPTION], [DATE_CREATED]) VALUES (2, 915000121, CAST(N'2019-04-01' AS Date), CAST(N'2020-03-31' AS Date), N'KPI-2019-02', N'KPI 2 - Enhancements', N'-> 95% of enhancements and task are completed within the target date', CAST(N'2019-09-12' AS Date))
INSERT [dbo].[KPI_TARGETS] ([ID], [EMP_ID], [FY_START], [FY_END], [KPI_REF], [SUBJECT], [DESCRIPTION], [DATE_CREATED]) VALUES (4, 915000121, CAST(N'2019-04-01' AS Date), CAST(N'2020-03-31' AS Date), N'KPI-2019-03', N'KPI 3 - Quality', N'->One defect per mandays of effort', CAST(N'2019-09-12' AS Date))
INSERT [dbo].[KPI_TARGETS] ([ID], [EMP_ID], [FY_START], [FY_END], [KPI_REF], [SUBJECT], [DESCRIPTION], [DATE_CREATED]) VALUES (6, 915000121, CAST(N'2020-04-01' AS Date), CAST(N'2021-03-31' AS Date), N'KPI-2020-01', N'KPI 1 - Incident Fixing', N'-> 4 bugs x 95% = 3.8 bugs in 5 days', CAST(N'2020-04-01' AS Date))
INSERT [dbo].[KPI_TARGETS] ([ID], [EMP_ID], [FY_START], [FY_END], [KPI_REF], [SUBJECT], [DESCRIPTION], [DATE_CREATED]) VALUES (7, 915000121, CAST(N'2020-04-01' AS Date), CAST(N'2021-03-31' AS Date), N'KPI-2020-02', N'KPI 2 - Enhancements', N'-> 95% of enhancements and task are completed within the target date', CAST(N'2020-04-01' AS Date))
INSERT [dbo].[KPI_TARGETS] ([ID], [EMP_ID], [FY_START], [FY_END], [KPI_REF], [SUBJECT], [DESCRIPTION], [DATE_CREATED]) VALUES (9, 915000121, CAST(N'2020-04-01' AS Date), CAST(N'2021-03-31' AS Date), N'KPI-2020-03', N'KPI 3 - Quality', N'->One defect per mandays of effort', CAST(N'2020-04-01' AS Date))
SET IDENTITY_INSERT [dbo].[KPI_TARGETS] OFF
