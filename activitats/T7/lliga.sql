use lliga;

select id_jugador,
    nom,
    cognom,
    posicio,
    equip, (select nom from lliga.equips where id_equip = j.equip) as nomEquip
from lliga.jugadors as j;

-- afegir a "equips" una columna amb les despeses (en salari)
alter table equips add column despeses int DEFAULT 0;

select sum(salari)
from lliga.jugadors
WHERE equip = 1;

update equips as e
set despeses = (select sum(salari) from lliga.jugadors WHERE equip = e.id_equip);

-- 
select * from partits;

select id_partit,
    (select nom from lliga.equips where id_equip = elocal) as equipLocal,
    (select nom from lliga.equips where id_equip = evisitant) as equipVisitant,
    resultat,
    data,
    arbit
from lliga.partits;

