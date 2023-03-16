-- 1) List of databases (2 solutions)
SHOW DATABASES;

SELECT * FROM INFORMATION_SCHEMA.SCHEMATA;

-- 2) List of tables in 'sanitat' database (2 solutions)


SELECT TABLE_SCHEMA, TABLE_NAME
FROM information_schema.TABLES
WHERE TABLE_SCHEMA;

-- 3) List of databases on our server with more then 5 tables.
SELECT TABLE_SCHEMA, COUNT(*)
FROM INFORMATION_SCHEMA.TABLES
GROUP BY TABLE_SCHEMA
HAVING COUNT(*) > 5;

-- 4) List of tables (and its database, of course) with less than 3 columns.
SELECT table_schema AS "Database Name", 
       table_name AS "Table Name", 
       COUNT(column_name) AS "Number of Columns"
FROM information_schema.columns
GROUP BY table_schema, table_name
HAVING COUNT(column_name) < 3;

-- 5) In 'sanitat' database, show table name and constraint name where the 'HOSPITAL_COD' column of HOSPITAL table is referenced? 
SELECT * FROM information_schema.key_column_usage
WHERE CONSTRAINT_SCHEMA = 'sanitat';

select * from information_schema.key_column_usage where table_schema = "sanitat" and column_name = 'hospital_cod';

-- 6) List of columns (with its database and table name) with an auto_increment option.
SELECT table_schema, table_name, column_name 
FROM information_schema.columns
where extra = 'auto_increment';

-- 7) Write a comand to get the sentence to create the HOSPITAL table of 'sanitat' database;
SHOW CREATE TABLE sanitat.HOSPITAL;

-- 8) Which tables on our server have the MyISAM engine?
SELECT * FROM information_schema.`TABLES`
WHERE ENGINE = 'MyISAM';

-- 9) List different data types that are used on our server.
SELECT DISTINCT data_type 
FROM information_schema.COLUMNS;

-- 10) How many tables (not from information_schema) have been created during the last month?
SELECT count(*) 
from information_schema.`TABLES` 
where table_schema != 'information_schema' 
	and TIMESTAMPDIFF(month, create_time, CURDATE()) < 1;




