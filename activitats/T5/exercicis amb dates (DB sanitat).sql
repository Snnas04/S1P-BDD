-- EXERCICIS amb funcions de dates i hores 
-- NOTA: Tots els noms (de mesos i dies) han d'estar en català (o castellà)

USE sanitat;

-- Llista de malalts amb el seu cognom i la data de naixement en format '<dia> de <mes> de <any> (per exemple, 6 de gener de 2014)
SELECT COGNOM, date_format(DATA_NAIX, '%D de %M de %Y') AS 'Data de naixament'
	FROM MALALT;

-- Quins malalts fan anys el mes de maig
SELECT COGNOM, DATA_NAIX
	FROM MALALT
    WHERE month(DATA_NAIX)= 5;

-- En quins mesos se celebren aniversaris de malats?
SELECT DISTINCT monthname(DATA_NAIX) AS 'Mes de naixament'
	FROM MALALT;
    
-- Llista de malalts amb el seu cognom i la seva edat
SELECT COGNOM, timestampdiff(year, DATA_NAIX, now()) AS 'edad'
	FROM MALALT;

-- Llista de malalts amb el seu cognom i la seva edat, però només els que tenen 70 o més anys
SELECT COGNOM, timestampdiff(year, DATA_NAIX, now()) AS edad
	FROM MALALT
    WHERE timestampdiff(year, DATA_NAIX, now()) >= 70;
