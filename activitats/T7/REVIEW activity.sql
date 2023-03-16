/*****************
 * Andreu Garcia *
 * Marc Sans     *
 *****************/

/*****************
 * INITIALIZE DB *
 *****************/

DROP DATABASE IF EXISTS EXERCICIHOSPITAL;
CREATE DATABASE EXERCICIHOSPITAL;
USE EXERCICIHOSPITAL;


/**********************************
 * CREATE PATIENT AND INSERT DATA *
 **********************************/

CREATE TABLE PATIENT (
  SSN VARCHAR(15),
  firstname VARCHAR(15),
  surname VARCHAR(30),
  address VARCHAR(30),
  location VARCHAR(25),
  zip_code VARCHAR(10),
  phone VARCHAR(12),
  history_nr VARCHAR(10) PRIMARY KEY,
  gender ENUM('M', 'F', 'O')
);

INSERT INTO PATIENT (SSN, firstname, surname, address, location, zip_code, phone, history_nr, gender)
VALUES 
('08/7888888', 'Matthew', 'Jackson', '123 Oxford Street', 'London', 'W1D 1AA', '07903 123456', '10203-F', 'M'),
('08/7234823', 'Brandon', 'Anderson', '456 Covent Garden', 'London', 'WC2E 8RF', '07902 654321', '11454-L', 'M'),
('08/7333333', 'Lauren', 'Taylor', '789 Sefton Park Road', 'Liverpool', 'L17 6AB', '07803 112233', '14546-E', 'F'),
('08/7555555', 'Sarah', 'Johnson Castells', '246 Mathew Street', 'Cardiff', 'L2 6RE', '07888 13579', '15413-S', 'M');


/**********************************
 * CREATE DOCTOR AND INSERT DATA  *
 **********************************/

CREATE TABLE DOCTOR (
  id_code VARCHAR(4) PRIMARY KEY,
  firstname VARCHAR(15),
  surname VARCHAR(30),
  speciality VARCHAR(25),
  hire_date DATE,
  job_title VARCHAR(25),
  member_nr INT,
  remark VARCHAR(300)
);

INSERT INTO DOCTOR (id_code, firstname, surname, speciality, hire_date, job_title, member_nr, remark)
VALUES 
('JSC', 'Jane', 'Smith Codina', 'Family doctor', '1994-09-23', 'Chief', '1331', NULL),
('KBR', 'Kevin', 'Brown', 'Paediatrics', '1982-08-12', 'Assistant', '2113', 'His retirement is near'),
('OLE', 'Olivia', 'Lee', 'Psychiatry', '1992-02-13', 'Section chief', '1231', NULL);

CREATE TABLE ADMISSION (
  admission_nr INT PRIMARY KEY,
  patient VARCHAR(9),
  admission_date DATE,
  doctor VARCHAR(4),
  floor_nr INT,
  bed_nr INT,
  allergic BOOLEAN,
  remark VARCHAR(300),
  treatment_cost DECIMAL(10,2),
  diagnosis VARCHAR(40),
  
  FOREIGN KEY (patient) REFERENCES PATIENT (history_nr),
  FOREIGN KEY (doctor) REFERENCES DOCTOR (id_code)
);

/*************************************
 * CREATE ADMISSION AND INSERT DATA  *
 *************************************/
INSERT INTO ADMISSION (admission_nr, patient, admission_date, doctor, floor_nr, bed_nr, allergic, diagnosis)
VALUES 
(1, '10203-F', '2009-01-23', 'KBR', 5, 121, FALSE, 'Epileptic'),
(2, '15413-S', '2009-03-13', 'JSC', 2, 5,   TRUE,  'Allergic to penicillin'),
(3, '11454-L', '2009-05-25', 'JSC', 3, 31,  FALSE, NULL),
(4, '15413-S', '2010-01-29', 'OLE', 2, 13,  FALSE, NULL),
(5, '14546-E', '2010-02-24', 'KBR', 1, 5,   TRUE,  'Allergic to Paidoterin');


/**********************************
 *            QUERIES             *
 **********************************/
 
-- 1
SELECT firstname, surname, hire_date
FROM DOCTOR
WHERE speciality = 'Paediatrics';

-- 2
select firstname, surname
from PATIENT
where location = 'London';

-- 3
SELECT CONCAT(d.firstname, " ", d.surname) as fullname
FROM ADMISSION a
JOIN DOCTOR d ON d.id_code = a.doctor
WHERE a.admission_date BETWEEN '2010-01-01' AND '2010-02-28';

-- 4
select concat(firstname, " ", surname) as fullname, SSN
from PATIENT;

-- 5
SELECT CONCAT(p.firstname, " ", p.surname) as fullname
FROM PATIENT p
JOIN ADMISSION a ON a.patient = p.history_nr
WHERE (a.admission_date BETWEEN '2009-01-01' AND '2010-05-31') AND allergic;

-- 6
select floor_nr, bed_nr
from ADMISSION
where patient = (select history_nr from PATIENT where location = 'Liverpool');

-- 7
SELECT CONCAT(p.firstname, " ", p.surname) as fullname
FROM PATIENT p
JOIN ADMISSION a ON a.patient = p.history_nr
JOIN DOCTOR d ON d.id_code = a.doctor
WHERE d.firstname = 'Kevin' AND d.surname = 'Brown';

-- 8
select concat(firstname, " ", surname) as fullname, phone
from PATIENT
join ADMISSION on patient = history_nr
where year(admission_date) = '2010';

-- 9
SELECT CONCAT(p.firstname, " ", p.surname) as fullname
FROM PATIENT p
JOIN ADMISSION a ON a.patient = p.history_nr
WHERE a.diagnosis = 'Epileptic';

-- 10 -> 2 maneres
select concat(p.firstname, " ", p.surname) as fullname, a.admission_date
from PATIENT as p
join ADMISSION as a on patient = history_nr
where doctor = (select id_code from DOCTOR where speciality = "Psychiatry");

select concat(p.firstname, " ", p.surname) as fullname, a.admission_date
from PATIENT as p
join ADMISSION as a on patient = history_nr
join DOCTOR as d on id_code = doctor
where d.speciality = 'Psychiatry';
