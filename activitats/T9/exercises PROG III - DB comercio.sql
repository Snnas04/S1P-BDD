-- DB comercio ---------------------------------------------------------------------------------------------------------------
USE comercio;
DELIMITER $$

-- 1) Write what you need to save in a variable defined by user, the number of invoices INSERTED during the current session. SHOW ME how you test your trigger.
set @total = 0 $$
select @total $$

drop trigger if exists insert_fac $$
create trigger insert_fac after insert on facturas
    for each row
    set @total = @total + 1 $$

select * from facturas $$
insert into facturas values (1, curdate(), 'Marc', 2000) $$
select @total;

-- 2) Write what you need to not allow prices UPDATED with values less than 0 or greater than 200 in the "detalles" table. SHOW ME how you test your trigger.
create trigger control_preu before update on detalles
    for each row
    if NEW.precio < 0 then
        set NEW.precio = 0;
    elseif NEW.precio > 200 then
        set NEW.precio = 200;
    end if $$


-- 3) Write what you need to update the field "total" of "facturas" every time a record is INSERTED into "detalles" table. SHOW ME how you test your trigger.



-- 4) Write what you need to update the "facturado_mes" table every time a record is INSERTED in "detalles" table. SHOW ME how you test your trigger.
