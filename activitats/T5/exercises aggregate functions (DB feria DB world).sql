-- BBDD feria
-- 1. Number of visitors to the stand.
select count(*) 
from visitantes;

-- 2. Number of visitors who have telephone.
select count(telefono) 
from visitantes;

select count(*) 
from visitantes 
where telefono is not null;

-- 3. Number of male visitors who came to the stand.
select count(*)
from visitantes
where sexo = 'm';

-- 4. Number of women over 25 years old who visited the stand.
select count(*)
from visitantes
where sexo = 'f' and edad > 25;

-- 5. Number of visitors who are not from "Cordoba".
select count(*)
from visitantes
where ciudad != 'Cordoba';

-- 6. Number of visitors who made a purchase.
select count(*)
from visitantes
where montocompra > 0;

-- 7. Number of visitors who didn't make purchases.
select count(*)
from visitantes
where montocompra <= 0;

-- 8. How much have spent visitors from "Alta Gracia"?
select sum(montocompra)
from visitantes
where ciudad = 'Alta Gracia';

-- 9. Amount of the most expensive purchase.
select max(montocompra)
from visitantes;

-- 10. Age of the youngest visitor.
select min(edad)
from visitantes;

-- 11. Average age of visitors.
select avg(edad)
from visitantes;

-- 12. Average price of purchases.
select avg(montocompra)
from visitantes;

-- 13. Number of visitors from each city.
select ciudad, count(*) 
from visitantes 
group by ciudad;

-- 14. Number of visitors without telephone from each city.
select ciudad, count(*)
from visitantes 
where telefono is null
group by ciudad;

-- 15. Total purchases grouped by sex.
select sexo, sum(montocompra)
from visitantes
group by sexo;

-- 16. The most expensive and the cheapest purchase of every sex.
select sexo, max(montocompra), min(montocompra)
from visitantes
group by sexo;

-- 17. Try to join the two previous sentences in one.
select sexo, max(montocompra), min(montocompra), sum(montocompra)
from visitantes
group by sexo;

-- 18. Average amount of purchases from every city.
select count(*)
from visitantes
group by ciudad;

-- 19. Number of visitors from every city classified by sex.
select sexo, ciudad, count(*)
from visitantes
group by sexo, ciudad;

-- 20. Number of visitors from each city except Cordoba.
select ciudad, count(*)
from visitantes
where ciudad != 'Cordoba'
group by ciudad;

-- 21. Number of visitors from each city sorted by city in descending.
select ciudad, count(*)
from visitantes
group by ciudad
order by ciudad desc;

-- 22. Add one more visitor
insert into visitantes 
values ('Marc Sans', 18, 'm', 'MyHouse', 'Sencelles', 666888222, 0.00);

-- 23. Capitalize city name but only from visitors without telephone
update visitantes
set ciudad = ucase(ciudad)
where telefono is null;
    
-- 24. Number of visitors from each city but only those cities with more than 2 visitors
select ciudad, count(*)
from visitantes
group by ciudad
having count(*) > 2;

-- 25. Remove visitors without any purchase
delete from visitantes
where montocompra <= 0;


use world;

-- 1. Number of countries of every continent
select Continent, count(*)
from country
group by Continent;

-- 2. List of cities ordered by country and population in descending order
select DISTINCT *
from city
order BY Population and Name desc;

-- 3. List of cities with the letter W in its name
select Name
from city
where name like '%w%';

-- 4. List of cities with more than 100000 inhabitants and less than 200000 inhabitants (two ways)
select name
from city
where `Population` > 100000 and `Population` < 200000;

-- 5. List of cities from ESP, FRA and USA.
SELECT * 
from city 
where CountryCode REGEXP "ESP|FRA|USA";

SELECT * 
from city 
where CountryCode in ('ESP','FRA','USA');

-- 6. Which city names are repeated
select Name, count(*) as Amount
from city
group by Name
having count(*) not like 1;

