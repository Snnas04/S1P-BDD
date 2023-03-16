/**********************
*****ANDREU GARICA*****
*******MARC SANS*******
**********************/

/*********************************
************EXERCISE 1************
*********************************/
-- DROP DATABASE mandatory;
CREATE DATABASE mandatory;
USE mandatory;

CREATE TABLE DEPARTMENT (
    department_code INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    office INT,
    building VARCHAR(50),
    floor INT,
    room INT
) ENGINE = InnoDB;

CREATE TABLE EMPLOYEE (
  employee_code INT PRIMARY KEY,
  NIF VARCHAR(9) NOT NULL UNIQUE,
  name VARCHAR(50) NOT NULL,
  surname1 VARCHAR(50) NOT NULL,
  surname2 VARCHAR(50),
  gender CHAR(1),
  position VARCHAR(100) NOT NULL,
  chair_name VARCHAR(100) NOT NULL,
  hire_date DATE NOT NULL,
  end_date DATE NOT NULL,
  salary DECIMAL(10,2) NOT NULL,
  commission DECIMAL(4,2),
  department_code INT,
  FOREIGN KEY (department_code) REFERENCES DEPARTMENT (department_code),
  CHECK (hire_date < end_date),
  CHECK (commission <= 0.1),
  CONSTRAINT genderCheck CHECK (gender IN ('M', 'F', 'O', 'N'))
) ENGINE = InnoDB;

CREATE TABLE CLIENT (
  client_code INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  address VARCHAR(100) NOT NULL,
  city VARCHAR(50) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  agent_code INT NOT NULL,
  credit_limit DECIMAL(10,2) NOT NULL,
  notes VARCHAR(255),
  CONSTRAINT fk_client_employee FOREIGN KEY (agent_code) REFERENCES EMPLOYEE (employee_code) ON DELETE RESTRICT
) ENGINE = InnoDB;

/*********************************
************EXERCISE 2************
*********************************/

-- 1
ALTER TABLE EMPLOYEE ADD COLUMN age INT NOT NULL; 

-- 2
ALTER TABLE EMPLOYEE ADD CHECK (age BETWEEN 16 AND 67);

-- 3
ALTER TABLE EMPLOYEE ADD CHECK (commission <= 0.1); 

-- 4
ALTER TABLE CLIENT ADD CHECK (credit_limit >= 10000);

-- 5
ALTER TABLE EMPLOYEE DROP CONSTRAINT genderCheck;

-- 6
ALTER TABLE CLIENT DROP COLUMN country;

-- 7
ALTER TABLE CLIENT DROP FOREIGN KEY fk_client_employee;
ALTER TABLE EMPLOYEE DROP PRIMARY KEY;
ALTER TABLE EMPLOYEE ADD PRIMARY KEY (name, surname1, surname2);

-- 8
RENAME TABLE EMPLOYEE TO AGENT; 

-- 9
DROP TABLE CLIENT; 

-- 10

