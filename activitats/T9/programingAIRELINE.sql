-- 1
select date(departure_time) AS 'DATE',
       id_flight AS FLIGHT,
       a.location AS 'FROM',
       ai.location AS 'TO',
       date_format(departure_time, '%H:%i') as 'DEPARTURE TIME',
           date_format(arrival_time, '%H:%i') AS 'ARRIVAL TIME',
       DATE_FORMAT(SEC_TO_TIME(TIMESTAMPDIFF(SECOND, departure_time, arrival_time)), '%H:%i') as DURATION,
       c.alias as PILOT,
       cr.alias as COPILOT
from FLIGHTS as f
join CREWS as c on c.id_crew = f.id_pilot
join CREWS as cr on cr.id_crew = f.id_copilot
join AIRPORTS as a on a.id_airport = f.departure_airport
join AIRPORTS as ai on ai.id_airport = f.arrival_airport;

-- 2
drop procedure if exists insertFlights;
create procedure insertFlights (id_flight int, flight_number char(5), departure_location varchar(30), arrival_location varchar(30), departure_time datetime, arrival_time datetime, pilot varchar(20), copilot varchar(20))
begin
    declare da char(3) default '';
    declare aa char(3) default '';
    declare idPilot int default 0;
    declare idCopilot int default 0;

    set da = (select id_airport from AIRPORTS where location = departure_location);
    set aa = (select id_airport from AIRPORTS where location = arrival_location);
    set idPilot = (select id_crew from CREWS where alias = pilot);
    set idCopilot = (select id_crew from CREWS where alias = copilot);

    if exists (select 1 from AIRPORTS where location = departure_location) then
        if exists (select 1 from AIRPORTS where location = arrival_location) then
            if exists (select 1 from CREWS where alias = pilot) then
                if exists (select 1 from CREWS where alias = copilot) then
                    insert into FLIGHTS values (id_flight, flight_number, da, aa, departure_time, arrival_time, null, idPilot, idCopilot);
                else
                    select 'ERROR: incorrect parameters';
                end if;
            else
                select 'ERROR: incorrect parameters';
            end if;
        else
            select 'ERROR: incorrect parameters';
        end if;
    else
        select 'ERROR: incorrect parameters';
    end if;
end;

call insertFlights (200, 'FR589', 'Amsterdam', 'Madrid', '2023-05-06 20:00:00', '2023-05-06 23:00:00', 'PEPE', 'JUAN');
call insertFlights (200, 'BL589', 'Loco', 'Madrid', '2023-05-06 20:00:00', '2023-05-06 23:00:00', 'PEPE', 'JUAN');
call insertFlights (200, 'FR589', 'Amsterdam', 'Loco', '2023-05-06 20:00:00', '2023-05-06 23:00:00', 'PEPE', 'JUAN');
call insertFlights (200, 'FR589', 'Amsterdam', 'Madrid', '2023-05-06 20:00:00', '2023-05-06 23:00:00', 'Desconocido', 'JUAN');
call insertFlights (200, 'FR589', 'Amsterdam', 'Madrid', '2023-05-06 20:00:00', '2023-05-06 23:00:00', 'PEPE', 'Desconocido');


-- 3
create procedure flightFrom(IN searchLocation VARCHAR(30))
BEGIN
    DECLARE output VARCHAR(1000) DEFAULT CONCAT('From ', searchLocation);
    DECLARE departureDate DATE;
    DECLARE flightNumber CHAR(5);
    DECLARE departureTimeHM VARCHAR(255);
    DECLARE airport CHAR(3);
    DECLARE fin BOOLEAN DEFAULT FALSE;
    DECLARE flight CURSOR FOR SELECT DATE(departure_time) as dateA,
                                     flight_number,
                                     TIME_FORMAT(departure_time, '%H:%i'),
                                     arrival_airport
                              FROM FLIGHTS
                                       JOIN AIRPORTS D on D.id_airport = FLIGHTS.departure_airport
                              WHERE D.location = searchLocation
                              ORDER BY dateA;
    declare continue handler for not found set fin = true;
    OPEN flight;
    WHILE fin = FALSE
        DO
            fetch flight into departureDate,flightNumber,departureTimeHM, airport;
            SET output =
                    CONCAT(
                            output, '\n', '------>',
                            'on ', departureDate,
                            ' flight nr. ', flightNumber,
                            ' to ', airport,
                            ' at ', departureTimeHM
                        );
        end while;
    CLOSE flight;
    SELECT output;
END;

call flightFrom('Bilbao');

-- 4
-- option 1
CREATE TRIGGER check_number_pax
    BEFORE INSERT ON FLIGHTS
    FOR EACH ROW
BEGIN
    IF NEW.number_pax < 0 OR NEW.number_pax > 300 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'The number of passengers must be between 0 and 300';
    END IF;
END;

-- option 2
CREATE TRIGGER check_pax_count
    BEFORE INSERT ON FLIGHTS
    FOR EACH ROW
BEGIN
    IF NEW.number_pax < 0 THEN
        SET NEW.number_pax = 0;
    ELSEIF NEW.number_pax > 300 THEN
        SET NEW.number_pax = 300;
    END IF;
END;

-- 5
-- a)
ALTER TABLE AIRPORTS ADD COLUMN nr_flights INT DEFAULT 0;

UPDATE AIRPORTS A
SET nr_flights = (SELECT COUNT(departure_airport)
                  FROM FLIGHTS F
                  WHERE F.departure_airport = A.id_airport);

-- b)
create trigger insertFlights after insert on FLIGHTS
    for each row
    update AIRPORTS set nr_flights = nr_flights + 1 where id_airport = NEW.departure_airport;

create trigger updateFlights after update on FLIGHTS
    for each row
    if OLD.departure_airport != NEW.departure_airport then
        update AIRPORTS set nr_flights = nr_flights - 1 where id_airport = OLD.departure_airport;
        update AIRPORTS set nr_flights = nr_flights + 1 where id_airport = NEW.departure_airport;
    end if;

create trigger deleteFlights after delete on FLIGHTS
    for each row
    update AIRPORTS set nr_flights = nr_flights - 1 where id_airport = OLD.departure_airport;
