-- adding extra columns to the country table to include geometry and gaul ids
ALTER TABLE country
ADD column geom geometry;

ALTER TABLE country
ADD column geom_point geometry;

ALTER TABLE country
ADD column adm0_code integer;

-- updating the country table with new gaul data
update country
set geom = gaul_2014_adm0.geom
from gaul_2014_adm0
where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ethiopia';

update country
set geom_point = gaul_2014_adm0.geom_point
from gaul_2014_adm0
where country.title = gaul_2014_adm0.adm0_name
and country.title = 'Ethiopia';

update country
set adm0_code = 79 -- this is what Ethiopia is set to in the district table
where country.title = 'Ethiopia';


-- adding extra columns to the district table to include geometry and gaul ids
ALTER TABLE district
ADD column geom geometry;

ALTER TABLE district
ADD column geom_point geometry;

ALTER TABLE district
ADD column adm1_code integer;

ALTER TABLE district
ADD column adm0_code integer;


-- updating the district names to match gaul names
update district
SET title = 'SNNPR'
WHERE title = 'Southern Nations, Nationalities and Peoples';


-- updating the district table with new gaul data
update district
set geom = gaul_2014_adm1.geom
from gaul_2014_adm1
where district.title = gaul_2014_adm1.adm1_name
and adm0_name = 'Ethiopia';

update district
set geom_point = gaul_2014_adm1.geom_point
from gaul_2014_adm1
where district.title = gaul_2014_adm1.adm1_name
and adm0_name = 'Ethiopia';

update district
set adm1_code = gaul_2014_adm1.adm1_code
from gaul_2014_adm1
where district.title = gaul_2014_adm1.adm1_name
and adm0_name = 'Ethiopia';

update district
set adm0_code = gaul_2014_adm1.adm0_code
from gaul_2014_adm1
where district.title = gaul_2014_adm1.adm1_name
and adm0_name = 'Ethiopia';

