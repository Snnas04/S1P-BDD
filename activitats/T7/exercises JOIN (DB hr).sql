USE hr;

-- 1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
SELECT departments.location_id, l.street_address, l.city, l.state_province, c.country_name
FROM departments as dpt
JOIN locations as l ON dpt.location_id = l.location_id
JOIN countries as c ON l.country_id = c.country_id;

-- 2. Write a query to find the names (first_name, last name), department ID and name of all the employees.  (two ways: subquery and join)
SELECT first_name, last_name, employees.department_id, d.department_name
FROM employees
JOIN departments as d ON employees.department_id = d.department_id;

SELECT first_name, last_name, employees.department_id, d.department_name
FROM employees
JOIN departments as d USING (department_id);

SELECT first_name,
       last_name,
       department_id,
       (SELECT department_name FROM departments WHERE employees.department_id = departments.department_id) as department_name
FROM employees;

-- 3. Find the names (first_name, last_name), job, department number, and department name of the employees who work in London.
SELECT first_name, last_name, job_id, e.department_id, d.department_name
FROM employees as e
JOIN departments d USING (department_id)
JOIN locations as l ON d.location_id = l.location_id
WHERE l.city = 'London';

-- 4. Write a query to find the employee id, name (last_name) along with their manager_id, manager name (last_name). (two ways: subquery and join)
SELECT e.employee_id as 'Emp_Id', e.last_name as 'Employee', m.employee_id as 'Mgr_Id', m.last_name as 'Manager' 
FROM employees as e 
join employees as m ON (m.manager_id = e.employee_id);

select e.employee_id, e.last_name, 
	(select manager_id from employees m where m.employee_id in (e.manager_id)) as 'Manager ID', 
    (select last_name from employees m where m.employee_id in (e.manager_id)) as 'Manager Last Name' 
from employees as e;

-- 5. Find the names (first_name, last_name) and hire date of the employees who were hired after 'Jones'.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Jones');

-- 6. Write a query to get the department name and number of employees in the department. (two ways: subquery and join)
SELECT departments.department_name, COUNT(employees.employee_id) AS num_employees
FROM departments
JOIN employees ON departments.department_id = employees.department_id
GROUP BY departments.department_id;

SELECT department_name,
    (SELECT COUNT(*) FROM employees WHERE department_id = departments.department_id) AS num_employees
FROM departments;

-- 7. Find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90 from job history. 
SELECT employee_id, jobs.job_title, DATEDIFF(end_date, start_date) AS days_between
FROM job_history
JOIN jobs ON job_history.job_id = jobs.job_id
WHERE job_history.department_id = 90;

-- 8. Write a query to display the department ID, department name and manager (of department) first name.
select d.department_id, department_name, first_name
from hr.departments as d
join hr.employees as e on d.manager_id = e.employee_id;

-- 9. Write a query to display the department name, manager name, and city.
select department_name, first_name, city
from hr.departments as d
left JOIN hr.employees as e ON d.manager_id = e.employee_id
JOIN hr.locations as l ON d.location_id = l.location_id;

-- 10. Write a query to display the job title and average salary of employees. 
SELECT job_title, avg(e.salary)
from hr.jobs as j
JOIN hr.employees as e on j.job_id = e.job_id
GROUP BY job_title;

-- 11. Display job title, employee name, and the difference between salary of the employee and minimum salary OF the job.
select job_title, 
    e.first_name,
    e.salary - j.min_salary as diferencia
from hr.jobs as j
JOIN hr.employees as e on j.job_id = e.job_id;

-- 12. Write a query to display the job history that were done by any employee who is currently earning more than 10000 of salary.
select jh.*, e.salary
from hr.job_history as jh
JOIN hr.employees as e ON e.employee_id = jh.employee_id
where e.salary > 10000;

-- 13. Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
select d.department_name, 
    concat(e.first_name, e.last_name), 
    e.hire_date, e.salary, 
    TIMESTAMPDIFF(YEAR, e.hire_date, curdate()) as XP
from hr.departments as d
JOIN hr.employees as e ON d.manager_id = e.employee_id
WHERE TIMESTAMPDIFF(YEAR, e.hire_date, curdate()) > 15;
