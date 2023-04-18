DELIMITER $$

CREATE PROCEDURE llista_jugadors ()
begin
	declare resultat text default '';
    declare fin boolean default false;
	declare vnom,vcognom varchar(45);
    declare vsalari int;
    
	declare myCursor cursor for select nom,cognom,salari from jugadors;
    declare continue handler for not found set fin = true;
    
    -- set fin = false;
    open myCursor;
    bucle: loop
		fetch myCursor into vnom,vcognom,vsalari;
        if fin = true then
			leave bucle;
        end if;
        set resultat = concat(resultat,vnom,' ',ifnull(vcognom,''),' (',ifnull(vsalari,''),')\n');
	end loop;
    close myCursor;
    
    select resultat;
end $$

call llista_jugadors $$

