-- On the EMPRESA database, indicate the sequence of sentences to be executed to carry out the following tasks:

--     Create two tables COM1986 and DET1986 that contain the data (header and detail) corresponding to the year 1986. 
--     These data loaded in the new tables must be eliminated from COMANDA and DETALL.
--     The new tables must have the same restrictions (PKs and indexes) as the tables where their data comes from.
--     Also create the corresponding FK between COM1986 and DET1986.

use empresa;

create table COM1986 as 
select * from COMANDA 
where year(com_data) = 1986;

create table DET1986 as 
select * from DETALL as d 
where (select year(com_data) from COMANDA where com_num = d.com_num) = 1986;


DELETE from empresa.`COMANDA` 
where year(com_data) = 1986;

DELETE from empresa.`DETALL` 
where (select year(com_data) from COMANDA where com_num = d.com_num) = 1986;

alter table com1986 add PRIMARY KEY (com_num);
alter table com1986 add INDEX (com_data, com_num);
alter table com1986 add INDEX (data_tramesa, com_num);

alter table det1986 add PRIMARY KEY (com_num. detall_num);
alter table det1986 add foreign key (com_num) REFERENCES com1986(com_num);
alter table det1986 add index (prod_num, com_num, detall_num);
