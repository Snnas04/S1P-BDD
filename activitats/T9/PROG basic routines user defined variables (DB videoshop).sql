-- DB videoshop ---------------------------------------------------------------------------------------------------------------
use videoshop;
-- 1. Store the length of the longest and the shortest film in two session variables.
set @max = (select MAX(length) from films);
SELECT @max;

-- 2. Show all data from both films using variables you created at previous exercise.


-- 3. Store in a session variable the actor name of the longest film.


-- 4. Show all films where the author stored in the previous variable is working.


-- 5. Write a function to return the length of the longest film.


-- 6. Write a procedure (with 3 parameters: title, actor and length) to insert this record in the films table.


-- 7. Write a function (with a film id as parameter) to return the actor name with the first word of the name in uppercase.
