DROP SERVER IF EXISTS fsp CASCADE;
DROP EXTENSION IF EXISTS postgres_fdw;
CREATE EXTENSION postgres_fdw;

CREATE SERVER fsp FOREIGN DATA WRAPPER postgres_fdw OPTIONS(host 'host', dbname 'fsp', port '5432');
CREATE USER MAPPING FOR postgres SERVER fsp OPTIONS (user 'user', password 'password');
CREATE FOREIGN TABLE gaul_2014_adm0
(
  adm0_name character varying(100),
  geom geometry(MultiPolygon,4326),
  bbox geometry(Geometry,4326),
  gaul_2014_adm0 integer,
  geom_point geometry(Geometry,4326)
) SERVER fsp;

CREATE FOREIGN TABLE gaul_2014_adm1
(
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
  bbox geometry(Geometry,4326),
  geom_point geometry(Geometry,4326),
  population integer
) SERVER fsp;

CREATE FOREIGN TABLE gaul_2014_adm2
(
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
  bbox geometry(Geometry,4326),
  geom_point geometry(Geometry,4326),
  population integer
) SERVER fsp;

