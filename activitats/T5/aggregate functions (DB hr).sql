-- MySQL Aggregate Functions and Group by

USE hr;

-- 1. Write a query to list the number of jobs available in the employees table.
SELECT count(DISTINCT job_id) AS 'Number jobs available'
	FROM employees;

-- 2. Write a query to get the total salaries payable to employees.
SELECT sum(salary) AS 'total salaries payable'
	FROM employees;

-- 3. Write a query to get the minimum salary from employees table. 
SELECT min(salary) AS 'minimum salaries from employees'
	FROM employees;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer
SELECT max(salary) AS 'maximum salary of an employee working as a Programmer'
	FROM employees
    WHERE job_id = 'IT_PROG';

-- 5. Write a query to get the average salary and number of employees working on the department 90.
SELECT avg(salary) AS 'average salary', 
		count(*) AS 'number of employees'
	FROM employees
    WHERE department_id = 90;

-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees.
SELECT max(salary) AS 'highest',
		min(salary) AS 'lowest',
        sum(salary) AS 'sum',
        avg(salary) AS 'average'
	FROM employees;

-- 7. Write a query to get the number of employees with the same job (that is, the same job_id)
SELECT job_id, count(job_id) AS 'number of employees with the same job'
	FROM employees
    GROUP BY job_id
    ORDER BY count(job_id) DESC;

-- 8. Write a query to get the difference between the highest and lowest salaries.
SELECT max(salary) - min(salary) as 'difference between the highest and lowest salaries'
	FROM employees;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
SELECT manager_id, min(salary) AS salary
	FROM employees
    WHERE manager_id IS NOT NULL
    GROUP BY manager_id;
    
-- 10. Write a query to get the department ID and the total salary payable in each department.
SELECT department_id, sum(salary) AS 'total salary payable'
	FROM employees
    WHERE department_id IS NOT NULL
    GROUP BY department_id;

-- 11. Write a query to get the average salary for each job ID excluding programmer.
SELECT avg(salary) AS 'average salary', job_id
	FROM employees
    WHERE job_id != 'IT_PROG'
    GROUP BY job_id;
-- Tambe es pot fer amb having i no where (es menos eficient amb having)
SELECT avg(salary) AS 'average salary', job_id
	FROM employees
    GROUP BY job_id
    HAVING job_id != 'IT_PROG';

-- 12. Write a query to get the total salary, maximum, minimum, average salary of employees with the same job, for department ID 90 only.
SELECT job_id,
		sum(salary) AS 'total salary',
		max(salary) AS 'highest',
		min(salary) AS 'lowest',
        avg(salary) AS 'average'
	FROM employees
    WHERE department_id = 90
    GROUP BY job_id;

-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
SELECT job_id, max(salary) AS 'maximum salary'
	FROM employees
    GROUP BY job_id
	HAVING max(salary) >= 4000;

-- 14. Write a query to get the average salary for all departments employing more than 10 employees.
SELECT department_id, avg(salary) AS 'average salary'
	FROM employees
    GROUP BY department_id
    HAVING count(employee_id) > 10;
