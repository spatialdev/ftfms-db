DROP SCHEMA public cascade;
CREATE SCHEMA public;

CREATE EXTENSION postgis;
DROP EXTENSION IF EXISTS postgres_fdw;
CREATE EXTENSION postgres_fdw;

DROP TABLE IF EXISTS category cascade;
DROP TABLE IF EXISTS codelist cascade;
DROP TABLE IF EXISTS country cascade;
DROP TABLE IF EXISTS district cascade;
DROP TABLE IF EXISTS indicator cascade;
DROP TABLE IF EXISTS interval cascade;
DROP TABLE IF EXISTS interval_range cascade;
DROP TABLE IF EXISTS measure cascade;
DROP TABLE IF EXISTS report cascade;
DROP TABLE IF EXISTS note cascade;
DROP TABLE IF EXISTS organization cascade;
DROP TABLE IF EXISTS edition cascade;
DROP TABLE IF EXISTS report_codelist cascade;
DROP TABLE IF EXISTS report_indicator cascade;
DROP TABLE IF EXISTS report_organization cascade;
DROP TABLE IF EXISTS site cascade;
DROP TABLE IF EXISTS report_site cascade;
DROP TABLE IF EXISTS value cascade;
DROP TABLE IF EXISTS measure_value cascade;
DROP TABLE IF EXISTS report_location cascade;
DROP TABLE IF EXISTS data cascade;


DROP TABLE IF EXISTS gaul_2014_adm0;
DROP TABLE IF EXISTS gaul_2014_adm1;
DROP TABLE IF EXISTS gaul_2014_adm2;

/*********************************************************************

	Creating M&E Tables

**********************************************************************/

create table category(
    category_id serial primary key NOT NULL,
    title character varying NOT NULL
);


create table codelist(
    codelist_id serial primary key NOT NULL,
    code_id int,
    parent_id int,
    list character varying NOT NULL,
    code character varying NOT NULL
);


create table megasite(
    megasite_id serial primary key NOT NULL,
    code character varying,
    title character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying
);


create table country(
    country_id serial primary key NOT NULL,
    megasite_id int references megasite(megasite_id) NOT NULL DEFAULT 1,
    code character varying,
    title character varying NOT NULL,
    description character varying,
    image_path character varying
);


create table district(
    district_id serial primary key NOT NULL,
    country_id int NOT NULL references country(country_id),
    title character varying NOT NULL
);


create table indicator(
    indicator_id serial primary key NOT NULL,
    title character varying NOT NULL,
    code character varying,
    type character varying,
    unit character varying
);


create table interval(
    interval_id serial primary key NOT NULL,
    title character varying NOT NULL
);


create table interval_range(
    interval_range_id serial primary key NOT NULL,
    interval_id int NOT NULL references interval(interval_id),
    title character varying NOT NULL,
    from_month int NOT NULL,
    from_day int NOT NULL,
    to_month int NOT NULL,
    to_day int NOT NULL
);


create table measure(
    measure_id serial primary key NOT NULL,
    indicator_id int NOT NULL references indicator(indicator_id),
    category_id int references category(category_id) NOT NULL DEFAULT 1,
    title character varying NOT NULL,
    code character varying
);


create table report(
    report_id serial primary key NOT NULL,
    interval_id int NOT NULL references interval(interval_id),
    title character varying NOT NULL,
    name character varying,
    email character varying,
    status character varying,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    created_by character varying,
    created_date timestamp with time zone DEFAULT current_timestamp
);


create table note(
    note_id serial primary key NOT NULL,
    report_id int NOT NULL references report(report_id),
    note character varying NOT NULL
);


create table organization(
    organization_id serial primary key NOT NULL,
    title character varying NOT NULL
);


create table edition(
    edition_id serial primary key NOT NULL,
    report_id int NOT NULL references report(report_id),
    interval_range_id int NOT NULL references interval_range(interval_range_id),
    year int NOT NULL,
    draft boolean NOT NULL DEFAULT true,
    revised_by character varying,
    revised_date timestamp with time zone
);


create table report_codelist(
    report_id int NOT NULL references report(report_id),
    codelist_id int NOT NULL references codelist(codelist_id),

    PRIMARY KEY(report_id, codelist_id)
);


create table report_indicator(
    report_id int NOT NULL references report(report_id),
    indicator_id int NOT NULL references indicator(indicator_id),

    PRIMARY KEY(report_id, indicator_id)
);


create table report_organization(
    report_id int NOT NULL references report(report_id),
    organization_id int NOT NULL references organization(organization_id),
    lead boolean NOT NULL DEFAULT false,

    PRIMARY KEY(report_id, organization_id,lead)
);


create table site(
    site_id serial primary key NOT NULL,
    village_id character varying,
    title character varying NOT NULL,
    type character varying,
    image_path character varying,
--  point geometry NOT NULL,
    district_id int references district(district_id)
);


create table report_site(
    report_id int NOT NULL references report(report_id),
    site_id int NOT NULL references site(site_id),

    PRIMARY KEY(report_id, site_id)
);


create table value(
    value_id serial primary key NOT NULL,
    title character varying NOT NULL,
    type character varying NOT NULL check (type='value list' OR type='boolean' OR type='decimal' OR type='text' OR type='integer'),
    fixed boolean NOT NULL DEFAULT false
);


create table measure_value(
    measure_id int NOT NULL references measure(measure_id),
    value_id int NOT NULL references value(value_id),

    PRIMARY KEY(measure_id, value_id)
);


create table report_location(
    report_id int NOT NULL references report(report_id),
    country_id int NOT NULL references country(country_id),
    district_id int references district(district_id),
    site_id int references site(site_id)
);


create table data(
    data_id serial primary key NOT NULL,
    report_id int NOT NULL references report(report_id),
    edition_id int references edition(edition_id),
    indicator_id int NOT NULL references indicator(indicator_id),
    measure_id int references measure(measure_id) NOT NULL,
    value_id int NOT NULL references value(value_id),
    data character varying,
    exceeds_margin boolean NOT NULL DEFAULT false
);



-- add null category to the category table
INSERT INTO category (category_id, title) VALUES (1, 'null');


-- add null megasite to megasite table
INSERT INTO megasite (megasite_id, title) VALUES (1, 'null');

-- add null codelist to codelist table
INSERT INTO codelist (list, code) VALUES ('null', 'null');


-- populate interval table
-- interval at which data is reported
INSERT INTO interval (title) VALUES ('annually');

--populate value table
INSERT INTO value (title, type) VALUES ('Baseline', 'integer');
INSERT INTO value (title, type) VALUES ('Target', 'integer');
INSERT INTO value (title, type) VALUES ('Actual', 'integer');


-- populate interval_range table
INSERT INTO interval_range (interval_id, title,from_month, from_day, to_month, to_day)
VALUES (1, 'Full Year', 1, 1, 12, 31);



/*********************************************************************

	Create GAUL tables
	-- Populate GAUL tables using external dump

**********************************************************************/


CREATE TABLE gaul_2014_adm0
(
  adm0_name character varying(100),
  geom geometry(MultiPolygon,4326),
  id integer,
  bbox geometry(Geometry,4326),
  gaul_2014_adm0 integer,
  geom_point geometry(Geometry,4326)
);

CREATE TABLE gaul_2014_adm1 (
  status character varying(37),
  disp_area character varying(3),
  adm1_code integer,
  adm1_name character varying(100),
  str1_year integer,
  exp1_year integer,
  adm0_code integer,
  adm0_name character varying(100),
  shape_leng numeric,
  shape_area numeric,
  geom geometry(MultiPolygon,4326),
  id integer,
  bbox geometry(Geometry,4326),
  geom_point geometry(Geometry,4326),
  population integer
);

CREATE TABLE gaul_2014_adm2 (
  adm2_code integer,
  adm2_name character varying(100),
  status character varying(37),
  disp_area character varying(3),
  str_year integer,
  exp_year integer,
  adm0_code integer,
  adm0_name character varying(100),
  adm1_code integer,
  adm1_name character varying(100),
  shape_leng numeric,
  shape_area numeric,
  geom geometry(MultiPolygon,4326),
  id integer,
  bbox geometry(Geometry,4326),
  geom_point geometry(Geometry,4326),
  population integer
);
