-- STRING FUNCTIONS
-- concat
SELECT concat("SQL", "Tutorial", "is" "fun!") AS ConvatenantedString;

SELECT titulo, autor, concat(titulo, ' de ', autor) 'llibre' FROM libros;

USE hr;

SELECT employee_id, first_name, last_name, concat(employee_id, ' - ', first_name, ' ', last_name) AS fullName
	FROM employees;

-- ucase / upper
SELECT first_name, ucase(first_name) FROM employees;
SELECT first_name, upper(first_name) FROM employees;

-- lower / lcase
SELECT employee_id, job_id, lcase(job_id) FROM employees;
SELECT employee_id, job_id, lower(job_id) FROM employees;

-- char_length / charcaracter_length
SELECT employee_id, first_name, char_length(first_name) FROM employees;

-- length
-- length compta bytes i el char_length compta caracters
SELECT char_length('Rosselló'), length('Rosselló');

-- ASCII
-- retorna el codi ascii de la primera lletra
SELECT ascii('Marc');
SELECT ascii('M');
SELECT ascii('Joan');

-- char
-- retorna el caracter d'un codi ascii
SELECT char(77);

-- replace
-- distingeix entre minuscules i mayuscules
SELECT replace('SQL tutorial', 'SQL', 'html');

-- repeat
-- SELECT repeat('sql tutorial ', 3);

-- revers
SELECT reverse('bon dia tot lo dia');

-- trim, rtrim, ltrim
SELECT TRIM("     SQL Tutorial     ") AS RightTrimmedString;
SELECT RTRIM("     SQL Tutorial     ") AS RightTrimmedString;
SELECT LTRIM("     SQL Tutorial     ") AS RightTrimmedString;

-- lpad, rpad
SELECT LPAD("SQL Tutorial", 20, "l");
SELECT RPAD("SQL Tutorial", 20, "r");

-- substr
-- a partir de la posició 5 agafa 3 caracters
SELECT SUBSTR("SQL Tutorial", 5, 3) AS ExtractString;

-- left, right
SELECT LEFT("SQL Tutorial", 3) AS ExtractString;
SELECT RIGHT("SQL Tutorial", 3) AS ExtractString;
