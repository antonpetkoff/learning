--use movies;

--insert into MOVIESTAR (name, gender, BIRTHDATE) values ('Nicole Kidman', 'F', '1967-06-20')

--delete from MOVIEEXEC where NETWORTH < 30000000;

--delete from MOVIESTAR where ADDRESS is null;

--use pc;

--insert into pc values (12, 1100, 2400, 2048, 500, 52, 299);

--delete from PC where model = 1100;

--delete l
--from laptop l
--join product p on p.model = l.model
--where p.maker NOT IN (
--	select maker
--	from printer join product on product.model = printer.model
--	where product.type = 'Printer'
--);

--update product
--set maker = 'A'
--where maker = 'B';

--update pc
--set price = 0.5 * price, hd = hd + 20;

--update laptop
--set screen = screen + 1
--from laptop join product on product.model = laptop.model
--where maker = 'B'

use ships;

--insert into classes (class, type, country, numguns, bore, DISPLACEMENT) values
--	('Nelson', 'bb', 'USA', 9, 16, 34000),
--	('Rodney', 'bb', 'USA', 9, 16, 34000);

--insert into ships values
--	('Nelson', 'Nelson', 1927),
--	('Rodney', 'Rodney', 1927);

--delete s
--from ships s
--join outcomes o on o.ship = s.name
--where o.result = 'sunk';

--update classes
--set bore = bore * 2.5, DISPLACEMENT = DISPLACEMENT / 1.1;