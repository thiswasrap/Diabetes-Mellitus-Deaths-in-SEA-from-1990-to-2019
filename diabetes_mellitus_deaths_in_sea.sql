-- select the specific causes of deaths (Diabetes Mellitus)
select country, code, year, diabetes_mellitus from cause_of_deaths
order by 1,2

alter table cause_of_deaths change diabetes_melitius diabetes_mellitus int(10);
-- create new table for asean country
CREATE TABLE asean_country AS
SELECT country, code, year, diabetes_mellitus
FROM cause_of_deaths
WHERE country IN ('Brunei', 'Cambodia', 'Indonesia', 'Laos', 'Malaysia', 'Myanmar', 'Philippines', 'Singapore', 'Thailand', 'Vietnam');

-- show all the countries in asean
select min(year), country from asean_country
group by country

-- average deaths on every country
select country, avg(asean_country.diabetes_mellitus) as brunei_avg_death
    from asean_country
        where country = 'Brunei';

-- create the column for every country average deaths
alter table asean_country
add column brunei_avg_death float;

update asean_country
set ``.asean_country.brunei_avg_death = (
    select avg(diabetes_mellitus)
    from asean_country
    where country = 'Brunei'
    )
    where country = 'Brunei';

-- country average death
alter table asean_country
add column country_avg_death float;

update asean_country as ac
set country_avg_death = (
    select avg(cd.diabetes_mellitus)
    from asean_country as cd
    where cd.country = ac.country
    )
where ac.country in ('Brunei', 'Cambodia', 'Indonesia', 'Laos', 'Malaysia', 'Myanmar', 'Philippines', 'Singapore', 'Thailand', 'Vietnam');

-- asean average death
alter table asean_country
add column asean_avg_death float;

update asean_country as ac
set asean_avg_death = (
    select avg(cd.diabetes_mellitus)
    from asean_country as cd
    where cd.country in ('Brunei', 'Cambodia', 'Indonesia', 'Laos', 'Malaysia', 'Myanmar', 'Philippines', 'Singapore', 'Thailand', 'Vietnam')
);

create table total_death_per_country (
    country varchar(255),
    total_death float,
    primary key (country)
);

insert into total_death_per_country (country, total_death)
select country, sum(diabetes_mellitus) as total_death
from asean_country
where year between 1990 and 2019
group by country;


select sum(diabetes_mellitus) as total_diabetes_deaths
from asean_country
where country = 'Indonesia';