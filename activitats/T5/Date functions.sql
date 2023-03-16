-- date functions

-- day, month, year
SELECT first_name, hire_date, 
		day(hire_date) AS dia, 
		month(hire_date) AS mes, 
        year(hire_date) AS 'any'
	FROM employees;

-- monthname
SELECT first_name, hire_date, 
		month(hire_date) AS mes, 
        monthname(hire_date) AS 'nom mes'
	FROM employees;

-- dayofweek
SELECT first_name, hire_date, 
		month(hire_date) AS mes, 
        dayofweek(hire_date) AS 'dia de la semana numero'
	FROM employees;

-- dayofmonth
SELECT first_name, hire_date, 
		month(hire_date) AS mes, 
        dayofmonth(hire_date) AS 'dia del mes'
	FROM employees;

-- dayofyear
SELECT first_name, hire_date, 
		month(hire_date) AS mes, 
        dayofyear(hire_date) AS "dia de l'any"
	FROM employees;

-- dayname
SELECT first_name, hire_date, 
		month(hire_date) AS mes, 
        dayname(hire_date) AS "dia de la seman nom"
	FROM employees;
    
SET lc_time_names = 'ca_ES';

-- monthname
SELECT first_name, hire_date, 
		month(hire_date) AS mes, 
        monthname(hire_date) AS "nom del mes"
	FROM employees;

-- hores
SELECT now();
SELECT curdate(), current_date(), current_time(), now(), sysdate(), utc_timestamp();

-- date_format
SELECT date_format(curdate(), '%D de %M de %Y');

-- last_day
-- detorna el derrer dia del mes
SELECT last_day('2020-04-22');

-- timestampdiff
SELECT timestampdiff(year, '2004-03-26', now());
SELECT timestampdiff(month, '2004-03-26', now());
SELECT timestampdiff(day, '2004-03-26', now());
SELECT timestampdiff(minute, '2004-03-26', now());
SELECT timestampdiff(second, '2004-03-26', now());
SELECT timestampdiff(microsecond, '2004-03-26', now());
