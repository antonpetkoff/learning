--use movies;

--SELECT NAME
--FROM MOVIEEXEC
--WHERE CERT# = (SELECT PRODUCERC# FROM MOVIE WHERE TITLE = 'STAR WARS');

/*
let R be a unary relation and S be a scalar
logical operators ::
exists R -- evaluated to true if R has tuples, thus is non-null
S in R -- true if R contains S
S > ALL R -- > can be replaced by <>, >= ...
S > ANY R -- true if S > r holds for at least one r in R
*/

--select *
--from starsin
--where starname in (select name from moviestar where address = 'XPath');

--select movietitle, starname
--from starsin
--where starname in (Select name from moviestar where birthdate like '%1977%');

--select *
--from movie
--where year < ANY (select year
--                from movie M
--                where title = M.title);   -- the nested query is executed for each tuple in movies
-- from clauses are searched inside out

--select name, networth
--from movieexec
--where networth >= ALL (select networth from movieexec);

--find the producers of movies in which Harrison Ford has starred
--select DISTINCT name
--from movieexec, (select PRODUCERC#        -- this nested query is called an TODO: inline view
--               from Movie, starsin
--               where starname = 'Harrison Ford' AND title = movieTitle AND year = MOVIEYEAR) AS producers
--where producers.producerc# = cert#;

--select title
--from movie
--where movie.length > ANY (Select length from movie where title = 'Star Wars');

--select title, name
--from movie JOIN movieexec ON movie.producerc# = movieexec.cert#
--where movieexec.networth > (Select networth from movieexec where name = 'Merv Griffin');

--use pc;

--select distinct product.maker
--from product join pc on product.model = pc.model
--where pc.speed > 500;

--select *
--from printer
--where price >= ALL (select price from printer);

--select *
--from laptop
--where laptop.speed < ALL (select speed from pc);

--select *
--from (
--      (select price, model from pc)
--      UNION
--      (select price, model from laptop)
--      UNION
--      (select price, model from printer)
--  ) as prods
--where prods.price >= (select price from prods);

--select product.maker
--from printer join product on product.model = printer.model
--where color = 'y' AND printer.price <= ALL (select price from printer where color = 'y');

--select *
--  from pc join product on product.model = pc.model
--  where pc.ram <= ALL (select ram from pc)

--select *
--from (
--  select pc.speed, product.maker
--  from pc join product on product.model = pc.model
--  where pc.ram <= ALL (select ram from pc)
--) as pcram
--where pcram.speed = 500;

--select *
--from pc join product on product.model = pc.model
--where speed >= ALL (select speed from pc where pc.ram <= ALL (select ram from pc));

use ships;

--select distinct country
--from classes
--where numguns >= ALL (select numguns from classes);

--select distinct classes.class
--from classes
--  join ships on ships.class = classes.class
--  join outcomes on outcomes.ship = ships.name
--where result = 'sunk';

--select ships.name, classes.class
--from classes
--  join ships on ships.class = classes.class
--where classes.bore = 16;

--select battle
--from classes
--  join ships on ships.class = classes.class
--  join outcomes on outcomes.ship = ships.name
--where classes.class = 'Kongo';

select c1.class, ships.name
from classes c1
    join ships on ships.class = c1.class
where c1.numguns >= ALL (select numguns
                         from classes c2
                         where c2.bore = c1.bore)
order by c1.class;