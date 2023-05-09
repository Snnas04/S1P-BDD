select CodiCap, count(*) as cont
from Empleats
group by CodiCap
order by cont desc;

-- un trigger que controli que un empleat no tengui més de 10 Empleats
DROP TRIGGER IF EXISTS comprovacioCapEmpleats;
CREATE TRIGGER comprovacioCapEmpleats BEFORE INSERT ON Empleats
    FOR EACH ROW
BEGIN
    IF ((SELECT count(*) from Empleats WHERE CodiCap = NEW.CodiCap) >= 10) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'This have 10 or more employees!!';
    end if;
end;


INSERT INTO Empleats VALUES (1000, 'PROVA', 'PROVA2', 'ff', 'FF', 'ff', 3, 3, 'PROVA');
