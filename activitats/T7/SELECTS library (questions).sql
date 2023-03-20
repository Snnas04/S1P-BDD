USE library;

-- 1. List of members cities (no duplicates)
select distinct CITY
from MEMBERS;

-- 2. Name and surname of all the members who live in Manacor or Felanitx
select NAME, SURNAMES
from MEMBERS
where CITY = 'Manacor' or CITY = 'Felanitx';

-- 3. Name and surname of all the members who live in Manacor and they have been registered before 01/01/2009
select NAME, SURNAMES
from MEMBERS
where CITY = 'Manacor' and ENTRY_DATE < '2009-01-01';

-- 4. Name and surname of all the members who live in Manacor sorted by surname and then by name (if they the same surname you must sort by name)
select NAME, SURNAMES
from MEMBERS
where CITY = 'Manacor'
order by SURNAMES, NAME;

-- 5. Name and surname of all members with a code between 10 and 20
select NAME, SURNAMES
from MEMBERS
where MEMBER_CODE between 10 and 20;

-- 6. Title of the books that we do not know their publisher.
select TITLE
from BOOKS
where PUBLISHER_CODE is null;

-- 7. Name and surname of all Manacor members who do not know their telephone number.
select NAME, SURNAMES
from MEMBERS
where CITY = 'Manacor' and PHONE is null;

-- 8. Retrieve the copy number and member code of all borrows made in 2012 and which have not yet been returned.
select COPY_CODE, MEMBER_CODE
from BORROWS
where year(BORROW_DATE) = 2012 and RETURN_DATE is null;

-- 9. Title of books containing the word 'TIERRA' or the word 'FUEGO'.
select TITLE
from BOOKS
where TITLE like "%TIERRA%" or TITLE like "%FUEGO%";

-- 10. Title of books that contain the word 'TIERRA' and do not contain the word 'PILARES'.
select TITLE
from BOOKS
where TITLE like "%TIERRA%" and TITLE not like "%PILARES%";

-- 11. Publishers that have a state, but not the city.
select NAME
from PUBLISHERS
where STATE is not null and CITY is null;

-- 12. Loans that have been returned late.
select COPY_CODE
from BORROWS
where RETURN_DATE > DEAD_DATE;

-- 13. Return the number of Manacor members.
select count(*) as mancaroMembers
from MEMBERS
where CITY like 'Manacor';

-- 14. Return the number of loans made by the member with code 1.
select count(BORROW_DATE) as 'number of loans'
from BORROWS
where MEMBER_CODE = 1;

-- 15. Return the highest member code and his/her full name (with the format 'surnames, name'). Give an alias for the fullname.
select max(MEMBER_CODE) as member_code, concat(SURNAMES, NAME) as fullname
from MEMBERS
group by fullname
order by member_code desc
limit 1;

select member_code, concat(SURNAMES,', ', NAME) as fullname
from MEMBERS
where member_code=(select max(member_code) from MEMBERS);

-- 16. Return the day we registered the oldest member (does not have to be the number 1 member)
select min(ENTRY_DATE)
from MEMBERS;

-- 17. Returns the average number of editions of all books in the database.
select avg(EDITION_NUM) as 'average number'
from BOOKS;

-- 18. Retrieves the number of days of the longest loan in 2011.
select max(timestampdiff(day, BORROW_DATE, RETURN_DATE)) as days
from BORROWS
where year(BORROW_DATE) = 2011
	and RETURN_DATE is not null;
    
select max(timestampdiff(day, BORROW_DATE, RETURN_DATE)) as days
from BORROWS
where year(BORROW_DATE) = 2011
	and year(RETURN_DATE) = 2011;

-- 19. Average number of days that each book has been borrowed (don't take in account some mistakes on dates as 0000-00-00 00:00:00 or when return date is before borrow date)
select avg(timestampdiff(day, BORROW_DATE, RETURN_DATE)) as days
from BORROWS
where RETURN_DATE is not null
    and
	BORROW_DATE < RETURN_DATE;

-- 20. Names and surnames of the members who live in Manacor or Son Servera and who were registered in 2011.
select NAME, SURNAMES
from MEMBERS
where CITY in ('Manacor', 'Son Servera')
	and
    year(ENTRY_DATE) = 2011;

-- 21. Title, full name of the author and name of the publisher of all books (2 solutions)
select title,
	(select concat(name," ", surnames) as 'Full name' 
		from AUTHORS  
        where author_code =b.author_code) as "author fullname",
	(select NAME 
		from PUBLISHERS 
        where PUBLISHER_CODE = b.PUBLISHER_CODE) as "publisher name"
from BOOKS as b;

select title, concat(a.name," ", a.surnames)  as  "author fullname",
	p.name as "publisher name" 
from BOOKS as b
left join AUTHORS as a on (a.author_code =b.author_code)
left join PUBLISHERS as p on ( p.PUBLISHER_CODE =b.PUBLISHER_CODE);

-- 22. Title, full name of the author and publisher name of all books written in the language 'CA' (2 solutions)
select title,
	(select concat(name," ", surnames) as 'Full name' 
		from AUTHORS  
        where author_code =b.author_code) as "author fullname",
	(select NAME 
		from PUBLISHERS
        where PUBLISHER_CODE = b.PUBLISHER_CODE) as "publisher name"
from BOOKS as b
where LANGUAGE = "CA";

select title, concat(a.name," ", a.surnames)  as  "author fullname",
	p.name as "publisher name" 
from BOOKS as b
left join AUTHORS as a on (a.author_code =b.author_code)
left join PUBLISHERS as p on ( p.PUBLISHER_CODE =b.PUBLISHER_CODE)
where LANGUAGE = "CA";

-- 23. Members (name and surnames) who are from Manacor and have made some loans.
select concat(NAME, " ", SURNAMES)
from MEMBERS
where CITY = 'Manacor'
	and
    MEMBER_CODE in (select MEMBER_CODE from BORROWS);

-- 24. Members (name and surnames) who have books on loan today.
select distinct concat(NAME, " ", SURNAMES)
from MEMBERS
join BORROWS using(MEMBER_CODE)
where RETURN_DATE is null;

-- 25. Title of all books borrowed by member number 1.
select TITLE
from BOOKS
join COPIES using(BOOK_CODE)
join BORROWS using(COPY_CODE)
where MEMBER_CODE = 1;

-- 26. Name of the publishers who have published some HISTORY book.
Select p.NAME
from PUBLISHERS as p
join BOOKS as b on p.PUBLISHER_CODE = b.PUBLISHER_CODE
join GENREBOOK as g on b.BOOK_CODE = g.BOOK_CODE
join GENRES as g2 on g.GENRE_CODE = g2.GENRE_CODE
where g2.NAME = "HISTORIA";

-- 27. Full name of the authors who have written a book published by PLANETA (2 solutions)
SELECT DISTINCT CONCAT(a.name, ' ', a.surnames) AS full_name
FROM AUTHORS as a
JOIN BOOKS as b ON a.author_code = b.author_code
JOIN PUBLISHERS as p ON b.publisher_code = p.publisher_code
WHERE p.name = 'PLANETA';

SELECT DISTINCT CONCAT(a.name, ' ', a.surnames) AS full_name
FROM AUTHORS as a
WHERE a.author_code IN (
  SELECT b.author_code
  FROM BOOKS as b 
  WHERE b.publisher_code IN (
    SELECT publisher_code
    FROM PUBLISHERS as p
    WHERE name = 'PLANETA')
);

-- 28. Names of authors different from NOAH GORDON who have written some HISTORIA books (2 solutions)
SELECT NAME
FROM AUTHORS
WHERE AUTHOR_CODE in (SELECT AUTHOR_CODE
		FROM BOOKS as B
		JOIN GENREBOOK as GB on B.BOOK_CODE = GB.BOOK_CODE
		JOIN GENRES as G on G.GENRE_CODE = GB.GENRE_CODE
		WHERE CONCAT(AUTHORS.NAME, ' ', AUTHORS.SURNAMES) != 'NOAH GORDON'
    AND G.NAME = 'HISTORIA');
    
select a.name
from AUTHORS as a
join BOOKS as b using (author_code)
join GENREBOOK as gb on gb.book_code = b.book_code
join GENRES as gen on gen.genre_code = gb.genre_code
where gen.name = 'Historia' and a.name != 'Noah';

-- 29. Full name of the members living in the same city as the member 1
select concat(name, " ", surnames)  as  "fullname"
from MEMBERS 
where city = (select city 
			from MEMBERS 
			where MEMBER_CODE=1);

-- 30. Title of all books published by the same publisher as the book "EL MEDICO"
SELECT b.TITLE
FROM BOOKS b
JOIN PUBLISHERS p ON b.PUBLISHER_CODE = p.PUBLISHER_CODE
WHERE p.NAME = (
  SELECT p1.NAME
  FROM BOOKS b1
  JOIN PUBLISHERS p1 ON b1.PUBLISHER_CODE = p1.PUBLISHER_CODE
  WHERE b1.TITLE = 'EL MEDICO'
);

-- 31. Title of all the books written by the same author as the book "EL MEDICO".
select TITLE
from BOOKS
where (select AUTHOR_CODE from AUTHORS where AUTHOR_CODE = BOOKS.AUTHOR_CODE)
and TITLE = 'EL MEDICO';

-- 32. Title of all the books that belong to any of the genres to which the book "EL MEDICO" belongs.
SELECT B.TITLE
FROM GENREBOOK G
    JOIN BOOKS B ON G.BOOK_CODE = B.BOOK_CODE AND
                    G.GENRE_CODE IN
                        (SELECT GENRE_CODE
                        FROM GENREBOOK G
                        JOIN BOOKS B ON G.BOOK_CODE = B.BOOK_CODE
                        WHERE TITLE = 'EL MEDICO'
                        );

-- 33. Returns how many books have been published by the same publisher as "EL MEDICO".
SELECT COUNT(*)
FROM BOOKS
WHERE PUBLISHER_CODE = (SELECT PUBLISHER_CODE FROM BOOKS WHERE TITLE = 'EL MEDICO');

-- 34. Returns the total number of loans made in 2011 and the total number of loans returned in the same year.
SELECT  COUNT(*) as 'Borrows of 2011'
FROM BORROWS
WHERE YEAR(BORROW_DATE) = 2011 AND YEAR(RETURN_DATE) = 2011;

SELECT  COUNT(*) as 'Borrows of 2011'
FROM BORROWS
WHERE YEAR(BORROW_DATE) = 2011;

SELECT (SELECT  COUNT(*) as 'Borrows of 2011'
    FROM BORROWS
    WHERE YEAR(BORROW_DATE) = 2011) as '2011 Borrows',
    (SELECT  COUNT(*) as 'Borrows of 2011'
FROM BORROWS
WHERE YEAR(BORROW_DATE) = 2011 AND YEAR(RETURN_DATE) = 2011) as 'Returned same Year';

-- 35. Returns how many books each author wrote (answer format: name surname number, noha gordon 5, ...)
SELECT A.NAME, COUNT(*)
FROM AUTHORS A
JOIN BOOKS B ON A.AUTHOR_CODE = B.AUTHOR_CODE
GROUP BY A.NAME;

SELECT CONCAT(A.NAME, ' ',SURNAMES, ' ', A.AUTHOR_CODE ) as author, COUNT(*)
FROM BOOKS
RIGHT JOIN AUTHORS A ON BOOKS.AUTHOR_CODE = A.AUTHOR_CODE
GROUP BY author;

-- 36. Return how many copies there are in total for each book (answer format: title total, PROGAMACION EN COBOL 3, ...)
SELECT TITLE, COUNT(*)
FROM BOOKS
LEFT JOIN COPIES C ON BOOKS.BOOK_CODE = C.BOOK_CODE
GROUP BY  TITLE;

-- 37. Return the average number of copies per book.
-- afegim left join per els llibres que no tenen copies, per això el count es de book_code i no de *
select avg(ncopies) from (
select count(c.BOOK_CODE) as 'ncopies'
from BOOKS as b
left join COPIES as c on c.BOOK_CODE = b.BOOK_CODE
group by b.BOOK_CODE
) as taula;

SELECT AVG(
	(SELECT COUNT(*) 
    FROM COPIES 
    WHERE COPIES.BOOK_CODE = OTHER.BOOK_CODE)
    ) as AVGcopys
FROM BOOKS OTHER;

-- 38. Returns how many books there are in each genre (output format: genre total, HISTORIA 25, ...)
select concat(gen.name, " - ", count(book_code)) as 'Books per genre'
from BOOKS as b
join GENREBOOK as gn using(book_code)
join GENRES as gen on gen.genre_code = gn.genre_code
group by gen.name;

select g.name, count(gb.book_code)
from GENREBOOK as gb
join GENRES as g using (genre_code)
group by g.name;

-- 39. Return how many loans each member has made in total (output format: name surnames total, toni mesquida 7, ...)
select concat(m.name, ", ",m.surnames, " - ", count(b.member_code)) as 'Loans'
from BORROWS as b
join  MEMBERS as m on (b.member_code = m.member_code)
group by b.MEMBER_CODE;

-- 40. Return, for each member, the number of books he has borrowed.
select m.name,m.surnames, count(distinct BOOK_CODE)
from BORROWS as b
join COPIES as c on b.COPY_CODE = c.COPY_CODE
join  MEMBERS as m on (b.member_code = m.member_code)
group by b.MEMBER_CODE;

-- 41. List of members that have made more than 5 loans.
select m.name,m.surnames, count(distinct BOOK_CODE)
from BORROWS as b
join COPIES as c on b.COPY_CODE = c.COPY_CODE
join  MEMBERS as m on (b.member_code = m.member_code)
group by b.MEMBER_CODE
having count(b.COPY_CODE) > 5;

-- 42. List of members who currently have more than one book on loan.
SELECT m.NAME, m.SURNAMES, COUNT(*) as total_loans
FROM BORROWS as b
JOIN MEMBERS as m ON b.MEMBER_CODE = m.MEMBER_CODE
WHERE b.RETURN_DATE IS NULL
GROUP BY m.MEMBER_CODE
HAVING total_loans > 1;

-- 43. For the book "El medico", return the total number of copies, number of copies currently on loan and number of available copies (output format: title number_of_copies on_loan available, the doctor 5 3 2)
SELECT
	(SELECT COUNT(*)
	FROM BOOKS
	JOIN COPIES as C ON BOOKS.BOOK_CODE = C.BOOK_CODE
	WHERE TITLE = 'El medico') as 'TOTAL COPYS',

	(SELECT COUNT(*)
	FROM BOOKS
	JOIN COPIES as C ON BOOKS.BOOK_CODE = C.BOOK_CODE
	JOIN BORROWS as B ON C.COPY_CODE = B.COPY_CODE
	WHERE TITLE = 'El medico' AND RETURN_DATE IS NULL) AS 'NOT AVIABLE',

	(SELECT COUNT(*)
	FROM BOOKS
	JOIN COPIES as C ON BOOKS.BOOK_CODE = C.BOOK_CODE
	JOIN BORROWS as B ON C.COPY_CODE = B.COPY_CODE
	WHERE TITLE = 'El medico' AND C.COPY_CODE NOT IN (SELECT COPY_CODE
	FROM BORROWS
	WHERE RETURN_DATE IS NULL)) AS 'AVIABLE';

-- 44. Retrieves the number of books in the library, the number of copies, and the average number of copies per book.


-- 45. Number of different books each member has borrowed.


-- 46. Returns the number of members of whom we do not know their telephone.


-- 47. Retrieve the copy code and member code for all loans made this year that either have been returned out of date, or have not yet been returned and are already out of date.


-- 48. Number of copies of each book published by "Planeta". The title, language, author and number of copies of the book must be retrieved, sorted by number of copies and author.


-- 49. Retrieve code from books that belong to more than one genre.


-- 50. Title of books left on loan in 2011.


-- 51. Total number of loans made by members who have taken a book during 2011.


-- 52. List of members that have not made any loans during 2011.


-- 53. List of loans (all fields) made in February 2011.


-- 54. List of loans (all fields) longer than 15 days.


-- 55. List of members (all fields) who were registered in the same month as the number 1 member.


-- 56. Title of the book with more editions.


-- 57. Name and surname of the members who have a book not returned.


-- 58. Returns the title of books written by authors who have authored more than 2 books.


-- 59. Name and surname of the member who made the most loans.


-- 60. For each book by the author 'FOLLETT' recover the number of loans and the average number of days that have been on loan. Books that are on loan and have not yet been returned we will consider the return date as 31/12/2013.


-- 61. What is the book we have the most copies?


-- 62. Number of members who have not borrowed a book for more than 9 years.


-- 63. Amount of loans made by the members according to the number of years they have been registered (answer format: years number_of_loans, 20 (years) 20 (loans)


-- 64. All books whose title contains the word 'tiempo' that are available.


-- 65. Details of the members (all fields) who have borrowed more than 2 times the same book.


-- 66. Data of the loans that have been returned 20 days or more, later than the dead date or that have not been returned and have passed more than 20 days of the dead date (output format: [surnames, names]-of-member book-title borrow-date return-date dead-date delay-days)


-- 67. Name and surname of the oldest member of the library.


-- 68. Code of the members who in 2010 borrowed some of the books written by 'Gordon'.


-- 69. Retrieve all books (only title) on the subject "HISTORIA" showing their number of loans.


-- 70. Which is the most requested book for each year, that is, borrowed more times.



























