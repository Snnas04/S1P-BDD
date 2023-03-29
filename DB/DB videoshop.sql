create database videoshop;
use videoshop;

 create table films (
  id_film smallint unsigned auto_increment,
  title varchar(50) not null,
  actor varchar(30),
  length tinyint unsigned,
  primary key (id_film)
 );

 insert into films (title,actor,length) values('Elsa y Fred','China Zorrilla',90);
 insert into films (title,actor,length) values('Mision imposible','Tom Cruise',120);
 insert into films (title,actor,length) values('Mision imposible 2','Tom Cruise',180);
 insert into films (title,actor,length) values('Harry Potter y la piedra filosofal','Daniel H.',120);
 insert into films (title,actor,length) values('Harry Potter y la camara secreta','Daniel H.',150);
