DROP DATABASE if EXISTS rutines;
create database rutines;
use rutines;

drop procedure if exists HolaMon;

create procedure HolaMon()
	select 'Hola mon';
    
call HolaMon;


drop procedure if exists HolaMon2;

create procedure HolaMon2()
begin
	select 'hola mon 2';
    select 'hola mon 3';
end;

call HolaMon2;

drop procedure if exists HolaMon3;

create procedure HolaMon3()
BEGIN
	SELECT 'test';
	SELECT 'test2';
END;

CALL HolaMon3;
