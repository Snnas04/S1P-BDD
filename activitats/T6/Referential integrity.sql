-- 1) At the world database, we want to enforce that country capitals are previously inserted into city table.
ALTER TABLE country
ADD CONSTRAINT fk_capitals FOREIGN KEY (Capital) REFERENCES city (ID);

-- 2) At the "video club" database, how to enforce "prestec" are from previously inserted "copia"?
ALTER TABLE PRESTEC
ADD CONSTRAINT fk_codi_copia FOREIGN KEY (CodiPeli, CodiCopia) REFERENCES COPIA (CodiPeli, CodiCopia);

-- 3) Improve referential integrity in "empresa" database to achieve the following:
-- (a) when we delete a purchase order (in "COMANDA" table), we want to delete all lines (in "DETALL" table) of this purchase order.
ALTER TABLE DETALL
ADD CONSTRAINT fk_drop_detall_comanda FOREIGN KEY (COM_NUM) REFERENCES COMANDA (COM_NUM) ON DELETE CASCADE;

-- (b) when we delete a client, we want to delete all purchase orders of this client.
ALTER TABLE COMANDA
ADD CONSTRAINT fk_client_purchase FOREIGN KEY (CLIENT_COD) REFERENCES CLIENT (CLIENT_COD) ON DELETE CASCADE;

