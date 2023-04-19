-- IN TYPE
DELIMITER $$

CREATE procedure proc1 (IN p int)
begin
	select p;
    set p = p + 1;
    select p;
end $$

set @var = 35 $$
select @var $$ -- 35
call proc2(@var) $$ -- 35 i 36
select @var $$ -- 35
-- var segueix set 35 perque es un parametre d'entrada

-- OUT TYPE

create procedure proc2 (OUT p int)
begin
	select p;
    set p = p + 1;
    select p;
    
    set p = 87;
    select p;
    set p = p + 1;
    select p;
end $$

select @var $$ -- 35
call proc2(@var) $$ -- mostra null sepre que no li assignem un valor, ja que nomes serveix per mostrar un valor, per aixo vem que els dos primers son null, i despres ja veim com augmenta...
select @var $$


-- INOUT TYPE

create procedure proc3 (inout p int)
begin
	select p;
    set p = p + 1;
    select p;
end $$

select @var $$
call proc3(@var) $$
select @var $$
-- fa les dues coses



























