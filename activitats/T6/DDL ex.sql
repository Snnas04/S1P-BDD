-- SOLVE THESE EXERCISES ON A TEST DATABASE

-- 1. Write a SQL statement to create a simple table countries including columns country_id,country_name and region_id. Insert into it 5 rows.
CREATE TABLE countries (
	country_id int AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT
);

INSERT INTO countries VALUES (null,'Inca',5);
INSERT INTO countries (country_name,region_id)VALUES ('Alcudia',6);
INSERT INTO countries VALUES (10,'Bugr',7);
INSERT INTO countries (country_name,region_id)VALUES ('Lloseta',8);
INSERT INTO countries (country_name,region_id)VALUES ('Santa Maria',4);

-- 2. Write a SQL statement to create a simple table countries (like in exercise 1) that already exists.
CREATE TABLE countries2 AS SELECT * FROM countries;

-- 3. Write a SQL statement to create the structure of a table dup_countries similar to countries.
CREATE TABLE countries3 LIKE countries;

-- 4. Write a SQL statement to create a duplicate copy of countries (named dup_countries2) table including structure and data.
CREATE TABLE countries4 AS SELECT * FROM countries;

-- 5. Write a SQL statement to create a table countries not allowing any null value.
CREATE TABLE countries5 (
	country_id int AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50) not null,
    region_id INT
);

-- 6. Write a SQL statement to create a table named countries including columns country_id,country_name and region_id and make sure that no duplicate data against column country_id will be allowed at the time of insertion.
CREATE TABLE countries6 (
	country_id int AUTO_INCREMENT UNIQUE,
    country_name VARCHAR(50) not null,
    region_id INT
);

-- 7. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.
CREATE TABLE jobs (
	job_id int PRIMARY KEY,
    job_title VARCHAR(50) DEFAULT '',
    min_salary int DEFAULT NULL,
    max_salary int DEFAULT NULL
);

INSERT INTO jobs (job_id) VALUE (1);

-- 8. Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make sure that the column country_id will be unique and store an auto incremented value.
CREATE TABLE countries8 (
	country_id int AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT
);

-- 9. Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make sure that the combination of columns country_id and region_id will be unique.
CREATE TABLE countries9 (
	country_id int AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT,
    
    UNIQUE (country_id, region_id)
);

-- ----------------------------------------------------------------------------------------------------------------
-- SOLVE THESE EXERCISES ON THE hr DATABASE

-- 1. Write a SQL statement to rename the table countries to country_new.
ALTER TABLE countries
RENAME TO country_new;

-- 2. Write a SQL statement to add a column region_id to the table locations.
ALTER TABLE locations
ADD COLUMN region_id INT;

-- 3. Write a SQL statement to add a columns ID as the first column of the table locations.
ALTER TABLE locations
ADD COLUMN ID INT FIRST;

-- 4. Write a SQL statement to add a column region_id after state_province to the table locations.
ALTER TABLE locations
ADD COLUMN region_id2 INT AFTER state_province;

-- 5. Write a SQL statement to change the data type of the column country_id to char (with 3 characters) in the table locations.
ALTER TABLE locations
MODIFY COLUMN country_id CHAR(3);

-- 6. Write a SQL statement to drop the column city from the table locations.
ALTER TABLE locations
DROP COLUMN city;

-- 7. Write a SQL statement to change the name of the column state_province to state, keeping the data type and size same.
ALTER TABLE locations
CHANGE state_province state VARCHAR(25);

-- 8. Write a SQL statement to add a primary key for the columns location_id in the locations table.
ALTER TABLE locations
MODIFY location_id INT;

ALTER TABLE locations
DROP PRIMARY KEY;

ALTER TABLE locations
ADD PRIMARY KEY (location_id);

-- 9. Write a SQL statement to add a primary key for a combination of columns location_id and country_id.
ALTER TABLE locations
DROP PRIMARY KEY;

ALTER TABLE locations
ADD PRIMARY KEY (location_id, country_id);

-- 10. Write a SQL statement to drop the existing primary from the table locations on a combination of columns location_id and country_id.
ALTER TABLE locations
DROP PRIMARY KEY;

-- 11. First, change the tables job_history and jobs to engine InnoDB and then write a SQL statement to add a foreign key on job_id column of job_history table referencing to the primary key job_id of jobs table.
ALTER TABLE job_history
ENGINE = InnoDB;

ALTER TABLE jobs
ENGINE = InnoDB;

-- 12. Write a SQL statement to add a foreign key constraint named fk_job_id on job_id column of job_history table referencing to the primary key job_id of jobs table.
DELETE FROM job_history 
WHERE employee_id = 0;

ALTER TABLE job_history ENGINE = InnoDB;
ALTER TABLE jobs ENGINE = InnoDB;

ALTER TABLE  job_history 
ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs (job_id);

-- 13. Write a SQL statement to drop the existing foreign key fk_job_id from job_history table on job_id column which is referencing to the job_id of jobs table.
ALTER TABLE job_history
DROP CONSTRAINT fk_job_id;

-- 14. Write a SQL statement to add an index named indx_start_date on start_date column in the table job_history.
ALTER TABLE job_history
ADD INDEX indx_start_date (start_date);

-- 15. Write a SQL statement to drop the index indx_start_date from job_history table.
ALTER TABLE job_history
DROP INDEX indx_start_date;

