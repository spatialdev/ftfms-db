
/************************************************************************

    Run ETL for all data

    1. run show data_directory to identify data directory for postgres and put ftfms folder
    of data to ETL inside the directory
    2. Add the lowercase name, capitalized name and file path to the list below to a country to the ETL

  -- Script will reate a table of countries to ETL

*************************************************************************/

DROP TABLE IF EXISTS countries_to_ETL_temp;

-- create temporary table of all country names
create table countries_to_ETL_temp (
    title character varying NOT NULL,
    capital_title character varying NOT NULL,
    file_path character varying NOT NULL
);


---- populate temporary countries to ETL table
INSERT INTO countries_to_ETL_temp VALUES ('ethiopia', 'Ethiopia', 'ftfms/ethiopia.csv');
INSERT INTO countries_to_ETL_temp VALUES ('nepal', 'Nepal', 'ftfms/nepal.csv');
INSERT INTO countries_to_ETL_temp VALUES ('haiti', 'Haiti', 'ftfms/haiti.csv');
INSERT INTO countries_to_ETL_temp VALUES ('tajikistan', 'Tajikistan', 'ftfms/tajikistan.csv');
INSERT INTO countries_to_ETL_temp VALUES ('cambodia', 'Cambodia', 'ftfms/cambodia.csv');
INSERT INTO countries_to_ETL_temp VALUES ('bangladesh', 'Bangladesh', 'ftfms/bangladesh.csv');
INSERT INTO countries_to_ETL_temp VALUES ('kenya', 'Kenya', 'ftfms/kenya.csv');
INSERT INTO countries_to_ETL_temp VALUES ('guatemala', 'Guatemala', 'ftfms/guatemala.csv');
INSERT INTO countries_to_ETL_temp VALUES ('honduras', 'Honduras', 'ftfms/honduras.csv');
INSERT INTO countries_to_ETL_temp VALUES ('liberia', 'Liberia', 'ftfms/liberia.csv');
--INSERT INTO countries_to_ETL_temp VALUES ('zambia', 'Zambia', 'ftfms/zambia.csv'); --todo leave out includes data from other countries
INSERT INTO countries_to_ETL_temp VALUES ('uganda', 'Uganda', 'ftfms/uganda.csv');
INSERT INTO countries_to_ETL_temp VALUES ('tanzania', 'Tanzania', 'ftfms/tanzania.csv');
INSERT INTO countries_to_ETL_temp VALUES ('senegal', 'Senegal', 'ftfms/senegal.csv');
INSERT INTO countries_to_ETL_temp VALUES ('mozambique', 'Mozambique', 'ftfms/mozambique.csv');
INSERT INTO countries_to_ETL_temp VALUES ('malawi', 'Malawi', 'ftfms/malawi.csv');
INSERT INTO countries_to_ETL_temp VALUES ('mali', 'Mali', 'ftfms/mali.csv');
INSERT INTO countries_to_ETL_temp VALUES ('ghana', 'Ghana', 'ftfms/ghana.csv');


/************************************************************************

   The script will loop through each of the countries in the
   ETL table to insert each countrys data into the FTFMS database

*************************************************************************/

CREATE OR REPLACE FUNCTION FTFMS_ETL() RETURNS boolean AS $$
DECLARE
    country RECORD;
    country_title character varying;
    country_capital_title character varying;
    file_path character varying;

BEGIN

    FOR country IN SELECT * FROM countries_to_ETL_temp LOOP

	country_title = country.title;
	country_capital_title = country.capital_title;
	file_path = country.file_path;


    DROP TABLE IF EXISTS country_raw;
    DROP TABLE IF EXISTS country_updated;
    DROP TABLE IF EXISTS country_geography;

    CREATE TABLE country_raw
    (
      implementing_mechanism text,
      indicator text,
      im_number text,
      baseline_year integer,
      baseline_value double precision,
      target_2008 double precision,
      actual_2008 double precision,
      target_2009 double precision,
      actual_2009 double precision,
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

    -- copy data fro country_raw into new table, country_updated
    execute format('COPY country_raw (implementing_mechanism, indicator, im_number, baseline_year, baseline_value, target_2008, actual_2008,target_2009, actual_2009, target_2010, actual_2010, target_2011, actual_2011, target_2012, actual_2012,target_2013,actual_2013, target_2014, actual_2014,  target_2015,  actual_2015, target_2016, target_2017,target_2018,prime_partner,locations, admin0, admin1, admin2, measure) FROM ''%s'' WITH DELIMITER '','' CSV HEADER ', file_path);


    -- create country_updated
    -- admin level 0 data is populated
    -- copy into new table
    --EXECUTE 'INSERT INTO country_updated (SELECT * FROM country_raw)';
    create table country_updated as (select * FROM country_raw);


    -- update country_updated
    UPDATE country_updated
    SET locations = country_capital_title
    WHERE locations is null;


    -- update country_updated for null measures
    UPDATE country_updated
    SET measure = 'null'
    WHERE measure is null;


    -- create table country_geography
    -- table of unique geographies
    CREATE TABLE country_geography AS
    (SELECT *
     FROM (
        Select distinct(a[3]) as admin2, a[1] as admin0, a[2] as admin1
        from (
            select regexp_split_to_array(locations, '->') -- split into multiple columns
            from (
                SELECT
                admin0, admin1, admin2,
                regexp_split_to_table(country_updated.locations, E'; ') AS locations -- split into multiple rows
                FROM country_updated
            ) as parsed_geographies
        ) as dt(a)
    group by 1,2,3
    order by 3) as geographies
    );


    -- populate country table
    INSERT INTO country (title)
        select distinct(admin0)
        FROM country_geography;


    -- populate district table
    INSERT INTO district (title, country_id)
        SELECT distinct(admin1), country_id
        FROM country_geography
        JOIN country c ON ( c.title = country_geography.admin0)
        WHERE admin1 IS NOT NULL
        GROUP BY country_id, admin1;


    -- populate the site table
    INSERT INTO site (district_id, title)
    SELECT distinct(district_id), admin2
        FROM country_geography, district, country
        where district_id = (select district_id from district where title = country_geography.admin1
        AND country_id = (select country_id from country where title = country_geography.admin0))
        AND admin2 IS NOT NULL
        AND admin1 IS NOT NULL
        AND admin0 IS NOT NULL;


    -- geography table is no longer needed
    DROP TABLE country_geography;


    -- populate organization table
    INSERT INTO organization (title)
        SELECT distinct(prime_partner)
        FROM country_updated
        WHERE prime_partner is not null
        EXCEPT
            SELECT distinct(title)
            FROM organization;



    -- populate indicator table
    INSERT INTO indicator (code, title)
        SELECT distinct(a[1]) as code, a[2] as title
        FROM (
            select regexp_split_to_array(indicator, ':') -- split into multiple columns
            from country_updated
        ) as dt(a)
        GROUP BY 1,2
        EXCEPT
            SELECT code, title
            FROM indicator;



    -- populate report table
    INSERT INTO report (title,interval_id)
    (SELECT DISTINCT implementing_mechanism, 1 FROM country_updated);



    -- populate edition table
    INSERT INTO edition (report_id, interval_range_id, year)
        SELECT report_id, 1 as interval_range_id,
        regexp_split_to_table('2008; 2009; 2010; 2011; 2012; 2013; 2014; 2015; 2016; 2017; 2018', E'; ')::int AS year
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
            from country_updated
        ) as dt(a)
        JOIN indicator ON (indicator.title = a[2])
        JOIN report ON (report.title = implementing_mechanism)
        GROUP BY 1,2
        EXCEPT
            SELECT indicator_id, report_id
            FROM report_indicator;


    -- populate report organization table
    INSERT INTO report_organization (organization_id, report_id)
        SELECT  organization.organization_id, report.report_id
        from country_updated

        JOIN organization ON (organization.title = country_updated.prime_partner)
        JOIN report ON (report.title = implementing_mechanism)
        GROUP BY 1,2
        EXCEPT
                SELECT organization_id, report_id
                FROM report_organization;


    -- NOT USING THIS TABLE BECAUSE IT CONFLICTS WITH REPORT_LOCATION
    --    -- populate report site table
    --    INSERT INTO report_site (report_id, site_id)
    --    SELECT distinct(report_id), site_id
    --    FROM (
    --        Select distinct(a[3]) as admin2, a[1] as admin0, a[2] as admin1, implementing_mechanism
    --        from (
    --            select regexp_split_to_array(locations, '->'), -- split into multiple columns
    --            implementing_mechanism
    --            from (
    --            SELECT implementing_mechanism,
    --            regexp_split_to_table(country_updated.locations, E'; ') AS locations -- split into multiple rows
    --            FROM country_updated
    --            ) as parse_country_updated
    --        ) as dt(a)
    --    GROUP BY 1,2,3,4
    --    ORDER BY 3 ) geo
    --    JOIN report ON (report.title = implementing_mechanism)
    --    JOIN site ON (site.title = admin2)
    --    GROUP BY 1,2;


    -- populate report location table
    INSERT INTO report_location (report_id, country_id, district_id, site_id)
    SELECT  distinct(report_id), c.country_id, district.district_id, site_id
        FROM (
            Select distinct(a[3]) as admin2, a[1] as admin0, a[2] as admin1, implementing_mechanism
            from (
                select regexp_split_to_array(locations, '->'), -- split into multiple columns
                implementing_mechanism
                from (
                SELECT implementing_mechanism,
                regexp_split_to_table(country_updated.locations, E'; ') AS locations -- split into multiple rows
                FROM country_updated
                ) as parse_country_updated
            ) as dt(a)
         ) geo
        JOIN report ON (report.title = implementing_mechanism)
        JOIN country c ON (c.title = admin0)
        LEFT JOIN district ON (district.title = admin1)
        LEFT JOIN site ON (site.title = admin2 AND site.district_id = district.district_id)
        GROUP by 1,2,3,4
        EXCEPT(
            SELECT report_id, country_id, district_id, site_id FROM report_location);



    -- populate measure table
    -- create a temporary table of all measures and indicators without measures
    CREATE TABLE measure_temp AS
    ( SELECT distinct(measure), indicator.indicator_id
      FROM (
            select regexp_split_to_array(indicator, ':'), -- split into multiple columns
         measure
            from country_updated
        ) as dt(a)
        JOIN indicator ON (indicator.title = a[2])
        GROUP BY 1,2
        );

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


    /************************************************************************

      Script will load data into "data" table

    *************************************************************************/

    -- data is target_2008
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2008 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2008, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2008, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2008)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for actual 2008
    -- data is actual_2008
    -- edition year is 2008
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2008 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, actual_2008, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, actual_2008, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2008)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Actual'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for target 2009
    -- edition year is 2009
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2009 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2009, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2009, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2009)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for actual 2009
    -- edition year is 2009
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2009 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, actual_2009, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, actual_2009, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2009)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Actual'
    GROUP BY 1,2,3,4,5,6;


    -- data is target_2010
    -- edition year is 2010
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2010 as data, m.measure_id
    FROM value v, (
        select measure,implementing_mechanism, target_2010, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure,implementing_mechanism, target_2010, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2010)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;

    -- load in data for actual 2010
    -- edition year is 2010
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2010 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, actual_2010, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, actual_2010, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2010)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Actual'
    GROUP BY 1,2,3,4,5,6;

    -- load in data for target 2011
    -- edition year is 2011
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2011 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2011, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2011, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2011)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for actual 2011
    -- edition year is 2011
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2011 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, actual_2011, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, actual_2011, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2011)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Actual'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for target 2012
    -- edition year is 2012
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2012 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2012, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2012, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2012)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for actual 2012
    -- edition year is 2012
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2012 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, actual_2012, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, actual_2012, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2012)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Actual'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for target 2013
    -- edition year is 2013
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2013 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2013, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2013, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2013)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for actual 2013
    -- edition year is 2013
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2013 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, actual_2013, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, actual_2013, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2013)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Actual'
    GROUP BY 1,2,3,4,5,6;

    -- load in data for target 2014
    -- edition year is 2014
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2014 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2014, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2014, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2014)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;

    -- load in data for actual 2014
    -- edition year is 2014
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2014 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, actual_2014, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, actual_2014, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2014)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Actual'
    GROUP BY 1,2,3,4,5,6;

    -- load in data for target 2015
    -- edition year is 2015
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2015 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2015, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2015, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2015)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for actual 2015
    -- edition year is 2015
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, actual_2015 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, actual_2015, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, actual_2015, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2015)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Actual'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for target 2016
    -- edition year is 2016
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2016 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2016, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2016, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2016)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;


    -- load in data for target 2017
    -- edition year is 2017
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2017 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2017, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2017, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2017)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;

    -- load in data for target 2018
    -- edition year is 2018
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, target_2018 as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, target_2018, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, target_2018, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    JOIN edition e ON (e.report_id = r.report_id AND e.year = 2018)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Target'
    GROUP BY 1,2,3,4,5,6;

    -- load in data for baseline
    -- data is baseline_value
    INSERT INTO data (report_id, edition_id, indicator_id, value_id, data, measure_id)
    SELECT distinct(r.report_id), e.edition_id, i.indicator_id, v.value_id, baseline_year as data, m.measure_id
    FROM value v, (
        select measure, implementing_mechanism, baseline_year, baseline_value, regexp_split_to_array(indicator, ':')
        from country_updated
    ) AS dt(measure, implementing_mechanism, baseline_year, baseline_value, indicator)
    JOIN report r ON (r.title = dt.implementing_mechanism)
    LEFT JOIN edition e ON (e.report_id = r.report_id AND e.year = dt.baseline_year)
    JOIN indicator i ON (i.title = dt.indicator[2])
    JOIN measure m ON (m.indicator_id = i.indicator_id and m.title = dt.measure)
    WHERE v.title = 'Baseline'
    GROUP BY 1,2,3,4,5,6;


    END LOOP;

    RAISE NOTICE 'Done inserting data into "data" table.';
    RETURN true;
END;
$$ LANGUAGE plpgsql;


 select * from FTFMS_ETL();