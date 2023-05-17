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
grant select (NomClient, NomContacte) on CompteComandesMadrid to X;
grant select on Clients.* to X;

