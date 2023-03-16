-- BBDD empresa -----------------------------------------------------------------------------------------------------

-- 1. Mostreu els productes (codi i descripció) que comercialitza l’empresa.
SELECT PROD_NUM, DESCRIPCIO 
	FROM PRODUCTE;

-- 2. Mostreu els productes (codi i descripció) que contenen la paraula tennis en la descripció.
SELECT PROD_NUM, DESCRIPCIO 
	FROM PRODUCTE
	WHERE DESCRIPCIO like '%tennis%';

-- 3. Mostreu el codi, nom, àrea i telèfon dels clients de l’empresa.
SELECT CLIENT_COD, NOM, AREA, TELEFON 
	FROM CLIENT;

-- 4. Mostreu els clients (codi, nom, ciutat) que no són de l’àrea telefònica 636.
SELECT CLIENT_COD, NOM, CIUTAT
	FROM CLIENT
    WHERE AREA != 636;

-- 5. Mostreu les ordres de compra de la taula de comandes (codi, dates d’ordre i de tramesa).
SELECT CLIENT_COD, COM_DATA, DATA_TRAMESA
	FROM COMANDA;

-- 6. Relació de tots els clients (codi, nom i observacions) que tinguin un crèdit superior a 4.000 i inferior a 8.000 i el nom dels quals contingui alguna S.
SELECT CLIENT_COD, NOM, OBSERVACIONS 
	FROM CLIENT
    WHERE LIMIT_CREDIT BETWEEN 4000 AND 8000
		AND NOM LIKE '%S%';

-- BBDD sanitat -----------------------------------------------------------------------------------------------------

-- 1. Mostreu els hospitals existents (número, nom i telèfon).
SELECT HOSPITAL_COD, NOM, TELEFON
	FROM HOSPITAL;

-- 2. Mostreu els hospitals existents (número, nom i telèfon) que tinguin una lletra A en la segona posició del nom.
SELECT HOSPITAL_COD, NOM, TELEFON
	FROM HOSPITAL
    where NOM LIKE '_a%';

-- 3. Mostreu els treballadors (codi hospital, codi sala, número empleat i cognom) existents.
SELECT HOSPITAL_COD, SALA_COD, EMPLEAT_NO, COGNOM
	FROM PLANTILLA;
    
-- 4. Mostreu els treballadors (codi hospital, codi sala, número empleat i cognom) que no siguin del torn de nit.
SELECT HOSPITAL_COD, SALA_COD, EMPLEAT_NO, COGNOM
	FROM PLANTILLA
    WHERE TORN != 'N';
 
-- 5. Mostreu els malalts nascuts l’any 1960.
SELECT * 
	FROM MALALT
    WHERE DATA_NAIX LIKE '1960-__-__';

-- 6. Mostreu els malalts nascuts a partir de l’any 1960.
SELECT *
	FROM MALALT
    WHERE DATA_NAIX <= '1960-01-01';

-- 7. Relació de tots els doctors de l’hospital 22.
SELECT  * 
	FROM DOCTOR
    WHERE HOSPITAL_COD LIKE '22';


-- BBDD videoclub -----------------------------------------------------------------------------------------------------

-- 1. Llista de noms i telèfons dels clients.
SELECT Nom, Telefon 
	FROM CLIENT;

-- 2. Llista de dates i imports de les factures.
SELECT Data, Import
	FROM FACTURA;

-- 3. Llista de productes (descripció) facturats en la factura número 3.
SELECT Descripcio
	FROM DETALLFACTURA
    WHERE CodiFactura LIKE 3;

-- 4. Llista de factures ordenada de forma decreixent per import.
SELECT *
	FROM FACTURA
    ORDER BY Import DESC;

-- 5. Llista dels actors el nom dels quals comenci per X.
SELECT *
	FROM ACTOR
    WHERE Nom LIKE 'X%';
