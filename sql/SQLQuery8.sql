--create database baza;

--use baza;

--create table Product(
--	maker char(1),
--	model char(4),
--	type varchar(7)
--);

--create table Printer(
--	code int,
--	model varchar(20),
--	color char(1) default 'n',
--	price decimal(20, 2)
--);

--create table Classes(
--	class varchar(50),
--	type char(2)
--);

--insert into printer (code, model) values (12, 'model');

--alter table classes
--add bore float(20);

--alter table classes
--drop column bore;

--drop table Classes;

--create database facebook;

use facebook;

create table Users (
	id int identity(1, 1),
	email varchar(50),
	password varchar(50),
	registerdate datetime
);

create table Friends (
	friend1 int,
	friend2 int
);

create table Walls (
	userId int,
	commentUserId int,
	commentText varchar(max),
	date datetime
);

create table Groups (
	id int identity(1, 1),
	name varchar(255),
	description varchar(max) default ''
);

create table GroupMembers (
	groupId int,
	userId int
);