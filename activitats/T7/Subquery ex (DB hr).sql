USE hr;

-- 1. Write a query to find the names (first_name, last_name) and salaries of the employees who have higher salary than the employee whose last_name is 'Bull'.


-- 2. Find the names (first_name, last_name) of all employees who work in the IT department.
select first_name, last_name from employees
where department_id = (select department_id from departments where department_name = 'IT');

-- 3. Find the names (first_name, last_name) of the employees who are managers.
select employee_id, first_name, last_name from hr.employees
where employee_id in (select distinct manager_id from hr.employees);

-- 4. Find the names (first_name, last_name) and salary of the employees whose salary is greater than the average salary.
select first_name, last_name, salary from hr.employees
where salary > (select AVG(salary) from hr.employees);

-- 5. Find the names (first_name, last_name) and salary of the employees who earn more than the average salary and who works in any of the IT departments.
select first_name, last_name, salary from hr.employees
where salary > (select AVG(salary) from hr.employees)
    and department_id = (select department_id from departments where department_name = 'IT');

-- 6.Find the names (first_name, last_name) and salary of the employees who earn more than Mr. Bell. 
select first_name, last_name, salary from hr.employees
where salary > (select salary from hr.employees where last_name = 'Bell');

-- 7. Find the names (first_name, last_name) and salary of the employees who earn the same salary as the minimum salary for all employees.
select first_name, last_name, salary from hr.employees
where salary = (select min(salary) from hr.employees);

-- 8. Find the names (first_name, last_name)and salary of the employees whose salary is greater than average salary of all department.
select first_name, last_name, salary from hr.employees
where salary > (select avg(salary) from hr.employees);

-- 9. Write a query to find the names (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results on salary from the lowest to highest, Fint two different solutions.
select first_name, last_name, salary from hr.employees
where salary > (select max(salary) from hr.employees where job_id = 'SH_CLERK') order by salary asc;

select first_name, last_name, salary from hr.employees
where salary >all (select salary from hr.employees where job_id = 'SH_CLERK') order by salary asc;

-- 10. Write a query to find the names (first_name, last_name) of the employees who are not managers.
select first_name, last_name from hr.employees
where employee_id not in (select distinct manager_id from hr.employees where manager_id is not null);

-- 11. Write a query to find the 5th maximum salary in the employees table (pay attention to the repeated salaries). 
select DISTINCT salary from hr.employees
ORDER BY salary desc limit 4,1;

-- 12. Write a query to find the 4th minimum salary in the employees table.
select DISTINCT salary from hr.employees
ORDER BY salary desc limit 3, 1;

-- 13. Write a query to list department number, name for all the departments in which there are no employees in the department.
select department_id, department_name from hr.departments
where department_id not in (select DISTINCT department_id from hr.employees);

-- 14. Write a query to get 3 maximum salaries.
select DISTINCT salary from hr.employees
ORDER BY salary desc
limit 3;

-- 15. Find the names (first_name, last_name) and salary of the employees whose salary is equal to the minimum salary for their job grade (pay attention to the predetermined minimum and maximum salary for every job).
select first_name, last_name, salary
from hr.employees as e
where salary = (select min_salary from hr.jobs WHERE job_id = e.job_id);

-- 16. Write a query to display the employee ID, first name, last names, and department names of all employees.
select employee_id, first_name, last_name, (select department_name from hr.departments WHERE department_id = e.department_id) as 'department name'
from hr.employees as e;

-- 17. Write a query to display the employee ID, first name, last names, salary of all employees whose salary is above average for their departments.
select employee_id, first_name, last_name, salary
from hr.employees as e
WHERE salary > (SELECT AVG(salary) from hr.employees WHERE department_id = e.department_id);
