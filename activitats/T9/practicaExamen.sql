USE JARDINERIA;

DELIMITER $$

/* 1. Implementa una funció que rebi per paràmetre un número (que representa un límit de crèdit) i que retorni un literal alfanumèric que podrà ser VIP++ (si el crèdit és superior a 100000), VIP (si el crèdit està entre 40000 i 100000, ambdós inclosos) o CC (si és inferior a 40000). 

Fes una consulta de Clients amb el codi i el nom del client, la ciutat i el tipus de client (VIP++, VIP o CC) segons el límit de crèdit que tengui. Cal utilitzar la funció que has implementat abans. [2 punts]
*/

drop function if exists tipus_client $$
create function tipus_client(credit decimal(15,2)) returns varchar(5)
no sql
  if credit > 100000 then
    return 'VIP++';
  elseif credit >= 40000 then
    return 'VIP';
  else
    return 'CC';
  end if $$

select CodiClient, NomClient, Ciutat, LimitCredit, tipus_client(LimitCredit) tipusClient 
from Clients $$

/*  2. No tenim implementada la restricció d'integritat "on delete cascade" a la clau forana de DetallComandes sobre Comandes. Crea el trigger necessari per a que aquesta restricció sigui efectiva.  [1 punt]
*/

drop trigger if exists del_comanda $$
CREATE TRIGGER del_comanda BEFORE DELETE ON Comandes
for each row
  delete from DetallComandes where CodiComanda = old.CodiComanda $$

-- SET foreign_key_checks = 0 $$
begin $$
delete from Comandes where CodiComanda = 1 $$
rollback $$
-- SET foreign_key_checks = 1$$

/* 3. Escriu un procediment que rebi per paràmetre el codi d’un cap («jefe») i mostri una llista numerada dels empleats que depenen d’ell. La llista acaba amb el nom del cap i el nombre d’empleats que té. [2 punts]

Exemple: CALL EmpleatsDe(3)
*/

select Nom,Cognom1,Cognom2 from Empleats where CodiCap = 3 $$

DROP PROCEDURE IF EXISTS EmpleatsDe $$
CREATE PROCEDURE EmpleatsDe(cap int)
BEGIN
  declare final boolean default false;
  declare llista text default '';
  declare cont tinyint default 0;
  declare vNom,vCognom1,vCognom2 varchar(50);
  
  declare cur_emple cursor for select Nom,Cognom1,Cognom2 from Empleats where CodiCap = cap;
  declare continue handler for not found set final = true;

  open cur_emple;
  
  myLoop: LOOP
    FETCH cur_emple INTO vNom,vCognom1,vCognom2;
    
    if final then
      leave myLoop;
    else
      set cont = cont + 1;
      set llista = concat(llista,cont,' - ',vNom,' ',vCognom1,' ',vCognom2,'\n');
    end if;
  
  END LOOP;
  
  select Nom,Cognom1,Cognom2 into vNom,vCognom1,vCognom2 from Empleats where CodiEmpleat = cap;
  set llista = concat(llista,'\nEl cap ',vNom,' ',vCognom1,' ',vCognom2,' té ',cont,' empleats');
  
  select llista;
  close cur_emple;
END $$

call EmpleatsDe(3) $$

/* 4. Modifica la taula “GamesProductes” per afegir un camp: quantitat int default 0
    • Actualitza aquest camp amb els valors correctes segons l’estoc que hi ha dels productes.
    • Crea el trigger per a que la inserció de «Productes» actualitzi automàticament aquest camp «quantitat» de la taula «GamesProductes» [3 punts]
    • Crea el trigger per a que l’eliminació de «Productes» actualitzi automàticament aquest camp «quantitat» de la taula «GamesProductes» [3 punts]
    • Crea el trigger per a que en modificar els camps «Estoc» o «Gama» de «Productes» se llanci un error indicant que l’actualització no està permesa.
*/
alter table GamesProductes add column quantitat int default 0 $$
select gama,sum(estoc) from productes group by gama $$
update GamesProductes g set quantitat = ifnull((select sum(estoc) from Productes where Gama = g.Gama),0) $$

drop trigger if exists ins_producte $$
create trigger ins_producte after insert on Productes
for each row
  update GamesProductes set quantitat = quantitat + new.Estoc where Gama = new.Gama $$

INSERT INTO Productes VALUES ('12345','LIMONERO','Frutales','100-130','Inca Jardí','Un cítric fantàstic',12,100,95)$$
  
drop trigger if exists del_producte $$
create trigger del_producte after delete on Productes
for each row
  update GamesProductes set quantitat = quantitat - old.Estoc where Gama = old.Gama $$

DELETE FROM Productes WHERE CodiProducte = '12345' $$

drop trigger if exists upd_producte $$
create trigger upd_producte after update on Productes
for each row
  if (old.Estoc != new.Estoc) or (old.Gama != new.Gama) then
    signal sqlstate '45000' set message_text = 'ERROR: Update denied for the stock field';
  end if $$

/*  
create trigger upd_producte after update on Productes
for each row
  if (old.Estoc != new.Estoc) or (old.Gama != new.Gama) then
    update GamesProductes set quantitat = quantitat - old.Estoc where Gama = old.Gama;
    update GamesProductes set quantitat = quantitat + new.Estoc where Gama = new.Gama;
  end if $$
*/

UPDATE Productes SET Dimensions='100-153' where CodiProducte = '12345' $$ -- ok
UPDATE Productes SET Gama='Ornamentales' where CodiProducte = '12345' $$ -- Error Code: 1644. ERROR: Update denied for the stock field
UPDATE Productes SET Estoc=9 where CodiProducte = '12345' $$ -- Error Code: 1644. ERROR: Update denied for the stock field
