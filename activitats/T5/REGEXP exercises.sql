use libreria;
-- 1) Book titles containing "Ma".
SELECT DISTINCT titulo 
	FROM libros
    WHERE titulo REGEXP 'Ma';

-- 2) Authors that have at least one "h" or one "k" or una "w" in his/her name.
SELECT autor
	FROM libros
    WHERE autor REGEXP '(h|k|w)';

-- 3) Authors that don't have any "h" nor "k" nor "w" in his/her name.
SELECT autor
	FROM libros
    WHERE autor NOT REGEXP '(h|k|w)';
    
-- 4) Authors that have at least one letter from "a" to "d", that is, a, b, c or d.
SELECT autor
	FROM libros
    WHERE autor REGEXP '[a-d]';

-- 5) Titles that begin with "A".
SELECT titulo
	FROM libros
    WHERE titulo REGEXP '^A';

-- 6) Titles that end with "HP".
SELECT titulo
	FROM libros
    WHERE titulo REGEXP 'HP$';
    
-- 7) Titles containing an "a", then any letter and then an "e".
SELECT DISTINCT titulo
	FROM libros
    WHERE titulo REGEXP 'a.e';

-- 8) Titles containing an "a", then two letters and then an "e".
SELECT DISTINCT titulo
	FROM libros
    WHERE titulo REGEXP 'a..e';
    
-- 9) 13-letter titles.
SELECT DISTINCT titulo
	FROM libros
    WHERE titulo REGEXP '^.{13}$';
    
-- 10) 30 or more letters titles.
SELECT DISTINCT titulo, char_length(titulo)
	FROM libros
    WHERE titulo REGEXP '.{30}';

use world;

-- 11) City names that have 7 consonants in a row
SELECT Name
	FROM city
	WHERE Name REGEXP '[b-df-hj-np-tv-z]{7}';

-- 12) City names that have no vowels
SELECT Name
	FROM city
	WHERE Name REGEXP '^[b-df-hj-np-tv-z]+$';
    
SELECT Name
FROM city
WHERE Name NOT REGEXP 'a|e|i|o|u';

-- 13) City names that have 2 vowels repeated on a row
SELECT DISTINCT `Name` 
	FROM world.city
    WHERE `Name` REGEXP "a{2}|e{2}|i{2}|o{2}|u{2}";
    
SELECT DISTINCT `Name`
	FROM world.city
    WHERE `Name` REGEXP "(aa)|(ee)|(ii)|(oo)|(uu)";
