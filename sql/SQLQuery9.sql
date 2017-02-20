--create database ships;
--use ships;

--create table classes (
--	class varchar(200),
--	type char(2),
--	country varchar(200),
--	numGuns int,
--	bore int,
--	discplacement int,
--	constraint classes_pk primary key(class)
--);

--create table ships (
--	name varchar(200),
--	class varchar(200),
--	launched int,
--	constraint ships_pk primary key(name)
--);

--create table outcomes (
--	ship varchar(200),
--	battle varchar(200),
--	result varchar(200),
--	constraint outcomes_pk primary key(battle)
--);

--create table battles (
--	name varchar(200),
--	date datetime
--);

--alter table ships
--add constraint ships_fk foreign key (class) references classes(class);

--alter table outcomes
--add constraint outcomes_fk foreign key (ship) references ships(name);

--alter table battles
--add constraint battles_fk foreign key (name) references outcomes(battle);

--insert into classes values ('Bismarck','bb','Germany',8,15,42000),
--('Iowa','bb','USA',9,16,46000),
--('Kongo','bc','Japan',8,14,32000),
--('North Carolina','bb','USA',12,16,37000),
--('Renown','bc','Gt.Britain',6,15,32000),
--('Revenge','bb','Gt.Britain',8,15,29000),
--('Tennessee','bb','USA',12,14,32000),
--('Yamato','bb','Japan',9,18,65000);

--insert into ships values
--('California','Tennessee',1921),
--('Haruna','Kongo',1916),
--('Hiei','Kongo',1914),
--('Iowa','Iowa',1943),
--('Kirishima','Kongo',1915),
--('Kongo','Kongo',1913),
--('Missouri','Iowa',1944),
--('Musashi','Yamato',1942),
--('New Jersey','Iowa',1943),
--('North Carolina','North Carolina',1941),
--('Ramillies','Revenge',1917),
--('Renown','Renown',1916),
--('Repulse','Renown',1916),
--('Resolution','Renown',1916),
--('Revenge','Revenge',1916),
--('Royal Oak','Revenge',1916),
--('Royal Sovereign','Revenge',1916),
--('Tennessee','Tennessee',1920),
--('Washington','North Carolina',1941),
--('Wisconsin','Iowa',1944),
--('Yamato','Yamato',1941),
--('South Dakota','North Carolina',1941);

--alter table battles
--drop constraint battles_fk;

--alter table outcomes
--drop constraint outcomes_pk;

--alter table outcomes
--alter column ship varchar(200) not null

--alter table outcomes
--alter column battle varchar(200) not null

--alter table outcomes
--add constraint outcomes_pk primary key (ship, battle);

--insert into outcomes values ('California','Surigao Strait','ok'),
--('Kirishima','Guadalcanal','sunk'),
--('South Dakota','Guadalcanal','damaged'),
--('Tennessee','Surigao Strait','ok'),
--('Washington','Guadalcanal','ok'),
--('California','Guadalcanal','damaged');

--insert into battles values ('Guadalcanal','19421115 00:00:00.000'),
--('North Atlantic','19410525 00:00:00.000'),
--('North Cape','19431226 00:00:00.000'),
--('Surigao Strait','19441025 00:00:00.000');


--alter table battles
--alter column name varchar(200) not null;

--alter table battles
--add constraint battles_pk primary key (name);

--alter table outcomes
--add constraint outcomes_fk2 foreign key (battle) references battles(name);

-------------- task 2 ----------------

use FLIGHTS;

--alter table airlines
--add constraint airlines_unique unique (name);

--insert into AIRLINES values (10, 'dingo', 'Pakistan');
--insert into AIRLINES values (12, 'dingo', 'Pakistan');

--alter table airplanes
--add constraint plane_seats check (seats >= 0);

--insert into AIRPLANES values (12, 'type', -2, 1999);

--alter table bookings
--add constraint booking_check check (booking_date <= flight_date);

--alter table customers
--add constraint email_check check (email like '%@%' and email like '%.%' and LEN(email) >= 6);

--insert into CUSTOMERS values (12, 'Dingo', 'Ludiq', 'div@.');

--alter table bookings
--add constraint booking_status check (status in (0, 1));

--alter table flights
--add constraint flight_duration_check check (flight_duration >= 0);

--alter table airports
--add constraint airports_unique unique (name, country);