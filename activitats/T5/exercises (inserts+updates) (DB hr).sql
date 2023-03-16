use hr;

-- 1. Write a SQL statement to insert a record with your own value into the table countries against each columns.
INSERT INTO countries 
	VALUES ('IC','Inca',1);
    
-- 2. Write a SQL statement to insert one row into the table countries against the column country_id and country_name.
INSERT INTO countries (country_id, country_name)
	VALUES ('PM','Palma');

-- 3. Write a SQL statement to create duplicate of countries table named country_new with all structure and data.
CREATE TABLE country_new SELECT * FROM countries;

-- 4. Write a SQL statement to insert NULL values against region_id column for a row of countries table. 
INSERT INTO countries
	VALUES ('SE', 'Sencelles', null);

-- 5. Write a SQL statement to insert 3 rows by a single insert statement. 
INSERT INTO countries
	VALUES ('LL', 'Lloseta', null), 
		('BS', 'Binisalem', null), 
		('SM', 'Santa Maria', null);

-- 6. Write a SQL statement to insert rows from country_new table to countries table.
INSERT INTO countries 
	SELECT * FROM country_new; -- Error Code: 1062. Duplicate entry 'IT' for key 'countries.PRIMARY'

-- 7. Write a SQL statement to change the email column of employees table with 'not available' for all employees. 
UPDATE employees 
	SET email = 'not available';

-- 8. Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for all employees.
UPDATE employees 
	SET email = 'not available', 
		commission_pct = 0.10;

-- 9. Write a SQL statement to change the email and commission_pct column of employees table with 'not available 2' and 0.20 for those employees whose department_id is 110. 
UPDATE employees 
	SET email = 'not available 2', 
		commission_pct = 0.20
	WHERE department_id = 110;

-- 10. Write a SQL statement to change the email column of employees table with 'not available 3' for those employees whose department_id is 80 and gets a commission is less than .20% 
SELECT * 
	FROM employees
	WHERE department_id = 80
		AND commission_pct < 0.20;
        
UPDATE employees
	SET email = 'not available 3'
	WHERE department_id = 80
		AND commission_pct < 0.20;

-- 11. Write a SQL statement to change salary of employee to 8000 whose ID is 105, if the existing salary is less than 5000.
SELECT *
	FROM employees
    WHERE employee_id = 105 
		AND salary < 5000;

Update employees 
	SET salary = 8000 
    WHERE employee_id = 105 
		AND salary < 5000;

-- 12. Write a SQL statement to change job ID of employee which ID is 118, to SH_CLERK if the employee belongs to department, which ID is 30 and the existing job ID does not start with SH.
SELECT * 
	FROM employees
	WHERE employee_id = 118 
		AND department_id = 30 
		AND job_id NOT LIKE 'SH%';

UPDATE employees
	SET job_id='SH_CLERK'
	WHERE employee_id = 118 
		AND department_id = 30 
		AND job_id NOT LIKE 'SH%';
