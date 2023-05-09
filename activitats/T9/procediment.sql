select * from information_schema.TABLES where TABLE_NAME = 'city';

select count(*) from world.city;

-- contar quantes files te cada taula d'una base de dades
use world;
drop procedure if exists tablecounter;
create procedure tablecounter(db varchar(20))
    reads sql data
begin
    declare fin boolean default false;
    declare tab varchar(45);
    declare myCursor cursor for select TABLE_NAME from information_schema.TABLES where TABLE_SCHEMA = db;
    declare continue handler for not found set fin = true;

    open myCursor;
    bucle: loop
        fetch myCursor into tab;
        if fin = true then
            leave bucle;
        end if;
        set @result = concat('SELECT COUNT(*) ',tab,' FROM ', db, '.', tab, ';');
        PREPARE prepared_stmt FROM @result;
        EXECUTE prepared_stmt;
    end loop;
    close myCursor;
end;

call tablecounter('lliga');
