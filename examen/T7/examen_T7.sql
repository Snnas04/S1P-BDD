-- 1
select nom, cognom, timestampdiff(month, data_registre, now()) as 'mesos'
from usuaris
where id_usuari in ('1', '6', '10', '13');


-- 2
select id_publicacio,
	(select data_creacio from comentaris order by data_creacio desc limit 1)
from publicacions
join comentaris as c on publicacio = id_publicacio;


-- 3
select p.id_publicacio
from publicacions as p
join publicacions_etiquetes as pe on p.id_publicacio = pe.publicacio
join etiquetes as e on e.id_etiqueta = pe.etiqueta
where e.nom = 'MySQL';


-- 4
-- join
select nom, titol
from usuaris
join publicacions on usuari = id_usuari
order by nom;

-- subconsulta
select (select nom from usuaris where id_usuari = usuari),
	titol
from publicacions
order by (select nom from usuaris where id_usuari = usuari);


-- 5
select titol
from publicacions
where (id_publicacio in (select publicacio from comentaris))
	and
    (id_publicacio not in (select publicacio from publicacions_etiquetes));


-- 6
select nom
from usuaris
order by data_registre
limit 2;


-- 7
select p.id_publicacio, c.contingut
from comentaris as c
join publicacions as p on p.id_publicacio = c.publicacio;


-- 8
select c.contingut, p.titol, u.nom, u.cognom
from comentaris as c
join publicacions as p on p.id_publicacio = c.publicacio
join usuaris as u on u.id_usuari = c.usuari;


-- 9
select id_publicacio, titol
from publicacions
join comentaris on publicacio = id_publicacio
group by id_publicacio
having count(id_comentari) >= 2;


-- 10
select id_publicacio, titol 
from publicacions
where id_publicacio not in (select publicacio from comentaris);


-- 11
select titol, 
	contingut,
    sum(m_agrada) as 'quantitat',
    (select avg(m_agrada) from publicacions) as 'mitja'
from publicacions
group by id_publicacio
having quantitat > mitja;

select m_agrada from publicacions;

-- 12
select titol
from publicacions as p
join comentaris as c on id_publicacio = publicacio
where day(p.data_creacio) = day(c.data_creacio);


-- 13
select nom
from etiquetes
join publicacions_etiquetes on id_etiqueta = etiqueta
join publicacions on id_publicacio = publicacio
group by nom
having sum(m_agrada) >= 2;


-- 14
select id_etiqueta
from etiquetes
join publicacions_etiquetes on etiqueta = id_etiqueta
join publicacions on id_publicacio = publicacio
where id_publicacio not in (select publicacio from publicacions_etiquetes);



























