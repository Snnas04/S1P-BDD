-- We will create a Stored Procedure to delete copies, which will have as input parameters, the copy code, and as output, a parameter that tells us how many copies left of the book. If the number of copies reaches zero the Stored Procedure will delete the book automatically.
use library;

delimiter //

drop procedure if exists delete_copy //
create procedure delete_copy (cc int, out ncopies tinyint)
inici: begin
	declare bc char(4);
    
    if exists (select * from BORROWS where COPY_CODE = cc and RETURN_DATE is null) then
		select 'Aquesta copia esta en presete. No es pot eliminar';
        leave inici;
	end if;
	select BOOK_CODE into bc from COPIES where COPY_CODE = cc;
    
	delete from BORROWS where COPY_CODE = cc;    
	delete from COPIES where COPY_CODE = cc;
    
    if bc is null then
		select 'Aquesta copia no existeix';
	end if;
    
    if bc is not null then
		delete from COPIES where COPY_CODE = cc;
        select count(*) into ncopies from COPIES where BOOK_CODE = bc;
        
        if ncopies = 0 then
			delete from GENREBOOK where BOOK_CODE = bc;
			delete from BOOKS where BOOK_CODE = bc;
		end if;
	end if;
end //

delimiter ;

call delete_copy(250, @queden); -- la copia s'ha eliminat (com s'ha eliminat ja no existeix)
call delete_copy(17, @queden);  -- la copia esta en prestec
call delete_copy(1, @queden);   -- la copa no existeix
call delete_copy(22, @queden);


-- We have been asked to add a new code for cities, that is, an alternative id. This new identifier will have 6 characters, the first three are the country code, and the next three characters are a number sequence from 1 to total number of cities of this country. For example, in Spain there are 59 cities, so the new identifiers will be from ESP001 to ESP059, and analogously for each country.

use world;

alter table city add column newCode char(6);

delimiter !!

create procedure codificar()
begin
	declare vID int;
    declare vCountryCode char(3);
    declare darrerPais char(3) default '';
    declare cont int;
	declare final boolean default false;
    
	declare myCursor cursor for 
		select id, countryCode from world.city order by CountryCode, name;
	declare continue handler for not found set final = true;
    
    open myCursor;
    
    bucle: loop
		fetch myCursor into vID, vCountryCode;
		if final then
			leave bucle;
        end if;
        
        if vCountryCode != darrerPais then
			set cont = 0;
        end if;
        
        set cont = cont + 1;
        update city set newCode = concat(vCountryCode, lpad(cont, 3, '0')) where ID = vID;
        
        set darrerPais = vCountryCode;
    end loop;
    
    close myCursor;
end !!

delimiter ;

call codificar();



























