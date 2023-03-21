USE library;

-- (1) List of members cities (no duplicates)
select distinct city from MEMBERS; -- 25
SELECT CITY FROM MEMBERS GROUP BY CITY;

-- (2) Name and surname of all the members who live in Manacor or Felanitx
select NAME,SURNAMES from MEMBERS where CITY = 'Manacor' or CITY = 'Felanitx'; -- 35
select NAME,SURNAMES from MEMBERS where CITY in ('Manacor','Felanitx');

-- (3) Name and surname of all the members who live in Manacor and they have been registered before 01/01/2009
select NAME,SURNAMES,ENTRY_DATE from MEMBERS where CITY = 'MANACOR' and ENTRY_DATE < '2009-01-01'; -- 2

-- (4) Name and surname of all the members who live in Manacor sorted by surname and then by name (if they have the same surname you must sort by name)
select NAME,SURNAMES from MEMBERS where CITY = 'Manacor' order by SURNAMES,NAME; -- 25

-- (5) Name and surname of all members with a code between 10 and 20
select NAME,SURNAMES,MEMBER_CODE from MEMBERS where MEMBER_CODE between 10 and 20; -- 11

-- (6) Title of the books that we do not know their publisher.
select TITLE from BOOKS where PUBLISHER_CODE is null; -- 8

-- (7) Name and surname of all Manacor members who do not know their telephone number.
select NAME,SURNAMES from MEMBERS where CITY = 'Manacor' and PHONE is null; -- 2

-- (8) Retrieve the copy number and member code of all borrows made in 2012 and which have not yet been returned.
select COPY_CODE,MEMBER_CODE from BORROWS where year(BORROW_DATE)=2012 and RETURN_DATE is null; -- 12

-- (9) Title of books containing the word 'TIERRA' or the word 'FUEGO'.
select TITLE from books where TITLE like '%TIERRA%' or TITLE like '%FUEGO%'; -- 4

-- (10) Title of books that contain the word 'TIERRA' and do not contain the word 'PILARES'.
select TITLE from books where TITLE like '%TIERRA%' and TITLE not like '%PILARES%'; -- 1

-- (11) Publishers that have a state, but not the city.
select * from PUBLISHERS where state IS NOT NULL AND city IS NULL;

-- (12) Loans that have been returned late.
select * from BORROWS where RETURN_DATE > DEAD_DATE;
select * from BORROWS where RETURN_DATE > DEAD_DATE or (RETURN_DATE IS NULL AND DEAD_DATE < NOW()); -- not returned but already out of time

-- (13) Return the number of Manacor members.
select count(*) from MEMBERS where city = 'MANACOR'; -- 25

-- (14) Return the number of loans made by the member with code 1.
select count(*) from BORROWS WHERE MEMBER_CODE = 1;

-- (15) Return the highest member code and his/her full name (with the format 'surnames, name'). Give an alias for the fullname.
SELECT CONCAT(SURNAMES,', ',NAME) 'FULL NAME',MEMBER_CODE FROM MEMBERS ORDER BY MEMBER_CODE DESC limit 1; -- SERVERA, FRANCISA

-- (16) Return the day we registered the oldest member (does not have to be the number 1 member)
select MIN(entry_date) from MEMBERS; -- 18
SELECT ENTRY_DATE FROM MEMBERS WHERE ENTRY_DATE IS NOT NULL ORDER BY ENTRY_DATE ASC LIMIT 1;

-- (17) Returns the average number of editions of all books in the database.
SELECT AVG(EDITION_NUM) FROM BOOKS; -- 4.4590
SELECT SUM(EDITION_NUM)/COUNT(EDITION_NUM) FROM BOOKS;

-- (18) Retrieves the number of days of the longest loan in 2011.
select MAX(timestampdiff(DAY,borrow_date,return_date) ) from BORROWS where year(BORROW_DATE)=2011; -- 684
select MAX(timestampdiff(DAY,borrow_date,return_date) ) from BORROWS where year(RETURN_DATE)=2011; -- 44

-- (19) Average number of days that each book has been borrowed (don't take in account some mistakes on dates as 0000-00-00 00:00:00 or when return date is before borrow date)
select AVG(timestampdiff(DAY,borrow_date,return_date))
from BORROWS
WHERE RETURN_DATE >= BORROW_DATE
AND YEAR(RETURN_DATE) != 0; -- 31.1538

-- (20) Names and surnames of the members who live in Manacor or Son Servera and who were registered in 2011.
select NAME, SURNAMES, city, ENTRY_DATE from MEMBERS
where (city = 'MANACOR' OR city = 'SON SERVERA')
  AND YEAR(ENTRY_DATE)=2011;
  
-- (21) Title, full name of the author and name of the publisher of all books (2 solutions)
select title,(select name from AUTHORS where AUTHOR_CODE = b.AUTHOR_CODE) AUTHOR,
             (select NAME from PUBLISHERS where PUBLISHER_CODE = b.PUBLISHER_CODE) PUBLISHER
from BOOKS b;

select TITLE,concat(a.SURNAMES,', ',a.NAME) author,p.NAME publisher
  from BOOKS b
  left join AUTHORS a on b.AUTHOR_CODE = a.AUTHOR_CODE
  left join PUBLISHERS p on b.PUBLISHER_CODE = p.PUBLISHER_CODE; -- 123

-- (22) Title, full name of the author and publisher name of all books written in the language 'CA' (2 solutions)
select title,(select name from AUTHORS where AUTHOR_CODE = b.AUTHOR_CODE) AUTHOR,
             (select NAME from PUBLISHERS where PUBLISHER_CODE = b.PUBLISHER_CODE) PUBLISHER
from BOOKS b
where LANGUAGE = 'CA';

select TITLE,concat(a.SURNAMES,', ',a.NAME) author,p.NAME publisher
  from BOOKS b
  left join AUTHORS a on b.AUTHOR_CODE = a.AUTHOR_CODE
  left join PUBLISHERS p on b.PUBLISHER_CODE = p.PUBLISHER_CODE
  WHERE LANGUAGE = 'CA';
  
-- (23) Members (name and surnames) who are from Manacor and have made some loans.
select NAME, SURNAMES, CITY from MEMBERS 
WHERE CITY LIKE '%MANACOR%'
AND MEMBER_CODE IN (SELECT MEMBER_CODE FROM BORROWS);

-- (24) Members (name and surnames) who have books on loan today.
select NAME, SURNAMES, CITY from MEMBERS
where MEMBER_CODE IN (SELECT DISTINCT MEMBER_CODE FROM BORROWS where RETURN_DATE IS NULL);

-- (25) Title of all books borrowed by member number 1.
select title from BOOKS
where BOOK_CODE in (select BOOK_CODE from COPIES where COPY_CODE IN (SELECT DISTINCT COPY_CODE FROM BORROWS WHERE MEMBER_CODE = 1));

SELECT distinct b.TITLE
FROM BOOKS b
JOIN COPIES c ON c.BOOK_CODE = b.BOOK_CODE
JOIN BORROWS bo ON bo.COPY_CODE = c.COPY_CODE
WHERE bo.MEMBER_CODE = 1;

-- (26) Name of the publishers who have published some HISTORY book.
SELECT GENRE_CODE FROM GENRES where NAME LIKE '%HISTORIA%';

SELECT BOOK_CODE FROM GENREBOOK WHERE GENRE_CODE = (SELECT GENRE_CODE FROM GENRES where NAME LIKE '%HISTORIA%');

SELECT DISTINCT PUBLISHER_CODE FROM BOOKS 
WHERE BOOK_CODE IN (SELECT BOOK_CODE FROM GENREBOOK WHERE GENRE_CODE = (SELECT GENRE_CODE FROM GENRES where NAME LIKE '%HISTORIA%'));

SELECT NAME FROM PUBLISHERS
WHERE PUBLISHER_CODE IN (SELECT DISTINCT PUBLISHER_CODE FROM BOOKS 
WHERE BOOK_CODE IN (SELECT BOOK_CODE FROM GENREBOOK WHERE GENRE_CODE = (SELECT GENRE_CODE FROM GENRES where NAME LIKE '%HISTORIA%'))); -- 7

SELECT DISTINCT p.NAME
FROM BOOKS b
JOIN GENREBOOK gb ON gb.BOOK_CODE = b.BOOK_CODE
JOIN GENRES g ON g.GENRE_CODE = gb.GENRE_CODE
JOIN PUBLISHERS p ON p.PUBLISHER_CODE = b.PUBLISHER_CODE
WHERE g.NAME LIKE '%HISTORIA%'; -- 7

-- (27) Full name of the authors who have written a book published by PLANETA (2 solutions)
SELECT distinct CONCAT(NAME,' ',SURNAMES) AS FULLNAME FROM AUTHORS WHERE AUTHOR_CODE IN
	(select DISTINCT AUTHOR_CODE from BOOKS WHERE PUBLISHER_CODE IN
		(select PUBLISHER_CODE from PUBLISHERS where name like '%planeta%'));
        
SELECT distinct CONCAT(a.NAME,' ',a.SURNAMES) AS FULLNAME 
FROM AUTHORS a
JOIN BOOKS b ON a.AUTHOR_CODE = b.AUTHOR_CODE
JOIN PUBLISHERS p ON p.PUBLISHER_CODE = b.PUBLISHER_CODE
where p.NAME like '%planeta%';

-- (28) Names of authors different from NOAH GORDON who have written some HISTORIA books (2 solutions)

select GENRE_CODE from GENRES where NAME like '%HISTORIA%';

select NAME, SURNAMES from AUTHORS 
WHERE (NAME != 'NOAH' OR SURNAMES != 'GORDON')
AND AUTHOR_CODE in (SELECT AUTHOR_CODE FROM BOOKS WHERE BOOK_CODE IN (SELECT BOOK_CODE FROM GENREBOOK WHERE GENRE_CODE IN (select GENRE_CODE from GENRES where NAME like '%HISTORIA%')));

select a.NAME, a.SURNAMES 
from AUTHORS a
join BOOKS b on a.AUTHOR_CODE = b.AUTHOR_CODE
join GENREBOOK gb on gb.BOOK_CODE = b.BOOK_CODE
join GENRES g on g.GENRE_CODE = gb.GENRE_CODE
WHERE (a.NAME != 'NOAH' OR a.SURNAMES != 'GORDON')
and g.NAME like '%HISTORIA%';

select a.NAME, a.SURNAMES 
from AUTHORS a
join BOOKS b on a.AUTHOR_CODE = b.AUTHOR_CODE
join GENREBOOK gb on gb.BOOK_CODE = b.BOOK_CODE
join GENRES g on g.GENRE_CODE = gb.GENRE_CODE
WHERE NOT (a.NAME = 'NOAH' AND a.SURNAMES = 'GORDON')
and g.NAME like '%HISTORIA%';

-- (29) Full name of the members living in the same city as the member 1
select concat(NAME,' ',SURNAMES) AS FULLNAME FROM MEMBERS
where CITY = (SELECT CITY FROM members WHERE MEMBER_CODE = 1)
and MEMBER_CODE != 1;

SELECT concat(m1.NAME,' ',m1.SURNAMES) AS FULLNAME 
FROM MEMBERS m1
JOIN MEMBERS m2 ON m2.CITY = m1.CITY
WHERE m2.MEMBER_CODE = 1
AND m1.MEMBER_CODE != 1;

-- (30) Title of all books published by the same publisher as the book "EL MEDICO"
select TITLE from BOOKS
where PUBLISHER_CODE in (select PUBLISHER_CODE from BOOKS
where TITLE = 'EL MEDICO');

select b1.TITLE 
from BOOKS b1
join BOOKS b2 ON b2.PUBLISHER_CODE = b1.PUBLISHER_CODE
join PUBLISHERS p ON p.PUBLISHER_CODE = b2.PUBLISHER_CODE
WHERE b2.TITLE = 'EL MEDICO';

-- -------------------------------------------------------------------------------------------------------------------------

-- (31) Title of all the books written by the same author as the book "EL MEDICO".
SELECT TITLE FROM BOOKS WHERE AUTHOR_CODE = (select AUTHOR_CODE from BOOKS where TITLE = 'EL MEDICO');

-- (32) Title of all the books that belong to any of the genres to which the book "EL MEDICO" belongs.
SELECT TITLE FROM BOOKS
WHERE BOOK_CODE IN (
SELECT BOOK_CODE FROM GENREBOOK 
WHERE GENRE_CODE IN (
SELECT GENRE_CODE FROM GENREBOOK WHERE BOOK_CODE = (SELECT BOOK_CODE FROM BOOKS WHERE TITLE = 'EL MEDICO'))); -- 34

SELECT DISTINCT TITLE
FROM BOOKS b
JOIN GENREBOOK g ON g.BOOK_CODE = b.BOOK_CODE
WHERE GENRE_CODE IN (
SELECT GENRE_CODE
FROM GENREBOOK g2
JOIN BOOKS b2 ON g2.BOOK_CODE = b2.BOOK_CODE
WHERE b2.TITLE = 'EL MEDICO');

-- (33) Returns how many books have been published by the same publisher as "EL MEDICO".
SELECT COUNT(*)
FROM BOOKS 
WHERE PUBLISHER_CODE = (SELECT PUBLISHER_CODE FROM BOOKS WHERE TITLE = 'EL MEDICO'); -- 7

SELECT COUNT(*)
FROM BOOKS b
JOIN BOOKS m ON b.PUBLISHER_CODE = m.PUBLISHER_CODE
WHERE m.TITLE = 'EL MEDICO';

-- (34) Returns the total number of loans made in 2011 and the total number of loans returned in the same year.
SELECT (select count(*) FROM BORROWS
WHERE YEAR(BORROW_DATE)=2011) AS 'Number of loans made',
(SELECT COUNT(*) FROM BORROWS
WHERE YEAR(RETURN_DATE) = 2011) AS 'Number of loans returned';

-- (35) Returns how many books each author wrote (answer format: name surname number, noha gordon 5, ...)
SELECT (SELECT CONCAT(NAME,' ',SURNAMES) FROM AUTHORS WHERE AUTHOR_CODE = b.AUTHOR_CODE) AS FULLNAME,COUNT(*)
FROM BOOKS b
WHERE AUTHOR_CODE IS NOT NULL
GROUP BY AUTHOR_CODE;

SELECT NAME,SURNAMES,COUNT(*)
FROM BOOKS b
JOIN AUTHORS a ON b.AUTHOR_CODE = a.AUTHOR_CODE
group by b.AUTHOR_CODE;

-- (36) Return how many copies there are in total for each book (answer format: title total, PROGAMACION EN COBOL 3, ...)
select TITLE,COUNT(COPY_CODE) total
from BOOKS b
left join COPIES c on b.BOOK_CODE = C. BOOK_CODE
group by b.BOOK_CODE
order by COUNT(COPY_CODE) desc;

-- (37) Return the average number of copies per book.
select avg(total) from
(select TITLE,COUNT(COPY_CODE) total
from BOOKS b
LEFT join COPIES c on b.BOOK_CODE = C. BOOK_CODE
group by b.BOOK_CODE) taula; -- 0.8780

-- (38) Returns how many books there are in each genre (output format: genre total, HISTORIA 25, ...)
select g.NAME,COUNT(*) total
from GENRES g
join GENREBOOK gb on g.GENRE_CODE = gb.GENRE_CODE
group by g.GENRE_CODE;

-- (39) Return how many loans each member has made in total (output format: name surnames total, toni mesquida 7, ...)
select m.NAME,m.SURNAMES,count(COPY_CODE) total
from MEMBERS m
LEFT join BORROWS b on m.MEMBER_CODE = b.MEMBER_CODE
group by m.MEMBER_CODE
order by 3 desc;

-- (40) Return, for each member, the number of books he has borrowed.
select m.NAME,m.SURNAMES,count(distinct COPY_CODE) total
from MEMBERS m
LEFT join BORROWS b on m.MEMBER_CODE = b.MEMBER_CODE
group by m.MEMBER_CODE
ORDER BY 3 DESC;

-- (41) List of members that have made more than 5 loans.
select m.NAME,m.SURNAMES,count(*) total
from MEMBERS m
join BORROWS b on m.MEMBER_CODE = b.MEMBER_CODE
group by m.MEMBER_CODE
having total > 5;

-- (42) List of members who currently have more than one book on loan.
select m.NAME,m.SURNAMES,count(*) total
from MEMBERS m
join BORROWS b on m.MEMBER_CODE = b.MEMBER_CODE
where RETURN_DATE is null
group by m.MEMBER_CODE
having total > 1;

-- (43) For the book "El medico", return the total number of copies, number of copies currently on loan and number of available copies (output format: title number_of_copies on_loan available, the doctor 5 3 2)
select TITLE,
	   count(c.COPY_CODE) number_of_copies,
       (count(c.COPY_CODE) - count(bo.RETURN_DATE)) on_loan,
       count(bo.RETURN_DATE) available
from BOOKS b
JOIN COPIES c on b.BOOK_CODE = c.BOOK_CODE
JOIN BORROWS bo on c.COPY_CODE = bo.COPY_CODE
WHERE TITLE = 'EL MEDICO';

-- (44) Retrieves the number of books in the library, the number of copies, and the average number of copies per book.
select count(distinct b.BOOK_CODE) 'Number of books',count(COPY_CODE) 'Number of copies',
       count(COPY_CODE)/count(distinct b.BOOK_CODE) 'average number of copies per book'
FROM BOOKS b
left join COPIES c ON b.BOOK_CODE = c.BOOK_CODE;

select count(*) from BOOKS; -- 123

select count(*) from COPIES; -- 108

-- (45) Number of different books each member has borrowed.
select NAME,SURNAMES,count(distinct BOOK_CODE) total
FROM MEMBERS m
LEFT join 
(BORROWS b 
join COPIES c ON c.COPY_CODE = b.COPY_CODE)
ON m.MEMBER_CODE = b.MEMBER_CODE
group by m.MEMBER_CODE
ORDER BY 3 DESC;

-- (46) Returns the number of members of whom we do not know their telephone.
select count(*) from MEMBERS where PHONE is null; -- 11

-- (47) Retrieve the copy code and member code for all loans made this year that either have been returned out of date, or have not yet been returned and are already out of date.
SELECT COPY_CODE,MEMBER_CODE,RETURN_DATE,DEAD_DATE
FROM BORROWS
WHERE year(BORROW_DATE) = 2020
and ((RETURN_DATE IS NULL and DEAD_DATE < now()) or (RETURN_DATE > DEAD_DATE)); -- 29

-- (48) Number of copies of each book published by "Planeta". The title, language, author and number of copies of the book must be retrieved, sorted by number of copies and author.
SELECT TITLE, LANGUAGE,concat(a.NAME,' ',SURNAMES) AUTHOR,count(c.COPY_CODE) 'number of copies'
FROM ((BOOKS b
JOIN PUBLISHERS p on b.PUBLISHER_CODE = p.PUBLISHER_CODE) 
LEFT JOIN AUTHORS a
ON b.AUTHOR_CODE = a.AUTHOR_CODE)
LEFT JOIN copies c on c.BOOK_CODE = b.BOOK_CODE
WHERE p.NAME like '%PLANETA%'
group by b.book_code;

-- (49) Retrieve code from books that belong to more than one genre.
select BOOK_CODE,count(*)
FROM GENREBOOK
group by BOOK_CODE
having count(*) > 1;

-- (50) Title of books left on loan in 2011.
select DISTINCT TITLE
FROM BOOKS b
JOIN COPIES c ON b.BOOK_CODE = c.BOOK_CODE
join BORROWS bo ON bo.COPY_CODE = c.COPY_CODE
where year(BORROW_DATE) = 2011;

-- (51) Total number of loans made by members who have taken a book during 2011.
select count(*) 
from BORROWS
where year(BORROW_DATE) = 2011;

-- (52) List of members that have not made any loans during 2011.
select NAME,SURNAMES FROM MEMBERS
WHERE MEMBER_CODE NOT IN (SELECT DISTINCT MEMBER_CODE FROM BORROWS WHERE YEAR(BORROW_DATE) = 2011);

-- (53) List of loans (all fields) made in February 2011.
select * from BORROWS where year(BORROW_DATE) = 2011 and month(BORROW_DATE) = 2;

-- (54) List of loans (all fields) longer than 15 days.
select *,datediff(RETURN_DATE,BORROW_DATE) as diferencia from BORROWS
where datediff(RETURN_DATE,BORROW_DATE) > 15;

-- (55) List of members (all fields) who were registered in the same month as the number 1 member.
select MONTH(ENTRY_DATE) FROM MEMBERS WHERE MEMBER_CODE = 1;

SELECT * FROM MEMBERS WHERE MONTH(ENTRY_DATE) = (select MONTH(ENTRY_DATE) FROM MEMBERS WHERE MEMBER_CODE = 1);

-- (56) Title of the book with more editions.
select TITLE from BOOKS
where EDITION_NUM = (select max(EDITION_NUM) from BOOKS); -- El tiempo entre costuras

select TITLE from BOOKS
where EDITION_NUM >= ALL (select EDITION_NUM from BOOKS WHERE EDITION_NUM IS NOT NULL);

select TITLE from BOOKS ORDER BY EDITION_NUM DESC LIMIT 1;

select TITLE
from BOOKS b
join (select max(EDITION_NUM) maxim from BOOKS) mx on b.EDITION_NUM = mx.maxim;

-- (57) Name and surname of the members who have a book not returned.
select DISTINCT NAME,SURNAMES
from BORROWS b
JOIN MEMBERS m on b.MEMBER_CODE = m.MEMBER_CODE
WHERE RETURN_DATE IS NULL;

-- (58) Returns the title of books written by authors who have authored more than 2 books.
select TITLE from BOOKS
where AUTHOR_CODE IN (SELECT AUTHOR_CODE FROM BOOKS GROUP BY AUTHOR_CODE HAVING count(*) > 2);

select TITLE
from BOOKS b
join (SELECT AUTHOR_CODE FROM BOOKS GROUP BY AUTHOR_CODE HAVING count(*) > 2) a on b.AUTHOR_CODE = a.AUTHOR_CODE;

-- (59) Name and surname of the member who made the most loans.
select NAME,SURNAMES FROM MEMBERS
WHERE MEMBER_CODE = (select MEMBER_CODE FROM BORROWS GROUP BY MEMBER_CODE ORDER BY count(*) desc limit 1);

select NAME,SURNAMES
FROM MEMBERS m 
JOIN BORROWS b ON m.MEMBER_CODE = b.MEMBER_CODE
GROUP BY m.MEMBER_CODE
order by COUNT(*) desc limit 1;

select NAME,SURNAMES 
FROM MEMBERS m
JOIN (select MEMBER_CODE FROM BORROWS GROUP BY MEMBER_CODE ORDER BY count(*) desc limit 1) mx 
on m.MEMBER_CODE = mx.MEMBER_CODE;


-- (60) For each book by the author 'FOLLETT' recover the number of loans and the average number of days that have been on loan. Books that are on loan and have not yet been returned we will consider the return date as 31/12/2013.
select TITLE,count(BORROW_DATE) 'number of loans',avg(datediff(ifnull(RETURN_DATE,'2013-01-31'),BORROW_DATE)) 'average number of days on loan'
from BOOKS b
JOIN AUTHORS a on b.AUTHOR_CODE = a.AUTHOR_CODE
JOIN COPIES c on c.BOOK_CODE = b.BOOK_CODE
JOIN BORROWS bo on bo.COPY_CODE = c.COPY_CODE
where SURNAMES = 'FOLLETT'
GROUP BY b.BOOK_CODE;


select TITLE,count(BORROW_DATE)
from BOOKS b
JOIN AUTHORS a on b.AUTHOR_CODE = a.AUTHOR_CODE
JOIN COPIES c on c.BOOK_CODE = b.BOOK_CODE
JOIN BORROWS bo on bo.COPY_CODE = c.COPY_CODE
where SURNAMES = 'FOLLETT'
GROUP BY b.BOOK_CODE;

-- ----------------------------------------------------------------------------------------

-- (61) What is the book we have the most copies?
select BOOK_CODE,COUNT(*) FROM COPIES GROUP BY BOOK_CODE ORDER BY COUNT(*) DESC;

SELECT b.BOOK_CODE,TITLE 
FROM BOOKS b
JOIN COPIES c ON b.BOOK_CODE = c.BOOK_CODE
group by b.BOOK_CODE
having count(*) = (select COUNT(*) FROM COPIES GROUP BY BOOK_CODE ORDER BY COUNT(*) DESC LIMIT 1); 

-- (62) Number of members who have not borrowed a book for more than 9 years.
SELECT COUNT(*) FROM
(select MEMBER_CODE
FROM BORROWS
group by MEMBER_CODE
having timestampdiff(year,MAX(BORROW_DATE),CURDATE()) > 9) taula;

-- (63) Amount of loans made by the members according to the number of years they have been registered (answer format: years number_of_loans, 20 (years) 20 (loans)
select timestampdiff(YEAR,ENTRY_DATE,CURDATE()) years,count(*) 'Number of loans'
FROM MEMBERS m
JOIN BORROWS b on m.MEMBER_CODE = b.MEMBER_CODE
where ENTRY_DATE IS NOT NULL
GROUP BY years;

-- (64) All books whose title contains the word 'tiempo' that are available.
select TITLE,c.COPY_CODE,BORROW_DATE,RETURN_DATE
FROM (BOOKS b
join COPIES c on b.BOOK_CODE = c.BOOK_CODE)
left join BORROWS bo on bo.COPY_CODE = c.COPY_CODE
WHERE TITLE LIKE '%tiempo%'
and (BORROW_DATE is null or RETURN_DATE is not null);

-- one book maybe has never been borrowed (BORROW_DATE is null) or, is already returned (RETURN_DATE is not null)

-- (65) Details of the members (all fields) who have borrowed more than 2 times the same book.
select distinct m.*
from BORROWS b
join COPIES c ON b.COPY_CODE = c.COPY_CODE
join MEMBERS m on m.MEMBER_CODE = b.MEMBER_CODE
GROUP BY MEMBER_CODE,BOOK_CODE
HAVING COUNT(*) > 1;

-- (66) Data of the loans that have been returned 20 days or more, later than the dead date or that have not been returned and have passed more than 20 days of the dead date (output format: [surnames, names]-of-member book-title borrow-date return-date dead-date delay-days)
SELECT concat(SURNAMES,', ',name) soci,TITLE,BORROW_DATE,RETURN_DATE,DEAD_DATE,datediff(IFNULL(RETURN_DATE,CURDATE()),DEAD_DATE) DAYS
FROM BORROWS b
join MEMBERS m ON m.MEMBER_CODE = b.MEMBER_CODE
join COPIES c on c.COPY_CODE = b.COPY_CODE 
join BOOKS bk on bk.BOOK_CODE = c.BOOK_CODE
WHERE YEAR(BORROW_DATE) = 2020
AND DEAD_DATE < curdate()
AND datediff(IFNULL(RETURN_DATE,CURDATE()),DEAD_DATE) > 20;
-- and ((RETURN_DATE IS NULL and DEAD_DATE < now()) or (RETURN_DATE > DEAD_DATE));

-- (67) Name and surname of the oldest member of the library
SELECT concat(SURNAMES,', ',name) soci FROM MEMBERS ORDER BY timestampdiff(year,ENTRY_DATE,CURDATE()) DESC LIMIT 1;

-- (68)  Code of the members who in 2010 borrowed some of the books written by 'Gordon'.
select distinct MEMBER_CODE
FROM BOOKS b
JOIN AUTHORS a ON b.AUTHOR_CODE = a.AUTHOR_CODE
JOIN COPIES c on c.BOOK_CODE = b.BOOK_CODE
join BORROWS bo on bo.COPY_CODE = c.COPY_CODE
where a.surnames like '%GORDON%'
and year(BORROW_DATE) = 2010;

-- (69) Retrieve all books (only title) on the subject "HISTORIA" showing their number of loans.
select title,count(*) 'number of loans'
FROM GENREBOOK gb
join GENRES g on g.GENRE_CODE = gb.GENRE_CODE
join BOOKS b on b.BOOK_CODE = gb.BOOK_CODE
join COPIES c on b.BOOK_CODE = c.BOOK_CODE
join BORROWS bo ON bo.COPY_CODE = c.COPY_CODE
WHERE NAME = 'HISTORIA'
group by b.BOOK_CODE;

-- (70) Which is the most requested book for each year, that is, borrowed more times.
create temporary table table_max as
select anys,max(nloans) maxim
from 
(select year(BORROW_DATE) anys,BOOK_CODE,COUNT(*) nloans
from BORROWS bo
join COPIES c on c.COPY_CODE = bo.COPY_CODE
GROUP BY year(BORROW_DATE),BOOK_CODE) taula
group by anys;

select * from table_max;

select year(BORROW_DATE) years,BOOK_CODE,COUNT(*) nloans
from BORROWS bo
join COPIES c on c.COPY_CODE = bo.COPY_CODE
GROUP BY year(BORROW_DATE),BOOK_CODE
HAVING COUNT(*) = (select maxim from table_max where anys = years);

