-- Mostra totes les obres del gènere 'drama' ordenades alfabèticament per títol.
SELECT * FROM Obra WHERE idGenere = (SELECT ID FROM Generes WHERE genere = 'drama') ORDER BY titol ASC;

-- Mostra el títol de les obres que es representen en el teatre amb ID 2 en una data i hora determinades.
SELECT Obra_Titol FROM Funcio WHERE Teatre_ID = 2 AND datetime = '2023-04-23 20:00:00';

-- Mostra el nombre total de funcions que es faran en el teatre amb ID 1 en un interval de temps determinat.
SELECT COUNT(*) FROM Funcio WHERE Teatre_ID = 1 AND datetime BETWEEN '2023-04-20 00:00:00' AND '2023-04-21 00:00:00';

-- Mostrar el títol de les obres, la data i hora de les funcions, i el nom del teatre on es realitzaran.
SELECT Obra.titol, Funcio.datetime, Teatre.nom FROM Obra
JOIN Funcio ON Obra.titol = Funcio.Obra_Titol
JOIN Teatre ON Funcio.Teatre_ID = Teatre.ID;

-- Mostrar el nom i la tasca de tot el personal tècnic de la taula PersonalTecnic, juntament amb el títol de l'obra en la qual estan treballant.
SELECT PersonalTecnic.nom, PersonalTecnic.tasca, Obra.titol FROM PersonalTecnic
JOIN Obra_PersonalTecnic ON PersonalTecnic.DNI = Obra_PersonalTecnic.personal_DNI
JOIN Obra ON Obra_PersonalTecnic.titol = Obra.titol;

-- Mostrar el nom dels actors que fan de protagonista en totes les obres de la taula Obra.
SELECT Actors.nom FROM Actors
JOIN Obra_Actor ON Actors.DNI = Obra_Actor.actor_dni
JOIN Obra ON Obra_Actor.titol = Obra.titol
WHERE Obra_Actor.rol = 'principal';

-- Mostrar el nom dels directors de la taula Director que no hagin dirigit cap obra de la taula Obra.
SELECT Director.nom FROM Director
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
