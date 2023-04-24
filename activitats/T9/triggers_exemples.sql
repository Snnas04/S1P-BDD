show triggers; -- nomes te mostra es triggers de la base de dades que l'indiques, per defecta nomes te mostra els que tens a la base de dades on te trobes.

set @sum = 0;
select @sum;

drop trigger if exists insert_moviments;
create trigger insert_moviments after insert on movimientos
    for each row
    set @sum = @sum + NEW.cantidad;

insert into movimientos values (now(), 70, '11223344', 6, 11);
select @sum;

insert into movimientos values (now(), 50, '11223344', 7, 12);
select @sum;


-- control of input values

drop trigger if exists tope_movimiento;
create trigger tope_movimiento before insert on movimientos
    for each row
    if NEW.cantidad > 100000 then
        set NEW.cantidad = 100000;
    end if;


insert into movimientos values (now(), 9999, '11223344', 5, 13);


-- maintenace of derived fields

drop trigger if exists act_compte;
create trigger act_compte after insert on movimientos
    for each row
    update cuentas set saldo = saldo + NEW.cantidad where cod_cuenta = new.cod_cuenta;

select * from cuentas;
insert into movimientos values (now(), 20, '11223344', 3, 14);
select * from cuentas;


-- statisitics

create TABLE statistics (
    id int auto_increment primary key,
    dia date,
    num_clients int
);

drop trigger if exists inseri_client;
create trigger inseri_client after insert on clientes
    for each row
    begin
        if exists(select * from statistics where dia = curdate()) then
            update statistics set num_clients = num_clients + 1 where dia = curdate();
        else
            insert into statistics values (null, curdate(),1);
        end if;
    end;

insert into clientes values (4, 11112222, 'Marc', 'Sans', 'Vera', 'c/ antoni maura 66');
insert into clientes values (5, 22223333, 'Andreu', 'Garcia', 'Algo', 'c/ un carrer numero');

select * from statistics;


-- login and auditing

select current_user();

create table auditoria (
    id int auto_increment primary key,
    saldo int,
    cod_cuenta int,
    usuari varchar(15),
    dia datetime
);

create trigger eliminar_compte after delete on cuentas
    for each row
    insert into auditoria values (null, OLD.saldo, OLD.cod_cuenta, current_user(), now());

select * from movimientos;


delete from tiene where cod_cuenta = 7;
delete from movimientos where id_movimiento = 10;
delete from cuentas where cod_cuenta = 7;
select * from auditoria;
