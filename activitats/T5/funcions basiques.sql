SELECT max(Population) AS maxim FROM country;
SELECT min(Population) AS minim FROM country;
SELECT avg(Population) AS mitja FROM country;
SELECT sum(Population) AS suma FROM country;
SELECT count(*) as comptar FROM country;

SELECT CountryCode as 'Codi de pais',
		count(*) as 'Num DE Ciutats',
		max(Population) as 'Població màxima',
		min(Population) as 'Població mínim',
		avg(Population) as 'Població mitjana',
		sum(Population) as 'Població total'
    FROM city
    WHERE Population > 1000
    GROUP BY CountryCode
    HAVING count(*) > 100
    ORDER BY count(*) DESC
    LIMIT 5;

