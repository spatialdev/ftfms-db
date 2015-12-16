-- create ken_projects0
-- admin level 0 project data
-- copy into new table
SELECT *
INTO ken_projects_0
FROM kenprojects_raw;

-- drop unneeded columns
ALTER TABLE ken_projects_0
DROP COLUMN admin1;

ALTER TABLE ken_projects_0
DROP COLUMN admin2;

ALTER TABLE ken_projects_0
DROP COLUMN locations;

-- update table data
UPDATE ken_projects_0
SET admin0 = 'Kenya';



-- create table ken_geography
-- table of unique geographies
SELECT * INTO ken_geography
FROM (
    Select distinct(a[3]) as admin2, a[1] as admin0, a[2] as admin1
    from (
        select regexp_split_to_array(locations, '->') -- split into multiple columns
        from (
            SELECT
            admin0, admin1, admin2,
            regexp_split_to_table(kenprojects_raw.locations, E'; ') AS locations -- split into multiple rows
            FROM kenprojects_raw
        ) as parsed_geographies
    ) as dt(a)
group by 1,2,3
order by 3) as geographies;



-- populate country table
INSERT INTO country (title)
	select distinct(admin0)
	FROM ken_geography;



-- populate district table
INSERT INTO district (title, country_id)
	SELECT distinct(admin1), country_id
	FROM ken_geography
	JOIN country ON ( country.title = ken_geography.admin0)
	WHERE admin1 IS NOT NULL
	GROUP BY country_id, admin1;


-- populate site table
INSERT INTO site (district_id, title)
	SELECT distinct(district_id), admin2
	FROM ken_geography
	JOIN district ON ( district.title = ken_geography.admin1)
	WHERE admin2 IS NOT NULL
	GROUP BY district_id, admin2;


-- populate organization table
INSERT INTO organization (title)
	SELECT distinct(prime_partner)
	FROM kenprojects_raw;


-- populate indicator table
INSERT INTO indicator (code, title)
    SELECT distinct(a[1]) as code, a[2] as title
    from (
        select regexp_split_to_array(indicator, ':') -- split into multiple columns
        from kenprojects_raw
    ) as dt(a)
    GROUP BY 1,2
    ORDER BY 1 asc;


-- populate interval table
-- interval at which data is reported
INSERT INTO interval (title) VALUES ('annually');


-- populate interval_range table
INSERT INTO interval_range (interval_id, title,from_month, from_day, to_month, to_day)
VALUES (1, 'Full Year', 1, 1, 12, 31);


-- populate report table
INSERT INTO report (title,interval_id)
(SELECT DISTINCT implementing_mechanism, 1 FROM kenprojects_raw);


-- populate value table
INSERT INTO value (title, type) VALUES ('Baseline', 'integer');
INSERT INTO value (title, type) VALUES ('Target', 'integer');
INSERT INTO value (title, type) VALUES ('Actual', 'integer');


-- populate edition table
INSERT INTO edition (report_id, interval_range_id, year)
	select report_id, 1 as interval_range_id,
	regexp_split_to_table('2010', '2013', '2014; 2015; 2016; 2017; 2018', E'; ')::int AS year
	from report;


-- populate report indicator table
INSERT INTO report_indicator (indicator_id, report_id)
    SELECT distinct(indicator.indicator_id), report.report_id
    FROM (
        select regexp_split_to_array(indicator, ':'), -- split into multiple columns
	implementing_mechanism
        from kenprojects_raw
    ) as dt(a)
    JOIN indicator ON (indicator.title = a[2])
    JOIN report ON (report.title = implementing_mechanism)
    GROUP BY 1,2
    ORDER BY 1 asc;


-- populate report organization table
INSERT INTO report_organization (organization_id, report_id)
    SELECT  organization.organization_id, report.report_id
    from kenprojects_raw

    JOIN organization ON (organization.title = kenprojects_raw.prime_partner)
    JOIN report ON (report.title = implementing_mechanism)
    GROUP BY 1,2
    ORDER BY 1 asc;


-- populate report site table
INSERT INTO report_site (report_id, site_id)
SELECT distinct(report_id), site_id
FROM (
	Select distinct(a[3]) as admin2, a[1] as admin0, a[2] as admin1, implementing_mechanism
	from (
	    select regexp_split_to_array(locations, '->'), -- split into multiple columns
		implementing_mechanism
	    from (
		SELECT implementing_mechanism,
		regexp_split_to_table(kenprojects_raw.locations, E'; ') AS locations -- split into multiple rows
		FROM kenprojects_raw
	    ) as parse_kenprojects_raw
	) as dt(a)
GROUP BY 1,2,3,4
ORDER BY 3 ) geo
JOIN report ON (report.title = implementing_mechanism)
JOIN site ON (site.title = admin2)
GROUP BY 1,2;



-- populate report location table
INSERT INTO report_location (report_id, country_id, district_id, site_id)
SELECT  distinct(report_id), country.country_id, district.district_id, site_id
	FROM (
		Select distinct(a[3]) as admin2, a[1] as admin0, a[2] as admin1, implementing_mechanism
		from (
		    select regexp_split_to_array(locations, '->'), -- split into multiple columns
			implementing_mechanism
		    from (
			SELECT implementing_mechanism,
			regexp_split_to_table(kenprojects_raw.locations, E'; ') AS locations -- split into multiple rows
			FROM kenprojects_raw
		    ) as parse_kenprojects_raw
		) as dt(a)
	 ) geo
	JOIN report ON (report.title = implementing_mechanism)
	JOIN country ON (country.title = admin0)
	LEFT JOIN district ON (district.title = admin1)
	LEFT JOIN site ON (site.title = admin2 AND site.district_id = district.district_id)
	GROUP by 1,2,3,4;



-- load data into data table

-- load in data for target 2014
-- value_id = 4 for target
-- data is target_2014
-- edition year is 2014
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data)
SELECT r.report_id, e.edition_id, i.indicator_id, 4 as value_id, target_2014 as data
FROM (
	select implementing_mechanism, target_2014, regexp_split_to_array(indicator, ':')
	from kenprojects_raw
) AS dt(implementing_mechanism, target_2014, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2014)
JOIN indicator i ON (i.title = dt.indicator[2]);



-- load in data for actual 2014
-- value_id = 3 for actual
-- data is actual_2014
-- edition year is 2014
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data)
SELECT r.report_id, e.edition_id, i.indicator_id, 3 as value_id, actual_2014 as data
FROM (
	select implementing_mechanism, actual_2014, regexp_split_to_array(indicator, ':')
	from kenprojects_raw
) AS dt(implementing_mechanism, actual_2014, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2014)
JOIN indicator i ON (i.title = dt.indicator[2]);



-- load in data for target 2015
-- value_id = 4 for target
-- data is target_2015
-- edition year is 2015
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data)
SELECT r.report_id, e.edition_id, i.indicator_id, 4 as value_id, target_2015 as data
FROM (
	select implementing_mechanism, target_2015, regexp_split_to_array(indicator, ':')
	from kenprojects_raw
) AS dt(implementing_mechanism, target_2015, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2015)
JOIN indicator i ON (i.title = dt.indicator[2]);



-- load in data for actual 2015
-- value_id = 3 for actual
-- data is actual_2015
-- edition year is 2015
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data)
SELECT r.report_id, e.edition_id, i.indicator_id, 3 as value_id, actual_2015 as data
FROM (
	select implementing_mechanism, actual_2015, regexp_split_to_array(indicator, ':')
	from kenprojects_raw
) AS dt(implementing_mechanism, actual_2015, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2015)
JOIN indicator i ON (i.title = dt.indicator[2]);



-- load in data for target 2016
-- value_id = 4 for target
-- data is target_2016
-- edition year is 2016
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data)
SELECT r.report_id, e.edition_id, i.indicator_id, 4 as value_id, target_2016 as data
FROM (
	select implementing_mechanism, target_2016, regexp_split_to_array(indicator, ':')
	from kenprojects_raw
) AS dt(implementing_mechanism, target_2016, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2016)
JOIN indicator i ON (i.title = dt.indicator[2]);



-- load in data for target 2017
-- value_id = 4 for target
-- data is target_2017
-- edition year is 2017
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data)
SELECT r.report_id, e.edition_id, i.indicator_id, 4 as value_id, target_2017 as data
FROM (
	select implementing_mechanism, target_2017, regexp_split_to_array(indicator, ':')
	from kenprojects_raw
) AS dt(implementing_mechanism, target_2017, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2017)
JOIN indicator i ON (i.title = dt.indicator[2]);


-- load in data for target 2018
-- value_id = 4 for target
-- data is target_2018
-- edition year is 2018
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data)
SELECT r.report_id, e.edition_id, i.indicator_id, 4 as value_id, target_2018 as data
FROM (
	select implementing_mechanism, target_2018, regexp_split_to_array(indicator, ':')
	from kenprojects_raw
) AS dt(implementing_mechanism, target_2018, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2018)
JOIN indicator i ON (i.title = dt.indicator[2]);


-- load in data for baseline
-- value_id = 2 for baseline
-- data is baseline_value
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data)
SELECT r.report_id, e.edition_id, i.indicator_id, 2 as value_id, baseline_value as data
FROM (
	select implementing_mechanism, baseline_year, baseline_value, regexp_split_to_array(indicator, ':')
	from kenprojects_raw
) AS dt(implementing_mechanism, baseline_year, baseline_value, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
LEFT JOIN edition e ON (e.report_id = r.report_id AND e.year = dt.baseline_year)
JOIN indicator i ON (i.title = dt.indicator[2]);