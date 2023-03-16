USE airline;

-- 1) Flight number, arrival airport and the pilot identifier of all flights departing from 'Bilbao' (two ways: subquery and join).
select flight_number, arrival_airport, id_pilot
from FLIGHTS
where departure_airport = (select id_airport from AIRPORTS where location = 'Bilbao');

SELECT f.flight_number, a.location , id_pilot
FROM FLIGHTS f
JOIN AIRPORTS a ON f.arrival_airport = a.id_airport
WHERE f.departure_airport = (SELECT id_airport FROM AIRPORTS WHERE location = 'Bilbao');

-- 2) Flight number, arrival location and the pilot alias of all flights departing from 'Bilbao'.
select f.flight_number, a.location , alias
from FLIGHTS f
join AIRPORTS a ON f.arrival_airport = a.id_airport
join CREWS on id_pilot = CREWS.id_crew
where f.departure_airport = (select id_airport from AIRPORTS where location = 'Bilbao');

-- 3) Firstname and number of flights of ALL pilots;
select c.firstname, 
	(select count(*) from FLIGHTS where id_pilot = c.id_crew) as number
from CREWS as c;

select c.firstname, 
    count(id_flight) as number
from FLIGHTS as f
right join CREWS as c on (c.id_crew = f.id_pilot)
group by c.id_crew;

-- 4) Firstname and number of flights of pilots with more than 2 flights.
select firstname, 
	(select COUNT(*) from FLIGHTS where c.id_crew = id_pilot) as Flights
from CREWS as c
where (select COUNT(*) from FLIGHTS where c.id_crew = id_pilot) > 2;

-- 5) List of pilot identifiers and surnames who have not flown as a copilot. 
SELECT id_crew, surname
FROM CREWS
WHERE id_crew NOT IN (SELECT DISTINCT id_copilot FROM FLIGHTS) 
	AND id_crew IN (SELECT DISTINCT id_pilot FROM FLIGHTS);

-- 6) List of (identifiers and surnames) pilots and copilots who have not flown as a copilot or pilot respectively.
SELECT id_crew, surname
FROM CREWS
WHERE id_crew NOT IN (SELECT DISTINCT id_copilot FROM FLIGHTS) 
	AND id_crew IN (SELECT DISTINCT id_pilot FROM FLIGHTS)
union
SELECT id_crew, surname
FROM CREWS
WHERE id_crew IN (SELECT DISTINCT id_copilot FROM FLIGHTS) 
	AND id_crew NOT IN (SELECT DISTINCT id_pilot FROM FLIGHTS);

SELECT id_crew, surname
FROM CREWS
WHERE (id_crew NOT IN (SELECT DISTINCT id_copilot FROM FLIGHTS) 
	AND id_crew IN (SELECT DISTINCT id_pilot FROM FLIGHTS))
    or
    (id_crew IN (SELECT DISTINCT id_copilot FROM FLIGHTS) 
	AND id_crew NOT IN (SELECT DISTINCT id_pilot FROM FLIGHTS));

-- 7) List of flights with flight number, departure date, departure location, arrival location, pilot alias and copiloy alias.
select flight_number, date(departure_time), sortida.location as sortida, arribada.location as arribada, pilot.alias as pilot, copilot.alias as copilot
from FLIGHTS as f
	join AIRPORTS as sortida on sortida.id_airport = departure_airport
	join AIRPORTS as arribada on arribada.id_airport = departure_airport
	join CREWS as pilot on f.id_pilot = pilot.id_crew
    join CREWS as copilot on f.id_copilot = copilot.id_crew;
    


























