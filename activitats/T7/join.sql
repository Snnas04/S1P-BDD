use empresa;

select * from empresa.`EMP`
CROSS JOIN dept on emp.dept_no = dept.dept_no;

select * from empresa.`EMP`
INNER JOIN dept on emp.dept_no = dept.dept_no;

select * from empresa.`EMP`
JOIN dept on emp.dept_no = dept.dept_no;

--
use lliga;

select j.*, e.nom from lliga.jugadors as j
JOIN lliga.equips as e ON j.equip = e.id_equip;

select p.*, el.nom as local, ev.nom as visitant
from lliga.partits as p
JOIN lliga.equips as el ON p.elocal = el.id_equip
JOIN lliga.equips as ev ON p.evisitant = ev.id_equip;

-- 
use world;

select co.name, cy.* from city as cy
JOIN world.country as co ON cy.CountryCode = co.Code;

select co.code, co.name, co.continent, co.population, co.capital, ci.name from country as co
join city as ci on co.capital = ci.id;
