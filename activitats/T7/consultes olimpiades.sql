/* 'Olimpíades de Cicles Formatius' és un esdeveniment cultural on participen diferents alumnes de diversos instituts de la província de Cadis en diversos Cicles Formatius (Administració, Electrònica i Informàtica). Cada institut participa amb un nombre màxim d'alumnes per a cadascun dels cicles. Per cada cicle se donen 3 premis (Or, Plata i Bronze). Els premis es concedeixen a l'institut, no als alumnes. Amb l'objectiu d'emmagatzemar aquesta informació, s'ha dissenyat la base de dades Olimpíades.
*/


-- 1) Llista d'instituts (nom) i localitat on se troben.
select i.nom, l.nom
from instituts as i
join localitats as l on l.id = i.localitats_id;

-- 2) Llista d'instituts (nom i entre parèntesi la localitat on se troba) amb els seus alumnes (nom i data de naixement).
SELECT CONCAT(i.nom, " ( ", l.nom, " )") AS 'Institut i localitat',
    a.nom AS 'Nom alumne',
    a.data_naixement
FROM instituts i
JOIN localitats l ON (l.id = i.localitats_id)
JOIN alumnes a ON (a.instituts_id = i.id);

-- 3) Llista alfabètica dels participants de les olimpíades indicant nom del participant, dorsal (compost per identificador de l'institut i identificador de l'alumne), institut al que pertany i localitat d'aquest.
SELECT a.nom as alumne, CONCAT(a.instituts_id, a.id) as dorsal, i.nom as institud, l.nom as localitat
FROM participants as p
	JOIN alumnes as a ON a.instituts_id = p.alumnes_instituts_id AND p.alumnes_id = a.id
	JOIN instituts as i ON i.id = a.instituts_id
	JOIN localitats as l ON l.id = i.localitats_id
ORDER BY a.nom;

-- 4) Llista d'instituts participants indicant nom de l'institut, nombre d'Ors, nombre de Plates, nombre de Bronzes i total de medalles, en ordre descendent per aquest darrer valor.
select distinct i.nom, 
    (select count(*) from premiats as pr where pr.instituts_id = p.alumnes_instituts_id and pr.posicio = 1) as ors, 
    (select count(*) from premiats as pr where pr.instituts_id = p.alumnes_instituts_id and pr.posicio = 2) as plata, 
    (select count(*) from premiats as pr where pr.instituts_id = p.alumnes_instituts_id and pr.posicio = 3) as bronze,
    (select count(*) from premiats as pr where pr.instituts_id = p.alumnes_instituts_id) as total
from participants as p
join instituts as i on i.id = alumnes_instituts_id
order by total desc;

select i.nom,
	ifnull(sum(posicio = 1), 0) as 'ors',
    ifnull(sum(posicio = 2), 0) 'plates',
    ifnull(sum(posicio = 3), 0) 'bronzes',
    count(posicio) as total
from instituts as i
left join premiats as p on i.id = p.instituts_id
group by i.id
order by total desc;

-- 5) Llista alfabètica de localitats que NO han aconseguit cap medalla a les Olimpíades.
select distinct l.nom
from localitats as l
join instituts as i on l.id = i.localitats_id
where i.id not in (select distinct instituts_id from premiats);

select nom
from localitats
where nom not in (select distinct l.nom from premiats as p
	join instituts as i on i.id = p.instituts_id
	join localitats as l on l.id = i.localitats_id);
    
select distinct l.nom from premiats as p
join instituts as i on i.id = p.instituts_id
right join localitats as l on l.id = i.localitats_id
where i.id is null;

-- 6) Llista de participants d’una determinada modalitat. Mostrar dorsal i nom del participant. El llistat estarà ordenat per dorsal.
select a.nom as participant, m.nom as modalitat, concat(a.instituts_id, a.id) AS dorsal
from alumnes as a
join participants as p on a.instituts_id = p.alumnes_instituts_id and a.id = p.alumnes_id
join modalitats as m on m.id = p.modalitats_id
order by dorsal;

select a.nom as participant, concat(a.instituts_id, a.id) AS dorsal
from alumnes as a
join participants as p on a.instituts_id = p.alumnes_instituts_id and a.id = p.alumnes_id
join modalitats as m on m.id = p.modalitats_id
where m.nom = 'Administrativo'
order by dorsal;

-- 7) Llista de medalles indicant modalitat (nom), institut (nom) i tipus de medalla (or, plata o bronze). Ordenar per modalitat i medalla.
SELECT m.nom AS 'Modalidad', i.nom AS 'Instituto', 
    CASE premiats.posicio
        WHEN 1 THEN 'Oro'
        WHEN 2 THEN 'Plata'
        WHEN 3 THEN 'Bronce'
    END AS 'Medalla'
FROM premiats
JOIN modalitats m ON m.id = premiats.modalitats_id
JOIN instituts i ON i.id = premiats.instituts_id
ORDER BY m.nom, premiats.posicio;

-- 8) Nom de l'alumne de més edat, l'institut on va i l'edat que té.
select i.nom, a.nom, timestampdiff(year, a.data_naixement, curdate()) as edad
from alumnes as a
join instituts as i on i.id = a.instituts_id;

select max(timestampdiff(year, a.data_naixement, curdate())) as edad
from alumnes as a;

select i.nom as institut, a.nom as alumne, timestampdiff(year, a.data_naixement, curdate()) as edad
from alumnes as a
join instituts as i on i.id = a.instituts_id
where timestampdiff(year, a.data_naixement, curdate()) = (select max(timestampdiff(year, data_naixement, curdate()))from alumnes);

-- 9) Estadística que mostra quants alumnes hi ha de cada sexe per cada any de naixement.
select year(data_naixement) as 'any', sexe, count(*)
from alumnes
group by year(data_naixement), sexe
order by 'any', sexe;

select year(data_naixement) as 'any', 
	sum(sexe = 'M') as 'Home',
    sum(sexe = 'F') as 'Dona'
from alumnes
group by year(data_naixement), sexe
order by 'any';

-- 10) Afegeix columna a instituts amb el nom de la localitat.
alter table instituts add column localitat varchar(45);

update instituts as i 
join localitats as l on l.id = i.localitats_id
set i.localitat = l.nom;



























