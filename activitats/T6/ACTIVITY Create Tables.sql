create database proves;
use proves;


-- fabricants
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


-- departaments
create table DEPARTAMENTOS (
	Codigo int,
    Nombre varchar(100),
    Presupuesto int,
    PRIMARY KEY (Codigo)
);

create table EMPLEADOS (
	DNI VARCHAR(8),
    Nombre VARCHAR(100),
    Apellidos VARCHAR(255),
    Departamento int,
	PRIMARY KEY (DNI),
    FOREIGN KEY (Departamento) REFERENCES DEPARTAMENTOS (Codigo)
);

-- magatzems
create table ALMACENES (
	Codigo int PRIMARY key,
    Lugar VARCHAR(100) not null,
    Capacidad int not null
);

create TABLE CAJAS (
	NumReferencia char(5) primary key,
    Contenidor varchar(100) not null,
    Valor int not null,
    Almacen int not null,
    FOREIGN KEY (Almacen) REFERENCES ALMACENES (Codigo)
);


-- cine
create table PELICULAS (
	Codigo int primary key,
    Nombre varchar(100) not null,
    CalificacionEdad int
);

create table SALAS (
	Codigo int primary key,
    Nombre VARCHAR(100) not null,
    Pelicula int,
    FOREIGN KEY (Pelicula) references PELICULAS (Codigo)
);


-- proveidors
create table PIEZAS (
	Codigo int PRIMARY key,
    Nombre VARCHAR(100)
);

create table PROVEEDORES (
	ID char(4),
    Nombre varchar(100) not null
);

create table SUMINISTRA (
	CodigoPieza int,
    IDProveidor char(4),
    Precio int,
    primary key (CodigoPieza, IDProveidor),
    foreign key (CodigoPieza) references PIEZAS (Codigo),
    foreign key (IDProveidor) references PROVEEDORES (ID)
);


-- cientifics
CREATE TABLE proyecto (
  ID CHAR(4) PRIMARY KEY,
  nombre VARCHAR(255),
  horas INT
);

CREATE TABLE CIENTIFICOS (
  DNI VARCHAR(8) PRIMARY KEY,
  NomApels VARCHAR(255)
);

CREATE TABLE ASIGNADO_A (
    Cientifico varchar(8),
    Proyecto char(4),

    PRIMARY KEY (Cientifico, Proyecto),
    FOREIGN KEY (Cientifico, Proyecto) REFERENCES PROYECTO(ID)
);


-- grans magatzems
CREATE TABLE CAJEROS (
	Codigo INT PRIMARY KEY,
    NomApels VARCHAR(255) NOT NULL
);

CREATE TABLE PRODUCTOS (
	Codigo INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Precio INT
);

CREATE TABLE MAQUINAS_REGISTRADORAS(
	Codigo INT PRIMARY KEY,
    Piso INT
);

CREATE TABLE VENTA(
	Cajero INT,
    Maquina INT,
    Producto INT,
    
    PRIMARY KEY (Cajero, Maquina, Producto),
    FOREIGN KEY (Cajero) REFERENCES CAJEROS (Codigo),
    FOREIGN KEY (Maquina) REFERENCES MAQUINAS_REGISTRADORAS (Codigo),
    FOREIGN KEY (Producto) REFERENCES PRODUCTOS (Codigo)
);


-- investigadors
create table FACULTAD (
	Codigo int,
    Nombre varchar(100),
    primary key (Codigo)
);

create table INVESTIGADORES (
	DNI varchar(8),
    NomApels varchar(255) NOT NULL,
    Facultad int NOT NULL,
    primary key (DNI),
    foreign key (Facultad) references FACULTAD (Codigo)
);

create table EQUIPOS (
	NumSerie char(4),
    Nombre varchar(100) NOT NULL,
    Facultad int NOT NULL,
    primary key (NumSerie),
    foreign key (Facultad) references FACULTAD (Codigo)
);

CREATE TABLE ASIGNADO_A (
    Cientifico varchar(8),
    Proyecto char(4),
    
    PRIMARY KEY (Cientifico, Proyecto),
    FOREIGN KEY (Cientifico) REFERENCES CIENTIFICOS(DNI),
    FOREIGN KEY (Proyecto) REFERENCES PROYECTO(ID)
);
