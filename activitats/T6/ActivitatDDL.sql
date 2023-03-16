create database DDL;
use DDL;


create table EDIFICIO (
	codigo tinyint PRIMARY key,
    
    nombre VARCHAR(100),
    direccion varchar(200),
    ciudad varchar(50),
    superficie float,
    num_apartat tinyint
);

create table APARTAMENTO (
	edificio tinyint,
    numero tinyint,
    letra char(1),
    
    superficie float,
    num_habitaciones tinyint,
	balcon tinyint(1),
    propietario varchar(9),
    
    PRIMARY key (edificio, numero, letra),
    foreign key (edificio) references EDIFICIO (codigo)
);

create table ALQUILER (
	edificio TINYINT,
    numero tinyint,
	letra char(1),
    dia_entrada date,
    
    dia_salida date,
    inquilino varchar(100),
    
    primary key (edificio, numero, letra, dia_entrada),
    foreign key (edificio, numero, letra) references APARTAMENTO (edificio, numero, letra)
);


insert into EDIFICIO
values (1, "name", "address", "city", 40.0, 1);

insert into APARTAMENTO
values (1, 1, "a", 20.0, 2, 1, "owner");

insert into ALQUILER
values (1, 1, "a", curdate(), null, "inquilino");
