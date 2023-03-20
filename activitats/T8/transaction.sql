start transaction;

update cuentas set saldo = saldo - 100 where cod_cuenta= 3;
update cuentas set saldo = saldo + 100 where cod_cuenta= 4;

commit;
