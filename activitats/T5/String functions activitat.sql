use hr;

-- 1. Increase the salary of all employees by 100 euros
SELECT employee_id, salary, salary + 100 
	FROM employees;

UPDATE employees 
	SET salary = salary + 100;

-- 2. Capitalize employees' last names.
SELECT ucase(last_name) 
	FROM employees;
    
UPDATE employees
	SET last_name = ucase(last_name);

-- 3. Eliminate employees who have a two-letter name.
SELECT first_name
	FROM employees
    WHERE char_length(first_name) = 2;

DELETE FROM employees
	WHERE char_length(first_name) = 2;

-- 4. Update employee emails in the following format: Firtsname.Lastname@thebest.com.
SELECT concat(first_name, '.', last_name, '@thebest.com')
	FROM employees;

UPDATE employees
	SET email = concat(first_name, '.', last_name, '@thebest.com');

SELECT email
	FROM employees;

-- 5. Show emails and their length in characters as follows: "alicia@pau.edu has 14 characters"
SELECT concat(email, ' has ', char_length(email), ' characters') 
	FROM employees;

-- 6. Remove blanks fom state_province field on locations table.
SELECT state_province, replace(state_province, ' ', '')
	FROM locations;
    
UPDATE locations
	SET state_province = replace(state_province, ' ', '');

-- 7. Show full name of employees with this format: Rosselló Ximenes, Alícia
SELECT concat(last_name, ', ', first_name)
	FROM employees;

-- 8. Show the job_id field in lower case of those jobs with a difference between maximum and minimum salary lesser than 5000.
SELECT LCASE(job_id)
	FROM employees
	GROUP BY job_id
	HAVING max(salary) - min(salary) < 5000;

-- 9. How many letters does the employee's longest first_name have?
SELECT max(char_length(first_name))
	FROM employees;
    
-- 10. Show the last name of employees with asterisks (one asterisk for each letter)
SELECT last_name, replace(last_name, last_name, repeat('*', char_length(last_name))) FROM employees;

SELECT last_name, REPEAT('*', LENGTH(last_name)) AS last_name 
	FROM employees;

-- el punt es qualsevol caracter
SELECT REGEXP_REPLACE(last_name, '.', '*')
	FROM employees;
