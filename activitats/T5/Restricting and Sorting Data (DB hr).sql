-- MySQL Restricting and Sorting Data

USE hr;

SELECT last_name FROM employees
	ORDER BY last_name;

-- 1. Write a query to display the names (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000.
SELECT first_name, last_name, salary
	FROM employees
    WHERE salary NOT BETWEEN 10000 AND 15000;
    
-- 2. Write a query to display the names (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order by department ID.
SELECT first_name, last_name, department_id
	FROM employees
    WHERE department_id = 30 OR department_id = 100
    ORDER BY department_id ASC;

-- UNA ALTRA OPCIÓ
SELECT first_name, last_name, department_id
	FROM employees
    WHERE department_id IN (30, 100)
    ORDER BY department_id ASC;


-- 3. Write a query to display the names (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100.
SELECT first_name, last_name, salary
	FROM employees
    WHERE salary NOT BETWEEN 10000 AND 15000
		AND department_id IN (30, 100);

-- 4. Write a query to display the names (first_name, last_name) and hire date for all employees who were hired in 1987.
SELECT first_name, last_name, hire_date
	FROM employees
    WHERE hire_date LIKE '1987-__-__';

-- 5. Write a query to display the first_name of all employees who have both "b" and "c" in their first name.
SELECT first_name
	FROM employees
    WHERE first_name LIKE '%B%' 
		AND first_name LIKE '%C%';

-- 6. Write a query to display the last name, job, and salary for all employees whose job is as a Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000.
SELECT first_name, job_id, salary
	FROM employees
    WHERE job_id LIKE 'IT_PROG' OR job_id LIKE 'SH_CLERK'
		AND salary != 4500 AND salary != 10000 AND salary != 15000;
    
-- UNA ALTRA OPCIO ES
SELECT last_name, job_id, salary
  FROM employees
  WHERE job_id IN ('IT_PROG' ,'SH_CLERK') AND salary NOT IN (4500, 10000, 15000);

-- 7. Write a query to display the last names of employees whose names have exactly 6 characters.
SELECT last_name
	FROM employees
    WHERE first_name LIKE '______';

-- 8. Write a query to display the last names of employees having 'e' as the third character.
SELECT last_name
	FROM employees
    WHERE last_name LIKE '__E%';

-- 9. Write a query to display the jobs/designations available in the employees table.
SELECT DISTINCT job_id
	FROM employees;

-- 10. Write a query to display the names (first_name, last_name), salary and PF -pension fund- (15% of salary) of all employees.
SELECT first_name, last_name, salary, salary * 0.15 as PF
  FROM employees;

-- 11. Write a query to select all record from employees where last name is one of these: BLAKE, SCOTT, KING, FORD.
SELECT first_name, last_name
	FROM employees
    WHERE last_name IN ('BLAKE', 'SCOTT', 'KING', 'FORD');
