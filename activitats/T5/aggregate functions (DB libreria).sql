-- BBDD libreria

-- 1. Number of records in the table "libros".
SELECT count(*) AS records
	FROM libros;

-- 2. Number of books published by "Planeta".
SELECT sum(cantidad) AS 'editorial Planeta'
	FROM libros
    WHERE editorial = 'Planeta';

-- 3. Number of books of the writer "Borges" (also if he is coauthor).
SELECT count(*) AS 'books of "Borges"'
	FROM libros
	WHERE autor LIKE '%Borges%';

-- 4. Number of books that have a price.
SELECT count(*) AS 'books with price'
	FROM libros
    WHERE precio IS NOT NULL;

-- 5. Number of books we have available.
SELECT sum(cantidad) AS 'books available'
	FROM libros
    WHERE cantidad > 0;

-- 6. Price of the most expensive book.
SELECT max(precio) AS 'most expensive book'
	FROM libros;

-- 7. Query of books sorted by price in descending.
SELECT *
	FROM libros
    ORDER BY precio DESC;

-- 8. Cheaper price of the book of "Rowling".
SELECT min(precio) AS 'Cheaper book of JK Rowling'
	FROM libros
    WHERE autor LIKE 'J.K. Rowling';

-- 9. Query of books of "Rowling" sorted by price in ascending.
SELECT *
	FROM libros
    WHERE autor LIKE 'J.K. Rowling'
    ORDER BY precio ASC;

-- 10. Average price of books on "PHP".
SELECT avg(precio) AS 'Average price'
	FROM libros
    WHERE titulo LIKE '%PHP%';

-- 11. Number of books published by every editorial.
SELECT editorial, count(*) AS 'Number of books'
	FROM libros
    GROUP BY editorial;

-- 12. Number of books published by editorials that have more than 2 books.
SELECT editorial, count(*) AS 'Number of books'
	FROM libros
    GROUP BY editorial
	HAVING count(*) > 2;

-- 13. Price average of books published by every editorial.
SELECT editorial, avg(precio) AS 'Average price'
	FROM libros
	GROUP BY editorial;

-- 14. Price average of the books published by every editorial whose average is greater than 25 euros.
SELECT editorial, avg(precio) AS 'Average price'
	FROM libros
    GROUP BY editorial
	HAVING avg(precio) > 25;

-- 15. Number of books published by every editorial except from “Planeta” (2 different SQL commands)
-- WHERE
SELECT editorial, count(*) AS 'Number of books'
	FROM libros
    WHERE editorial != 'Planeta'
    GROUP BY editorial;

-- HAVING
SELECT editorial, count(*) AS 'Number of books'
	FROM libros
    GROUP BY editorial
    HAVING editorial != 'Planeta';

-- 16. Number of books published by every editorial except from “Planeta” and without counting those books with no price.
SELECT editorial, count(*) AS 'Number of books'
	FROM libros
    WHERE editorial != 'Planeta'
		AND precio IS NOT NULL
    GROUP BY editorial;

-- 17. Price average of books published by the editorials with more than 2 books.
SELECT editorial, avg(precio) AS 'Average price'
	FROM libros
    GROUP BY editorial
	HAVING count(*) > 2;

-- 18. Price of the most expensive book published by every editorial (only books of 30 or more euros).
SELECT editorial, max(precio) AS 'most expensive book'
	FROM libros
    WHERE precio >= 30
    GROUP BY editorial;
    