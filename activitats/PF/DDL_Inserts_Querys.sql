-- Es pot executar tot el fitxer a la vegada.
/*********************
*      INIT DB       *
**********************/

DROP DATABASE IF EXISTS Teatre;
CREATE DATABASE Teatre;
USE Teatre;

/*********************
*  CREATE TABLES     *
**********************/

CREATE TABLE Persona (
  DNI VARCHAR(9) PRIMARY KEY,
  nom VARCHAR(40) NOT NULL,
  telèfon INT NOT NULL,
  data_neixament DATE NOT NULL
);

CREATE TABLE Director (
  DNI VARCHAR(9) PRIMARY KEY,
  nacionalitat VARCHAR(50) NOT NULL,
  biografia TEXT NOT NULL,
  adreça VARCHAR(100) NOT NULL,

  FOREIGN KEY (DNI) REFERENCES Persona(DNI)
);

CREATE TABLE Actors (
  DNI VARCHAR(9) PRIMARY KEY,

  FOREIGN KEY (DNI) REFERENCES Persona(DNI)
);

CREATE TABLE PersonalTecnic (
  DNI VARCHAR(9) PRIMARY KEY,

  FOREIGN KEY (DNI) REFERENCES Persona(DNI)
);

CREATE TABLE Generes (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  genere VARCHAR(50) NOT NULL
);

CREATE TABLE Obra (
  titol VARCHAR(100) PRIMARY KEY,
  idGenere INT NOT NULL,
  idDirector VARCHAR(20) NOT NULL,
  tipo ENUM('classic', 'modern', 'absurd', 'negre') NOT NULL,
  cost DECIMAL(10, 2) NOT NULL,
  autor VARCHAR(50) NOT NULL,

  FOREIGN KEY (idGenere) REFERENCES Generes(ID),
  FOREIGN KEY (idDirector) REFERENCES Director(DNI)
);

CREATE TABLE Obra_Actor (
  titol VARCHAR(100) NOT NULL,
  actor_dni VARCHAR(20) NOT NULL,
  rol ENUM('principal', 'secundari', 'extra') NOT NULL,
  paper VARCHAR(50),

  PRIMARY KEY (titol, actor_dni),

  FOREIGN KEY (titol) REFERENCES Obra(titol),
  FOREIGN KEY (actor_dni) REFERENCES Actors(DNI)
);

CREATE TABLE Obra_PersonalTecnic (
  titol VARCHAR(100) NOT NULL,
  personal_DNI VARCHAR(20) NOT NULL,
  tasca VARCHAR(50) NOT NULL,

  PRIMARY KEY (titol, personal_DNI),

  FOREIGN KEY (titol) REFERENCES Obra(titol),
  FOREIGN KEY (personal_DNI) REFERENCES PersonalTecnic(DNI)
);

CREATE TABLE Teatre (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  ciutat VARCHAR(50) NOT NULL,
  capacitat INT NOT NULL,
  nom VARCHAR(50) NOT NULL,
  adreça VARCHAR(100) NOT NULL,
  categoria ENUM('luxe', 'gran', 'mitjans', 'petits') NOT NULL
);

CREATE TABLE Funcio (
  datetime DATETIME NOT NULL,
  Teatre_ID INT NOT NULL,
  Obra_Titol VARCHAR(100) NOT NULL,

  PRIMARY KEY (datetime, Teatre_ID, Obra_Titol),
  FOREIGN KEY (Teatre_ID) REFERENCES Teatre(ID),
  FOREIGN KEY (Obra_Titol) REFERENCES Obra(titol)
);

CREATE TABLE Zones(
  ID INT AUTO_INCREMENT PRIMARY KEY ,
  categoria VARCHAR(50)
);

CREATE  TABLE Teatre_Zona(
    idTeatre INT,
    idZona  INT,

    PRIMARY KEY (idTeatre, idZona),
    FOREIGN KEY (idTeatre) REFERENCES Teatre(ID),
    FOREIGN KEY (idZona) REFERENCES Zones(ID)
);

CREATE TABLE Ticket(
  datetime DATETIME NOT NULL,
  Teatre_ID INT NOT NULL,
  Obra_Titol VARCHAR(100) NOT NULL,
  silla INT NOT NULL,
  idZona INT NOT NULL,
  preu INT NOT NULL,

  PRIMARY KEY (datetime, Teatre_ID, Obra_Titol,silla ),

  FOREIGN KEY (datetime, Teatre_ID, Obra_Titol) REFERENCES Funcio(datetime, Teatre_ID, Obra_Titol),
  FOREIGN KEY (idZona) REFERENCES Zones(ID)
);

/*********************
*      FUNCTIONS     *
**********************/
DROP FUNCTION IF EXISTS esUnaZonaValida;
DELIMITER //
CREATE FUNCTION esUnaZonaValida(idZone INT, Teatre_ID INT) RETURNS BOOLEAN
READS SQL DATA
BEGIN
  RETURN idZone IN (SELECT idZona FROM Teatre_Zona WHERE idTeatre = Teatre_ID);
END //
DELIMITER ;

/*********************
*      TRIGGERS      *
**********************/
CREATE TRIGGER `InsertComprovarZonaValida`
BEFORE INSERT ON Ticket
FOR EACH ROW
BEGIN
  IF NOT esUnaZonaValida(NEW.idZona, NEW.Teatre_ID) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Zone';
  END IF;
END;

CREATE TRIGGER `UpdateComprovarZonaValida`
BEFORE UPDATE ON Ticket
FOR EACH ROW
BEGIN
  IF NOT esUnaZonaValida(NEW.idZona, NEW.Teatre_ID) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Zone';
  END IF;
END;


/*********************
*      INSERTS       *
**********************/

INSERT INTO Persona (DNI, nom, telèfon, data_neixament) VALUES
('12345678A', 'Maria García', 123456789, '1990-01-01'),
('23456789B', 'Juan Pérez', 987654321, '1985-05-05'),
('34567890C', 'Laura Martínez', 654321987, '1992-12-10'),
('45678901D', 'Pedro Fernández', 369258147, '1988-06-15'),
('56789012E', 'Ana González', 147852369, '1995-02-20'),
('67890123F', 'Marta Sánchez', 258147369, '1993-07-25'),
('78901234G', 'Javier Rodríguez', 654987321, '1991-11-30'),
('89012345H', 'Sara Gómez', 789456123, '1987-03-06'),
('90123456I', 'Antonio López', 456789123, '1984-09-11'),
('01234567J', 'Elena Torres', 321654987, '1994-04-16');

INSERT INTO Director (DNI, nacionalitat, biografia, adreça) VALUES
('12345678A', 'Espanyol', 'Va estudiar a l\'Institut del Teatre i ha dirigit nombroses obres teatrals', 'Carrer Major 12, Barcelona'),
('23456789B', 'Frances', 'Famos per ser un dels millors directors de teatre del segle XX', 'Rue de la Paix 15, París'),
('34567890C', 'Anglès', 'Ha treballat en diferents teatres d\'Anglaterra i dels Estats Units', 'Baker Street 221B, Londres'),
('45678901D', 'Alemany', 'Ha dirigit moltes obres clàssiques i és conegut per la seva visió innovadora', 'Am Kupfergraben 10, Berlín'),
('56789012E', 'Americà', 'Ha treballat en teatres de Broadway i ha dirigit moltes obres de renom', 'Times Square 1, Nova York'),

('67890123F', 'Espanyol', 'Va estudiar a l\'Institut del Teatre i ha dirigit nombroses obres teatrals', 'Carrer Major 12, Barcelona'),
('89012345H', 'Frances', 'Famos per ser un dels millors directors de teatre del segle XX', 'Rue de la Paix 15, París'),
('78901234G', 'Anglès', 'Ha treballat en diferents teatres d\'Anglaterra i dels Estats Units', 'Baker Street 221B, Londres'),
('90123456I', 'Alemany', 'Ha dirigit moltes obres clàssiques i és conegut per la seva visió innovadora', 'Am Kupfergraben 10, Berlín'),
('01234567J', 'Americà', 'Ha treballat en teatres de Broadway i ha dirigit moltes obres de renom', 'Times Square 1, Nova York');

INSERT INTO Actors (DNI) VALUES
('23456789B'),
('34567890C'),
('45678901D'),
('56789012E'),
('67890123F'),
('78901234G'),
('89012345H'),
('90123456I'),
('01234567J'),
('12345678A');

INSERT INTO PersonalTecnic (DNI) VALUES
('23456789B'),
('34567890C'),
('45678901D'),
('56789012E'),
('67890123F'),
('78901234G'),
('89012345H'),
('90123456I'),
('01234567J'),
('12345678A');

INSERT INTO Generes (genere) VALUES
  ('Drama'),
  ('Comèdia'),
  ('Thriller'),
  ('Acció'),
  ('Ciència-ficció'),
  ('Terror'),
  ('Romàntic'),
  ('Musical'),
  ('Infantil'),
  ('Documental');

INSERT INTO Obra (titol, idGenere, idDirector, tipo, cost, autor) VALUES
('Hamlet', 1, '12345678A', 'classic', 150.00, 'William Shakespeare'),
('La casa de Bernarda Alba', 2, '23456789B', 'modern', 100.00, 'Federico García Lorca'),
('Lluvia de primavera', 3, '34567890C', 'absurd', 80.00, 'Maurice Maeterlinck'),
('La cantante calva', 4, '45678901D', 'negre', 90.00, 'Eugène Ionesco'),
('Don Quijote de la Mancha', 1, '12345678A', 'classic', 200.00, 'Miguel de Cervantes'),
('La vida es sueño', 2, '23456789B', 'modern', 120.00, 'Pedro Calderón de la Barca'),
('El jardín de los cerezos', 2, '23456789B', 'classic', 180.00, 'Antón Chéjov'),
('El avaro', 4, '45678901D', 'classic', 110.00, 'Molière'),
('El perro del hortelano', 3, '34567890C', 'classic', 70.00, 'Lope de Vega'),
('Bodas de sangre', 2, '23456789B', 'modern', 100.00, 'Federico García Lorca');

INSERT INTO Obra_Actor(titol, actor_dni, rol, paper) VALUES
('Hamlet', '23456789B', 'principal', 'Hamlet'),
('Hamlet','34567890C' , 'secundari', 'Horacio'),
('Hamlet', '45678901D','secundari', 'Osric'),
('Hamlet','56789012E' ,'extra','Francisco'),
('Hamlet','67890123F' ,'extra','Fantasma'),

('Don Quijote de la Mancha','78901234G' , 'principal','Don Quijote'),
('Don Quijote de la Mancha', '89012345H', 'secundari', 'Cura'),
('Don Quijote de la Mancha','90123456I' ,'secundari', 'Barbero'),
('Don Quijote de la Mancha', '01234567J','extra', 'Caballero'),
('Don Quijote de la Mancha', '12345678A','extra', 'Caballo de los espejos');


INSERT INTO Obra_PersonalTecnic (titol, personal_DNI, tasca) VALUES
('Hamlet', '23456789B','Il·luminació'),
('Hamlet', '34567890C', 'So'),
('La casa de Bernarda Alba', '45678901D', 'Escenografia'),
('Lluvia de primavera', '56789012E', 'Vestuari'),
('La cantante calva', '67890123F', 'Maquillatge'),
('Don Quijote de la Mancha', '78901234G','Efectes especials'),
('La vida es sueño', '89012345H', 'Producció'),
('El jardín de los cerezos', '90123456I', 'Assistent de direcció'),
('El avaro', '01234567J', 'Xef de sala'),
('El perro del hortelano', '12345678A', 'Fotografia'),
('Bodas de sangre', '23456789B', 'Escenografia');


INSERT INTO Teatre (ciutat, capacitat, nom, adreça, categoria) VALUES
('Barcelona', 1000, 'Teatre Principal', 'Carrer dels Pins, 15', 'mitjans'),
('Madrid', 2000, 'Teatre Real', 'Plaza de Oriente, s/n', 'gran'),
('Valencia', 500, 'Teatre Olympia', 'Carrer de San Vicente Mártir, 44', 'petits'),
('Sevilla', 800, 'Teatre Lope de Vega', 'Av. de María Luisa, s/n', 'mitjans'),
('Bilbao', 1200, 'Teatre Arriaga', 'Plaza Arriaga, 1', 'gran'),
('Málaga', 600, 'Teatre Cervantes', 'Calle Ramos Marín, s/n', 'mitjans'),
('Zaragoza', 700, 'Teatre Principal Zaragoza', 'Plaza José Sinués y Urbiola, s/n', 'mitjans'),
('Murcia', 400, 'Teatre Circo Murcia', 'Calle Enrique Villar, 11', 'petits'),
('Palma de Mallorca', 900, 'Teatre Principal de Palma', 'Carrer de la Riera, 2A', 'mitjans'),
('Las Palmas de Gran Canaria', 1500, 'Teatro Cuyás', 'Calle Viera y Clavijo, s/n', 'gran');

INSERT INTO Funcio (datetime, Teatre_ID, Obra_Titol) VALUES
('2023-04-21 20:00:00', 1, 'Hamlet'),
('2023-04-22 19:00:00', 2, 'La casa de Bernarda Alba'),
('2023-04-23 18:00:00', 3, 'Lluvia de primavera'),
('2023-04-24 17:00:00', 4, 'La cantante calva'),
('2023-04-25 16:00:00', 5, 'Don Quijote de la Mancha'),
('2023-04-26 20:30:00', 6, 'La vida es sueño'),
('2023-04-27 21:00:00', 7, 'El jardín de los cerezos'),
('2023-04-28 19:30:00', 8, 'El avaro'),
('2023-04-29 18:30:00', 9, 'El perro del hortelano'),
('2023-04-30 17:30:00', 10, 'Bodas de sangre'),
('2023-04-22 20:00:00', 4, 'Hamlet');

INSERT INTO Zones (categoria) VALUES
('Palcos'),
('Anfiteatro'),
('Platea'),
('Balcón'),
('General');

INSERT INTO Teatre_Zona (idTeatre, idZona) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 3),
(2, 4),
(2, 5),
(3, 2),
(3, 4),
(3, 5),
(4, 1),
(4, 2),
(4, 3),
(4, 5),
(5, 1),
(5, 2),
(5, 3);


INSERT INTO Ticket (datetime, Teatre_ID, Obra_Titol, silla, idZona, preu)
VALUES ('2023-04-21 20:00:00', 1, 'Hamlet', 10, 1, 20),
('2023-04-21 20:00:00', 1, 'Hamlet', 11, 1,63),
('2023-04-21 20:00:00', 1, 'Hamlet', 12, 1,55),
('2023-04-21 20:00:00', 1, 'Hamlet', 20, 2,14),
('2023-04-21 20:00:00', 1, 'Hamlet', 21, 2,11),
('2023-04-21 20:00:00', 1, 'Hamlet', 22, 2,33),
('2023-04-21 20:00:00', 1, 'Hamlet', 30, 3,33),
('2023-04-21 20:00:00', 1, 'Hamlet', 31, 3,76),
('2023-04-21 20:00:00', 1, 'Hamlet', 32, 3,42),
('2023-04-21 20:00:00', 1, 'Hamlet', 40, 4,44),
('2023-04-23 18:00:00', 3, 'Lluvia de primavera', 9,2,300),
('2023-04-23 18:00:00', 3, 'Lluvia de primavera', 8,2,91),
('2023-04-25 16:00:00', 5, 'Don Quijote de la Mancha', 10,1,300);


/*********************
*      Querys        *
**********************/

-- Mostra totes les obres del gènere 'drama' ordenades alfabèticament per títol.
SELECT * FROM Obra WHERE idGenere = (SELECT ID FROM Generes WHERE genere = 'drama') ORDER BY titol ASC;

-- Mostra el títol de les obres que es representen en el teatre amb ID 1 en una data i hora determinades.
SELECT Obra_Titol FROM Funcio WHERE Teatre_ID = 1 AND datetime = '2023-04-21 20:00:00';

-- Mostra el nombre total de funcions que es faran en el teatre amb ID 1 en un interval de temps determinat.
SELECT COUNT(*) FROM Funcio WHERE Teatre_ID = 1 AND datetime BETWEEN '2023-04-20 00:00:00' AND '2023-04-24 00:00:00';

-- Mostrar el títol de les obres, la data i hora de les funcions, i el nom del teatre on es realitzaran.
SELECT Obra.titol, Funcio.datetime, Teatre.nom FROM Obra
JOIN Funcio ON Obra.titol = Funcio.Obra_Titol
JOIN Teatre ON Funcio.Teatre_ID = Teatre.ID;

-- Mostrar el nom i la tasca de tot el personal tècnic de la taula PersonalTecnic, juntament amb el títol de l'obra en la qual estan treballant.

SELECT P.nom, OP.tasca, O.titol FROM PersonalTecnic
JOIN Persona P ON PersonalTecnic.DNI = P.DNI
JOIN Obra_PersonalTecnic OP ON PersonalTecnic.DNI = OP.personal_DNI
JOIN Obra O ON OP.titol = O.titol;

-- Mostrar el nom dels actors que fan de protagonista en totes les obres de la taula Obra.
SELECT P.nom FROM Actors
JOIN Persona P ON Actors.DNI = P.DNI
JOIN Obra_Actor ON Actors.DNI = Obra_Actor.actor_dni
JOIN Obra ON Obra_Actor.titol = Obra.titol
WHERE Obra_Actor.rol = 'principal';

-- Mostrar el nom dels directors de la taula Director que no hagin dirigit cap obra de la taula Obra.
SELECT P.nom FROM Director
JOIN Persona P ON Director.DNI = P.DNI
LEFT JOIN Obra ON Director.DNI = Obra.idDirector
WHERE Obra.titol IS NULL;

-- Mostrar el nom dels teatres que estiguin a Barcelona i tinguin una capacitat de més de 100 persones.
SELECT nom FROM Teatre
WHERE ciutat = 'Barcelona' AND capacitat > 100;

-- Mostrar el nom de l'obra, la data i hora de la funció, la categoria del teatre i el preu dels tickets per a totes les funcions de la taula Funcio.
SELECT Obra.titol, Funcio.datetime, Teatre.categoria, Obra.cost FROM Funcio
JOIN Teatre ON Funcio.Teatre_ID = Teatre.ID
JOIN Obra ON Funcio.Obra_Titol = Obra.titol;

-- Mostrar el número de silla, el títol de l'obra, la data i hora de la funció i el nom del teatre on es realitza, per a tots els tickets de la taula Ticket.
SELECT silla, Obra.titol, Funcio.datetime, Teatre.nom FROM Ticket
JOIN Funcio ON Ticket.datetime = Funcio.datetime AND Ticket.Teatre_ID = Funcio.Teatre_ID AND Ticket.Obra_Titol = Funcio.Obra_Titol
JOIN Teatre ON Funcio.Teatre_ID = Teatre.ID
JOIN Obra ON Ticket.Obra_Titol = Obra.titol;
