create database proves;
use proves;

create table FABRICANTES (
	Codigo int primary key,
    Nombre VARCHAR(100)
);


CREATE TABLE ARTICULOS (
	Codigo int,
    Nombre VARCHAR(100),
    Precio int,
    Fabricante int,
    primary key (Codigo),
    foreign key (Fabricante) references FABRICANTES (Codigo)
);
