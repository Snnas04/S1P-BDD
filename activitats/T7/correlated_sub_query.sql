-- llista d'empleats que tenen el mateix ofici i el mateix salari qeu en fernandez

select ofici from empresa.`EMP`
WHERE COGNOM = 'FERNÁNDEZ';

select salari from empresa.`EMP`
WHERE COGNOM = 'FERNÁNDEZ';


select * from empresa.`EMP`
WHERE ofici = (select ofici from empresa.`EMP` WHERE COGNOM = 'FERNÁNDEZ')
    and salari = (select salari from empresa.`EMP` WHERE COGNOM = 'FERNÁNDEZ')
    and cognom != 'FERNÁNDEZ';

select * from empresa.`EMP`
where (ofici, salari) = (select ofici, salari from empresa.`EMP` where COGNOM = 'FERNÁNDEZ')
    and cognom != 'FERNÁNDEZ';




SELECT DNOM FROM empresa.`DEPT` WHERE dept_no = 10;

-- manera 1 fer tres selects diferents (NO-MALAMENT)
select emp_no, cognom, (SELECT DNOM FROM empresa.`DEPT` WHERE dept_no = 10) as departament
from empresa.`EMP` WHERE dept_no = 10;

select emp_no, cognom, (SELECT DNOM FROM empresa.`DEPT` WHERE dept_no = 20) as departament
from empresa.`EMP` WHERE dept_no = 20;

select emp_no, cognom, (SELECT DNOM FROM empresa.`DEPT` WHERE dept_no = 30) as departament
from empresa.`EMP` WHERE dept_no = 30;

-- manera 2 indicar qeu el dept_no de dept ha de ser igual al dept_no de emp (SI-BIEN)
select emp_no, cognom, dept_no, (SELECT DNOM FROM empresa.`DEPT` WHERE dept_no = EMP.dept_no) as departament
from empresa.`EMP`;

-- 

select emp_no, 
    cognom, 
    dept_no, 
    (SELECT DNOM FROM empresa.`DEPT` WHERE dept_no = e.dept_no) as departament, 
    cap,
    (SELECT cognom from empresa.`EMP` WHERE emp_no = e.dept_no) as boss
from empresa.`EMP` as e;

-- 

select `COM_NUM`,
    `COM_DATA`
    `COM_TIPUS`,
    `CLIENT_COD`,
    (SELECT nom FROM `CLIENT` WHERE `CLIENT_COD` = comanda.`CLIENT_COD`) as client,
    `DATA_TRAMESA`,
    `TOTAL`
from empresa.`COMANDA`;


-- world

select id, name, (select `Name` from world.country WHERE `Code` = city.`CountryCode`) as country
from world.city;

select code, name, continent, population, capital, (SELECT `Name` from world.city where `ID` = country.`Capital`) as NomCapital
from world.country;


-- airline

select flight_number,
    (SELECT location from `AIRLINE`.`AIRPORTS` where id_airport = f.departure_airport) as sortida,
    (select location from `AIRLINE`.`AIRPORTS` WHERE id_airport = f.arrival_airport) as arribada,
    (select alias from `AIRLINE`.`CREWS` WHERE id_crew = f.id_pilot) as alias_pilot,
    (select alias from `AIRLINE`.`CREWS` WHERE id_crew = f.id_copilot) as alias_copilot
FROM airline.`FLIGHTS` as f;
