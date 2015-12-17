-- drop schema public cascade;
-- create schema public;

-- CREATE EXTENSION postgis;


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
    category_id int not null references category(category_id),
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
    measure_id int primary key not null references measure(measure_id),
    value_id int not null references value(value_id)
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


/**
drop table category cascade;

drop table codelist cascade;

drop table country cascade;

drop table district cascade;

drop table indicator cascade;

drop table interval cascade;

drop table interval_range cascade;

drop table measure cascade;

drop table report cascade;

drop table note cascade;

drop table organization cascade;

drop table edition cascade;

drop table report_codelist cascade;

drop table report_indicator cascade;

drop table report_organization cascade;

drop table site cascade;

drop table report_site cascade;

drop table value cascade;

drop table measure_value cascade;

drop table report_location cascade;

drop table data cascade;

**/
