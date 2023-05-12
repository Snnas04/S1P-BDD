-- 1
drop function if exists mediaInfo;
create function mediaInfo(cuantsBytes int, medidaType int) returns varchar(13)
    reads sql data
    begin
        if (medidaType = 3) then
            if (cuantsBytes < 300000000) then
                return 'Video lleuger';
            elseif (cuantsBytes > 300000000 and cuantsBytes < 600000000) then
                return 'Video';
            elseif (cuantsBytes > 600000000) then
                return 'Video pesat';
            end if;
        else
            if (cuantsBytes < 17000000) then
                return 'Audio lleuger';
            elseif (cuantsBytes > 17000000 and cuantsBytes < 35000000) then
                return 'Audio';
            elseif (cuantsBytes > 35000000) then
                return 'Audio pesat';
            end if;
        end if;
    end;

select mediaInfo(500000000, 3);
select mediaInfo(620000000, 3);
select mediaInfo(200000000, 3);
select mediaInfo(20000000, 2);
select mediaInfo(2000000, 4);
select mediaInfo(200000000, 2);

-- 2
drop trigger if exists  validarCanvisFactures;
create trigger validarCanvisFactures before update on Invoice
    for each row
    begin
        if (month(OLD.InvoiceDate) < month(curdate()) or year(OLD.InvoiceDate) < year(curdate())) then
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ha passat mes d un mes';
        end if;
    end;

select InvoiceId, InvoiceDate from Invoice;

update Invoice
set InvoiceDate = '2009-06-05' where InvoiceId = 28;

-- 3
create event augmentPreu
    on schedule every 1 year starts '01-01-2024'
    do
    begin
        update Track
            set UnitPrice = UnitPrice + (UnitPrice * 0.1);
    end;

select * from Track;

-- 4
drop procedure if exists trackFromAlbum;
CREATE PROCEDURE trackFromAlbum (IN disco VARCHAR(255), OUT artista VARCHAR(100), OUT cancons VARCHAR(255))
reads sql data
begin
    declare discoID int;

    select AlbumId into discoID from Album where Title = disco;

    select A.Name into artista from Album
        join Artist A on Album.ArtistId = A.ArtistId
        where AlbumId = discoID;

    select concat(Name, '(', time_format(Milliseconds, '%m:%S') , ')') into cancons
        from Track;
end;

call trackFromAlbum('Big Ones',@artista, @cancons);
select (@artista, @cancons);

-- 5
alter table Album add column numTracks int;

drop trigger if exists recompteTracks;
create trigger recompteTracks after insert on Album
    for each row
    begin
        if (numTracks < (select count(TrackId) from Track where Track.AlbumId = AlbumId)) then
            update Album
            set numTracks = numTracks + (select count(TrackId) from Track group by AlbumId);
        end if;
    end;

select * from Album order by AlbumId desc;

insert into Album (AlbumId, Title, ArtistId)
values (352, 'Test3', 275);
