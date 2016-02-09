/*********************************************************************
	Loads Uganda data into ME database

	-- run show data_directory to identify where postgres stores data
    -- copy the ftfms folder into that directory

**********************************************************************/

DROP TABLE IF EXISTS uganda_raw;
DROP TABLE IF EXISTS uganda_updated;
DROP TABLE IF EXISTS uganda_geography;
-- TRUNCATE TABLE report_indicator;
-- TRUNCATE TABLE report_organization;
-- TRUNCATE TABLE report_site;

CREATE TABLE uganda_raw
(
  implementing_mechanism text,
  indicator text,
  im_number text,
  baseline_year integer,
  baseline_value double precision,
  target_2010 double precision,
  actual_2010 double precision,
  target_2011 double precision,
  actual_2011 double precision,
  target_2012 double precision,
  actual_2012 double precision,
  target_2013 double precision,
  actual_2013 double precision,
  target_2014 double precision,
  actual_2014 double precision,
  target_2015 double precision,
  actual_2015 double precision,
  target_2016 double precision,
  target_2017 double precision,
  target_2018 double precision,
  prime_partner text,
  locations text,
  admin0 text,
  admin1 text,
  admin2 text,
  measure text
);

COPY uganda_raw (implementing_mechanism, indicator, im_number, baseline_year, baseline_value,
target_2012,
target_2013,
target_2014,
target_2015,
target_2016,
target_2017,
target_2018,
actual_2012,
actual_2013,
actual_2014,
actual_2015,
prime_partner,
locations,
admin0,
admin1,
admin2,
measure) FROM './ftfms/clean_uganda_12_18.csv'
WITH DELIMITER ',' CSV HEADER;


-- create uganda_updated
-- admin level 0 data is populated
-- copy into new table
SELECT *
INTO uganda_updated
FROM uganda_raw;

-- update uganda_updated
UPDATE uganda_updated
SET locations = 'Uganda'
WHERE locations is null;

-- update uganda_updated for null measures
UPDATE uganda_updated
SET measure = 'null'
WHERE measure is null;

-- create table uganda_geography
-- table of unique geographies
SELECT * INTO uganda_geography
FROM (
    Select distinct(a[3]) as admin2, a[1] as admin0, a[2] as admin1
    from (
        select regexp_split_to_array(locations, '->') -- split into multiple columns
        from (
            SELECT
            admin0, admin1, admin2,
            regexp_split_to_table(uganda_updated.locations, E'; ') AS locations -- split into multiple rows
            FROM uganda_updated
        ) as parsed_geographies
    ) as dt(a)
group by 1,2,3
order by 3) as geographies;


-- populate country table
INSERT INTO country (title)
	select distinct(admin0)
	FROM uganda_geography;


-- populate district table
INSERT INTO district (title, country_id)
	SELECT distinct(admin1), country_id
	FROM uganda_geography
	JOIN country ON ( country.title = uganda_geography.admin0)
	WHERE admin1 IS NOT NULL
	GROUP BY country_id, admin1;


-- populate site table
INSERT INTO site (district_id, title)
	SELECT distinct(district_id), admin2
	FROM uganda_geography
	JOIN district ON ( district.title = uganda_geography.admin1)
	WHERE admin2 IS NOT NULL
	GROUP BY district_id, admin2;


-- geography table is no longer needed
DROP TABLE uganda_geography;


-- populate organization table
INSERT INTO organization (title)
	SELECT distinct(prime_partner)
	FROM uganda_updated
	WHERE prime_partner is not null
	EXCEPT
		SELECT distinct(title)
		FROM organization;



-- populate indicator table
INSERT INTO indicator (code, title)
    SELECT distinct(a[1]) as code, a[2] as title
    FROM (
        select regexp_split_to_array(indicator, ':') -- split into multiple columns
        from uganda_updated
    ) as dt(a)
    GROUP BY 1,2
    EXCEPT
	    SELECT code, title
	    FROM indicator;



-- populate report table
INSERT INTO report (title,interval_id)
(SELECT DISTINCT implementing_mechanism, 1 FROM uganda_updated);



-- populate edition table
INSERT INTO edition (report_id, interval_range_id, year)
	SELECT report_id, 1 as interval_range_id,
	regexp_split_to_table('2010; 2011; 2012; 2013; 2014; 2015; 2016; 2017; 2018', E'; ')::int AS year
	FROM report
	EXCEPT
        SELECT report_id, interval_range_id, year
        FROM edition;


-- populate report indicator table
INSERT INTO report_indicator (indicator_id, report_id)
    SELECT distinct(indicator.indicator_id), report.report_id
    FROM (
        select regexp_split_to_array(indicator, ':'), -- split into multiple columns
	implementing_mechanism
        from uganda_updated
    ) as dt(a)
    JOIN indicator ON (indicator.title = a[2])
    JOIN report ON (report.title = implementing_mechanism)
    GROUP BY 1,2
    ORDER BY 1 asc;


-- populate report organization table
INSERT INTO report_organization (organization_id, report_id)
    SELECT  organization.organization_id, report.report_id
    from uganda_updated

    JOIN organization ON (organization.title = uganda_updated.prime_partner)
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
		regexp_split_to_table(uganda_updated.locations, E'; ') AS locations -- split into multiple rows
		FROM uganda_updated
	    ) as parse_uganda_updated
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
			regexp_split_to_table(uganda_updated.locations, E'; ') AS locations -- split into multiple rows
			FROM uganda_updated
		    ) as parse_uganda_updated
		) as dt(a)
	 ) geo
	JOIN report ON (report.title = implementing_mechanism)
	JOIN country ON (country.title = admin0)
	LEFT JOIN district ON (district.title = admin1)
	LEFT JOIN site ON (site.title = admin2 AND site.district_id = district.district_id)
	GROUP by 1,2,3,4;


-- populate measure table
-- create a temporary table of all measures and indicators without measures
SELECT distinct(measure), indicator.indicator_id
INTO measure_temp
    FROM (
        select regexp_split_to_array(indicator, ':'), -- split into multiple columns
     measure
        from uganda_updated
    ) as dt(a)
    JOIN indicator ON (indicator.title = a[2])
    GROUP BY 1,2;

-- update indicators without measures to be linked to a measure with title null
UPDATE measure_temp
SET measure = 'null'
WHERE measure is null;

-- update the measures table
INSERT INTO measure (title, indicator_id)
SELECT * FROM measure_temp
EXCEPT
        SELECT title, indicator_id
        FROM measure;

-- drop temporary table
DROP table measure_temp;



-- populate measure_value table
INSERT INTO measure_value (measure_id, value_id)
    SELECT measure_id, value_id
    FROM measure, value
    EXCEPT
        SELECT *
        FROM measure_value;


-- populate report_codelist table
INSERT INTO report_codelist (report_id, codelist_id)
SELECT report_id, 1
FROM report
EXCEPT
	SELECT report_id, codelist_id
	FROM report_codelist;


-- load data into data table
select * from value;
-- load in data for target 2010
-- data is target_2010
-- edition year is 2010
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2010 as data, m.measure_id
FROM value v, (
	select measure,implementing_mechanism, target_2010, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure,implementing_mechanism, target_2010, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2010)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Target'
GROUP BY 1,2,3,4,5,6;

-- load in data for actual 2010
-- value_id = 3 for actual
-- data is actual_2010
-- edition year is 2010
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2010 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, actual_2010, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, actual_2010, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2010)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Actual'
GROUP BY 1,2,3,4,5,6;

-- load in data for target 2011
-- value_id = 4 for target
-- data is target_2011
-- edition year is 2011
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2011 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, target_2011, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, target_2011, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2011)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Target'
GROUP BY 1,2,3,4,5,6;


-- load in data for actual 2011
-- value_id = 3 for actual
-- data is actual_2011
-- edition year is 2011
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2011 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, actual_2011, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, actual_2011, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2011)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Actual'
GROUP BY 1,2,3,4,5,6;


-- load in data for target 2012
-- value_id = 4 for target
-- data is target_2012
-- edition year is 2012
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2012 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, target_2012, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, target_2012, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2012)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Target'
GROUP BY 1,2,3,4,5,6;


-- load in data for actual 2012
-- value_id = 3 for actual
-- data is actual_2012
-- edition year is 2012
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2012 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, actual_2012, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, actual_2012, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2012)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Actual'
GROUP BY 1,2,3,4,5,6;


-- load in data for target 2013
-- value_id = 4 for target
-- data is target_2013
-- edition year is 2013
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2013 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, target_2013, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, target_2013, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2013)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Target'
GROUP BY 1,2,3,4,5,6;


-- load in data for actual 2013
-- value_id = 3 for actual
-- data is actual_2013
-- edition year is 2013
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2013 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, actual_2013, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, actual_2013, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2013)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Actual'
GROUP BY 1,2,3,4,5,6;

-- load in data for target 2014
-- value_id = 4 for target
-- data is target_2014
-- edition year is 2014
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2014 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, target_2014, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, target_2014, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2014)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Target'
GROUP BY 1,2,3,4,5,6;

-- load in data for actual 2014
-- value_id = 3 for actual
-- data is actual_2014
-- edition year is 2014
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2014 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, actual_2014, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, actual_2014, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2014)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Actual'
GROUP BY 1,2,3,4,5,6;

-- load in data for target 2015
-- value_id = 4 for target
-- data is target_2015
-- edition year is 2015
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2015 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, target_2015, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, target_2015, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2015)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Target'
GROUP BY 1,2,3,4,5,6;


-- load in data for actual 2015
-- value_id = 3 for actual
-- data is actual_2015
-- edition year is 2015
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2015 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, actual_2015, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, actual_2015, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2015)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Actual'
GROUP BY 1,2,3,4,5,6;


-- load in data for target 2016
-- value_id = 4 for target
-- data is target_2016
-- edition year is 2016
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2016 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, target_2016, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, target_2016, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2016)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Target'
GROUP BY 1,2,3,4,5,6;


-- load in data for target 2017
-- value_id = 4 for target
-- data is target_2017
-- edition year is 2017
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2017 as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, target_2017, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, target_2017, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
JOIN edition e ON (e.report_id = r.report_id AND e.year = 2017)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Target'
GROUP BY 1,2,3,4,5,6;

-- load in data for baseline
-- value_id = 2 for baseline
-- data is baseline_value
INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, baseline_year as data, m.measure_id
FROM value v, (
	select measure, implementing_mechanism, baseline_year, baseline_value, regexp_split_to_array(indicator, ':')
	from uganda_updated
) AS dt(measure, implementing_mechanism, baseline_year, baseline_value, indicator)
JOIN report r ON (r.title = dt.implementing_mechanism)
LEFT JOIN edition e ON (e.report_id = r.report_id AND e.year = dt.baseline_year)
JOIN indicator i ON (i.title = dt.indicator[2])
JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
WHERE v.title = 'Baseline'
GROUP BY 1,2,3,4,5,6;
