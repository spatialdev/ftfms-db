/************************************************************************

  -- Add geometry to FTFMS data
  -- Data is updated to match GAUL 2014 naming conventions

*************************************************************************/

-- adding extra columns to the country table to include geometry and gaul ids
ALTER TABLE country
ADD column geom geometry;

ALTER TABLE country
ADD column geom_point geometry;

ALTER TABLE country
ADD column adm0_code integer;

-- UPDATE country table so ftfms matches gaul
UPDATE country c
SET title = 'United Republic of Tanzania'
WHERE c.title = 'Tanzania';


-- remove unneeded rows from gaul data
DELETE
FROM gaul_2014_adm0
WHERE adm0_name not in (SELECT title from country);

DELETE
FROM gaul_2014_adm1
WHERE adm0_name not in (SELECT title from country);

DELETE
FROM gaul_2014_adm2
WHERE adm0_name not in (SELECT title from country);



CREATE OR REPLACE FUNCTION FTFMS_GAUL_COUNTRY_UPDATE() RETURNS boolean AS $$
DECLARE
    country RECORD;
    country_title character varying;

BEGIN

FOR country IN SELECT * FROM country LOOP

    country_title = country.title;

    -- updating the country table with new gaul data
    UPDATE country c SET geom = gaul_2014_adm0.geom FROM gaul_2014_adm0 WHERE c.title = gaul_2014_adm0.adm0_name
    and c.title = country_title;


    UPDATE country c SET geom_point = gaul_2014_adm0.geom_point FROM gaul_2014_adm0 WHERE c.title = gaul_2014_adm0.adm0_name
    and c.title = country_title;

    END LOOP;
    RETURN true;
END;
$$ LANGUAGE plpgsql;


-- run function to update gaul country data
select * from FTFMS_GAUL_COUNTRY_UPDATE();


-- get adm0 codes FROM adm1 table
UPDATE country c
SET adm0_code = countries.adm0_code
from(
	SELECT distinct(adm0_code), adm0_name
	FROM gaul_2014_adm1
	group by 1,2) countries
WHERE c.title = countries.adm0_name;


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

UPDATE district
SET title = 'Nord Est'
WHERE title = 'Nord-Est'
AND country_id in (SELECT country_id FROM country WHERE title = 'Haiti');

UPDATE district
SET title = 'Sud Est'
WHERE title = 'Sud-Est'
AND country_id in (SELECT country_id FROM country WHERE title = 'Haiti');

UPDATE district
SET title = 'Nord Ouest'
WHERE title = 'Nord-Ouest'
AND country_id in (SELECT country_id FROM country WHERE title = 'Haiti');


UPDATE district
SET title = 'Artibonite'
WHERE title = 'L''Artibonite'
AND country_id = (SELECT country_id FROM country WHERE title = 'Haiti');

UPDATE district
SET title = 'Battambang'
WHERE title = 'Batdâmbâng'
AND country_id = (SELECT country_id FROM country WHERE title = 'Cambodia');

UPDATE district
SET title = 'Kampong Thom'
WHERE title = 'Kâmpóng Thum'
AND country_id = (SELECT country_id FROM country WHERE title = 'Cambodia');

UPDATE district
SET title = 'Kampong Thom'
WHERE title = 'Kâmpóng Thum'
AND country_id = (SELECT country_id FROM country WHERE title = 'Cambodia');

UPDATE district
SET title = 'Pursat'
WHERE title = 'Pouthisat'
AND country_id = (SELECT country_id FROM country WHERE title = 'Cambodia');

UPDATE district
SET title = 'Siem Reap'
WHERE title = 'Siemréab'
AND country_id = (SELECT country_id FROM country WHERE title = 'Cambodia');

UPDATE district
SET title = 'Quetzaltenango'
WHERE title = 'Quezaltenango'
AND country_id = (SELECT country_id FROM country WHERE title = 'Guatemala');

UPDATE district
SET title = 'Copan'
WHERE title = 'Copán'
AND country_id = (SELECT country_id FROM country WHERE title = 'Honduras');

UPDATE district
SET title = 'Intibuca'
WHERE title = 'Intibucá'
AND country_id = (SELECT country_id FROM country WHERE title = 'Honduras');

UPDATE district
SET title = 'Santa Barbara'
WHERE title = 'Santa Bárbara'
AND country_id = (SELECT country_id FROM country WHERE title = 'Honduras');

UPDATE district
SET title = 'Grand Gedeh'
WHERE title = 'GrandGedeh'
AND country_id = (SELECT country_id FROM country WHERE title = 'Liberia');

-- Malawi has its admin2 as admin1 so admin1 have to be added manually
UPDATE district SET title = 'Southern Region' WHERE country_id = (select country_id from country where title = 'Malawi' );
INSERT INTO district (title, country_id) VALUES ( 'Central Region', (select country_id from country where title = 'Malawi' ));
INSERT INTO district (title, country_id) VALUES ( 'Northern Region', (select country_id from country where title = 'Malawi' ));



-- updating the district table with new gaul data
UPDATE district
SET adm0_code = c.adm0_code
FROM country c
WHERE district.country_id = c.country_id;

UPDATE district
SET adm0_name = c.title
FROM country c
WHERE district.country_id = c.country_id;


CREATE OR REPLACE FUNCTION FTFMS_GAUL_DISTRICT_UPDATE() RETURNS boolean AS $$
DECLARE
    country RECORD;
    country_title character varying;

BEGIN

FOR country IN SELECT * FROM country LOOP


    country_title = country.title;


    UPDATE district SET geom = gaul_2014_adm1.geom FROM gaul_2014_adm1
    WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
    and gaul_2014_adm1.adm0_name = country_title;


    UPDATE district SET geom_point = gaul_2014_adm1.geom_point FROM gaul_2014_adm1
    WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
    and gaul_2014_adm1.adm0_name = country_title;


    UPDATE district SET adm1_code = gaul_2014_adm1.adm1_code FROM gaul_2014_adm1
    WHERE district.adm0_code = gaul_2014_adm1.adm0_code and district.title = gaul_2014_adm1.adm1_name
    and gaul_2014_adm1.adm0_name = country_title;

    END LOOP;
    RETURN true;
END;
$$ LANGUAGE plpgsql;

select * from FTFMS_GAUL_DISTRICT_UPDATE();


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


-- update site with Malawi data because need to backfill data
UPDATE site
SET adm1_name = 'Southern Region'
WHERE title in ('Balaka', 'Blantyre', 'Chikwawa', 'Chiradzulu', 'Machinga', 'Mangochi', 'Mulanje', 'Nsanje', 'Thyolo', 'Zomba' )
AND adm0_name = 'Malawi';

UPDATE site
SET district_id = (select district_id from district where title = 'Southern Region')
WHERE title in ('Balaka', 'Blantyre', 'Chikwawa', 'Chiradzulu', 'Machinga', 'Mangochi', 'Mulanje', 'Nsanje', 'Thyolo', 'Zomba' )
AND adm0_name = 'Malawi';

UPDATE site
SET adm1_name = 'Central Region'
WHERE title in ('Dedza', 'Dowa','Kasungu', 'Lilongwe', 'Mchinji', 'Nkhotakota', 'Ntcheu', 'Ntchisi', 'Salima' )
AND adm0_name = 'Malawi';

UPDATE site
SET district_id = (select district_id from district where title = 'Central Region')
WHERE title in ('Dedza', 'Dowa', 'Kasungu', 'Lilongwe', 'Mchinji', 'Nkhotakota', 'Ntcheu', 'Ntchisi', 'Salima' )
AND adm0_name = 'Malawi';

UPDATE site
SET adm1_name = 'Northern Region'
WHERE title in ('Karonga', 'Mzimba', 'Nkhata Bay', 'Rumphi')
AND adm0_name = 'Malawi';

UPDATE site
SET district_id = (select district_id from district where title = 'Northern Region')
WHERE title in ( 'Karonga', 'Mzimba', 'Nkhata Bay', 'Rumphi' )
AND adm0_name = 'Malawi';


-- updating the site names to match gaul names
UPDATE site
SET title = 'Central'
WHERE title = 'Central Tigray'
AND adm0_name = 'Ethiopia'
AND adm1_name = 'Tigray';

UPDATE site
SET title = 'Southern'
WHERE title = 'Southern Tigray'
AND adm0_name = 'Ethiopia'
AND adm1_name = 'Tigray';

UPDATE site
SET title = 'Abura/Asebu/Kwamankese'
WHERE title = 'Abura-Asebu-Kwamankese'
AND adm0_name = 'Ghana'
AND adm1_name = 'Central';

UPDATE site
SET title = 'Accra'
WHERE title = 'Accra Metropolitan'
AND adm0_name = 'Ghana'
AND adm1_name = 'Greater Accra';

UPDATE site
SET title = 'Angonia'
WHERE title = 'Angónia'
AND adm0_name = 'Mozambique'
AND adm1_name = 'Tete';

UPDATE site
SET title = 'Atwima'
WHERE title = 'Atwima Mponua'
AND adm0_name = 'Ghana'
AND adm1_name = 'Ashanti';

UPDATE site
SET title = 'Bolgatanga'
WHERE title = 'Bolgatanga Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Upper East';

UPDATE site
SET title = 'Cape Coast'
WHERE title = 'Cape Coast Metropolitan'
AND adm0_name = 'Ghana'
AND adm1_name = 'Central';

UPDATE site
SET title = 'Saboba/Chereponi'
WHERE title = 'Chereponi'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Chokwe'
WHERE title = 'Chókwè'
AND adm0_name = 'Mozambique'
AND adm1_name = 'Gaza';

UPDATE site
SET title = 'Dodoma Urban'
WHERE title = 'Dodoma Rural'
AND adm0_name = 'United Republic of Tanzania'
AND adm1_name = 'Dodoma';

UPDATE site
SET title = 'Marakwet'
WHERE title = 'Elgeyo-Marakwet'
AND adm0_name = 'Kenya'
AND adm1_name = 'Rift Valley';

UPDATE site
SET title = 'Ga'
WHERE title = 'Ga East Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Greater Accra';

UPDATE site
SET title = 'Ga'
WHERE title = 'Ga West Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Greater Accra';

UPDATE site
SET title = 'Gomoa'
WHERE title = 'Gomoa West'
AND adm0_name = 'Ghana'
AND adm1_name = 'Central';

UPDATE site
SET title = 'Gushiegu/Karaga'
WHERE title = 'Gushegu'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Jaman'
WHERE title = 'Jaman North'
AND adm0_name = 'Ghana'
AND adm1_name = 'Brong Ahafo';

UPDATE site
SET title = 'Fafan'
WHERE title = 'Jijiga'
AND adm0_name = 'Ethiopia'
AND adm1_name = 'Somali';

UPDATE site
SET title = 'Jirapa/Lambussie'
WHERE title = 'Jirapa'
AND adm0_name = 'Ghana'
AND adm1_name = 'Upper West';

UPDATE site
SET title = 'Gushiegu/Karaga'
WHERE title = 'Karaga'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Kintampo'
WHERE title = 'Kintampo North Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Brong Ahafo';

UPDATE site
SET title = 'Kintampo'
WHERE title = 'Kintampo South'
AND adm0_name = 'Ghana'
AND adm1_name = 'Brong Ahafo';

UPDATE site
SET title = 'Nyamira'
WHERE title = 'Kisii'
AND adm0_name = 'Kenya'
AND adm1_name = 'Nyanza';

UPDATE site
SET title = 'Komenda/Edina Aguafo'
WHERE title = 'Komenda-Edina-Eguafo-Abire Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Central';

UPDATE site
SET title = 'Kpandu'
WHERE title = 'Kpandai'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Kumasi'
WHERE title = 'Kumasi Metropolitan'
AND adm0_name = 'Ghana'
AND adm1_name = 'Ashanti';


UPDATE site
SET title = 'Tolon/Kumbungu'
WHERE title = 'Kumbungu'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Kedougou'
WHERE title = 'Kédougou'
AND adm0_name = 'Senegal'
AND adm1_name = 'Tambacounda';

UPDATE site
SET title = 'Yendi'
WHERE title = 'Mion'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Morogoro Urban'
WHERE title = 'Morogoro Rural'
AND adm0_name = 'United Republic of Tanzania'
AND adm1_name = 'Morogoro';

UPDATE site
SET title = 'Nacala-A-Velha'
WHERE title = 'Nacala Velha'
AND adm0_name = 'Mozambique'
AND adm1_name = 'Nampula';

UPDATE site
SET title = 'Nandi North'
WHERE title = 'Nandi';

UPDATE site
SET title = 'Nanumba'
WHERE title = 'Nanumba North'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Nanumba'
WHERE title = 'Nanumba South'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Nioro du rip'
WHERE title = 'Nioro-Du-Rip'
AND adm0_name = 'Senegal'
AND adm1_name = 'Kaolack';

UPDATE site
SET title = 'West Gonja'
WHERE title = 'North Gonja'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'North Shewa(R4)'
WHERE title = 'North Shewa (K4)';

UPDATE site
SET title = 'Nzema East'
WHERE title = 'Nzema East Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Western';

UPDATE site
SET title = 'Offinso'
WHERE title = 'Offinso South Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Ashanti';

UPDATE site
SET title = 'Atebubu'
WHERE title = 'Pru'
AND adm0_name = 'Ghana'
AND adm1_name = 'Brong Ahafo';

UPDATE site
SET title = 'Saboba/Chereponi'
WHERE title = 'Saboba'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Tamale'
WHERE title = 'Sagnarigu'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Savelgu/Nanton'
WHERE title = 'Savelugu-Nanton'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Bole'
WHERE title = 'Sawla-Tuna-Kalba'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Shama Ahanta East'
WHERE title = 'Shama'
AND adm0_name = 'Ghana'
AND adm1_name = 'Western';

UPDATE site
SET title = 'Siti'
WHERE title = 'Shinile'
AND adm0_name = 'Ethiopia'
AND adm1_name = 'Somali';

UPDATE site
SET title = 'Sunyani'
WHERE title = 'Sunyani Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Brong Ahafo';

UPDATE site
SET title = 'Sedhiou'
WHERE title = 'Sédhiou'
AND adm0_name = 'Senegal'
AND adm1_name = 'Kolda';

UPDATE site
SET title = 'Bolgatanga'
WHERE title = 'Talensi-Nabdam'
AND adm0_name = 'Ghana'
AND adm1_name = 'Upper East';

UPDATE site
SET title = 'Tamale'
WHERE title = 'Tamale Metropolitan'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Zabzugu/Tatale'
WHERE title = 'Tatale Sangule'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Techiman'
WHERE title = 'Techiman Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Brong Ahafo';

UPDATE site
SET title = 'Tema'
WHERE title = 'Tema Metropolitan'
AND adm0_name = 'Ghana'
AND adm1_name = 'Greater Accra';

UPDATE site
SET title = 'Thies'
WHERE title = 'Thiès'
AND adm0_name = 'Senegal'
AND adm1_name = 'Thies';

UPDATE site
SET title = 'Tolon/Kumbungu'
WHERE title = 'Tolon'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Trans Nzoia'
WHERE title = 'Trans-Nzoia'
AND adm0_name = 'Kenya'
AND adm1_name = 'Rift Valley';

UPDATE site
SET title = 'Tenenkou'
WHERE title = 'Ténenkou'
AND adm0_name = 'Mali'
AND adm1_name = 'Mopti';

UPDATE site
SET title = 'Vilankulo'
WHERE title = 'Vilanculos'
AND adm0_name = 'Mozambique'
AND adm1_name = 'Inhambane';

UPDATE site
SET title = 'Wa'
WHERE title = 'Wa West'
AND adm0_name = 'Ghana'
AND adm1_name = 'Upper West';

UPDATE site
SET title = 'Wa'
WHERE title = 'Wa East'
AND adm0_name = 'Ghana'
AND adm1_name = 'Upper West';

UPDATE site
SET title = 'Wa'
WHERE title = 'Wa Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Upper West';

UPDATE site
SET title = 'Yendi'
WHERE title = 'Yendi Municipal'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Zabzugu/Tatale'
WHERE title = 'Zabzugu'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'West Gonja'
WHERE title = 'Central Gonja'
AND adm0_name = 'Ghana'
AND adm1_name = 'Northern';

UPDATE site
SET title = 'Fort Liberte'
WHERE title = 'Fort-Liberté'
AND adm0_name = 'Haiti'
AND adm1_name = 'Nord Est';

UPDATE site
SET title = 'Grande Riviere Du Nord'
WHERE title = 'Grande-Rivière du Nord'
AND adm0_name = 'Haiti'
AND adm1_name = 'Nord';

UPDATE site
SET title = 'Gonave'
WHERE title = 'La Gonâve'
AND adm0_name = 'Haiti'
AND adm1_name = 'Ouest';

UPDATE site
SET title = 'Leogane'
WHERE title = 'Léogâne'
AND adm0_name = 'Haiti'
AND adm1_name = 'Ouest';

UPDATE site
SET title = 'Port-Au-Prince'
WHERE title = 'Port-au-Prince'
AND adm0_name = 'Haiti'
AND adm1_name = 'Ouest';

UPDATE site
SET title = 'Acul Du Nord'
WHERE title = 'l''Acul-du-Nord'
AND adm0_name = 'Haiti'
AND adm1_name = 'Nord';

UPDATE site
SET title = 'Arcahaie'
WHERE title = 'l''Arcahaie'
AND adm0_name = 'Haiti'
AND adm1_name = 'Ouest';

UPDATE site
SET title = 'Cap Haitien'
WHERE title = 'le Cap-Haïtien'
AND adm0_name = 'Haiti'
AND adm1_name = 'Nord';

UPDATE site
SET title = 'Limbe'
WHERE title = 'le Limbé'
AND adm0_name = 'Haiti'
AND adm1_name = 'Nord';

UPDATE site
SET title = 'Ghozimalik'
WHERE title = 'Khuroson'
AND adm0_name = 'Tajikistan'
AND adm1_name = 'Khatlon';

UPDATE site
SET title = 'Kabodien'
WHERE title = 'Qabodiyon'
AND adm0_name = 'Tajikistan'
AND adm1_name = 'Khatlon';

UPDATE site
SET title = 'Kumsangirskiy'
WHERE title = 'Qumsangir'
AND adm0_name = 'Tajikistan'
AND adm1_name = 'Khatlon';

UPDATE site
SET title = 'Shaartuskiy'
WHERE title = 'Shahrituz'
AND adm0_name = 'Tajikistan'
AND adm1_name = 'Khatlon';

UPDATE site
SET title = 'Vahshskiy'
WHERE title = 'Vakhsh'
AND adm0_name = 'Tajikistan'
AND adm1_name = 'Khatlon';

UPDATE site
SET title = 'Angonia'
WHERE title = 'Angónia'
AND adm0_name = 'Mozambique'
AND adm1_name = 'Tete';

UPDATE site
SET title = 'Chokwe'
WHERE title = 'Chókwè'
AND adm0_name = 'Mozambique'
AND adm1_name = 'Gaza';

UPDATE site
SET title = 'Nacala-A-Velha'
WHERE title = 'Nacala Velha'
AND adm0_name = 'Mozambique'
AND adm1_name = 'Nampula';

UPDATE site
SET title = 'Vilankulo'
WHERE title = 'Vilanculos'
AND adm0_name = 'Mozambique'
AND adm1_name = 'Inhambane';


CREATE OR REPLACE FUNCTION FTFMS_GAUL_SITE_UPDATE() RETURNS boolean AS $$
DECLARE
    country RECORD;
    country_title character varying;

BEGIN

FOR country IN SELECT * FROM country LOOP

    country_title = country.title;

    UPDATE site
    SET geom = gaul_2014_adm2.geom FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
    and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
    and gaul_2014_adm2.adm0_name = country_title;


    UPDATE site
    SET geom_point = gaul_2014_adm2.geom_point FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
    and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
    and gaul_2014_adm2.adm0_name = country_title;


    UPDATE site
    SET adm2_code = gaul_2014_adm2.adm2_code FROM gaul_2014_adm2 WHERE gaul_2014_adm2.adm0_code = site.adm0_code
    and gaul_2014_adm2.adm1_code = site.adm1_code and site.title = gaul_2014_adm2.adm2_name
    and gaul_2014_adm2.adm0_name = country_title;

    END LOOP;
    RETURN true;
END;
$$ LANGUAGE plpgsql;


select * from FTFMS_GAUL_SITE_UPDATE();


-- CREATE view with all district and country data
CREATE VIEW country_district AS
SELECT district.district_id, district.title as district_title, c.country_id, c.code, c.title, c.description, c.image_path
FROM district
JOIN country c ON (district.country_id = c.country_id);


-- CREATE view with all site, district and country data
CREATE VIEW country_district_site AS
SELECT site.site_id, site.village_id, site.title as site_title, site.image_path as site_image_path, district.district_id, district.title as district_title, c.country_id, c.code, c.title, c.description, c.image_path
FROM site
JOIN district ON (district.district_id = site.district_id)
JOIN country c ON (district.country_id = c.country_id);


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

create view me_report_country as
select distinct country_id, report_id from report_location;

create view me_report_district as
select distinct district_id, report_id from report_location where district_id is not null;

create view me_report_site as
select distinct site_id, report_id from report_location where site_id is not null;

-- Get distinct list of indicators by adm0 code
CREATE VIEW me_report_indicator_country AS
SELECT distinct i.indicator_id, r.report_id, r.title as report_title, i.title as indicator_title, c.adm0_code
FROM report r, me_report_country rc,  report_indicator ri, indicator i, country c
where rc.country_id = c.country_id
and rc.report_id = r.report_id
and ri.report_id = r.report_id
and ri.indicator_id = i.indicator_id;

-- Get distinct list of indicators by adm1_code
CREATE VIEW me_report_indicator_district AS
SELECT i.indicator_id, r.report_id, r.title as report_title, i.title as indicator_title, d.adm1_code
FROM report r, me_report_district rd,  report_indicator ri, indicator i, district d
where rd.district_id = d.district_id
and rd.report_id = r.report_id
and ri.report_id = r.report_id
and ri.indicator_id = i.indicator_id;

--select distinct report_id, report_title, adm1_code from me_report_indicator_district where adm1_code in (select adm1_code from district where adm0_code = 94);

-- Get distinct list of indicators by adm2_code
CREATE VIEW me_report_indicator_site AS
SELECT i.indicator_id, r.report_id, r.title as report_title, i.title as indicator_title, s.adm2_code
FROM report r, me_report_site rs,  report_indicator ri, indicator i, site s
where rs.site_id = s.site_id
and rs.report_id = r.report_id
and ri.report_id = r.report_id
and ri.indicator_id = i.indicator_id;
