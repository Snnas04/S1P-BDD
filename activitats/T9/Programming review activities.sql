/* 1. Create a procedure to calculate the real price of a flight.
The procedure will receive 4 input parameters:
- a base price, the initial price of the flight without any discounts.
- a customer fidelity program level:
	· ‘Silver’ → 5% discount
	· ‘Gold’ → 10% discount
	· ‘Platinum’ → 15% discount
	· ‘None’ → 0% discount
- a resident status:
	· If the client is resident in the islands → 75% discount
	· If not resident, no discount
- a large family (families with 3 or more children) condition:
	· If the client is a recognised large family member → 10% discount
	· If not, no discount
The discounts are all compatible between them. That is, if a customer is a ‘Gold’ member, resident and member of a large family, the discount he should obtain is 95% over the base price.
The procedure should return in an output parameter the real price of the flight, considering the possible discounts.
*/
drop procedure if exists calculatePrice;

delimiter $$

create procedure calculatePrice(in basePrice float, in customer varchar(10), in residentStatus boolean, in largeFamily boolean, out price float)
    begin
        declare discount float;

        if customer != 'None' then
            case
                when customer = 'Silver' then set discount = discount + 0.5 ;
                when customer = 'Gold' then set discount = discount + 0.1;
                when customer = 'Platinum' then set discount = discount + 0.15;
            end case;
        end if $$

        if residentStatus then
            set discount = discount + 0.75;
        end if $$

        if largeFamily then
            set discount = discount + 0.1;
        end if $$

        set price = basePrice - (basePrice * discount);
    end $$


-- diosito procedure
CREATE PROCEDURE calcDiscount(
    IN basePrice DECIMAL(6, 2),
    IN fidelityLevel ENUM ('Silver', 'Gold', 'Platinum', 'None'),
    IN resident BOOLEAN,
    IN largeFamily BOOLEAN,
    OUT finalPrice DECIMAL(6, 2)
)
BEGIN
    DECLARE discount FLOAT;

    CASE fidelityLevel
        WHEN 'Silver' THEN SET discount = 0.05;
        WHEN 'Gold' THEN SET discount = 0.1;
        WHEN 'Platinum' THEN SET discount = 0.15;
        WHEN 'None' THEN SET discount = 0;
        END CASE;

    IF resident THEN
        SET discount = discount + 0.75;
    END IF;

    IF largeFamily THEN
        SET discount = discount + 0.1;
    END IF;

    SELECT discount;
    SET finalPrice = basePrice - (basePrice * discount);
END $$

delimiter ;


-- 2. Write a procedure that receives three numbers and show them ordered in ascending, in the same line and separated by the symbol <

drop procedure if exists ordenant;

delimiter $$

create procedure ordenant(num1 int, num2 int, num3 int)
    reads sql data
begin
    declare ordenat boolean default true;
    declare temp int default 0;
    while ordenat do
            if num1 < num2 then
                set temp = num1;
                set num1 = num2;
                set num2 = temp;
            end if;

            if num2 < num3 then
                set temp = num2;
                set num2 = num3;
                set num3 = temp;
            end if;
            if num1 > num2 and num2 > num3 then
                set ordenat = false;
            end if;
        end while;

    select concat(num3, ' < ', num2, ' < ', num1);
end $$


delimiter ;

call ordenant (3,6,8); -- 3 < 6 < 8
call ordenant (3,8,6); -- 3 < 6 < 8
call ordenant (6,3,8); -- 3 < 6 < 8
call ordenant (6,8,3); -- 3 < 6 < 8
call ordenant (8,3,6); -- 3 < 6 < 8
call ordenant (8,6,3); -- 3 < 6 < 8

-- 3. Write a function that receives a string as parameter and returns it with  blanks between its characters. For example, if it receives 'Welcome', it will return 'W e l c o m e'.
delimiter $$

DROP FUNCTION ampliar;
CREATE FUNCTION ampliar(word VARCHAR(127)) RETURNS VARCHAR(255)
    NO SQL
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result VARCHAR(255) DEFAULT '';
    lop : LOOP
        IF i > CHAR_LENGTH(word) THEN
            LEAVE lop;
        END IF;

        SET result = CONCAT( result, ' ', SUBSTR(word FROM i FOR 1));
        SET i = i +1;
    END LOOP;
    RETURN  result;
END $$

delimiter ;


select ampliar ('Welcome'); -- W e l c o m e
select ampliar ('Alice'); -- A l i c e

/* 4. Write a procedure to find multiples of a number. This procedure will have four parameters: 
- the number from which we want to get the multiples  
- the number from which we begin to search
- the last number where we finish the searching
- an output parameter to save the result 
*/
-- toni vercio
delimiter $$
set @resultado = 0 $$

DROP PROCEDURE if exists muLtiples;
create procedure multiples (in tablaNumero int, in numeroEmpezar int, in numeroAcabar int, out resultado int)
begin
    declare i int default 1;
    WHILE numeroEmpezar <= numeroAcabar DO
            set numeroEmpezar = tablaNumero * i;
            if numeroEmpezar <= numeroAcabar then
                set resultado = numeroEmpezar;
                set i = i + 1;
            end if;
        END WHILE;
end $$

-- diosito vercio
DROP PROCEDURE if exists muLtiples;
CREATE PROCEDURE muLtiples(IN mult INT, IN init INT, IN end INT, OUT resultString VARCHAR(500))
BEGIN
    DECLARE result INT DEFAULT mult;

    SET resultString = CONCAT('The multiples of ', mult, ' are:');
    main_loop:
    LOOP
        SET result = mult * init;

        IF result > end THEN
            LEAVE main_loop;
        END IF;

        SET resultString = CONCAT(resultString, ' ', result);

        SET init = init + 1;
    END LOOP;
END $$

-- puthon
DROP PROCEDURE if exists muLtiples;
CREATE PROCEDURE muLtiples(base INT, start INT, final INT, OUT result VARCHAR(9999))
BEGIN
    DECLARE tempResult VARCHAR(9999) DEFAULT '';
    DECLARE counter INT DEFAULT start;

    WHILE counter < final DO
            SET tempResult = CONCAT(tempResult, ' ', counter);
            SET counter = counter + base;
        END WHILE;

    SET result = CONCAT('The multiples of are', base, ' ', tempResult);
END $$

-- juanito
create procedure multiples(number int, begin int, end int, out llista varchar(5000))
    reads sql data
begin
    declare contador int default 1;
    set llista = concat('The multiples of ', number , 'are: ');
    bucle : loop
        if number * contador = end then
            set llista = concat(llista, number * contador);
            leave bucle;
        elseif number * contador > end then
            leave bucle;
        elseif number * contador >= begin then
            set llista = concat(llista, number * contador, ', ');
        end if;
        set contador = contador + 1;
    end loop;
    select llista;
end $$


delimiter ;


call muLtiples (2,1,100,@result);
select @result; -- The multiples of 2 are:  2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100

call muLtiples (3,1,100,@result);
select @result; -- The multiples of 3 are:  3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87 90 93 96 99

call muLtiples (4,1,100,@result);
select @result; -- The multiples of 4 are:  4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100