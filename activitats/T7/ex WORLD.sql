USE world;

-- 1. Select identifier, name and population from only 10 records of cities. Order the data by population from the most populated to the least populated city
SELECT ID, Name, Population
FROM city
ORDER BY Population DESC
LIMIT 10;

-- 2. The same as in 1, but now only rows from 16 to 20.
SELECT ID, Name, Population
FROM city
ORDER BY Population DESC
LIMIT 15, 5;

-- 3. Number of cities
SELECT COUNT(*) AS "Number of cities"
FROM city;

-- 4. Show name and population from the most populated city in the table.
SELECT Name, Population
FROM city
ORDER BY Population DESC
LIMIT 1;

SELECT Name, Population
FROM city
WHERE Population = (SELECT MAX(Population) FROM city);

-- 5. Show name and population from the least populated city in the table.
SELECT Name, Population
FROM city
ORDER BY Population ASC
LIMIT 1;

SELECT Name, Population
FROM city
WHERE Population = (SELECT MIN(Population) FROM city);

-- 6. Show name and population from the most and the least populated cities in the table.
SELECT Name, Population
FROM city
WHERE Population = (SELECT MAX(Population) FROM city)
    OR Population = (SELECT MIN(Population) FROM city);


SELECT Name, Population
FROM city
WHERE Population IN (
	(SELECT MAX(Population) FROM city), 
    (SELECT MIN(Population) FROM city)
);

SELECT Name, Population
FROM city
WHERE Population = (SELECT MAX(Population) FROM city)
UNION
SELECT Name, Population
FROM city
WHERE Population = (SELECT MIN(Population) FROM city);

-- 7. All cities (name and population) with a population above one million people.
SELECT Name, Population
FROM city
WHERE Population > 1000000;

-- 8. Select all city names which begin with Kal.
SELECT Name
FROM city
WHERE Name LIKE 'Kal%';

-- 9. Select all columns for one specific city, namely Bratislava.
SELECT *
FROM city
WHERE Name = 'Bratislava';

-- 10. Find out cities with a population between 670000 and 700000.
SELECT Name, Population
FROM city
WHERE Population BETWEEN 670000 AND 700000;

-- 11. Returns the total number of people in the towns of the New York district.
SELECT SUM(Population) AS "Total population"
FROM city
WHERE District = 'New York';

-- 12. Select every district from USA with its total number of people.
SELECT District, SUM(Population) AS "Total population"
FROM city
WHERE CountryCode = 'USA'
GROUP BY District;

SELECT District, SUM(ci.Population) AS "Total population"
FROM city AS ci
JOIN country AS co ON ci.CountryCode = co.Code
WHERE co.Name = 'United States'
GROUP BY District;

-- 13. Select all districts from USA which have population over 3 million people
SELECT District, SUM(Population) AS "Total population"
FROM city
WHERE CountryCode = 'USA'
GROUP BY District
HAVING SUM(Population) > 3000000;

-- 14. Show the number of countries and the average population per continent:
SELECT continent, COUNT(Code), AVG(Population)
FROM country
GROUP BY continent;

-- 15. Select all country names that doesn't have any city.
SELECT Name
FROM country
WHERE Code NOT IN (SELECT DISTINCT CountryCode FROM city);

-- 16. Select all country names with its number of cities (two ways: subquery and join).
SELECT Name, 
    (SELECT COUNT(*) 
    FROM city 
    WHERE CountryCode = Code) as 'Number of city'
FROM country;

SELECT co.Name, COUNT(*) as 'Numbre of city'
FROM country as co
LEFT JOIN city as ci ON ci.`CountryCode`  = co.`Code`
GROUP BY co.`Name`;

-- 17. Select all country names with its capital name (two ways: subquery and join).
SELECT name, (SELECT name FROM world.city WHERE ID = Capital) as capital
FROM world.country;

SELECT co.name as country, ci.name as city
FROM world.country as co
LEFT JOIN world.city as ci ON ci.ID = co.capital;

-- 18. Select repeated cities names and the number of repetitio


-- 19. Select language (with country code in brackets) from all countries in Europe (two ways: subquery and join).
SELECT CONCAT(language, " (", CountryCode, ")") as languatges
FROM world.countrylanguage as cl
JOIN world.country as co ON cl.CountryCode = co.code
WHERE continent = 'Europe';

SELECT CONCAT(language, " (", CountryCode, ")") as languatges
FROM world.countrylanguage as cl
WHERE (SELECT continent FROM country WHERE code = cl.countrycode) = 'Europe';

-- 20. Select language and country name from all countries in Europe (two ways: subquery and join).
SELECT CONCAT(language, " (", co.Name, ")") as languatges
FROM world.countrylanguage as cl
JOIN world.country as co ON cl.CountryCode = co.code
WHERE continent = 'Europe';

SELECT CONCAT(language, " (", (SELECT Name FROM world.country WHERE Code = CountryCode), ")") as languatges
FROM world.countrylanguage as cl
WHERE (SELECT continent FROM country as co WHERE code = cl.countrycode) = 'Europe';

-- 21. Select country name, life expectancy, continent, area and population from the country with the highest and lowest life expectancy
SELECT Name, LifeExpectancy, Continent, SurfaceArea, Population 
FROM country WHERE LifeExpectancy IN (
	(SELECT MAX(LifeExpectancy) FROM country),
    (SELECT MIN(LifeExpectancy) FROM country)
);

-- 22. Select the average population from all countries
select avg(population) from country;

-- 23. Select name, continent and population from countries with a population lower than the average population from all countries 
SELECT Name, Continent, Population
FROM country
WHERE Population < (SELECT AVG(Population) FROM country);

-- 24. Select the total area from every continent
SELECT Continent, sum(SurfaceArea) as "Superficie" FROM country GROUP BY continent;

-- 25. Select the number of countries for every different government form (ordered from the most common government form to the least common one)
SELECT GovernmentForm, COUNT(*) AS times
FROM country
GROUP BY GovernmentForm
ORDER BY times DESC;

-- 26. What is the most common government form? (Build a query to answer this question)
SELECT  GovernmentForm, COUNT(*) AS 'number' 
FROM country 
GROUP BY GovernmentForm 
ORDER BY number DESC
LIMIT 1;

SELECT GovernmentForm
FROM country
GROUP BY GovernmentForm
HAVING COUNT(*) = (    SELECT COUNT()
    FROM country
    GROUP BY GovernmentForm
    ORDER BY COUNT(*) DESC
    LIMIT 1);












