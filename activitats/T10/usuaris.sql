SELECT * FROM mysql.user;

create user test@localhost identified by 'password'; -- indicam el nom d'usuari, l'equip del qual se pot connectar i una contrasenya, si no especificam el servidor per defecta posa % "qualsevol"

drop user test;