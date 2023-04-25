DELIMITER $$

-- 1) Write what you need to manage the log_facturas with the current date, the number of the invoice and the user who inserted a new invoice into facturas table.
USE comercio$$


/* 2) Triggers: LOGGING and AUDITING.
The bookseller has asked us to implement a change control system on the 'libros' registers. To do this we will create a table containing the following information:

- id for this table
- date and time of the modification
- user
- book code
- type of operation (INSERT, DELETE, UPDATE)
- old price (for deleting and updating)
- new price (fot updating and inserting)

This table will be kept automatically with TRIGGERS on the 'libros' table
*/
USE libreria$$


/* 3) Trigger. Sale of tickets.

A website specializing in ticket sales has problems because sometimes more tickets are sold than can really be put up for sale. The data structure is:
*/
create database SHOWS $$
use SHOWS $$

create table shows
(id int not null,
 show_name varchar(500) not null,
 tickets_for_sale int not null,
 tickets_sold int not null default 0,
 primary key (id))$$

insert into shows 
(id, show_name, tickets_for_sale)
values
(1,'Barça-Madrid', 5 ), -- 5 tickets available for selling
(2,'Concert Madonna', 9 ), -- 9 tickets available for selling
(3,'Màgia amb Maria Bimbolles', 1000 )$$ -- 1000 tickets available for selling

create table tickets 
( id int auto_increment not null,
  id_card_buyer varchar(200) not null,
  show_id int not null,
  primary key (id),
  foreign key (show_id) references shows (id))$$
  
-- Write a trigger that:
-- a) updates tickets_sold, and 
-- b) does not allow you to sell more tickets than the tickets_for_sale.



insert into tickets values (null,'12345678',1) $$ -- After this insert, we have 1 ticket sold
insert into tickets values (null,'8888',1) $$ -- After this insert, we have 2 ticket sold
insert into tickets values (null,'7777',1) $$ -- After this insert, we have 3 ticket sold
insert into tickets values (null,'6666',1) $$ -- After this insert, we have 4 ticket sold
insert into tickets values (null,'5555',1) $$ -- After this insert, we have 5 ticket sold
insert into tickets values (null,'4444',1) $$ -- Error Code: 1644. Tickets sold out!
