-- Date and Time Exercises

-- -------------------------------------------------------------------------------------------
-- 1. Write a query to display the first day of the month (in date format) three months before the current month.
SELECT last_day(curdate()) + INTERVAL 1 DAY - INTERVAL 4 MONTH;

-- 2. Write a query to display the last day of the month (in date format) three months before the current month.
SELECT last_day(curdate()) - INTERVAL 3 MONTH;

-- 3. Write a query to get the distinct Mondays from hire_date in employees tables.
SELECT DISTINCT hire_date
	FROM employees
    WHERE dayofweek(hire_date) = 2;

-- 4. Write a query to get the first day of the current year.
SELECT date_format(curdate(), '%Y - 01 - 01');

-- 5. Write a query to get the last day of the current year.
SELECT date_format(curdate(), '%Y - 12 - 31');

-- 6. Write a query to calculate your age from your birthday;
SELECT timestampdiff(year, '2004-03-26', now());
SELECT timestampdiff(month, '2004-03-26', now());
SELECT timestampdiff(day, '2004-03-26', now());
SELECT timestampdiff(minute, '2004-03-26', now());
SELECT timestampdiff(second, '2004-03-26', now());
SELECT timestampdiff(microsecond, '2004-03-26', now());

-- 7. Write a query to get the current date in the following format: Thursday September 2014
SELECT concat(dayname(curdate()), " ", monthname(curdate()), " ", year(curdate())) AS 'Data';
SELECT DATE_FORMAT(curdate(), '%W %M %Y');

-- 8. Write a query to display the current date in the following format: 28/01/2016 (consult your manual 'MySQL 5.7 Reference Manual' for 'date_format')
SELECT concat(day(curdate()), "/", month(curdate()), "/", year(curdate())) AS 'Data';
SELECT DATE_FORMAT(CURDATE(), '%d/%m/%Y');

-- 9. Write a query to get the firstname, lastname who joined in the month of June.
SELECT first_name, last_name 
	FROM employees
	WHERE month(hire_date) = 6;

-- 10. Write a query to get the years in which more than 10 employees joined.
SELECT year(hire_date), count(*)
	FROM employees
	GROUP BY year(hire_date)
	HAVING count(*) > 10;

-- 11. Write a query to get the department ID, year, and number of employees joined.
SELECT department_id, YEAR(hire_date) as hireYear, count(employee_id)
	FROM employees
	GROUP BY department_id, hireYear;

-- 12. Write a query to get first name, hire date and experience of the employees. 
SELECT first_name, last_name, hire_date, TIMESTAMPDIFF(YEAR ,hire_date, CURDATE()) as experience
    FROM employees;

-- 13. Write a query to get first name of employees who joined in 1987
SELECT first_name, hire_date
	FROM employees
	WHERE year(hire_date) ='1987';


use AIRLINE;

-- 14. Listo of flights. Show all data and flight duration in fromat hh:mm
SELECT * , left(sec_to_time(TIMESTAMPDIFF(SECOND, departure_time, arrival_time)), 5) as DURATION
	FROM FLIGHTS;

SELECT *, date_format(sec_to_time(TIMESTAMPDIFF(SECOND, departure_time, arrival_time)), '%H:%i') as DURATION
	FROM FLIGHTS;
