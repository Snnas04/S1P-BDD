use hr;

select min(salary) from employees;

select first_name, last_name
from employees
where salary = 2100;

-- subconsultes simples

select first_name, last_name from employees
where salary = (select min(salary) from employees);

select department_id, min(salary)
from employees
GROUP BY department_id
HAVING min(salary) < (select AVG(salary) from employees);
