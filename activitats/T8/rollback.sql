select @@autocommit;

set autocommit = 0;

select count(*) from city;

select * from city where CountryCode = 'ESP';

delete from city where CountryCode = 'ESP';

select * from city where CountryCode = 'ESP';

rollback;

select * from city where CountryCode = 'ESP';

select @@autocommit;

--

select * from city where CountryCode = 'AIA';

delete from city where CountryCode = 'AIA';

select * from city where CountryCode = 'AIA';

commit;

--

select * from city where CountryCode = 'FRA';

delete from city where CountryCode = 'FRA';

select * from city where CountryCode = 'FRA';

--

start transaction;

select * from city where CountryCode = 'AFG';

delete from city where CountryCode = 'AFG';

select * from city where CountryCode = 'AFG';

rollback;

select * from city where CountryCode = 'AFG';



























