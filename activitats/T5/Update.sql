-- update als empleats que tenen un null a la columna ofici

UPDATE EMP
SET ofici = 'BECARI'
WHERE ofici IS NULL; 

SELECT * FROM EMP
WHERE ofici LIKE 'BECARI';


-- update a un empleat en concret

SELECT * FROM EMP WHERE EMP_NO = 7566;

UPDATE EMP
	SET COGNOM = 'GIMENEZ',
		OFICI = 'DIRECTOR'
    WHERE EMP_NO = 7566;