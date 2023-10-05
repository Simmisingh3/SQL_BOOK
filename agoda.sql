create database agoda;
create table item(
id int,
brand varchar(30),
name varchar(30),
unitprice real,
primary key(id)
);
create table customer(
id int,
first_name varchar(30),
last_name varchar(30),
registration_date varchar(30),
primary key(id)
);

create table purchase_2(
id int,
payment_source varchar(30),
current_code varchar(30),
purchase_date date,
customer_id int,
store_is int,
primary key(id),
foreign key(customer_id) references customer(id)
);

create table purchase_item_2(
id int,
item_id int,
purchase_id int,
unit_price real,
quantity int,
primary key(id),
foreign key(item_id) references item(id),
foreign key(purchase_id) references purchase(id)
);


insert into item values
(1, 'samsung', 'phone', 11111),
(2, 'maruti', 'car', 22222),
(3, 'ambuja', 'cement', 33333),
(4, 'apple', 'macbook', 44444),
(5, 'facebook', 'chats', 55555)
;

insert into customer values
(6, 'krish', 'naik', '2019'),
(7, 'sudh','kumar', '2020'),
(8, 'sunny', 'savita', '2021'),
(9, 'kapil', 'ahuja', '2022'),
(10, 'Simmi', 'Singh', '2023');

insert into purchase_2 values
(11, 'bank', 'Rs', '2020-04-10', 6, 110),
(22, 'share', 'Rs', '2020-06-04', 7, 220),
(33, 'crypto', 'Rs', '2021-04-10', 8, 330),
(44, 'Freelance', 'Rs', '2021-06-4', 9, 440),
(55, 'Company', 'Rs', '2021-04-10', 10, 550);
 
 
insert into purchase_item_2 values
(66, 1, 11, 123.0, 1),
(77, 2, 22, 234.1, 2),
(88, 3, 33, 345.2, 3),
(99, 4, 44, 456.3, 4),
(100, 5, 55, 567.4, 5);

select*from item;
select*from customer;
select*from purchase_2;
select*from purchase_item_2;

select p.store_is from purchase_item_2 pi
inner join purchase_2 p on
p.id=pi.purchase_id
where purchase_date between '2021-04-01' and '2021-04-30' 
group by store_is
order by max(pi.quantity) desc
limit 1;

select*from customer;
select first_name, last_name, count(distinct item_id) as item_count
from customer cs
inner join purchase p 
on cs.id=p.customer_id
inner join purchase_item_2 pi 
on p.id=pi.purchase_id
group by first_name, last_name, quantity;