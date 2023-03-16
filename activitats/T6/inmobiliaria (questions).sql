-- 1. Create the database and tables with the required PKs and FKs
-- fet a l'arxiu ActivitatDDL

-- 2. Make the following modifications:

-- a) The field "inquilino" cannot take any null value.
alter table ALQUILER
modify inquilino 
varchar(100) not null;

-- b) In the "edificio" table, add a 'balcony' field that will be a boolean and is false by default
alter table APARTAMENTO
modify balcon BOOLEAN default false;

-- c) In the "alquiler" table, if the day of departure is not null, it must be after the day of entry.
alter table ALQUILER add constraint 
check(dia_salida > dia_entrada);

-- d) In the "edificio" Table, check that the area is larger than 30 square meters.
alter table EDIFICIO add constraint
check (superficie > 30.0);
