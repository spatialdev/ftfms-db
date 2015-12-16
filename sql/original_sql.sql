-- CREATE TABLE CATEGORY, 12/11/2015

CREATE TABLE [dbo].[category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE CODELIST, 12/11/2015

CREATE TABLE [dbo].[codelist](
	[codelist_id] [int] IDENTITY(1,1) NOT NULL,
	[code_id] [int] NULL,
	[parent_id] [int] NULL,
	[list] [nvarchar](250) NOT NULL,
	[code] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_codelist] PRIMARY KEY

 CLUSTERED
(
	[codelist_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE COUNTRY, 12/11/2015

CREATE TABLE [dbo].[country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[megasite_id] [int] NOT NULL,
	[code] [nvarchar](5) NULL,
	[title] [nvarchar](250) NOT NULL,
	[description] [nvarchar](max) NULL,
	[image_path] [nvarchar](max) NULL,
 CONSTRAINT [PK_country] PRIMARY KEY CLUSTERED
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



-- CREATE TABLE DATA, 12/11/2015

CREATE TABLE [dbo].[data](
	[data_id] [int] IDENTITY(1,1) NOT NULL,
	[report_id] [int] NOT NULL,
	[edition_id] [int] NULL,
	[indicator_id] [int] NOT NULL,
	[measure_id] [int] NOT NULL,
	[value_id] [int] NOT NULL,
	[data] [nvarchar](max) NULL,
	[exceeds_margin] [bit] NOT NULL,
 CONSTRAINT [PK_data] PRIMARY KEY CLUSTERED
(
	[data_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



-- CREATE TABLE DISTRICT, 12/11/2015

CREATE TABLE [dbo].[district](
	[district_id] [int] IDENTITY(1,1) NOT NULL,
	[country_id] [int] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_district] PRIMARY KEY CLUSTERED
(
	[district_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE EDITION, 12/11/2015

CREATE TABLE [dbo].[edition](
	[edition_id] [int] IDENTITY(1,1) NOT NULL,
	[report_id] [int] NOT NULL,
	[interval_range_id] [int] NOT NULL,
	[year] [int] NOT NULL,
	[draft] [bit] NOT NULL,
	[revised_by] [nvarchar](250) NULL,
	[revised_date] [datetime] NULL,
 CONSTRAINT [PK_edition] PRIMARY KEY CLUSTERED
(
	[edition_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE INDICATOR, 12/11/2015

CREATE TABLE [dbo].[indicator](
	[indicator_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NOT NULL,
	[code] [nvarchar](50) NULL,
	[type] [nvarchar](15) NOT NULL,
	[unit] [varchar](255) NULL,
 CONSTRAINT [PK_indicator] PRIMARY KEY CLUSTERED
(
	[indicator_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



-- CREATE TABLE INTERVAL, 12/11/2015

CREATE TABLE [dbo].[interval](
	[interval_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_interval] PRIMARY KEY CLUSTERED
(
	[interval_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE INTERVAL_RANGE, 12/11/2015

CREATE TABLE [dbo].[interval_range](
	[interval_range_id] [int] IDENTITY(1,1) NOT NULL,
	[interval_id] [int] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[from_month] [int] NOT NULL,
	[from_day] [int] NOT NULL,
	[to_month] [int] NOT NULL,
	[to_day] [int] NOT NULL,
 CONSTRAINT [PK_interval_range] PRIMARY KEY CLUSTERED
(
	[interval_range_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE MEASURE, 12/11/2015

CREATE TABLE [dbo].[measure](
	[measure_id] [int] IDENTITY(1,1) NOT NULL,
	[indicator_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[code] [nvarchar](50) NULL,
 CONSTRAINT [PK_measure] PRIMARY KEY CLUSTERED
(
	[measure_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE MEASURE_VALUE, 12/11/2015

CREATE TABLE [dbo].[measure_value](
	[measure_id] [int] NOT NULL,
	[value_id] [int] NOT NULL,
 CONSTRAINT [PK_measure_value] PRIMARY KEY CLUSTERED
(
	[measure_id] ASC,
	[value_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE MEGASITE, 12/11/2015

CREATE TABLE [dbo].[megasite](
	[megasite_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](5) NULL,
	[title] [nvarchar](250) NOT NULL,
	[first_name] [nvarchar](150) NULL,
	[last_name] [nvarchar](150) NULL,
	[email] [nvarchar](250) NULL,
 CONSTRAINT [PK_megasite] PRIMARY KEY CLUSTERED
(
	[megasite_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE NOTE, 12/11/2015

CREATE TABLE [dbo].[note](
	[note_id] [int] IDENTITY(1,1) NOT NULL,
	[report_id] [int] NOT NULL,
	[note] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_note] PRIMARY KEY CLUSTERED
(
	[note_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



-- CREATE TABLE ORGANIZATION, 12/11/2015

CREATE TABLE [dbo].[organization](
	[organization_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_organization] PRIMARY KEY CLUSTERED
(
	[organization_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



-- CREATE TABLE REPORT, 12/11/2015

CREATE TABLE [dbo].[report](
	[report_id] [int] IDENTITY(1,1) NOT NULL,
	[interval_id] [int] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[name] [nvarchar](250) NULL,
	[email] [nvarchar](250) NULL,
	[status] [varchar](25) NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[created_by] [nvarchar](128) NULL,
	[created_date] [datetime] NULL,
 CONSTRAINT [PK_report] PRIMARY KEY CLUSTERED
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE REPORT_CODELIST, 12/11/2015

CREATE TABLE [dbo].[report_codelist](
	[report_id] [int] NOT NULL,
	[codelist_id] [int] NOT NULL,
 CONSTRAINT [PK_report_codelist] PRIMARY KEY CLUSTERED
(
	[report_id] ASC,
	[codelist_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE REPORT_INDICATOR, 12/11/2015

CREATE TABLE [dbo].[report_indicator](
	[report_id] [int] NOT NULL,
	[indicator_id] [int] NOT NULL,
 CONSTRAINT [PK_report_indicator] PRIMARY KEY CLUSTERED
(
	[report_id] ASC,
	[indicator_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE REPORT_ORGANIZATION, 12/11/2015

CREATE TABLE [dbo].[report_organization](
	[report_id] [int] NOT NULL,
	[organization_id] [int] NOT NULL,
	[lead] [bit] NOT NULL,
 CONSTRAINT [PK_report_organization] PRIMARY KEY CLUSTERED
(
	[report_id] ASC,
	[organization_id] ASC,
	[lead] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


-- CREATE TABLE REPORT_SITE, 12/11/2015

CREATE TABLE [dbo].[report_site](
	[report_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
 CONSTRAINT [PK_report_site] PRIMARY KEY CLUSTERED
(
	[report_id] ASC,
	[site_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



-- CREATE TABLE SITE, 12/11/2015

CREATE TABLE [dbo].[site](
	[site_id] [int] IDENTITY(1,1) NOT NULL,
	[village_id] [nvarchar](10) NULL,
	[title] [nvarchar](250) NOT NULL,
	[type] [nvarchar](25) NOT NULL,
	[image_path] [nvarchar](max) NULL,
	[point] [geometry] NOT NULL,
	[district_id] [int] NULL,
 CONSTRAINT [PK_site] PRIMARY KEY CLUSTERED
(
	[site_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



-- CREATE TABLE VALUE, 12/11/2015

CREATE TABLE [dbo].[value](
	[value_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[type] [nvarchar](15) NOT NULL,
	[fixed] [bit] NOT NULL,
 CONSTRAINT [PK_value] PRIMARY KEY CLUSTERED
(
	[value_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]




-- create view for exporting data to csv
CREATE VIEW [dbo].[vwCSVReport]
AS
SELECT r.report_ids
-- report title
, r.title AS [Report]
-- indicator code
, i.[code] AS [Indicator Code]
-- indicator title
,i.[title] AS [Indicator Literal]
-- category code
,CASE WHEN c.title IS NULL OR c.title = '' THEN i.code + '-' + m.code WHEN c.title IS NOT NULL OR c.title <> '' THEN
i.code + '-' + SUBSTRING(m.code, 0, CHARINDEX('.',m.code)) END AS [Category Code]
-- category title
,CASE WHEN c.title IS NULL OR c.title = '' THEN m.[title] WHEN c.title IS NOT NULL OR c.title <> '' THEN c.title END AS [Category Literal]
-- measure code
,CASE WHEN c.title IS NULL OR c.title = '' THEN NULL WHEN c.title IS NOT NULL OR c.title <> '' THEN i.code + '-' + m.code END AS [Measure Code]
-- measure title
,CASE WHEN c.title IS NULL OR c.title = '' THEN NULL WHEN c.title IS NOT NULL OR c.title <> '' THEN m.title END AS [Measure Literal]
-- indicator unit
,i.[unit] AS [Unit]
-- baseline value
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data WHERE report_id = r.report_id AND edition_id is null
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Baseline')) as [Baseline]
-- all edition values
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2012 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2012-01-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2012 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2012-01-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2012 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2012-02-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2012 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2012-02-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2013 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2013-01-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2013 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2013-01-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2013 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2013-02-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2013 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2013-02-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2014 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2014-01-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2014 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2014-01-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2014 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2014-02-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2014 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2014-02-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2015 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2015-01-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2015 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2015-01-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2015 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2015-02-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2015 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2015-02-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2016 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2016-01-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2016 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '1st Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2016-01-Actual]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2016 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Target')) as [2016-02-Target]
,(SELECT sum(CAST(round([data],2) AS decimal(18,2))) FROM data AS d WHERE d.report_id = r.report_id AND edition_id = (SELECT edition_id FROM edition WHERE report_id = d.report_id
AND [year] = 2016 AND interval_range_id = (SELECT interval_range_id FROM interval_range WHERE title = '2nd Semester'))
AND indicator_id = i.indicator_id AND measure_id = m.measure_id AND value_id = (SELECT value_id FROM value WHERE title = 'Actual')) as [2016-02-Actual]
FROM dbo.report AS r
LEFT JOIN dbo.report_indicator AS ri
ON r.report_id = ri.report_id
LEFT JOIN [dbo].indicator AS i
ON ri.indicator_id = i.indicator_id
LEFT JOIN dbo.measure AS m
ON ri.indicator_id = m.indicator_id
LEFT JOIN dbo.category AS c
ON m.category_id = c.category_id



GO
/****** Object:  View [dbo].[vwSitesByCodelist]    Script Date: 12/11/2015 10:23:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSitesByCodelist]
AS
SELECT [dbo].[site].site_id, [dbo].[report_site].report_id, [dbo].[report_codelist].codelist_id
FROM   [dbo].[report_codelist]
INNER JOIN [dbo].[report_site]
ON [dbo].[report_codelist].report_id = [dbo].[report_site].report_id
INNER JOIN [dbo].[site]
ON [dbo].[report_site].site_id = [dbo].[site].site_id

GO
/****** Object:  View [dbo].[vwSitesByOrganization]    Script Date: 12/11/2015 10:23:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSitesByOrganization]
AS
SELECT [dbo].site.site_id, [dbo].report_site.report_id, [dbo].organization.organization_id
FROM [dbo].organization
INNER JOIN [dbo].report_organization
ON [dbo].organization.organization_id = [dbo].report_organization.organization_id
INNER JOIN [dbo].report
ON [dbo].report_organization.report_id = [dbo].report.report_id
INNER JOIN [dbo].report_site
ON [dbo].report.report_id = [dbo].report_site.report_id
INNER JOIN [dbo].site
ON [dbo].report_site.site_id = [dbo].site.site_id

GO
ALTER TABLE [dbo].[data] ADD  DEFAULT ((0)) FOR [exceeds_margin]
GO
ALTER TABLE [dbo].[edition] ADD  DEFAULT ((1)) FOR [draft]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[report_organization] ADD  DEFAULT ((0)) FOR [lead]
GO
ALTER TABLE [dbo].[value] ADD  DEFAULT ((0)) FOR [fixed]


GO
ALTER TABLE [dbo].[country]  WITH CHECK ADD  CONSTRAINT [FK_country_megasite] FOREIGN KEY([megasite_id])
REFERENCES [dbo].[megasite] ([megasite_id])

GO
ALTER TABLE [dbo].[country] CHECK CONSTRAINT [FK_country_megasite]
GO

ALTER TABLE [dbo].[data]  WITH CHECK ADD  CONSTRAINT [FK_data_edition] FOREIGN KEY([edition_id])
REFERENCES [dbo].[edition] ([edition_id])
GO


ALTER TABLE [dbo].[data] CHECK CONSTRAINT [FK_data_edition]
GO
ALTER TABLE [dbo].[data]  WITH CHECK ADD  CONSTRAINT [FK_data_indicator] FOREIGN KEY([indicator_id])
REFERENCES [dbo].[indicator] ([indicator_id])
GO
ALTER TABLE [dbo].[data] CHECK CONSTRAINT [FK_data_indicator]
GO
ALTER TABLE [dbo].[data]  WITH CHECK ADD  CONSTRAINT [FK_data_measure] FOREIGN KEY([measure_id])
REFERENCES [dbo].[measure] ([measure_id])
GO
ALTER TABLE [dbo].[data] CHECK CONSTRAINT [FK_data_measure]
GO
ALTER TABLE [dbo].[data]  WITH CHECK ADD  CONSTRAINT [FK_data_report] FOREIGN KEY([report_id])
REFERENCES [dbo].[report] ([report_id])
GO
ALTER TABLE [dbo].[data] CHECK CONSTRAINT [FK_data_report]
GO
ALTER TABLE [dbo].[data]  WITH CHECK ADD  CONSTRAINT [FK_data_value] FOREIGN KEY([value_id])
REFERENCES [dbo].[value] ([value_id])
GO
ALTER TABLE [dbo].[data] CHECK CONSTRAINT [FK_data_value]
GO

ALTER TABLE [dbo].[district]  WITH CHECK ADD  CONSTRAINT [FK_district_country] FOREIGN KEY([country_id])
REFERENCES [dbo].[country] ([country_id])
GO
ALTER TABLE [dbo].[district] CHECK CONSTRAINT [FK_district_country]
GO
ALTER TABLE [dbo].[edition]  WITH CHECK ADD  CONSTRAINT [FK_edition_interval_range] FOREIGN KEY([interval_range_id])
REFERENCES [dbo].[interval_range] ([interval_range_id])
GO
ALTER TABLE [dbo].[edition] CHECK CONSTRAINT [FK_edition_interval_range]
GO
ALTER TABLE [dbo].[edition]  WITH CHECK ADD  CONSTRAINT [FK_edition_report] FOREIGN KEY([report_id])
REFERENCES [dbo].[report] ([report_id])
GO
ALTER TABLE [dbo].[edition] CHECK CONSTRAINT [FK_edition_report]
GO
ALTER TABLE [dbo].[interval_range]  WITH CHECK ADD  CONSTRAINT [FK_interval_range_interval] FOREIGN KEY([interval_id])
REFERENCES [dbo].[interval] ([interval_id])

GO
ALTER TABLE [dbo].[interval_range] CHECK CONSTRAINT [FK_interval_range_interval]
GO


ALTER TABLE [dbo].[measure]  WITH CHECK ADD  CONSTRAINT [FK_measure_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[measure] CHECK CONSTRAINT [FK_measure_category]
GO
ALTER TABLE [dbo].[measure]  WITH CHECK ADD  CONSTRAINT [FK_measure_indicator] FOREIGN KEY([indicator_id])
REFERENCES [dbo].[indicator] ([indicator_id])
GO
ALTER TABLE [dbo].[measure] CHECK CONSTRAINT [FK_measure_indicator]
GO
ALTER TABLE [dbo].[measure_value]  WITH CHECK ADD  CONSTRAINT [FK_measure_value_measure] FOREIGN KEY([measure_id])
REFERENCES [dbo].[measure] ([measure_id])
GO
ALTER TABLE [dbo].[measure_value] CHECK CONSTRAINT [FK_measure_value_measure]
GO
ALTER TABLE [dbo].[measure_value]  WITH CHECK ADD  CONSTRAINT [FK_measure_value_value] FOREIGN KEY([value_id])
REFERENCES [dbo].[value] ([value_id])
GO
ALTER TABLE [dbo].[measure_value] CHECK CONSTRAINT [FK_measure_value_value]
GO
ALTER TABLE [dbo].[note]  WITH CHECK ADD  CONSTRAINT [FK_note_report] FOREIGN KEY([report_id])
REFERENCES [dbo].[report] ([report_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[note] CHECK CONSTRAINT [FK_note_report]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FK_report_interval] FOREIGN KEY([interval_id])
REFERENCES [dbo].[interval] ([interval_id])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FK_report_interval]
GO
ALTER TABLE [dbo].[report_codelist]  WITH CHECK ADD  CONSTRAINT [FK_report_codelist_codelist] FOREIGN KEY([codelist_id])
REFERENCES [dbo].[codelist] ([codelist_id])
GO
ALTER TABLE [dbo].[report_codelist] CHECK CONSTRAINT [FK_report_codelist_codelist]
GO
ALTER TABLE [dbo].[report_codelist]  WITH CHECK ADD  CONSTRAINT [FK_report_codelist_report] FOREIGN KEY([report_id])
REFERENCES [dbo].[report] ([report_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[report_codelist] CHECK CONSTRAINT [FK_report_codelist_report]
GO
ALTER TABLE [dbo].[report_indicator]  WITH CHECK ADD  CONSTRAINT [FK_report_indicator_indicator] FOREIGN KEY([indicator_id])
REFERENCES [dbo].[indicator] ([indicator_id])
GO
ALTER TABLE [dbo].[report_indicator] CHECK CONSTRAINT [FK_report_indicator_indicator]
GO
ALTER TABLE [dbo].[report_indicator]  WITH CHECK ADD  CONSTRAINT [FK_report_indicator_report] FOREIGN KEY([report_id])
REFERENCES [dbo].[report] ([report_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[report_indicator] CHECK CONSTRAINT [FK_report_indicator_report]
GO
ALTER TABLE [dbo].[report_organization]  WITH CHECK ADD  CONSTRAINT [FK_report_organization_organization] FOREIGN KEY([organization_id])
REFERENCES [dbo].[organization] ([organization_id])
GO
ALTER TABLE [dbo].[report_organization] CHECK CONSTRAINT [FK_report_organization_organization]
GO
ALTER TABLE [dbo].[report_organization]  WITH CHECK ADD  CONSTRAINT [FK_report_organization_report] FOREIGN KEY([report_id])
REFERENCES [dbo].[report] ([report_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[report_organization] CHECK CONSTRAINT [FK_report_organization_report]
GO
ALTER TABLE [dbo].[report_site]  WITH CHECK ADD  CONSTRAINT [FK_report_site_report] FOREIGN KEY([report_id])
REFERENCES [dbo].[report] ([report_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[report_site] CHECK CONSTRAINT [FK_report_site_report]
GO
ALTER TABLE [dbo].[report_site]  WITH CHECK ADD  CONSTRAINT [FK_report_site_site] FOREIGN KEY([site_id])
REFERENCES [dbo].[site] ([site_id])
GO
ALTER TABLE [dbo].[report_site] CHECK CONSTRAINT [FK_report_site_site]
GO
ALTER TABLE [dbo].[site]  WITH CHECK ADD  CONSTRAINT [FK_site_district] FOREIGN KEY([district_id])
REFERENCES [dbo].[district] ([district_id])
GO
ALTER TABLE [dbo].[site] CHECK CONSTRAINT [FK_site_district]
GO
ALTER TABLE [dbo].[indicator]  WITH CHECK ADD CHECK  (([type]='Custom' OR [type]='FtF'))
GO
ALTER TABLE [dbo].[site]  WITH CHECK ADD CHECK  (([type]='Action Site (Planned)' OR [type]='Control Site' OR [type]='Action Site'))
GO
ALTER TABLE [dbo].[value]  WITH CHECK ADD CHECK  (([type]='value list' OR [type]='boolean' OR [type]='decimal' OR [type]='text' OR [type]='integer'))
GO



