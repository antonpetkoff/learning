--use movies;

--SELECT Studio.name, MovieExec.name
--FROM Studio, MovieExec;

--SELECT name
--FROM Movie, MovieExec
--WHERE title = 'Star Wars' AND producerc#=cert#;

--equivalently make a join on a condition
--ON condition :: in what relation is the attribute from the first relation to the second relation
--first a cartesian product of the tables is made then the resulting table is filtered by the condition
--more than one join are allowed
--SELECT name
--FROM Movie INNER JOIN MovieExec ON producerc# = cert#	-- INNER is optional
--WHERE title = 'Star Wars'

--SELECT title, studioname, year
--FROM Movie
--	JOIN StarsIn ON (Movie.title = StarsIn.movieTitle
--					AND movie.year = starsin.MOVIEYEAR)
--	JOIN MovieStar ON (MovieStar.name = starsin.starname);	--in the second join we use the accumulator

--actors which have the same address
--tuple variable, working with the same relation
--SELECT ms1.name, ms2.name
--FROM MOVIESTAR AS ms1, MOVIESTAR ms2
--WHERE ms1.address = ms2.address AND ms1.name < ms2.name;	--the < filters out duplicates

--SET OPERATIONS
--the count of the attributes must be the same for the two sets
--the types of the attributes must be compatible
--the order of the attributes matters
--the names of the attributes needn't be the same, but you could use aliases

--(SELECT name, address
--FROM MovieStar
--WHERE gender = 'F')
--INTERSECT --INTERSECT ALL is a multi-set intersection and equal elements are preserved
--(SELECT name, address
--FROM MovieExec
--WHERE networth > 10000000);

--(SELECT title, year	--these names of the attributes will be shown in the result
--FROM Movie)
--UNION ALL
--(SELECT movietitle, movieyear
--FROM StarsIn);

--(SELECT name, address
--FROM MovieStar)
--EXCEPT
--(SELECT name, address
--FROM MovieExec);

--EXERCISES:
--use movies;

--SELECT name
--FROM MOVIESTAR INNER JOIN STARSIN ON STARSIN.starname = moviestar.name
--WHERE gender = 'M' AND STARSIN.MOVIETITLE = 'Terms of Endearment';

--SELECT moviestar.name
--FROM MOVIESTAR
--	INNER JOIN STARSIN ON MOVIESTAR.name = STARSIN.STARNAME
--	INNER JOIN MOVIE ON MOVIE.title = STARSIN.movietitle
--	INNER JOIN STUDIO ON MOVIE.studioname = STUDIO.name
--WHERE STUDIO.name = 'MGM' and Movie.year = 1995;

--SELECT DISTINCT movieexec.name
--FROM MOVIE
--	INNER JOIN MOVIEEXEC ON MOVieexec.cert# = movie.producerc#
--	INNER JOIN STUDIO ON STUDIO.name = movie.studioname
--WHERE studio.name = 'MGM'
--ORDER BY movieexec.name;

--SELECT mv2.title
--FROM Movie mv1, Movie mv2
--WHERE mv1.title = 'Star Wars' AND mv2.title <> 'Star Wars' AND mv2.length > mv1.length;

--SELECT me2.name
--FROM Movieexec me1, Movieexec me2
--WHERE me1.name = 'Merv Griffin' AND me2.name <> me1.name AND me2.NETWORTH > me1.NETWORTH;

--SELECT Movie.title
--FROM Movieexec me1, Movieexec me2
--	INNER JOIN Movie ON Movie.producerc# = me2.cert#
--WHERE me1.name = 'Merv Griffin' AND me2.name <> me1.name AND me2.NETWORTH > me1.NETWORTH

--use pc;

--SELECT PRODUCT.maker, LAPTOP.speed
--FROM LAPTOP INNER JOIN PRODUCT ON LAPTOP.MODEL = PRODUCT.MODEL
--WHERE hd >= 9;


--(SELECT product.model, pc.price
--FROM product JOIN PC ON pc.model = product.model
--WHERE maker = 'B')
--UNION
--(SELECT product.model, laptop.price
--FROM product JOIN LAPTOP ON LAPTOP.model = product.model
--WHERE maker = 'B')
--UNION
--(SELECT product.model, printer.price
--FROM product JOIN PRINTER ON printer.model = product.model
--WHERE maker = 'B')

--SELECT DISTINCT pc1.hd
--FROM PC pc1, PC pc2
--WHERE pc1.code <> pc2.code AND pc1.hd = pc2.hd;

--SELECT pc1.model, pc2.model
--FROM PC pc1, PC pc2
--WHERE pc1.code < pc2.code AND pc1.speed = pc2.speed AND pc1.ram = pc2.ram;

--SELECT DISTINCT product.maker
--FROM PC pc1, PC pc2
--	JOIN PRODUCT ON product.model = pc2.model
--WHERE pc1.model > pc2.model AND pc1.code > pc2.code AND pc1.speed >= 400 AND pc2.speed >= 400;

use ships;

--SELECT ships.name
--FROM classes join ships on classes.class = ships.class
--WHERE classes.displacement > 50000;

--SELECT ships.name, classes.displacement, classes.numguns
--FROM classes
--	JOIN ships on classes.class = ships.class
--	JOIN outcomes on outcomes.ship = ships.name
--	JOIN battles on battles.name = outcomes.battle
--WHERE battles.name = 'Guadalcanal';

--(select country from classes where type = 'bb')
--INTERSECT
--(select country from classes where type = 'bc')

SELECT *
FROM battles b2, battles b1
	JOIN outcomes on outcomes.battle = b1.name
WHERE b1.date < b2.date AND outcomes.result = 'damaged'
