-- Changing Videoclub database

-- The goal of this activity is to practice creating and modifying tables in MySQL.

USE videoclub;

-- 1. Modify the PRESTEC table to add information about whether or not the loan has already been returned.
ALTER TABLE PRESTEC ADD COLUMN data_retorn date;

-- 2. As it is expected to be intensively used the search for movie titles, create an index on the titles of PELICULA.
ALTER TABLE PELICULA ADD INDEX (titol);
ALTER TABLE PELICULA ADD KEY (titol);
CREATE INDEX index_title ON PELICULA (titol);

-- 3. We want that the CodiGenere field of GENERE table has the auto increment property.
SET foreign_key_checks = 0; -- lleva les FK
ALTER TABLE GENERE MODIFY CodiGenere INT auto_increment PRIMARY KEY;
SET foreign_key_checks = 1;

-- 4. Modify the DETALLFACTURA table so that the NumeroUnitats field has the value 1 by default and must be always positive.
ALTER TABLE DETALLFACTURA MODIFY NumeroUnitats INT DEFAULT 1,
    ADD CONSTRAINT positive CHECK (NumeroUnitats > 0);
