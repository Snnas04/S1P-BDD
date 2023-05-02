show variables like 'EVENT_SCHEDULER';
show events; -- de la bd que esteim actualment
select * from information_schema.EVENTS; -- de tot es server

-- exemple
use empresa;

create event bonificacio
on schedule at now()
do
begin
    update EMP set SALARI = SALARI + 100 where DATA_ALTA > '1981-12-01';
end;

select * from EMP where DATA_ALTA > '1981-12-01';


-- si posam on completion preserve se quede en el sistema
create event bonificacio
    on schedule at now()
    on completion preserve
    do
    begin
        update EMP set SALARI = SALARI + 100 where DATA_ALTA > '1981-12-01';
    end;

select * from EMP where DATA_ALTA > '1981-12-01';


-- periodic
create event bonificacio
    on schedule every 1 minute
    do
    begin
        update EMP set SALARI = SALARI + 100 where DATA_ALTA > '1981-12-01';
    end;

alter event bonificacio disable;

select * from EMP where DATA_ALTA > '1981-12-01';
