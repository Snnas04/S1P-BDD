create database libreria;
USE libreria;

 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15),
  precio decimal(5,2) unsigned,
  cantidad mediumint unsigned,
  primary key(codigo)
 );


 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('El aleph','Borges','Planeta',15,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Martin Fierro','Jose Hernandez','Emece',22.20,200);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Antologia poetica','J.L. Borges','Planeta',40,150);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Aprenda PHP','Mario Molina','Emece',18.20,200);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',36.40,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Manual de PHP', 'J.C. Paez', 'Paidos',30.80,120);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Harry Potter y la piedra filosofal','J.K. Rowling','Paidos',45.00,50);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Harry Potter y la camara secreta','J.K. Rowling','Paidos',46.00,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',null,200);

 insert into libros values(10,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00,45);
 insert into libros values(11,'Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00,133);
 insert into libros values(12,'Aprenda PHP','Mario Molina','Siglo XXI',40.00,26);
 insert into libros values(13,'El aleph','Borges','Emece',10.00,7);
 insert into libros values(14,'Ilusiones','Richard Bach','Planeta',15.00,68);
 insert into libros values(15,'Java en 10 minutos','Mario Molina','Siglo XXI',50.00,54);
 insert into libros values(16,'Martin Fierro','Jose Hernandez','Planeta',20.00,12);
 insert into libros values(17,'Martin Fierro','Jose Hernandez','Emece',30.00,12);
 insert into libros values(18,'Uno','Richard Bach','Planeta',10.00,7);