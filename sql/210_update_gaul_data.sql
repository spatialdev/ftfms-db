-- adding extra columns to the country table to include geometry and gaul ids
ALTER TABLE country
ADD column geom geometry;

ALTER TABLE country
ADD column geom_point geometry;

ALTER TABLE country
ADD column adm0_code integer;

-- update country table so ftfms matches gaul
update country
set title = 'United Republic of Tanzania'
where country.title = 'Tanzania';

-- updating the country table with new gaul data
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ethiopia';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Bangladesh';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Kenya';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Senegal';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ghana';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Liberia';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Zambia';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Malawi';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Nepal';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Mali';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Mozambique';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Rwanda';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Uganda';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Zimbabwe';
update country set geom = gaul_2014_adm0.geom from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'United Republic of Tanzania';


update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ethiopia';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Bangladesh';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Kenya';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Senegal';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ghana';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Liberia';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Zambia';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Malawi';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Nepal';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Mali';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Mozambique';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Rwanda';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Uganda';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Zimbabwe';
update country set geom_point = gaul_2014_adm0.geom_point from gaul_2014_adm0 where country.title = gaul_2014_adm0.adm0_name
and country.title = 'United Republic of Tanzania';



-- get adm0 codes from adm1 table
update country
set adm0_code = countries.adm0_code
from(
	select distinct(adm0_code), adm0_name
	from gaul_2014_adm1
	group by 1,2) countries
where country.title = countries.adm0_name;


--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Ethiopia')
--from gaul_2014_adm1
--where country.title = 'Ethiopia';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Bangladesh')
--from gaul_2014_adm1
--where country.title = 'Bangladesh';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Kenya')
--from gaul_2014_adm1
--where country.title = 'Kenya';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Senegal')
--from gaul_2014_adm1
--where country.title = 'Senegal';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Ghana')
--from gaul_2014_adm1
--where country.title = 'Ghana';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'United Republic of Tanzania')
--from gaul_2014_adm1
--where country.title = 'United Republic of Tanzania';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Liberia')
--from gaul_2014_adm1
--where country.title = 'Liberia';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Zambia')
--from gaul_2014_adm1
--where country.title = 'Zambia';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Malawi')
--from gaul_2014_adm1
--where country.title = 'Malawi';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Nepal')
--from gaul_2014_adm1
--where country.title = 'Nepal';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Mali')
--from gaul_2014_adm1
--where country.title = 'Mali';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Mozambique')
--from gaul_2014_adm1
--where country.title = 'Mozambique';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Rwanda')
--from gaul_2014_adm1
--where country.title = 'Rwanda';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Uganda')
--from gaul_2014_adm1
--where country.title = 'Uganda';
--update country
--set adm0_code = (Select distinct adm0_code FROM gaul_2014_adm1 where adm0_name = 'Zimbabwe')
--from gaul_2014_adm1
--where country.title = 'Zimbabwe';


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
WHERE title = 'Southern Nations, Nationalities and Peoples'
AND country_id = (select country_id from country where title = 'Ethiopia');

update district
SET title = 'North Eastern'
WHERE title = 'North-Eastern'
AND country_id = (select country_id from country where title = 'Kenya');

update district
SET title = 'Segou'
WHERE title = 'Ségou'
AND country_id = (select country_id from country where title = 'Mali');

update district
SET title = 'West/Iburengerazuba'
WHERE title = 'Western Province'
AND country_id = (select country_id from country where title = 'Rwanda');

update district
SET title = 'East/Iburasirazuba'
WHERE title = 'Eastern Province'
AND country_id = (select country_id from country where title = 'Rwanda');

update district
SET title = 'Kigali City/Umujyi wa Kigali'
WHERE title = 'Kigali Province'
AND country_id = (select country_id from country where title = 'Rwanda');

update district
SET title = 'North/Amajyaruguru'
WHERE title = 'Northern Province'
AND country_id = (select country_id from country where title = 'Rwanda');

update district
SET title = 'South/Amajyepfo'
WHERE title = 'Southern Province'
AND country_id = (select country_id from country where title = 'Rwanda');

update district
SET title = 'Saint louis'
WHERE title = 'Saint-Louis'
AND country_id in (select country_id from country where title = 'Senegal');

update district
SET title = 'Thies'
WHERE title = 'Thiès'
AND country_id in (select country_id from country where title = 'Senegal');

update district
SET title = 'Dar es salaam'
WHERE title = 'Dar-Es-Salaam'
AND country_id in (select country_id from country where title = 'United Republic of Tanzania');

update district
SET title = 'Kusini Unguja'
WHERE title = 'Zanzibar South and Central'
AND country_id in (select country_id from country where title = 'United Republic of Tanzania');

update district
SET title = 'Mjini Magharibi'
WHERE title = 'Zanzibar West'
AND country_id in (select country_id from country where title = 'United Republic of Tanzania');


-- updating the district table with new gaul data
update district
set adm0_code = country.adm0_code
from country
where district.country_id = country.country_id;

update district
set adm0_name = country.title
from country
where district.country_id = country.country_id;

update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ethiopia';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Bangladesh';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Kenya';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Senegal';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ghana';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'United Republic of Tanzania';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Liberia';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zambia';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Malawi';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Nepal';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mali';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mozambique';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Rwanda';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Uganda';
update district set geom = gaul_2014_adm1.geom from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zimbabwe';


update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ethiopia';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Bangladesh';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Kenya';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Senegal';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ghana';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'United Republic of Tanzania';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Liberia';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zambia';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Malawi';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Nepal';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mali';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mozambique';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Rwanda';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Uganda';
update district set geom_point = gaul_2014_adm1.geom_point from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zimbabwe';


update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ethiopia';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Bangladesh';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Kenya';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Senegal';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ghana';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'United Republic of Tanzania';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Liberia';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zambia';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Malawi';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Nepal';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mali';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mozambique';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Rwanda';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Uganda';
update district set adm1_code = gaul_2014_adm1.adm1_code from gaul_2014_adm1
where district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zimbabwe';


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

update site
SET title = 'Abura/Asebu/Kwamankese'
WHERE title = 'Abura-Asebu-Kwamankese';

update site
SET title = 'Accra'
WHERE title = 'Accra Metropolitan';

update site
SET title = 'Angonia'
WHERE title = 'Angónia';

update site
SET title = 'Atwima'
WHERE title = 'Atwima Mponua';

update site
SET title = 'Bolgatanga'
WHERE title = 'Bolgatanga Municipal';

update site
SET title = 'Cape Coast'
WHERE title = 'Cape Coast Metropolitan';

update site
SET title = 'Saboba/Chereponi'
WHERE title = 'Chereponi';

update site
SET title = 'Chokwe'
WHERE title = 'Chókwè';

update site
SET title = 'Dodoma Urban'
WHERE title = 'Dodoma Rural';

update site
SET title = 'Marakwet'
WHERE title = 'Elgeyo-Marakwet';

update site
SET title = 'Ga'
where title = 'Ga East Municipal';

update site
SET title = 'Ga'
where title = 'Ga West Municipal';

update site
SET title = 'Gomoa'
where title = 'Gomoa West';

update site
SET title = 'Gushiegu/Karaga'
where title = 'Gushegu';

update site
SET title = 'Jaman'
where title = 'Jaman North';

update site
SET title = 'Fafan'
where title = 'Jijiga';

update site
SET title = 'Jirapa/Lambussie'
where title = 'Jirapa';

update site
SET title = 'Gushiegu/Karaga'
where title = 'Karaga';

update site
SET title = 'Kintampo'
where title = 'Kintampo North Municipal';

update site
SET title = 'Kintampo'
where title = 'Kintampo South';

update site
SET title = 'Nyamira'
where title = 'Kisii';

update site
SET title = 'Komenda/Edina Aguafo'
where title = 'Komenda-Edina-Eguafo-Abire Municipal';

update site
SET title = 'Kumasi'
where title = 'Kumasi Metropolitan';

update site
SET title = 'Tolon/Kumbungu'
where title = 'Kumbungu';

update site
SET title = 'Kedougou'
where title = 'Kédougou';

update site
SET title = 'Metekel'
where title = 'Mekele';

update site
SET title = 'Yendi'
where title = 'Mion';

update site
SET title = 'Mogincual'
where title = 'Mongincual';

update site
SET title = 'Morogoro Urban'
where title = 'Morogoro Rural';

update site
SET title = 'Nacala-A-Velha'
where title = 'Nacala Velha';

update site
SET title = 'Nandi North'
where title = 'Nandi';

update site
SET title = 'Nanumba'
where title = 'Nanumba North';

update site
SET title = 'Nanumba'
where title = 'Nanumba South';

update site
SET title = 'Nioro du rip'
where title = 'Nioro-Du-Rip';

update site
SET title = 'West Gonja'
where title = 'North Gonja';

update site
SET title = 'North Shewa(R4)'
where title = 'North Shewa (K4)';

update site
SET title = 'Nzema East'
where title = 'Nzema East Municipal';

update site
SET title = 'Offinso'
where title = 'Offinso South Municipal';

update site
SET title = 'Atebubu'
where title = 'Pru';

update site
SET title = 'Saboba/Chereponi'
where title = 'Saboba';

update site
SET title = 'Tamale'
where title = 'Sagnarigu';

update site
SET title = 'Savelgu/Nanton'
where title = 'Savelugu-Nanton';

update site
SET title = 'Savelgu/Nanton'
where title = 'Savelugu-Nanton';

update site
SET title = 'Bole'
where title = 'Sawla-Tuna-Kalba';

update site
SET title = 'Shama Ahanta East'
where title = 'Shama';

update site
SET title = 'Siti'
where title = 'Shinile';

update site
SET title = 'Sunyani'
where title = 'Sunyani Municipal';

update site
SET title = 'Sedhiou'
where title = 'Sédhiou';

update site
SET title = 'Bolgatanga'
where title = 'Talensi-Nabdam';

update site
SET title = 'Tamale'
where title = 'Tamale Metropolitan';

update site
SET title = 'Zabzugu/Tatale'
where title = 'Tatale Sangule';

update site
SET title = 'Techiman'
where title = 'Techiman Municipal';

update site
SET title = 'Tema'
where title = 'Tema Metropolitan';

update site
SET title = 'Thies'
where title = 'Thiès';

update site
SET title = 'Tolon/Kumbungu'
where title = 'Tolon';

update site
SET title = 'Trans Nzoia'
where title = 'Trans-Nzoia';

update site
SET title = 'Tenenkou'
where title = 'Ténenkou';

update site
SET title = 'Vilankulo'
where title = 'Vilanculos';

update site
SET title = 'Wa'
where title = 'Wa West';

update site
SET title = 'Wa'
where title = 'Wa East';

update site
SET title = 'Wa'
where title = 'Wa Municipal';

update site
SET title = 'Yendi'
where title = 'Yendi Municipal';

update site
SET title = 'Zabzugu/Tatale'
where title = 'Zabzugu';

update site
SET title = 'West Gonja'
where title = 'Central Gonja';

-- updating the site table with new gaul data
update site
set adm0_code = district.adm0_code
from district
where district.district_id = site.district_id;

update site
set adm0_name = district.adm0_name
from district
where district.district_id = site.district_id;

update site
set adm1_code = district.adm1_code
from district
where district.district_id = site.district_id;

update site
set adm1_name = district.title
from district
where district.district_id = site.district_id;

update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ethiopia';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Bangladesh';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Kenya';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Senegal';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ghana';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'United Republic of Tanzania';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Liberia';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zambia';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Malawi';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Nepal';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mali';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mozambique';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Rwanda';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Uganda';
update site
set geom = gaul_2014_adm2.geom from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zimbabwe';


update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ethiopia';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Bangladesh';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Kenya';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Senegal';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ghana';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'United Republic of Tanzania';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Liberia';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zambia';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Malawi';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Nepal';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mali';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mozambique';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Rwanda';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Uganda';
update site
set geom_point = gaul_2014_adm2.geom_point from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zimbabwe';



update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ethiopia';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Bangladesh';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Kenya';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Senegal';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ghana';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'United Republic of Tanzania';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Liberia';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zambia';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Malawi';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Nepal';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mali';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mozambique';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Rwanda';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Uganda';
update site
set adm2_code = gaul_2014_adm2.adm2_code from gaul_2014_adm2 where gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zimbabwe';



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
SELECT count(distinct ro.report_id) report_count, count(distinct o.organization_id) organization_count, c.country_id, d.district_id, s.site_id, c.title country_title, d.title district_title, s.title site_title, c.adm0_code, d.adm1_code, s.adm2_code
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


-- create view to get all data for a given project
CREATE VIEW summary_data_by_project AS
SELECT data_id, r.report_id, r.title report_title, e.edition_id, e.year, i.indicator_id, i.title indicator_title, m.measure_id, m.title measure_title, v.value_id, v.title value_title, data
FROM data
JOIN report r ON (r.report_id = data.report_id)
JOIN edition e ON (e.edition_id = data.edition_id)
JOIN indicator i ON (i.indicator_id = data.indicator_id)
JOIN measure m ON (m.measure_id = data.measure_id)
JOIN value v ON (v.value_id = data.value_id)


DROP SERVER fsp CASCADE;