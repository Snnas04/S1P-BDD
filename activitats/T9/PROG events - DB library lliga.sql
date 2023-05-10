show variables like 'event_scheduler';
set global event_scheduler = on;

/* (1) On the "library" database:
   Create a simple event to capitalize all names and surnames in the MEMBERS table. Requirements:
     a) Once this event has expired, it must not be dropped.
     b) This event must not be active
   How can you active this event?  
*/
use library;
create event capitalizeNames
on schedule at now()
on completion preserve disable
do
begin
    update MEMBERS set NAME = upper(NAME);
    update MEMBERS set SURNAMES = upper(SURNAMES);
end;

alter event capitalizeNames enable;

show events;

select NAME, SURNAMES from MEMBERS;

/* (2) On database 'library', 
   a) Create 'not_returned' table with 2 fields, id and copy code.
   b) Create an event to run every morning at 06:00 for inserting into previous table those copies whose dead date is reached and they are not yet returned.
*/
create table not_returned(
    id int primary key auto_increment,
    copyCode int
);

create event copiesNotReturned
on schedule every 1 day
    starts time ('6:00')
on completion preserve
do
begin
    declare llibre int;
    declare fin boolean default false;

    declare myCursor cursor for select COPY_CODE from BORROWS where RETURN_DATE is null and DEAD_DATE < now();
    declare continue handler for not found set fin = true;

    open myCursor;
    bucle: loop
        fetch myCursor into llibre;
        if fin = true then
            leave bucle;
        end if;
        insert into not_returned values (null, llibre);
    end loop;
    close myCursor;
end;

-- python event
CREATE EVENT getMorosos
    ON SCHEDULE EVERY 1 DAY STARTS TIME('06:00:00') DO
    BEGIN
        TRUNCATE TABLE not_returned;
        INSERT INTO not_returned (copyCode)
        SELECT COPY_CODE
        FROM BORROWS
        WHERE RETURN_DATE IS NULL AND DEAD_DATE < CURDATE();
    END;

show events;
select * from not_returned;

select * from performance_schema.error_log; -- veure els errors d'un event

alter event copiesNotReturned disable;

/* (3) On database 'library':
   a) Create 'no_copies' table with 3 fields, id, book code and book title.
   b) Create an event disabled, not repetitive and planned to run at 23:00. This event must insert into previous table those books without copies.
*/


/* (4) On database 'lliga':
  a) Insert 5 basketball matches (played during the current month or planned for the future) into 'partits' table.
  b) Create 'historic_partits' table with the same structure as 'partits'.
  c) Create an event (executed EVERY month from now) to keep on 'partits' table only basketball matches from current month and on. The other basketball matches will be unload from 'partits' table (that is, deleted) and saved on 'historic_partits' table
  
REMARK: If you need more than one statement in the event body, a block BEGIN-END is a must.
*/
