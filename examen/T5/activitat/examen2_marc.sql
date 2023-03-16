DROP DATABASE IF EXISTS CIFP;
CREATE DATABASE CIFP;
USE CIFP;

CREATE TABLE CICLE (
    codi CHAR(3) NOT NULL,
    nom VARCHAR(80) NOT NULL,
    nivell VARCHAR(10) NOT NULL,
    horabaixa TINYINT(1) NOT NULL,
    acces VARCHAR(100),
    data_creacio DATE,
    descripcio VARCHAR(500),
    PRIMARY KEY (codi)
);

CREATE TABLE CURS (
    cicle CHAR(3) NOT NULL,
    ncurs TINYINT NOT NULL,
    aula VARCHAR(20),
    PRIMARY KEY (cicle, ncurs),
    FOREIGN KEY (cicle) REFERENCES CICLE(codi) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MODUL (
    codi VARCHAR(6) NOT NULL,
    codi_boe CHAR(4),
    nom VARCHAR(100) NOT NULL,
    hores SMALLINT NOT NULL,
    angles TINYINT(1) NOT NULL,
    imatge BLOB,
    descripcio VARCHAR(200),
    PRIMARY KEY (codi),
    UNIQUE (codi_boe),
    CHECK (hores BETWEEN 30 AND 300)
);

CREATE TABLE ESTUDIS (
    cicle CHAR(3) NOT NULL,
    curs TINYINT NOT NULL,
    modul VARCHAR(6) NOT NULL,
    suport TINYINT(1),
    professir VARCHAR(100),
    PRIMARY KEY (cicle, curs, modul),
    FOREIGN KEY (cicle, curs) REFERENCES CURS(cicle, ncurs) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (modul) REFERENCES MODUL(codi) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 2
INSERT INTO MODUL (codi, codi_boe, nom, hores, angles, descripcio)
VALUES
    ('M01', 'MF01', 'Programació', 200, 0, 'Aquest mòdul té com a objectiu introduir els conceptes bàsics de programació.'),
    ('M02', 'MF02', 'Bases de dades', 150, 0, 'Aquest mòdul té com a objectiu introduir les bases de dades i el seu disseny.'),
    ('M03', 'MF03', 'Sistemes operatius', 100, 0, 'Aquest mòdul té com a objectiu introduir els sistemes operatius i les seves funcions.'),
    ('M04', 'MF04', 'Seguretat informàtica', 75, 0, 'Aquest mòdul té com a objectiu introduir les mesures de seguretat informàtica.'),
    ('M05', 'MF05', 'Xarxes informàtiques', 125, 0, 'Aquest mòdul té com a objectiu introduir les xarxes informàtiques i la seva configuració.');

INSERT INTO CICLE (codi, nom, nivell, horabaixa, acces, data_creacio, descripcio)
VALUES
    ('ASI', 'Administració de sistemes informàtics en xarxa', 'Mitjà', 1, 'Coneixements bàsics d\'informàtica', '2022-01-01', 'Aquest cicle té com a objectiu formar professionals en l\'administració de sistemes informàtics en xarxa.'),
    ('DAM', 'Desenvolupament d\'aplicacions multiplataforma', 'Superior', 0, 'Coneixements bàsics de programació', '2022-01-01', 'Aquest cicle té com a objectiu formar professionals en el desenvolupament d\'aplicacions multiplataforma.');

INSERT INTO CURS (cicle, ncurs, aula)
VALUES
    ('ASI', 1, 'Aula 101'),
    ('ASI', 2, 'Aula 102'),
    ('DAM', 1, 'Aula 201'),
    ('DAM', 2, 'Aula 202');

INSERT INTO MODUL (codi, codi_boe, nom, hores, angles, descripcio)
VALUES
    ('M06', 'MF06', 'Programació avançada', 150, 0, 'Aquest mòdul té com a objectiu aprofundir en els conceptes de programació.'),
    ('M07', 'MF07', 'Interfícies d\'usuari', 100, 0, 'Aquest mòdul té com a objectiu ensenyar a dissenyar i implementar interfícies d\'usuari.');

INSERT INTO ESTUDIS (cicle, curs, modul, suport, professir)
VALUES
('ASI', 1, 'M01', 0, 'John Smith'),
('ASI', 1, 'M02', 1, 'Laura García');

-- 3
-- mysqldump --xml --no-create-info CIFP > CIFP_data.xml

-- 4
ALTER TABLE CICLE CHANGE COLUMN acces requisists VARCHAR(100) NOT NULL AFTER descripcio;

-- 5
ALTER TABLE CICLE MODIFY COLUMN nivell ENUM('Superior', 'Mitjà', 'Bàsic') NOT NULL;
ALTER TABLE CICLE MODIFY COLUMN horabaixa TINYINT(1) NOT NULL CHECK (horabaixa IN (0, 1));

CREATE INDEX idx_estudis_modul_professor ON ESTUDIS (modul, professir);

-- 6
CREATE TABLE MODUL_NOU LIKE MODUL;
ALTER TABLE MODUL_NOU DROP COLUMN codi_boe;
ALTER TABLE MODUL_NOU ADD COLUMN data_creacio DATE;
INSERT INTO MODUL_NOU (codi, nom, hores, angles, imatge, descripcio, data_creacio)
SELECT codi, nom, hores, angles, imatge, descripcio, CURDATE() FROM MODUL;

-- 7
ALTER TABLE MODUL_NOU ADD FOREIGN KEY (codi) REFERENCES MODUL(codi);

-- 8
SELECT column_name, table_name
FROM information_schema.columns
WHERE data_type = 'varchar' AND table_schema = 'CIFP';

SELECT data_type, COUNT(*) AS num_columns
FROM information_schema.columns
WHERE table_schema = 'CIFP'
GROUP BY data_type;

-- 9
SHOW CREATE TABLE information_schema.ENGINES;
