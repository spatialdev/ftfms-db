-- adding extra columns to the country table to include geometry and gaul ids
ALTER TABLE country
ADD column geom geometry;

ALTER TABLE country
ADD column geom_point geometry;

ALTER TABLE country
ADD column adm0_code integer;

-- UPDATE country table so ftfms matches gaul
UPDATE country
SET title = 'United Republic of Tanzania'
WHERE country.title = 'Tanzania';

-- updating the country table with new gaul data
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ethiopia';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Bangladesh';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Kenya';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Senegal';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ghana';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Liberia';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Zambia';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Malawi';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Nepal';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Mali';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Mozambique';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Rwanda';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Uganda';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Zimbabwe';
UPDATE country SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'United Republic of Tanzania';


UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ethiopia';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Bangladesh';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Kenya';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Senegal';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ghana';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Liberia';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Zambia';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Malawi';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Nepal';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Mali';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Mozambique';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Rwanda';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Uganda';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'Zimbabwe';
UPDATE country SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE country.title = gaul_2014_adm0.adm0_name
and country.title = 'United Republic of Tanzania';



-- get adm0 codes FROM adm1 table
UPDATE country
SET adm0_code = countries.adm0_code
from(
	SELECT distinct(adm0_code), adm0_name
	FROM gaul_2014_adm1
	group by 1,2) countries
WHERE country.title = countries.adm0_name;



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
UPDATE district
SET title = 'SNNPR'
WHERE title = 'Southern Nations, Nationalities and Peoples'
AND country_id = (SELECT country_id FROM country WHERE title = 'Ethiopia');

UPDATE district
SET title = 'North Eastern'
WHERE title = 'North-Eastern'
AND country_id = (SELECT country_id FROM country WHERE title = 'Kenya');

UPDATE district
SET title = 'Segou'
WHERE title = 'Ségou'
AND country_id = (SELECT country_id FROM country WHERE title = 'Mali');

UPDATE district
SET title = 'West/Iburengerazuba'
WHERE title = 'Western Province'
AND country_id = (SELECT country_id FROM country WHERE title = 'Rwanda');

UPDATE district
SET title = 'East/Iburasirazuba'
WHERE title = 'Eastern Province'
AND country_id = (SELECT country_id FROM country WHERE title = 'Rwanda');

UPDATE district
SET title = 'Kigali City/Umujyi wa Kigali'
WHERE title = 'Kigali Province'
AND country_id = (SELECT country_id FROM country WHERE title = 'Rwanda');

UPDATE district
SET title = 'North/Amajyaruguru'
WHERE title = 'Northern Province'
AND country_id = (SELECT country_id FROM country WHERE title = 'Rwanda');

UPDATE district
SET title = 'South/Amajyepfo'
WHERE title = 'Southern Province'
AND country_id = (SELECT country_id FROM country WHERE title = 'Rwanda');

UPDATE district
SET title = 'Saint louis'
WHERE title = 'Saint-Louis'
AND country_id in (SELECT country_id FROM country WHERE title = 'Senegal');

UPDATE district
SET title = 'Thies'
WHERE title = 'Thiès'
AND country_id in (SELECT country_id FROM country WHERE title = 'Senegal');

UPDATE district
SET title = 'Dar es salaam'
WHERE title = 'Dar-Es-Salaam'
AND country_id in (SELECT country_id FROM country WHERE title = 'United Republic of Tanzania');

UPDATE district
SET title = 'Kusini Unguja'
WHERE title = 'Zanzibar South and Central'
AND country_id in (SELECT country_id FROM country WHERE title = 'United Republic of Tanzania');

UPDATE district
SET title = 'Mjini Magharibi'
WHERE title = 'Zanzibar West'
AND country_id in (SELECT country_id FROM country WHERE title = 'United Republic of Tanzania');


-- updating the district table with new gaul data
UPDATE district
SET adm0_code = country.adm0_code
FROM country
WHERE district.country_id = country.country_id;

UPDATE district
SET adm0_name = country.title
FROM country
WHERE district.country_id = country.country_id;

UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ethiopia';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Bangladesh';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Kenya';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Senegal';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ghana';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'United Republic of Tanzania';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Liberia';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zambia';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Malawi';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Nepal';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mali';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mozambique';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Rwanda';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Uganda';
UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zimbabwe';


UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ethiopia';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Bangladesh';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Kenya';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Senegal';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ghana';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'United Republic of Tanzania';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Liberia';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zambia';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Malawi';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Nepal';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mali';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mozambique';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Rwanda';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Uganda';
UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zimbabwe';


UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ethiopia';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Bangladesh';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Kenya';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Senegal';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Ghana';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'United Republic of Tanzania';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Liberia';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Zambia';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Malawi';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Nepal';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mali';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Mozambique';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Rwanda';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
and gaul_2014_adm1.adm0_name = 'Uganda';
UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
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
UPDATE site
SET title = 'Central'
WHERE title = 'Central Tigray';

UPDATE site
SET title = 'Southern'
WHERE title = 'Southern Tigray';

UPDATE site
SET title = 'Abura/Asebu/Kwamankese'
WHERE title = 'Abura-Asebu-Kwamankese';

UPDATE site
SET title = 'Accra'
WHERE title = 'Accra Metropolitan';

UPDATE site
SET title = 'Angonia'
WHERE title = 'Angónia';

UPDATE site
SET title = 'Atwima'
WHERE title = 'Atwima Mponua';

UPDATE site
SET title = 'Bolgatanga'
WHERE title = 'Bolgatanga Municipal';

UPDATE site
SET title = 'Cape Coast'
WHERE title = 'Cape Coast Metropolitan';

UPDATE site
SET title = 'Saboba/Chereponi'
WHERE title = 'Chereponi';

UPDATE site
SET title = 'Chokwe'
WHERE title = 'Chókwè';

UPDATE site
SET title = 'Dodoma Urban'
WHERE title = 'Dodoma Rural';

UPDATE site
SET title = 'Marakwet'
WHERE title = 'Elgeyo-Marakwet';

UPDATE site
SET title = 'Ga'
WHERE title = 'Ga East Municipal';

UPDATE site
SET title = 'Ga'
WHERE title = 'Ga West Municipal';

UPDATE site
SET title = 'Gomoa'
WHERE title = 'Gomoa West';

UPDATE site
SET title = 'Gushiegu/Karaga'
WHERE title = 'Gushegu';

UPDATE site
SET title = 'Jaman'
WHERE title = 'Jaman North';

UPDATE site
SET title = 'Fafan'
WHERE title = 'Jijiga';

UPDATE site
SET title = 'Jirapa/Lambussie'
WHERE title = 'Jirapa';

UPDATE site
SET title = 'Gushiegu/Karaga'
WHERE title = 'Karaga';

UPDATE site
SET title = 'Kintampo'
WHERE title = 'Kintampo North Municipal';

UPDATE site
SET title = 'Kintampo'
WHERE title = 'Kintampo South';

UPDATE site
SET title = 'Nyamira'
WHERE title = 'Kisii';

UPDATE site
SET title = 'Komenda/Edina Aguafo'
WHERE title = 'Komenda-Edina-Eguafo-Abire Municipal';

UPDATE site
SET title = 'Kumasi'
WHERE title = 'Kumasi Metropolitan';

UPDATE site
SET title = 'Tolon/Kumbungu'
WHERE title = 'Kumbungu';

UPDATE site
SET title = 'Kedougou'
WHERE title = 'Kédougou';

UPDATE site
SET title = 'Metekel'
WHERE title = 'Mekele';

UPDATE site
SET title = 'Yendi'
WHERE title = 'Mion';

UPDATE site
SET title = 'Mogincual'
WHERE title = 'Mongincual';

UPDATE site
SET title = 'Morogoro Urban'
WHERE title = 'Morogoro Rural';

UPDATE site
SET title = 'Nacala-A-Velha'
WHERE title = 'Nacala Velha';

UPDATE site
SET title = 'Nandi North'
WHERE title = 'Nandi';

UPDATE site
SET title = 'Nanumba'
WHERE title = 'Nanumba North';

UPDATE site
SET title = 'Nanumba'
WHERE title = 'Nanumba South';

UPDATE site
SET title = 'Nioro du rip'
WHERE title = 'Nioro-Du-Rip';

UPDATE site
SET title = 'West Gonja'
WHERE title = 'North Gonja';

UPDATE site
SET title = 'North Shewa(R4)'
WHERE title = 'North Shewa (K4)';

UPDATE site
SET title = 'Nzema East'
WHERE title = 'Nzema East Municipal';

UPDATE site
SET title = 'Offinso'
WHERE title = 'Offinso South Municipal';

UPDATE site
SET title = 'Atebubu'
WHERE title = 'Pru';

UPDATE site
SET title = 'Saboba/Chereponi'
WHERE title = 'Saboba';

UPDATE site
SET title = 'Tamale'
WHERE title = 'Sagnarigu';

UPDATE site
SET title = 'Savelgu/Nanton'
WHERE title = 'Savelugu-Nanton';

UPDATE site
SET title = 'Savelgu/Nanton'
WHERE title = 'Savelugu-Nanton';

UPDATE site
SET title = 'Bole'
WHERE title = 'Sawla-Tuna-Kalba';

UPDATE site
SET title = 'Shama Ahanta East'
WHERE title = 'Shama';

UPDATE site
SET title = 'Siti'
WHERE title = 'Shinile';

UPDATE site
SET title = 'Sunyani'
WHERE title = 'Sunyani Municipal';

UPDATE site
SET title = 'Sedhiou'
WHERE title = 'Sédhiou';

UPDATE site
SET title = 'Bolgatanga'
WHERE title = 'Talensi-Nabdam';

UPDATE site
SET title = 'Tamale'
WHERE title = 'Tamale Metropolitan';

UPDATE site
SET title = 'Zabzugu/Tatale'
WHERE title = 'Tatale Sangule';

UPDATE site
SET title = 'Techiman'
WHERE title = 'Techiman Municipal';

UPDATE site
SET title = 'Tema'
WHERE title = 'Tema Metropolitan';

UPDATE site
SET title = 'Thies'
WHERE title = 'Thiès';

UPDATE site
SET title = 'Tolon/Kumbungu'
WHERE title = 'Tolon';

UPDATE site
SET title = 'Trans Nzoia'
WHERE title = 'Trans-Nzoia';

UPDATE site
SET title = 'Tenenkou'
WHERE title = 'Ténenkou';

UPDATE site
SET title = 'Vilankulo'
WHERE title = 'Vilanculos';

UPDATE site
SET title = 'Wa'
WHERE title = 'Wa West';

UPDATE site
SET title = 'Wa'
WHERE title = 'Wa East';

UPDATE site
SET title = 'Wa'
WHERE title = 'Wa Municipal';

UPDATE site
SET title = 'Yendi'
WHERE title = 'Yendi Municipal';

UPDATE site
SET title = 'Zabzugu/Tatale'
WHERE title = 'Zabzugu';

UPDATE site
SET title = 'West Gonja'
WHERE title = 'Central Gonja';

-- updating the site table with new gaul data
UPDATE site
SET adm0_code = district.adm0_code
FROM district
WHERE district.district_id = site.district_id;

UPDATE site
SET adm0_name = district.adm0_name
FROM district
WHERE district.district_id = site.district_id;

UPDATE site
SET adm1_code = district.adm1_code
FROM district
WHERE district.district_id = site.district_id;

UPDATE site
SET adm1_name = district.title
FROM district
WHERE district.district_id = site.district_id;

UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ethiopia';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Bangladesh';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Kenya';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Senegal';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ghana';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'United Republic of Tanzania';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Liberia';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zambia';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Malawi';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Nepal';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mali';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mozambique';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Rwanda';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Uganda';
UPDATE site
SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zimbabwe';


UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ethiopia';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Bangladesh';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Kenya';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Senegal';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ghana';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'United Republic of Tanzania';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Liberia';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zambia';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Malawi';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Nepal';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mali';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mozambique';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Rwanda';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Uganda';
UPDATE site
SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zimbabwe';



UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ethiopia';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Bangladesh';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Kenya';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Senegal';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Ghana';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'United Republic of Tanzania';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Liberia';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zambia';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Malawi';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Nepal';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mali';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Mozambique';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Rwanda';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Uganda';
UPDATE site
SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
and gaul_2014_adm2.adm0_name = 'Zimbabwe';



-- CREATE view with all district and country data
CREATE VIEW country_district AS
SELECT district.district_id, district.title as district_title, country.country_id, country.code, country.title, country.description, country.image_path
FROM district
JOIN country ON (district.country_id = country.country_id);


-- CREATE view with all site, district and country data
CREATE VIEW country_district_site AS
SELECT site.site_id, site.village_id, site.title as site_title, site.image_path as site_image_path, district.district_id, district.title as district_title, country.country_id, country.code, country.title, country.description, country.image_path
FROM site
JOIN district ON (district.district_id = site.district_id)
JOIN country ON (district.country_id = country.country_id);


-- CREATE view report details which includes details for report endpoint
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


-- CREATE view organization details which includes details for organization/prime partner endpoint
CREATE VIEW organization_details AS
SELECT organization.organization_id, organization.title, array_agg(distinct ro.report_id) report_id, rl.country_id, array_agg( distinct rl.district_id) district_id, array_agg(distinct rl.site_id) site_id
FROM organization
JOIN report_organization ro ON ( ro.organization_id = organization.organization_id)
JOIN report_location rl ON ( rl.report_id = ro.report_id)
GROUP BY 1,2,4;


-- CREATE view to get summary data by country
-- summary includes number of projects and organizations in a given country
CREATE VIEW summary_data_by_country AS
SELECT count(distinct ro.report_id) report_count, count(distinct o.organization_id) organization_count, c.country_id,  c.title country_title, c.adm0_code
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
GROUP BY c.country_id, c.title, c.adm0_code;


-- CREATE view to get summary data by district
-- summary includes number of projects and organizations in a given district
CREATE VIEW me_summary_data_by_district AS
SELECT count(distinct ro.report_id) report_count, count(distinct o.organization_id) organization_count, count(distinct ri.indicator_id) indicator_count, c.country_id, d.district_id, c.title country_title, d.title district_title, c.adm0_code, d.adm1_code
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN report_indicator ri ON (ri.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
JOIN district d ON (d.district_id = rl.district_id)
GROUP BY c.country_id, d.district_id, c.title, d.title, c.adm0_code, d.adm1_code;


-- CREATE view to get summary data by site
-- summary includes number of projects and organizations in a given site
CREATE view me_summary_data_by_site AS
SELECT count(distinct ro.report_id) report_count, count(distinct o.organization_id) organization_count, count(distinct ri.indicator_id) indicator_count, c.country_id, d.district_id, s.site_id, c.title country_title, d.title district_title, s.title site_title, c.adm0_code, d.adm1_code, s.adm2_code
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN report_indicator ri ON (ri.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
JOIN district d ON (d.district_id = rl.district_id)
JOIN site s ON (s.site_id = rl.site_id)
GROUP BY c.country_id, d.district_id, s.site_id, c.title, d.title, s.title;


-- CREATE view to get summary data by organization
-- summary includes number of projects, and locations
CREATE VIEW me_summary_data_by_organization AS
SELECT o.organization_id, o.title, count(distinct ro.report_id) report_count, count(distinct rl.country_id) country_count, count(distinct d.district_id) district_count, count(distinct s.site_id) site_count, array_agg(distinct c.title) country_title, array_agg(distinct d.title) district_title, array_agg(distinct s.title) site_title
FROM organization o
JOIN report_organization ro ON ( ro.organization_id = o.organization_id)
JOIN report_location rl ON (rl.report_id = ro.report_id)
JOIN country c ON (c.country_id = rl.country_id)
LEFT JOIN district d ON (d.district_id = rl.district_id)
LEFT JOIN site s ON (s.site_id = rl.site_id)
GROUP BY o.organization_id
ORDER BY country_title;


-- CREATE view to get all data for a given location
CREATE VIEW me_summary_data_by_location AS
SELECT data_id, r.report_id, r.title report_title, e.edition_id, e.year, i.indicator_id, i.title indicator_title, m.measure_id, m.title measure_title, v.value_id, v.title value_title, c.adm0_code, d.adm1_code, s.adm2_code, o.title, data
FROM data
JOIN report r ON (r.report_id = data.report_id)
JOIN report_location rl ON (rl.report_id = data.report_id)
LEFT JOIN country c ON (c.country_id = rl.country_id)
LEFT JOIN district d ON (d.district_id = rl.district_id)
LEFT JOIN site s ON (s.site_id = rl.site_id)
LEFT JOIN report_organization ro ON (ro.report_id = r.report_id)
JOIN organization o ON ( o.organization_id = ro.organization_id)
JOIN edition e ON (e.edition_id = data.edition_id)
JOIN indicator i ON (i.indicator_id = data.indicator_id)
JOIN measure m ON (m.measure_id = data.measure_id)
JOIN value v ON (v.value_id = data.value_id);


-- CREATE view to of summary statistics for M&E module
CREATE VIEW me_summary_stats AS
SELECT 4 as id, 'Implementing Mechanisms' title, count(distinct r.report_id) count, 'Projects reporting outcomes in the Feed The Future Monitoring System.' description
FROM data
JOIN report r ON (r.report_id = data.report_id)
JOIN report_location rl ON (r.report_id = rl.report_id)
JOIN report_organization ro ON (r.report_id = ro.report_id)
JOIN indicator i ON (i.indicator_id = data.indicator_id)
UNION
SELECT 3, 'Implementing Partners' as title, count(distinct organization_id), 'Implementing Partners working on Feed The Future projects.'
FROM data
JOIN report r ON (r.report_id = data.report_id)
JOIN report_location rl ON (r.report_id = rl.report_id)
JOIN report_organization ro ON (r.report_id = ro.report_id)
JOIN indicator i ON (i.indicator_id = data.indicator_id)
UNION
SELECT 2, 'Indicators' as title, count(distinct i.indicator_id), 'Feed The Future Indicators reported in 2015.'
FROM data
JOIN report r ON (r.report_id = data.report_id)
JOIN report_location rl ON (r.report_id = rl.report_id)
JOIN report_organization ro ON (r.report_id = ro.report_id)
JOIN indicator i ON (i.indicator_id = data.indicator_id)
UNION
SELECT 1,'Regions' as title, count(distinct district_id), 'Regions that have ongoing Feed The Future projects'
FROM data
JOIN report r ON (r.report_id = data.report_id)
JOIN report_location rl ON (r.report_id = rl.report_id)
JOIN report_organization ro ON (r.report_id = ro.report_id)
JOIN indicator i ON (i.indicator_id = data.indicator_id);


DROP SERVER fsp CASCADE;