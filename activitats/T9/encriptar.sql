DELIMITER //

drop function if exists caesar_encrypt //

CREATE FUNCTION caesar_encrypt(str VARCHAR(255), step INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
  DECLARE len INT;
  DECLARE resultat VARCHAR(255);
  DECLARE i INT;
  
  SET len = LENGTH(str);
  SET resultat = '';
  SET step = step % 26;
  
  IF step < 0 THEN
    SET step = step + 26;
  END IF;
  
  SET i = 1;
  
  WHILE i <= len DO
    SET resultat = CONCAT(resultat, CHAR(ASCII(SUBSTRING(str, i, 1)) + step));
    SET i = i + 1;
  END WHILE;
  
  RETURN lower(resultat);
END //

DELIMITER ;

-- select caesar_encrypt('DPOHSBUVMBUJPOT"!Zpv!bsf!uif!cftu"', -1);

select caesar_encrypt('hola bon dia', 1);

























