-- EXECISI

-- crear dues tules, parell i imparells, amb un camp tipo int. Fer un procediment amb un parametre in tope int, un out conta_p int (num registres insertats a parells) i un out conta_i (num registres insertats a imparells) int

DELIMITER $$

drop database if exists parametres $$
create database parametres $$
use parametres $$

create table parell (
	num int primary key
) $$

create table imparell (
	num int primary key
) $$

create procedure insertNum (in tope int, out conta_p int, out conta_i int)
begin
	declare num int;
	set num = 0;
    
    while tope > num do
		set num = num + 1;
        
        if num % 2 = 0 then
			insert into parell values(num);
		else
			insert into imparell values(num);
		end if;
	end while;
    
    set conta_p = (select count(*) from parell);
	set conta_i = (select count(*) from imparell);
end $$

set @tope = 50 $$

call insertNum(@total, @contar_p, @contar_i) $$

select num from imparell $$
select num from parell $$



























