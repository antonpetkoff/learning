--use FLIGHTS;
--go

--create view v1
--as
--select *
--from bookings;

--select * from v1;

--select agency, CUSTOMER_ID
--from AGENCIES
--	join bookings on bookings.AGENCY = agencies.name
--group by AGENCY, CUSTOMER_ID;

--create view v_SF_Agencies
--as
--select *
--from AGENCIES
--where city = 'Sofia'
--with check option;

--select *
--from v_SF_Agencies;

--create view v_SF_PH_Agencies
--as
--select *
--from AGENCIES
--where phone is null
--with check option;

--select *
--from v_SF_PH_Agencies;

--INSERT INTO v_SF_Agencies
--VALUES('T1 Tour', 'Bulgaria', 'Sofia','+359');
--INSERT INTO v_SF_PH_Agencies
--VALUES('T2 Tour', 'Bulgaria', 'Sofia',null);
--INSERT INTO v_SF_Agencies
--VALUES('T3 Tour', 'Bulgaria', 'Varna','+359');
--INSERT INTO v_SF_PH_Agencies
--VALUES('T42 Tour', 'Bulgaria', 'Varna',null);
--INSERT INTO v_SF_PH_Agencies
--VALUES('T4 Tour', 'Bulgaria', 'Sofia','+359');

use movies;
go

--create view RichExec
--as
--select *
--from MOVIEEXEC
--where NETWORTH > 10000000;

--select * from RichExec;

--create view StudioPres
--as
--select *
--from MOVIEEXEC
--where CERT# in (select presc#
--				from studio);

--create view Executivestar
--as
--select *
--from MOVIESTAR
--where name in (select name
--			   from MOVIEEXEC);

--select * from ExecutiveStar;

---- 10
--select name
--from ExecutiveStar
--where gender = 'f';

---- 11
--select name
--from StudioPres
--where networth >= 10000000;

--drop view StudioPres;
--drop view ExecutiveStar;
--drop view RichExec;