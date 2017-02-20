--use pc;

--pc1
--select avg(speed)
--from pc;

--pc2
--select product.maker, AVG(laptop.screen) as avgScreen
--from laptop join product on product.model = laptop.model
--group by product.maker;

--pc3
--select avg(speed)
--from laptop
--where price > 1000;

--pc4
--select Convert(decimal(9, 2), avg(price)) --a total of 9 digits, 2 after the point
--from pc join product on product.model = pc.model
--where product.maker = 'A';

--pc5
--select maker, avg(price)
--from ((select maker, price
--		from product join pc on product.model = pc.model)
--		UNION
--		(select maker, price
		--from product join laptop on product.model = laptop.model)) as t
--where maker = 'B';

--pc6
--select speed, avg(price)
--from pc
--group by speed;

--pc7
--select maker, count(pc.model) as cnt
--from pc join product on product.model = pc.model
--group by maker
--having count(pc.model) >= 3;

--pc8 TODO: when adding maker the query is invalid
--select max(pc.price)
--from pc join product on product.model = pc.model;

--pc9
--select speed, avg(price) as avgPrice
--from pc join product on product.model = pc.model
--where speed > 800
--group by speed;

--pc10
--select avg(hd)
--from pc join product on product.model = pc.model
--where product.maker IN (select maker
--						from printer join product on product.model = printer.model);

use ships;

----ships1
--select count(class)
--from classes;

----ships2
--select class, avg(numguns)
--from classes
--group by class;

----ships3
--select avg(numguns)
--from classes;

----ships4
--select classes.class, min(launched) as firstYear, max(launched) as lastYear
--from classes join ships on classes.class = ships.class
--group by classes.class;

----ships5
--select ships.class, count(*)
--from ships join outcomes on ships.NAME = outcomes.SHIP
--where outcomes.RESULT = 'sunk'
--group by ships.class;

----ships6
--select s1.class, count(*)
--from ships s1 join outcomes on s1.NAME = outcomes.SHIP
--where outcomes.RESULT = 'sunk' AND 2 < (select count(*) from ships as s2 where s2.CLASS = s1.CLASS)
--group by s1.class;

--ships7
select country, avg(bore)
from classes
group by country;