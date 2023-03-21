CREATE DATABASE IF NOT EXISTS blog;

USE blog;

CREATE TABLE usuaris (
    id_usuari         INT AUTO_INCREMENT PRIMARY KEY,
    nom               VARCHAR(30) NOT NULL,
    cognom            VARCHAR(60) NOT NULL,
    correu_electronic VARCHAR(50) NOT NULL,
    data_registre     DATETIME NOT NULL
);

CREATE TABLE publicacions (
    id_publicacio INT AUTO_INCREMENT PRIMARY KEY,
    titol         VARCHAR(100) NOT NULL,
    contingut     TEXT NOT NULL,
    data_creacio  DATETIME NOT NULL,
    usuari        INT,
    m_agrada      smallint default 0,
    FOREIGN KEY (usuari) REFERENCES usuaris(id_usuari)
);

CREATE TABLE comentaris (
    id_comentari INT AUTO_INCREMENT PRIMARY KEY,
    contingut    TEXT NOT NULL,
    data_creacio DATETIME NOT NULL,
    publicacio   INT,
    usuari       INT,
    FOREIGN KEY (publicacio) REFERENCES publicacions(id_publicacio),
    FOREIGN KEY (usuari) REFERENCES usuaris(id_usuari)
);

CREATE TABLE etiquetes (
    id_etiqueta INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(50) NOT NULL
);

CREATE TABLE publicacions_etiquetes (
    publicacio INT,
    etiqueta   INT,
    PRIMARY KEY (publicacio, etiqueta),
    FOREIGN KEY (publicacio) REFERENCES publicacions(id_publicacio),
    FOREIGN KEY (etiqueta) REFERENCES etiquetes(id_etiqueta)
);

INSERT INTO usuaris
VALUES ('1','JÚLIA','PONS CODINA','JOSEP_ANTONI@alumne.pau','2022-02-15 12:00'),
	   ('2','JOEL','GÓMEZ MAS','ADRIAN@alumne.pau','2022-02-16 10:20:30'),
	   ('3','ANTÒNIA','JIMÉNEZ GARCÍA','ALEX@alumne.pau','2022-02-17 15:45:10'),
	   ('4','GIBERT','ALZINA GUAL','IGNASI@alumne.pau','2022-02-17 20:40:19'),
	   ('5','OLÍVIA','RIUTORT RODSSELLÓ','MARIA_MAGDALENA@alumne.pau','2022-02-18 09:45:00'),
	   ('6','TONI','ALORDA MUÑOZ','ANTONIO@alumne.pau','2022-03-20 12:10:23'),
	   ('7','JOANA','GARCÍA QUETGLAS','ANDREU.GARCI@alumne.pau','2022-03-03 17:45:10'),
	   ('8','JORDI','FERRER ROTGER','MIQUEL@alumne.pau','2022-03-15 11:00:10'),
	   ('9','AINA','MUNAR VALRIU','ESTEVE@alumne.pau','2022-03-25 18:30:00'),
	   ('10','ARNAU','CODINA GÓMEZ','OSCAR@alumne.pau','2022-03-24 11:35:10'),
	   ('11','TERESA','MÉNDEZ TUR','ANDREU.PONS@alumne.pau','2022-04-01 10:50:10'),
	   ('12','JAUME','MOLL SUAU','RICARDO@alumne.pau','2022-02-19 03:56:23'),
	   ('13','MARINA','SÁNCHEZ COLL','JOAN@alumne.pau','2022-02-15 12:00'),
	   ('14','MARC','VILLALONGA MUNAR','MARC@alumne.pau','2022-04-21 12:14:09');


INSERT INTO publicacions
VALUES (1,'El meu primer post', 'Aquest és el meu primer post a la pàgina', '2022-02-18 09:00:00', 1,2),
       (2,'Un començament nou', 'Avui començ un nou projecte', '2022-02-19 12:30:00', 2,5),
       (3,'Compartint els meus coneixements', 'Vos compartesc els meus coneixements sobre MySQL', '2022-02-20 16:45:00', 6, 10),
       (4,'Python for dummies','Pels qui necessitau un curs bàsic de Python, aquí teniu https://www.w3schools.com/python/default.asp','2023-03-19 10:30',10, 1);
INSERT INTO publicacions VALUES (5, 'MySQL, sí o no?','És recomanable MySQL per projectes grans? Una vegada més la resposta és depèn ...','2023-01-15 21:25',14, 4);
INSERT INTO publicacions VALUES (6, 'MySQL vs PostgreSQL','PostgreSQL i MySQL són sistemes de gestió de bases de dades relacionals. Hi ha molta discussió sobre per què MySQL està més estès que PostgreSQL. Comprovem alguns motius per triar MySQL.','2023-02-17 22:10',1, 20);
INSERT INTO publicacions VALUES (7,'Visual Studio Code és bo per programar?','Visual Studio Code està bé si no trobau res millor pel llenguatge que utilitzau. Hi ha millors alternatives per als llenguatges més populars.
C#: utilitzau Visual Studio Community, és gratuït i molt millor que Visual Studio Code.
Java - Utilitzeu IntelliJ
Vés - Goland.
Python - PyCharm.
C o C++ - CLion.
Rust: IDEA amb connector.','2023-03-01 12:55',10, 7);

INSERT INTO comentaris
VALUES (1,'Excel·lent post, m''encanta', '2022-02-18 09:30:00', 1, 2),
       (2,'Te desig molt d''èxit en el teu nou projecte', '2022-02-19 13:00:00', 2, 1),
       (3,'Molt bons consells, gràces per compartir', '2022-02-20 17:00:00', 3, 2),
       (4,'Magnífic, moltes gràcies!!!','2023-03-19 21:35',4,5),
       (5,'Fantàstic!!!','2023-03-19 20:50',4,9);
INSERT INTO comentaris VALUES (6,'Increïble, just lo que necessitava','2023-03-20 08:15',4,1);
INSERT INTO comentaris VALUES (7,'Reflexió interessant','2023-02-21 09:45',5,14);
INSERT INTO comentaris VALUES (8,'Gràcies, ho tendré en compte!','2023-02-20 17:20',7,8);
INSERT INTO comentaris VALUES (9,'MySQL, sempre!!!','2023-02-22 13:23',5,2);

INSERT INTO etiquetes
VALUES (10,'MySQL'),
       (20,'Programació'),
       (30,'Tecnologia'),
       (40,'Python');
INSERT INTO etiquetes VALUES (50,'Pascal');
INSERT INTO etiquetes VALUES (60,'Clipper');

INSERT INTO publicacions_etiquetes
VALUES (1, 10),
       (3, 10),
       (3, 20),
       (3, 30),
       (4, 20),
       (4, 40);
INSERT INTO publicacions_etiquetes VALUES (5, 10);
