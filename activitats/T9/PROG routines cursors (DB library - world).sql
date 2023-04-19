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
    
    if bc is not null then
		delete from COPIES where COPY_CODE = cc;
        select count(*) into ncopies from COPIES where BOOK_CODE = bc;
        
        if ncopies = 0 then
			delete from BOOKS where BOOK_CODE = bc;
		end if;
	end if;
end //

call delete_copy(250, @queden) //
call delete_copy(17, @queden) //


-- We have been asked to add a new code for cities, that is, an alternative id. This new identifier will have 6 characters, the first three are the country code, and the next three characters are a number sequence from 1 to total number of cities of this country. For example, in Spain there are 59 cities, so the new identifiers will be from ESP001 to ESP059, and analogously for each country.
use world;



























