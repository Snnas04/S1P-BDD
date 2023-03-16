/*
ANDREU GARCIA
MARC SANS
*/

-- DROP DATABASE ddlactivity;
CREATE DATABASE ddlactivity;
USE ddlactivity;

/*
EXERCIES 1
*/

CREATE TABLE DEPARTMENT (
	department_code INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
    office INT,
    building VARCHAR(50),
    floor INT,
    room INT
) ENGINE=InnoDB;

CREATE TABLE EMPLOYEE (
  employee_code INT PRIMARY KEY,
  NIF VARCHAR(9) NOT NULL UNIQUE,
  name VARCHAR(20) NOT NULL,
  surname1 VARCHAR(20) NOT NULL,
  surname2 VARCHAR(20),
  gender CHAR(1), -- CHANGE TO ENUM
  position VARCHAR(70) NOT NULL,
  chair_name VARCHAR(20) NOT NULL,
  hire_date DATE NOT NULL,
  end_date DATE NOT NULL,
  salary DECIMAL(10,2) NOT NULL,
  commission DECIMAL(4,2),
  department_code INT,
  FOREIGN KEY (department_code) REFERENCES DEPARTMENT (department_code),
  CHECK (hire_date < end_date),
  CONSTRAINT genderCheck CHECK (gender IN ('M','F','O','N'))
) ENGINE=InnoDB;

CREATE TABLE CLIENT (
  client_code INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  address VARCHAR(100) NOT NULL,
  city VARCHAR(50) NOT NULL,
  country VARCHAR (50) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  agent_code INT NOT NULL,
  credit_limit DECIMAL(10,2) NOT NULL,
  notes VARCHAR(255),
  CONSTRAINT fk_client_employee FOREIGN KEY (agent_code) REFERENCES EMPLOYEE (employee_code) ON DELETE RESTRICT,
  CHECK (credit_limit >= 10000)
) ENGINE=InnoDB;

/*
EXERCISE 2
*/

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

-- --------------- 7 -----------------------
-- Primer borrar la calu forana existent per poder borrar la clau primaria
ALTER TABLE CLIENT DROP CONSTRAINT fk_client_employee;

-- Borram la clau primaria per crear la nova
ALTER TABLE EMPLOYEE DROP PRIMARY KEY;
ALTER TABLE EMPLOYEE ADD PRIMARY KEY (name, surname1, surname2); 

-- Tornam a crear la clau forana
-- Primer crear un Index per employee_code perque sino no podem crear la clau forana
ALTER TABLE EMPLOYEE ADD KEY (employee_code);

-- Tornam a crear la clau forana com hem fet abans i podrem sguir identificant de forma unica amb la clau que hem creat anteiriorment ja que es una clau unica de un camp.

ALTER TABLE CLIENT ADD CONSTRAINT fk_client_employee FOREIGN KEY (agent_code) REFERENCES EMPLOYEE (employee_code) ON DELETE RESTRICT;

-- 8
RENAME TABLE EMPLOYEE TO AGENT;

-- 9
DROP TABLE CLIENT;

-- --------------- 10 -----------------------
/*
COMANDA:
mysqldump --xml ddlactivity AGENT > agent_table.xml -p
*/

/*
<?xml version="1.0"?>
<mysqldump xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<database name="ddlactivity">
	<table_structure name="AGENT">
		<field Field="employee_code" Type="int" Null="NO" Key="MUL" Extra="" Comment="" />
		<field Field="NIF" Type="varchar(9)" Null="NO" Key="UNI" Extra="" Comment="" />
		<field Field="name" Type="varchar(20)" Null="NO" Key="PRI" Extra="" Comment="" />
		<field Field="surname1" Type="varchar(20)" Null="NO" Key="PRI" Extra="" Comment="" />
		<field Field="surname2" Type="varchar(20)" Null="NO" Key="PRI" Extra="" Comment="" />
		<field Field="gender" Type="char(1)" Null="YES" Key="" Extra="" Comment="" />
		<field Field="position" Type="varchar(70)" Null="NO" Key="" Extra="" Comment="" />
		<field Field="chair_name" Type="varchar(20)" Null="NO" Key="" Extra="" Comment="" />
		<field Field="hire_date" Type="date" Null="NO" Key="" Extra="" Comment="" />
		<field Field="end_date" Type="date" Null="NO" Key="" Extra="" Comment="" />
		<field Field="salary" Type="decimal(10,2)" Null="NO" Key="" Extra="" Comment="" />
		<field Field="commission" Type="decimal(4,2)" Null="YES" Key="" Extra="" Comment="" />
		<field Field="department_code" Type="int" Null="YES" Key="MUL" Extra="" Comment="" />
		<field Field="age" Type="int" Null="NO" Key="" Extra="" Comment="" />
		<key Table="AGENT" Non_unique="0" Key_name="PRIMARY" Seq_in_index="1" Column_name="name" Collation="A" Cardinality="0" Null="" Index_type="BTREE" Comment="" Index_comment="" Visible="YES" />
		<key Table="AGENT" Non_unique="0" Key_name="PRIMARY" Seq_in_index="2" Column_name="surname1" Collation="A" Cardinality="0" Null="" Index_type="BTREE" Comment="" Index_comment="" Visible="YES" />
		<key Table="AGENT" Non_unique="0" Key_name="PRIMARY" Seq_in_index="3" Column_name="surname2" Collation="A" Cardinality="0" Null="" Index_type="BTREE" Comment="" Index_comment="" Visible="YES" />
		<key Table="AGENT" Non_unique="0" Key_name="NIF" Seq_in_index="1" Column_name="NIF" Collation="A" Cardinality="0" Null="" Index_type="BTREE" Comment="" Index_comment="" Visible="YES" />
		<key Table="AGENT" Non_unique="1" Key_name="department_code" Seq_in_index="1" Column_name="department_code" Collation="A" Cardinality="0" Null="YES" Index_type="BTREE" Comment="" Index_comment="" Visible="YES" />
		<key Table="AGENT" Non_unique="1" Key_name="employee_code" Seq_in_index="1" Column_name="employee_code" Collation="A" Cardinality="0" Null="" Index_type="BTREE" Comment="" Index_comment="" Visible="YES" />
		<options Name="AGENT" Engine="InnoDB" Version="10" Row_format="Dynamic" Rows="0" Avg_row_length="0" Data_length="16384" Max_data_length="0" Index_length="32768" Data_free="0" Create_time="2023-02-07 19:49:10" Collation="utf8mb4_0900_ai_ci" Create_options="" Comment="" />
	</table_structure>
	<table_data name="AGENT">
	</table_data>
</database>
</mysqldump>
*/