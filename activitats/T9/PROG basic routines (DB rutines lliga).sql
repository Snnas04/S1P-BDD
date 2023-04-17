DELIMITER &&

USE rutines;

-- 1. Create a function that returns the current year
create function any_actual() returns int
reads sql data
	return year(curdate());


SELECT any_actual();

-- 2. Create a procedure that shows the first three letters in capitals of a string passed as a parameter.
SELECT upper(SUBSTRING('marc', 1, 3));

create PROCEDURE primeres3(cadena VARCHAR(30))
BEGIN
	DECLARE resultat VARCHAR(3);

	set resultat = upper(SUBSTRING('marc', 1, 3));

	SELECT resultat;
END &&


CALL primeres3('hola radiola');


create FUNCTION primeres3_v2 (cadena varchar(30))
	select UPPER(SUBSTRING(cadena, 1, 3)) &&

CALL primeres3_v2('hola radiola');

-- 3. Create a function that takes two parameters (of string type) and shows them in capitals, concatenated and separated by a blank space.
create function ajunta(primer varchar(20), segon varchar(20)) returns varchar(41)
reads sql data
    return upper(concat( primer, ' ', segon));


SELECT ajunta('alicia', 'rossello');

-- 4. Create a function that returns the largest of three numbers passed as parameters.
CREATE FUNCTION major(primer INT, segon INT, tercer INT) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE max_num INT;
    SET max_num = primer;
    IF segon > max_num THEN
        SET max_num = segon;
    END IF;
    IF tercer > max_num THEN
        SET max_num = tercer;
    END IF;
    RETURN max_num;
END &&


SELECT major(5,34,12); -- 34
SELECT major(34,5,12);
SELECT major(12,5,34);
-- --------------------------------------------------------------------------------------------------------------------------
USE lliga;

-- 5. On the database "lliga", create a function that calculates the number of points taking as parameter the match result in format 'xxx-xxx'. Test your function with the field <resultat> of table "partits".
-- HINT: use the "substring_index" function.
select '123-98',
    substring_index('123-98','-',1),
    substring_index('123-98','-',-1), 
    substring_index('123-98','-',1) + substring_index('123-98','-',-1) &&

CREATE FUNCTION total_punts(resultat VARCHAR(7)) RETURNS INT
reads sql data
BEGIN
    DECLARE punts_local INT;
    DECLARE punts_visitant INT;
    SET punts_local = SUBSTRING_INDEX(resultat, '-', 1);
    SET punts_visitant = SUBSTRING_INDEX(resultat, '-', -1);
    RETURN punts_local + punts_visitant;
END &&

select total_punts('78-100') && -- 178
select elocal,evisitant,resultat,total_punts(resultat) as PUNTS
from partits &&

-- 6. On the database "lliga", create a function that returns true (1) if the visitor wins and false (0) otherwise. The input parameter is the match result in format 'xxx-xxx'.
create function guanyador (resultat varchar(8)) returns tinyint
reads sql data
begin
	declare x int;
    declare y int;
    declare z tinyint;
    set x = substring_index(resultat,'-',1);
    set y = substring_index(resultat,'-',-1);
    
    if x > y then
		set z = 0;
	elseif y > x then
		set z = 1;
	end if;
	return z;
end &&



SELECT guanyador('88-79'); -- 0
SELECT guanyador('79-88'); -- 1
SELECT elocal,evisitant,resultat,guanyador(resultat) FROM partits; -- Check your function with this query



























