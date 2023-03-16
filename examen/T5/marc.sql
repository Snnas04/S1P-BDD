-- 1
drop database if exists CIFP;
create database CIFP;
use CIFP;

create table CICLE (
	codi int primary key,
    nom varchar(80) not null,
    nivell varchar(10) not null,
    horabaixa tinyint(1) not null,
    acces varchar(100),
    data_creacio date not null,
    descripcio varchar(500)
);

create table MODUL (
	codi varchar(6) primary key,
    codi_boe char(4) not null,
    nom varchar(100) not null,
    hores smallint not null,
    angles tinyint(1) not null,
    imatge blob,
    descripcio varchar(200)
);

create table CURS (
	cicle char(3),
    ncurs tinyint,
    
    aula varchar(20) not null,
    
    primary key (cicle, ncurs)
	-- foreign key (cicle) references CICLE(codi)
);

create table ESTUDIS (
	cicle char(3),
    curs tinyint,
    modul varchar(6),
    
    suport tinyint(1) not null,
    professor varchar(100) not null,
    
    primary key (cicle, curs, modul)
    -- foreign key (cicle, curs, modul) references MODUL(codi)
);


-- 2
insert into MODUL values ('1', '1234', 'marc', 100, 1, null, null);
insert into MODUL values ('2', '2345', 'joan', 70, 2, null, null);
insert into MODUL values ('3', '3456', 'andreu', 120, 4, null, null);
insert into MODUL values ('4', '4567', 'esteve', 80, 3, null, null);
insert into MODUL values ('5', '5678', 'alicia', 90, 5, null, null);

insert into CICLE values ('123', 'multiplataforma', 'superior', 1, null, curdate(), null);
insert into CICLE values ('098', 'sistemas', 'superior', 1, null, curdate(), null);

insert into CURS values ('S1P', 1, 'A2F');
insert into CURS values ('S1S', 1, 'M1I');

insert into ESTUDIS values ('S1P', 1, '1234', 1, 'ramon');
insert into ESTUDIS values ('S1P', 1, '2345', 1, 'marti');


-- 3
-- en el amcbook no em funcionam el mysqldump, pero executaria aquest comandament:
-- mysqldump --xml CIFP > CIFP_info.xml -p

-- 4
alter table MODUL add check (hores between 30 AND 300);
-- alter table CICLE modify acces varchar(100) requisists not null;


-- 5
alter table MODUL add unique key (codi_boe);
alter table CICLE add check (horabaixa = 0 or horabaixa = 1);
alter table CICLE add check (nivell in('superior', 'mitjà', 'bàsic'));
alter table ESTUDIS add index (modul, professor);


-- 6
create table NEW_MODUL (
	codi varchar(6) primary key,
    nom varchar(100) not null,
    hores smallint not null,
    angles tinyint(1) not null,
    imatge blob,
    descripcio varchar(200),
    date date
);

insert into NEW_MODUL values ('1', 'marc', 100, 1, null, null, curdate());
insert into NEW_MODUL values ('2', 'joan', 70, 2, null, null, curdate());
insert into NEW_MODUL values ('3', 'andreu', 120, 4, null, null, curdate());
insert into NEW_MODUL values ('4', 'esteve', 80, 3, null, null, curdate());
insert into NEW_MODUL values ('5', 'alicia', 90, 5, null, null, curdate());

-- 7
-- alter table NEW_MODUL add constraint check (nom like MODUL(nom));

-- 8
select * 
from INFORMATION_SCHEMA.columns
where column_type = 'varchar';

select count(*)
from INFORMATION_SCHEMA.columns
where table_schema = 'CIFP';
