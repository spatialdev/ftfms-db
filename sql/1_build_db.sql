--drop schema public cascade;
--create schema public;

--CREATE EXTENSION postgis;


create table category(
    category_id serial primary key not null,
    title character varying not null
);


create table codelist(
    codelist_id serial primary key not null,
    code_id int,
    parent_id int,
    list character varying not null,
    code character varying not null
);


--
--create table megasite(
--    megasite_id serial primary key not null,
--    code character varying,
--    title character varying not null,
--    first_name character varying,
--    last_name character varying,
--    email character varying
--);



create table country(
    country_id serial primary key not null,
--    megasite_id int references megasite(megasite_id) not null,
    code character varying,
    title character varying not null,
    description character varying,
    image_path character varying
);



create table district(
    district_id serial primary key not null,
    country_id int not null references country(country_id),
    title character varying not null
);



create table indicator(
    indicator_id serial primary key not null,
    title character varying not null,
    code character varying,
--    type character varying not null,
    unit character varying
);


create table interval(
    interval_id serial primary key not null,
    title character varying not null
);


create table interval_range(
    interval_range_id serial primary key not null,
    interval_id int not null references interval(interval_id),
    title character varying not null,
    from_month int not null,
    from_day int not null,
    to_month int not null,
    to_day int not null
);



create table measure(
    measure_id serial primary key not null,
    indicator_id int not null references indicator(indicator_id),
    category_id int references category(category_id),
    title character varying not null,
    code character varying
);



create table report(
    report_id serial primary key not null,
    interval_id int not null references interval(interval_id),
    title character varying not null,
    name character varying,
    email character varying,
    status character varying,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    created_by character varying,
    created_date timestamp with time zone default current_timestamp
);

create table note(
    note_id serial primary key not null,
    report_id int not null references report(report_id),
    note character varying not null
);


create table organization(
    organization_id serial primary key not null,
    title character varying not null
);



create table edition(
    edition_id serial primary key not null,
    report_id int not null references report(report_id),
    interval_range_id int not null references interval_range(interval_range_id),
    year int not null,
    draft bit not null default cast(1 as bit(1)),
    revised_by character varying,
    revised_date timestamp with time zone
);


create table report_codelist(
    report_id int not null references report(report_id),
    codelist_id int not null references codelist(codelist_id),

    PRIMARY KEY(report_id, codelist_id)
);



create table report_indicator(
    report_id int not null references report(report_id),
    indicator_id int not null references indicator(indicator_id),

    PRIMARY KEY(report_id, indicator_id)
);


create table report_organization(
    report_id int not null references report(report_id),
    organization_id int not null references organization(organization_id),
    lead bit not null default cast(0 as bit(1)),

    PRIMARY KEY(report_id, organization_id,lead)
);

create table site(
    site_id serial primary key not null,
    village_id character varying,
    title character varying not null,
--    type character varying not null check (type='Action Site (Planned)' OR type='Control Site' OR type='Action Site'),
    image_path character varying,
--    point geometry not null,
    district_id int references district(district_id)
);


create table report_site(
    report_id int not null references report(report_id),
    site_id int not null references site(site_id),

    PRIMARY KEY(report_id, site_id)
);


create table report_location(
    report_id int not null references report(report_id),
    country_id int not null references country(country_id),
    district_id int references district(district_id),
    site_id int references site(site_id)
);


create table value(
    value_id serial primary key not null,
    title character varying not null,
    type character varying not null check (type='value list' OR type='boolean' OR type='decimal' OR type='text' OR type='integer'),
    fixed bit not null default cast(0 as bit(1))
);


create table measure_value(
    measure_id int not null references measure(measure_id),
    value_id int not null references value(value_id),

    PRIMARY KEY(measure_id, value_id)
);


create table data(
    data_id serial primary key not null,
    report_id int not null references report(report_id),
    edition_id int references edition(edition_id),
    indicator_id int not null references indicator(indicator_id),
    measure_id int references measure(measure_id),
    value_id int not null references value(value_id),
    data character varying,
    exceeds_margin bit not null default cast(0 as bit(1))
);


-- populate interval table
-- interval at which data is reported
INSERT INTO interval (title) VALUES ('annually');


INSERT INTO value (title, type) VALUES ('Baseline', 'integer');
INSERT INTO value (title, type) VALUES ('Target', 'integer');
INSERT INTO value (title, type) VALUES ('Actual', 'integer');


-- populate interval_range table
INSERT INTO interval_range (interval_id, title,from_month, from_day, to_month, to_day)
VALUES (1, 'Full Year', 1, 1, 12, 31);



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
GROUP BY c.country_id, c.title, c.adm0_code


-- create view to get summary data by district
-- summary includes number of projects and organizations in a given district
CREATE VIEW summary_data_by_district AS
SELECT count(distinct ro.report_id) report_count, count(distinct o.organization_id) organization_count, c.country_id, d.district_id, c.title country_title, d.title district_title, c.adm0_code, d.adm1_code
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
JOIN district d ON (d.district_id = rl.district_id)
GROUP BY c.country_id, d.district_id, c.title, d.title, c.adm0_code, d.adm1_code


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
ORDER BY country_title


--drop table category cascade;
--
--drop table codelist cascade;
--
--drop table country cascade;
--
--drop table district cascade;
--
--drop table indicator cascade;
--
--drop table interval cascade;
--
--drop table interval_range cascade;
--
--drop table measure cascade;
--
--drop table report cascade;
--
--drop table note cascade;
--
--drop table organization cascade;
--
--drop table edition cascade;
--
--drop table report_codelist cascade;
--
--drop table report_indicator cascade;
--
--drop table report_organization cascade;
--
--drop table site cascade;
--
--drop table report_site cascade;
--
--drop table value cascade;
--
--drop table measure_value cascade;
--
--drop table report_location cascade;
--
--drop table data cascade;

