--use movies;

---- 1
--select name, ADDRESS, title, length
--from movie join studio on studio.NAME = movie.STUDIONAME
--where year > 1980 and studioname LIKE 'M%';

---- 2
--select MOVIESTAR.name, MOVIESTAR.ADDRESS, STARSIN.MOVIETITLE
--from movie join STARSIN on STARSIN.MOVIETITLE = movie.TITLE
--	join MOVIESTAR on STARSIN.STARNAME = MOVIESTAR.NAME
--where year > 1990 and STARNAME LIKE 'J%'

---- 3
--select title, year, length
--from movie
--where year < 2000 and (length > 120 or length is null);

---- 4
--select *
--from moviestar
--where name LIKE 'J%' and year(BIRTHDATE) > 1948
--order by MOVIESTAR.name desc;

---- 5
--select STUDIONAME, COUNT(STARSIN.STARNAME)
--from movie join STARSIN on STARSIN.MOVIETITLE = movie.TITLE
--group by STUDIONAME;

---- 6
--select starname, COUNT(MOVIETITLE)
--from starsin
--group by STARNAME

---- 7
--select m1.STUDIONAME, m1.TITLE, m1.year
--from movie m1
--where m1.year >= ALL (select m2.year from movie m2 where m2.STUDIONAME = m1.STUDIONAME);

-- 8
--select *
--from moviestar m1
--where gender = 'm' and m1.BIRTHDATE >= ALL (select m2.birthdate from moviestar m2 where GENDER = 'm');

---- 9
--select movie.STUDIONAME, starname, count(STARNAME)
--from movie join starsin on starsin.MOVIETITLE = movie.TITLE
--group by starname, studioname
--having count(starname) >= all (
--	select count(starname)
--	from movie join starsin on starsin.MOVIETITLE = movie.title
--	group by starname, STUDIONAME
--);

---- 10
--select distinct STARNAME, MOVIEEXEC.NAME
--from MOVIEEXEC
--	join movie on movieexec.CERT# = movie.PRODUCERC#
--	join starsin on starsin.MOVIETITLE = movie.TITLE
--where NETWORTH >= ALL (select NETWORTH from MOVIEEXEC);

---- 11
--select MOVIETITLE, MOVIEYEAR, count(starname)
--from movie join starsin on starsin.MOVIETITLE = movie.title
--group by movietitle, movieyear
--having count(starname) > 2

--use ships;

---- 1
--select distinct ship
--from ships join outcomes on outcomes.SHIP = ships.NAME
--where name LIKE 'C%' or name LIKE 'K%';

---- 2
--select distinct name, country
--from classes
--	join ships on ships.CLASS = classes.CLASS
--	left join outcomes on outcomes.SHIP = ships.name
--where result <> 'sunk' or result is null;

---- 3
--select country, count(result)
--from classes
--	left join ships on classes.class = ships.class
--	left join outcomes on outcomes.SHIP = ships.NAME
--where result = 'sunk' or result is null
--group by country;

use pc;

---- 1
--select *
--from laptop
--where screen = 15 or screen = 11;

---- 2 maybe i didn't do this task right
--select distinct pc.model, pc.price
--from pc join product p1 on p1.model = pc.model
--where pc.price < ALL (select price
--					  from laptop join product p2 on p2.model = laptop.model
--					  where p1.maker = p2.maker);

---- 3
--select p1.code, product.maker, (
--	select count(*)
--	from pc p2
--	where p2.price > p1.price
--)
--from pc p1 join product on product.model = p1.model;

-- 4
select pc.model, AVG(price)
from pc join product p1 on p1.model = pc.model
group by pc.model, p1.maker
having AVG(price) < (select min(price)
						 from laptop join product p2 on p2.model = laptop.model
						 where p2.maker = p1.maker);