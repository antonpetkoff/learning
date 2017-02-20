--create database furniture_db;

create table customer (
	customer_id int identity(1, 1),
	customer_name varchar(250),
	customer_address varchar(250),
	customer_city varchar(250),
	city_code int
);

create table order_t (
	order_id int,
	order_date date,
	customer_id int
);

create table product (
	product_id int,
	product_description varchar(250),
	product_finish varchar(250)
);