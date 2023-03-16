-- 1
DROP DATABASE IF EXISTS GIMNAS;
CREATE DATABASE GIMNAS;
USE GIMNAS;

CREATE TABLE activitat (
	idactivitat char(3),
    nom varchar(45) NOT NULL,
    tarifa smallint NOT NULL,
    descripcio varchar(200) NOT NULL,
    
    primary key (idactivitat)
);

CREATE TABLE horari (
	idhorari tinyint,
    dia char(2) NOT NULL,
    hora time NOT NULL,
    sala varchar(45) NOT NULL,
    activitat char(3) NOT NULL,
    
    primary key (idhorari),
    foreign key (activitat) references activitat(idactivitat)
);

CREATE TABLE monitor (
	idmonitor tinyint,
    nom varchar(30) NOT NULL,
    cognom varchar(60) NOT NULL,
    titulacio varchar(100) NOT NULL,
    salari decimal (7,2) NOT NULL,
    email varchar(100) NOT NULL,
    nif varchar(9) NOT NULL,
    
    primary key (idmonitor)
);

CREATE TABLE relitzada (
	activitat_id char(3),
    monitor_id tinyint,
    
    primary key (activitat_id, monitor_id),
    foreign key (activitat_id) references activitat(idactivitat),
    foreign key (monitor_id) references monitor(idmonitor)
);


-- 2
ALTER TABLE horari ADD CONSTRAINT CK_dia CHECK(dia IN ('dl', 'dt', 'dc', 'dj', 'dv', 'ds', 'dg'));
ALTER TABLE horari ADD CONSTRAINT CK_hora CHECK(hora > 09.00);


-- 3
ALTER TABLE monitor ADD CONSTRAINT nif UNIQUE nif_monitor(nif);
ALTER TABLE monitor ADD CONSTRAINT email UNIQUE email_monitor(email);
ALTER TABLE monitor MODIFY cognom varchar(9) NOT NULL;


-- 4
INSERT INTO monitor (idmonitor, nom, cognom, titulacio, salari, email, nif)
VALUES
	(1, 'marc', 'sans', 'grau superior', 22000, 'ms@gimnas.com', '74338821C'),
	(2, 'joan', 'sanchez', 'grau superior', 25000, 'js@gimnas.com', '74938225G'),
	(3, 'andreu', 'garcia', 'grau superior', 30000, 'ag@gimnas.com', '55993300H'),
	(4, 'andreu', 'pons', 'grau superior', 21000, 'ap@gimnas.com', '22003822J'),
	(5, 'pep', 'alorda', 'grau superior', 24000, 'pa@gimnas.com', '66334466X'),
	(6, 'esteve', 'vives', 'grau mitja', 18000, 'ev@gimnas.com', '44883377F'),
	(7, 'alicia', 'mayol', 'grau mitja', 19000, 'am@gimnas.com', '88339944N'),
	(8, 'david', 'lopez', 'grau mitja', 15000, 'dl@gimnas.com', '11223344L');

INSERT INTO activitat (idactivitat, nom, tarifa, descripcio)
VALUES
	(111, 'ACT1', '10', 'descripcio de act1'),
	(222, 'ACT2', '8', 'descripcio de act2');

INSERT INTO relitzada (activitat_id, monitor_id)
VALUES
	(111, '4'),
	(222, '3');

INSERT INTO horari (idhorari, dia, hora, sala, activitat)
VALUES
	(1, 'dl', '10.00', 'sala 1', 111),
	(2, 'dc', '10.30', 'sala 2', 222);


-- 5
ALTER TABLE activitat ADD COLUMN intensitat varchar(10) after tarifa;


-- 6
CREATE TABLE monitor_vip LIKE monitor;
ALTER TABLE monitor_vip DROP COLUMN salari;
INSERT INTO monitor_vip (idmonitor, nom, cognom, titulacio, email, nif)
SELECT idmonitor, nom, cognom, titulacio, email, nif
FROM monitor
WHERE salari > 20000;


-- 7
ALTER TABLE monitor_vip ADD FOREIGN KEY (idmonitor) REFERENCES monitor(idmonitor);


-- 8

SELECT table_name
FROM information_schema.columns
WHERE table_schema = 'GIMNAS';

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'GIMNAS' AND table_name = 'monitor';


-- 9
ALTER TABLE horari DROP CONSTRAINT CK_dia;
ALTER TABLE horari DROP CONSTRAINT CK_hora;

ALTER TABLE horari DROP PRIMARY KEY;
ALTER TABLE horari ADD PRIMARY KEY (dia, hora, sala); 
