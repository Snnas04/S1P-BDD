-- 1
create user paco@localhost;
select * from mysql.user;

-- 2
create user joan@localhost identified by 'joan';
select * from mysql.user;

-- 3
grant select on world.city to paco@localhost;
show grants for paco@localhost;
select * from mysql.tables_priv;

-- 4
grant select, insert, update on world.* to joan@localhost with grant option;
select * from mysql.db;

-- 5
grant select on world.country to paco@localhost;
flush privileges;

-- 6
revoke select on world.city from paco@localhost;

-- 7
revoke all privileges , grant option from paco@localhost;
revoke all privileges , grant option from joan@localhost;

-- 8


-- 9


-- 10

