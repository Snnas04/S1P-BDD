use JARDINERIA;

-- 1
create view CompteComandesMadrid as select NomClient,
                                    NomContacte,
                                    (select count(CodiComanda)
                                        from Comandes
                                        where Clients.CodiClient = Comandes.CodiClient) as 'NumeroDeComandes'
                                    from Clients
                                    where Regio = 'Madrid'
                                    order by NomClient asc;

-- 2
-- No he posat que l’usuari es connecti només des del localhost perquè al emprar docker me dona error a l’hora d’intentar connectar-me
create user X identified by 'X';
grant select (NomClient, NomContacte, NumeroDeComandes) on CompteComandesMadrid to X;
grant select on Clients to X;

show grants for X;

-- 3
-- s'ha d'executrar desde l'usuari X, per complir amb els requisits de l'exercisi
select cm.`NomClient`, c.`CodiPostal`, c.`Telefon`
from `CompteComandesMadrid` cm
join `Clients` as c on c.`NomClient` = cm.`NomClient`
order by `NumeroDeComandes` desc, cm.NomClient asc
limit 5;

-- 4
create view Top5Madrid as select cm.`NomClient`, c.`CodiPostal`, c.`Telefon`
                            from `CompteComandesMadrid` cm
                            join `Clients` as c on c.`NomClient` = cm.`NomClient`
                            order by `NumeroDeComandes` desc, cm.NomClient asc
                            limit 5;

grant select (NomClient, CodiPostal, Telefon) on Top5Madrid to X;

-- 5
revoke select (NomClient, NomContacte, NumeroDeComandes) on CompteComandesMadrid from X;
revoke select on Clients from X;

select *
from Top5Madrid;
