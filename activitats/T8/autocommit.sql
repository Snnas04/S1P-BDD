select @@autocommit;

set autocommit = 0;

select count(*) from city;

select * from city where CountryCode = 'ESP';

delete from city where CountryCode = 'ESP';

select * from city where CountryCode = 'ESP';

rollback;

select * from city where CountryCode = 'ESP';

select @@autocommit;
