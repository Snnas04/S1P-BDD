drop database if exists comercio;
create database comercio;
use comercio;

 create table facturas(
  numero int not null,
  fecha date,
  cliente varchar(30),
  total decimal(6,2) default 0,
  primary key(numero)
 );


 create table detalles(
  numerofactura int not null,
  numeroitem int not null, 
  articulo varchar(30),
  precio decimal(5,2),
  cantidad int,
  primary key(numerofactura,numeroitem),
  constraint FK_detalles_numerofactura
   foreign key (numerofactura)
   references facturas(numero)
   on delete cascade
 );

 insert into facturas values(1200,'2007-01-15','Juan Lopez',0);
 insert into facturas values(1201,'2007-01-15','Luis Torres',0);
 insert into facturas values(1202,'2007-01-15','Ana Garcia',0);
 insert into facturas values(1300,'2007-01-20','Juan Lopez',0);

 insert into detalles values(1200,1,'lapiz',1,100);
 insert into detalles values(1200,2,'goma',0.5,150);
 insert into detalles values(1201,1,'regla',1.5,80);
 insert into detalles values(1201,2,'goma',0.5,200);
 insert into detalles values(1201,3,'cuaderno',4,90);
 insert into detalles values(1202,1,'lapiz',1,200);
 insert into detalles values(1202,2,'escuadra',2,100);
 insert into detalles values(1300,1,'lapiz',1,300);
 
 UPDATE facturas set total = (SELECT SUM(precio * cantidad) FROM detalles WHERE numerofactura = numero);

CREATE TABLE facturado_mes (anyo smallint, mes tinyint, facturado decimal(10,2), primary key(anyo,mes));
CREATE TABLE log_facturas (fecha DATETIME, usuario VARCHAR(20), nro_factura int);
