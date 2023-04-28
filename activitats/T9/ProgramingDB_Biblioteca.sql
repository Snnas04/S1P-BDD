-- 1
delimiter $$
create procedure AltaAutor(in code int, in name varchar(100), in birthdate datetime)
begin
    insert into AUTORS (ID_AUT, NOM_AUT, DNAIX_AUT) values (code, name, birthdate);
end $$

-- 2
create procedure AltaAutor2(name varchar(100), birthdate date)
BEGIN
    declare code int;
    set code = (select id_aut from autors order by ID_AUT desc limit 1);
    set code = code + 1;
    insert into autors (id_aut,nom_aut,dnaix_aut) values
        (code,name,birthdate);
end $$

-- 3
CREATE PROCEDURE AltaAutor3(IN name VARCHAR(50), IN birthdate DATE, IN nationality VARCHAR(50))
    READS SQL DATA
BEGIN
    DECLARE temp INT;
    SET temp = (SELECT ID_AUT FROM autors ORDER BY ID_AUT DESC LIMIT 1);

    IF NOT EXISTS(SELECT NACIONALITAT FROM nacionalitats WHERE NACIONALITAT = nationality) THEN
        INSERT INTO nacionalitats VALUES (nationality);
    end if;

    INSERT INTO autors VALUES (temp+1, name, birthdate, nationality, NULL);
end;

-- 4
select ID_LLIB AS 'CODE', TITOL as 'TITLE',
       e.NOM_EDIT as 'PUBLISHER',
       count(e2.NUM_EXM) as 'COPIES',
       AutorsLlibre(ID_LLIB) as 'AUTORS'
from LLIBRES
join editors e on e.ID_EDIT = LLIBRES.FK_IDEDIT
join exemplars e2 on LLIBRES.ID_LLIB = e2.FK_IDLLIB
group by ID_LLIB;

drop function AutorsLlibre;

create function AutorsLlibre(code int) returns varchar(255)
    reads sql data
begin
    return (select group_concat(a.NOM_AUT separator ' / ')
            from lli_aut
                     join autors a on lli_aut.FK_IDAUT = a.ID_AUT
            where FK_IDLLIB = code);
end $$

set @autors = AutorsLlibre(123);
select @autors;

-- 5

