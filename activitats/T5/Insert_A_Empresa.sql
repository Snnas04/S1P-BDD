-- Insert dins una mateixa base de dades

INSERT INTO EMP VALUES (1, 'Rosselló', 'PROFE', 7369, '2001-12-05', 10000, 50000, 20);

INSERT INTO EMP VALUES (2, 'Ximenes', 'PROFE', NULL, NULL, NULL, NULL, 20);

INSERT INTO EMP (EMP_NO, COGNOM, DEPT_NO) VALUES (3, 'Garcia', 20);

-- Insert de una base de dades a una altra
-- de sanitat a empresa
SELECT DOCTOR_NO, COGNOM, 40 FROM sanitat.DOCTOR;

INSERT INTO EMP (EMP_NO, COGNOM, DEPT_NO) SELECT DOCTOR_NO, COGNOM, 40 FROM sanitat.DOCTOR;
