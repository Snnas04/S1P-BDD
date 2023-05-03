-- 1. event cada 2s
-- avançar una cabra aleatoriament entre (-2 i 5) unitats
-- 2. trigger
-- actualitzar es camp de meatersSoFar cada vegada qeu una cabre se mogui

select * from goat order by rand() limit 1; -- selecionar una cabra aleatoriament

select floor(rand() * 8) -2; -- generar num entre -2 i 5 // formula floor(rand() * (max - min + 1)) + min

drop event if exists GoatsRace;
create event GoatsRace
on schedule every 2 second
do
begin
    declare dorsalGoat int;
    declare metersGoat int;
    declare meta int;
    set meta = 30;

    select dorsal into dorsalGoat from goat where metersSoFar < meta order by rand() limit 1;
    select floor(rand() * 8) -2 into metersGoat;

    insert into race (dorsal, meters) values (dorsalGoat, metersGoat);

    if (select count(*) from goat where metersSoFar >= meta) = 3 then
        alter event GoatsRace disable ;
    end if;
end;

drop trigger if exists goatUpdate;
create trigger goatUpdate
    after insert on race
    for each row
    update goat set metersSoFar = metersSoFar + NEW.meters where dorsal = NEW.dorsal;

select * from race order by meters desc;
select * from goat order by metersSoFar desc;
