--use movies;

---- zad1
--select title, name
--from movie m join movieexec me on m.producerc# = me.cert#
--where cert# IN (select producerc#
--                  from movie
--                  where title = 'Star Wars');

---- zad2
--select distinct name
--from movie m join movieexec me on m.producerc# = me.cert#
--where cert# IN (Select producerc#
--			   from Movie join starsin on movie.title = starsin.movietitle
--			   where starsin.starname = 'Harrison Ford');

---- zad3
--select distinct studio.name, starsin.starname
--from studio
--	join movie on studio.name = movie.studioname
--	join starsin on movie.title = starsin.movietitle
--order by name, starname;

---- zad4
--select starname, networth, title
--from movie
--	join movieexec on movie.producerc# = movieexec.cert#
--	join starsin on starsin.movietitle = movie.title
--where networth >= ALL (Select networth from movieexec);

---- zad5
--select name
--from moviestar left join starsin on starsin.starname = moviestar.name
--where movietitle is null;

--use pc;

---- zad1
--(select product.maker, product.model, product.type
--from product
--	left join pc on pc.model = product.model
--where pc.code is null and type = 'PC')
--UNION
--(select product.maker, product.model, product.type
--from product
--	left join laptop on laptop.model = product.model
--where laptop.code is null and type = 'Laptop')
--UNION
--(select product.maker, product.model, product.type
--from product
--	left join printer on printer.model = product.model
--where printer.code is null and product.type = 'Printer');

---- zad2
--(select maker from product join laptop on laptop.model = product.model)
--Intersect
--(select maker from product join printer on printer.model = product.model);

---- zad3
--select distinct l1.hd
--from laptop l1, laptop l2
--where l1.hd = l2.hd and l1.model <> l2.model;

---- zad4
--select pc.model
--from pc left join product on pc.model = product.model
--where product.maker is null;

use ships;

---- zad1
--select *
--from ships join classes on ships.class = classes.class;

---- zad2
--select *
--from ships full join classes on ships.class = classes.class;

---- zad3
--select country, name
--from classes
--	join ships on ships.class = classes.class
--	left join outcomes on ships.name = outcomes.ship
--where battle is null
--order by country, name;

---- zad4
--select name as 'Ship Name'
--from classes join ships on ships.class = classes.class
--where launched = 1916 and numguns > 7;

---- zad5
--select ship, battle, date
--from ships
--	join outcomes on ships.name = outcomes.ship
--	join battles on battles.name = outcomes.battle
--where result = 'sunk';

---- zad6
--select classes.class
--from classes join ships on ships.class = classes.class
--where ships.class = ships.name;

---- zad7
--select *
--from classes left join ships on ships.class = classes.class
--where launched is null;

-- zad8
select name, displacement, numguns, result
from classes
	join ships on classes.class = ships.class
	join outcomes on ships.name = outcomes.ship
where outcomes.battle = 'North Atlantic';
