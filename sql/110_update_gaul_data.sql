-- adding extra columns to the country table to include geometry and gaul ids
ALTER TABLE country
ADD column geom geometry;

ALTER TABLE country
ADD column geom_point geometry;

ALTER TABLE country
ADD column adm0_code integer;

-- updating the country table with new gaul data
update country
set geom = gaul_2014_adm0.geom
from gaul_2014_adm0
where country.title = gaul_2014_adm0.adm0_name
and country.title in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

update country
set geom_point = gaul_2014_adm0.geom_point
from gaul_2014_adm0
where country.title = gaul_2014_adm0.adm0_name
and country.title in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

-- get adm0 codes from adm1 table
update country
set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Ethiopia')
from gaul_2014_adm1
where country.title = 'Ethiopia';
update country
set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Bangladesh')
from gaul_2014_adm1
where country.title = 'Bangladesh';
update country
set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Kenya')
from gaul_2014_adm1
where country.title = 'Kenya';
update country
set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Senegal')
from gaul_2014_adm1
where country.title = 'Senegal';

-- adding extra columns to the district table to include geometry and gaul ids
ALTER TABLE district
ADD column geom geometry;

ALTER TABLE district
ADD column geom_point geometry;

ALTER TABLE district
ADD column adm1_code integer;

ALTER TABLE district
ADD column adm0_code integer;

ALTER TABLE district
ADD column adm0_name character varying;

-- updating the district names to match gaul names
update district
SET title = 'SNNPR'
WHERE title = 'Southern Nations, Nationalities and Peoples';


-- updating the district table with new gaul data
update district
set geom = gaul_2014_adm1.geom, adm0_name = gaul_2014_adm1.adm0_name
from gaul_2014_adm1
where district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

update district
set geom_point = gaul_2014_adm1.geom_point
from gaul_2014_adm1
where district.title = gaul_2014_adm1.adm1_name
and adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

update district
set adm1_code = gaul_2014_adm1.adm1_code
from gaul_2014_adm1
where district.title = gaul_2014_adm1.adm1_name
and adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

update district
set adm0_code = gaul_2014_adm1.adm0_code
from gaul_2014_adm1
where district.title = gaul_2014_adm1.adm1_name
and adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');



-- adding extra columns to the site table to include geometry and gaul ids
ALTER TABLE site
ADD column geom geometry;

ALTER TABLE site
ADD column geom_point geometry;

ALTER TABLE site
ADD column adm0_code integer;

ALTER TABLE site
ADD column adm0_name character varying;

ALTER TABLE site
ADD column adm1_code integer;

ALTER TABLE site
ADD column adm1_name character varying;

ALTER TABLE site
ADD column adm2_code integer;

-- updating the site names to match gaul names
update site
SET title = 'Central'
WHERE title = 'Central Tigray';

update site
SET title = 'Southern'
WHERE title = 'Southern Tigray';


-- updating the site table with new gaul data
update site
set geom = gaul_2014_adm2.geom, adm0_name = gaul_2014_adm2.adm0_name, adm1_name = gaul_2014_adm2.adm1_name
from gaul_2014_adm2
where site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

update site
set geom_point = gaul_2014_adm2.geom_point
from gaul_2014_adm2
where site.title = gaul_2014_adm2.adm2_name
and adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

update site
set adm0_code = gaul_2014_adm2.adm0_code
from gaul_2014_adm2
where site.title = gaul_2014_adm2.adm2_name
and adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

update site
set adm1_code = gaul_2014_adm2.adm1_code
from gaul_2014_adm2
where site.title = gaul_2014_adm2.adm2_name
and adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');

update site
set adm2_code = gaul_2014_adm2.adm2_code
from gaul_2014_adm2
where site.title = gaul_2014_adm2.adm2_name
and adm0_name in ('Ethiopia', 'Bangladesh', 'Kenya', 'Senegal');



-- create view with all district and country data
CREATE VIEW country_district AS
SELECT district.district_id, district.title as district_title, country.country_id, country.code, country.title, country.description, country.image_path
FROM district
JOIN country ON (district.country_id = country.country_id);


-- create view with all site, district and country data
CREATE VIEW country_district_site AS
SELECT site.site_id, site.village_id, site.title as site_title, site.image_path as site_image_path, district.district_id, district.title as district_title, country.country_id, country.code, country.title, country.description, country.image_path
FROM site
JOIN district ON (district.district_id = site.district_id)
JOIN country ON (district.country_id = country.country_id);


-- create view report details which includes details for report endpoint
CREATE VIEW report_details AS
SELECT report.report_id, report.title report_title, i.indicator_id, i.title indicator_title, i.code, rl.country_id, array_agg( distinct rl.district_id) district_id, array_agg(distinct rl.site_id) site_id, o.organization_id
FROM report
JOIN report_indicator ri ON (report.report_id = ri.report_id)
JOIN indicator i ON (ri.indicator_id = i.indicator_id)
JOIN report_location rl ON ( rl.report_id = report.report_id)
JOIN report_organization ro ON ( ro.report_id = report.report_id)
JOIN organization o ON (o.organization_id = ro.organization_id)
GROUP BY 1,2,3,4,5,6,9
ORDER by i.indicator_id;


-- create view organization details which includes details for organization/prime partner endpoint
CREATE VIEW organization_details AS
SELECT organization.organization_id, organization.title, array_agg(distinct ro.report_id) report_id, rl.country_id, array_agg( distinct rl.district_id) district_id, array_agg(distinct rl.site_id) site_id
FROM organization
JOIN report_organization ro ON ( ro.organization_id = organization.organization_id)
JOIN report_location rl ON ( rl.report_id = ro.report_id)
GROUP BY 1,2,4;


-- create view to get summary data by country
-- summary includes number of projects and organizations in a given country
CREATE VIEW summary_data_by_country AS
SELECT count(distinct ro.report_id) report_count, count(distinct o.organization_id) organization_count, c.country_id,  c.title country_title, c.adm0_code
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
GROUP BY c.country_id, c.title, c.adm0_code;


-- create view to get summary data by district
-- summary includes number of projects and organizations in a given district
CREATE VIEW summary_data_by_district AS
SELECT count(distinct ro.report_id) report_count, count(distinct o.organization_id) organization_count, c.country_id, d.district_id, c.title country_title, d.title district_title, c.adm0_code, d.adm1_code
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
JOIN district d ON (d.district_id = rl.district_id)
GROUP BY c.country_id, d.district_id, c.title, d.title, c.adm0_code, d.adm1_code;


-- create view to get summary data by site
-- summary includes number of projects and organizations in a given site
CREATE VIEW summary_data_by_site AS
SELECT count(distinct ro.report_id) report_count, count(distinct o.organization_id) organization_count, c.country_id, d.district_id, s.site_id, c.title country_title, d.title district_title, s.title site_title
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
JOIN district d ON (d.district_id = rl.district_id)
JOIN site s ON (s.site_id = rl.site_id)
GROUP BY c.country_id, d.district_id, s.site_id, c.title, d.title, s.title;


-- create view to get summary data by organization
-- summary includes number of projects, and locations
CREATE VIEW summary_data_by_organization AS
SELECT o.organization_id, o.title, count(distinct ro.report_id) report_count, count(distinct rl.country_id) country_count, count(distinct d.district_id) district_count, count(distinct s.site_id) site_count, array_agg(distinct c.title) country_title, array_agg(distinct d.title) district_title, array_agg(distinct s.title) site_title
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
LEFT JOIN district d ON (d.district_id = rl.district_id)
LEFT JOIN site s ON (s.site_id = rl.site_id)
GROUP BY o.organization_id
ORDER BY country_title;

DROP SERVER fsp CASCADE;