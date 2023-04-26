delimiter $$

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

create procedure calculatePrice(basePrice float, customer varchar(10), residentStatus boolean, largeFamily boolean)
    begin
        declare price float;

        case
            when customer = 'Silver' then price
            when customer = 'Gold' then price
            when customer = 'Platinum' then price
            when customer = 'None' then price
            end;
    end $$

-- 2. Write a procedure that receives three numbers and show them ordered in ascending, in the same line and separated by the symbol <

call ordenant (3,6,8) $$ -- 3 < 6 < 8
call ordenant (3,8,6) $$ -- 3 < 6 < 8
call ordenant (6,3,8) $$ -- 3 < 6 < 8
call ordenant (6,8,3) $$ -- 3 < 6 < 8
call ordenant (8,3,6) $$ -- 3 < 6 < 8
call ordenant (8,6,3) $$ -- 3 < 6 < 8

-- 3. Write a function that receives a string as parameter and returns it with  blanks between its characters. For example, if it receives 'Welcome', it will return 'W e l c o m e'. 

select ampliar ('Welcome') $$ -- W e l c o m e 
select ampliar ('Alice') $$ -- A l i c e 

/* 4. Write a procedure to find multiples of a number. This procedure will have four parameters: 
- the number from which we want to get the multiples  
- the number from which we begin to search
- the last number where we finish the searching
- an output parameter to save the result 
*/


call muLtiples (2,1,100,@result) $$
select @result $$ -- The multiples of 2 are:  2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100

call muLtiples (3,1,100,@result) $$
select @result $$ -- The multiples of 3 are:  3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87 90 93 96 99

call muLtiples (4,1,100,@result) $$
select @result $$ -- The multiples of 4 are:  4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100