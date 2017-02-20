--use movies;

--go
--create view paramount_view (title, year)
--as
--select title, year
--from movie
--where STUDIONAME = 'Paramount';

--go
--create trigger paramount_trigger on movie
--instead of insert
--as
--	insert into Movie(title, year, STUDIONAME)
--	select title, year, studioname
--	from inserted
--	where STUDIONAME = 'Paramount';

--insert into paramount_view values('dingo', '1888');

--select * from paramount_view;

-- zad2
-- set a PK

--create database employee;
--use employee;
--create table Employees(
--	empCode int,
--	name varchar(250),
--	designation varchar(250),
--	qual_code int,
--	deleted bit default(0),
--	constraint pk_emp primary key(empCode)
--);

--go
--create trigger emp_trigger on employees
--instead of delete
--as
--	update employees
--	set deleted=1
--	where empCode in (select empcode
--					  from deleted);

--insert into employees values(43, 'Titko3', '9gag', 15, 0)
--select * from employees;
--delete from employees
--where empCode = 43;
--select * from employees;

-- zad3
--create table Person(
--id int,
--name varchar(250),
--previous_name varchar(250),
--same_name_count int,
--constraint person_pk primary key(id)
--);

use employee;


create trigger person_trigger on person
for insert, update, delete
as
begin
	if update(name)
	begin
		update person
		set previous_name = name;
	end;

	update person
	set same_name_count = (select count(*)
						   from person p2
						   where p2.name = p1.name);
end;
-- previous_name updated on name update
-- same_name_count updated - count e broi redove s ednakva stoinost

