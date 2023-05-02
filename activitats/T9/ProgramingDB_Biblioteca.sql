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

delimiter ;

set @autors = AutorsLlibre(123);
select @autors;


-- 5
CREATE TABLE llibresLog (
    book_code INT,
    operation ENUM('Insert', 'Delete', 'Update'),
    new_title VARCHAR(200),
    old_title VARCHAR(200),
    new_isbn VARCHAR(25),
    old_isbn VARCHAR(25),
    user VARCHAR(200),
    daatetime DATETIME,

    PRIMARY KEY (book_code, daatetime)
);

delimiter $$

CREATE TRIGGER llibreInsert
    AFTER INSERT ON LLIBRES
    FOR EACH ROW
BEGIN
    INSERT INTO llibresLog (book_code, operation, new_title, new_isbn, user, daatetime) VALUES
        (NEW.ID_LLIB, 'Insert', NEW.TITOL, NEW.ISBN, CURRENT_USER(), NOW());
END $$

CREATE TRIGGER llibreDelete
    before DELETE ON LLIBRES
    FOR EACH ROW
BEGIN
    INSERT INTO llibresLog VALUES
        (OLD.ID_LLIB, 'Delete', null, old.TITOL, null, old.ISBN, CURRENT_USER(), NOW());
END $$

CREATE TRIGGER llibreUpdate
    AFTER UPDATE ON LLIBRES
    FOR EACH ROW
BEGIN
    INSERT INTO llibresLog VALUES
        (NEW.ID_LLIB, 'Update', NEW.TITOL, OLD.TITOL, NEW.ISBN, OLD.ISBN, CURRENT_USER(), NOW());
END $$

delimiter ;

-- comprovar trigger per fer insert
insert into LLIBRES (ID_LLIB, TITOL, ISBN, IMG_LLIB) VALUES (9000, 'ALICE IN WONDERLAND', 'AAAABBBBR4445', NULL);
SELECT * FROM LLIBRES order by ID_LLIB desc;
select * from llibresLog;

-- comprovar trigger per fer update
update LLIBRES
set TITOL = 'ALICE II' where ID_LLIB = 9000;
select  * from LLIBRES order by ID_LLIB desc;
select * from llibresLog;

-- comprovar trigger per fer delete
delete from LLIBRES
where ID_LLIB = 9000;
select  * from LLIBRES order by ID_LLIB desc;
select * from llibresLog;


-- 6


-- 7
select * from LLIBRES
where ID_LLIB not in (select distinct FK_IDLLIB from EXEMPLARS);

select count(*) from EXEMPLARS; -- 10107
select count(*) from LLI_AUT; -- 8727
select count(*) from LLI_TEMA; -- 14957
select count(*) from RESERVES; -- 0

create event netejaExemplars
    on schedule every 2 minute
    do
    begin
        start transaction;
        delete from LLI_AUT where FK_IDLLIB not in (select distinct FK_IDLLIB from EXEMPLARS);
        delete from LLI_TEMA where FK_IDLLIB not in (select distinct FK_IDLLIB from EXEMPLARS);
        delete from RESERVES where FK_IDLLIB not in (select distinct FK_IDLLIB from EXEMPLARS);
        delete from LLIBRES where ID_LLIB not in (select distinct FK_IDLLIB from EXEMPLARS);
        commit;
    end;

show events;
