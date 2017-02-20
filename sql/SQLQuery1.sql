--USE MOVIES;

/*
SELECT ADDRESS
FROM STUDIO
WHERE ADDRESS LIKE 'MGM%';
*/

/*
SELECT BIRTHDATE
FROM MOVIESTAR
WHERE NAME = 'SANDRA BULLOCK';
*/

/*
SELECT STARNAME
FROM STARSIN
WHERE MOVIEYEAR = 1980 AND MOVIETITLE LIKE '%EMPIRE%';
*/

/*
SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > 10000000;
*/

/*
SELECT NAME
FROM MOVIESTAR
WHERE ADDRESS = 'Perfect Rd' OR GENDER = 'M';
*/

--USE pc;

/*
SELECT MODEL, SPEED AS MHZ, HD AS GB
FROM PC
WHERE PRICE < 1200;
*/

/*
SELECT DISTINCT MAKER
FROM PRODUCT
WHERE TYPE = 'PRINTER';
*/

--SELECT model, ram, screen

--FROM laptop

--WHERE price > 1000;

--select * from printer where color = 'y';

--select model, speed, hd from pc where cd IN('12x', '16x') AND price < 2000;

use ships;

--select class, COUNTRY from classes where NUMGUNS < 10;

--select name shipName from ships where LAUNCHED < 1918;

--select ship, battle from OUTCOMES where result = 'sunk';

--select name from ships where name = class;

select name from ships where name LIKE 'R%';