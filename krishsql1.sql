show databases;
USE ineuron;
create table  employees(emp_ID int, 
first_name varchar(50),
last_name varchar(50),
DOB date, 
hire_date date,
position varchar(50),
salary float
);

select*from employees;
insert into employees values(1, "simmi", "singh", "1997-10-03", "2024-01-10", "data scientist", 2000000.00);
insert into employees values(2,"sunny", "savita", "1995-11-10", "2019-07-01", "data scientist", 20000.00);
insert into employees values(3,"krish", "nayak", "1985-11-10", "2011-07-01", "ML engineer", 2550000.00);
insert into employees values(4,"suraj", "singh", "1990-11-10", "2017-07-01", "data analyst", 21000.00);
insert into employees values(5,"sudh", "kumar", "1990-11-10", "2014-07-01", "pr data scientist", 2550000.00);

select first_name, last_name, salary from employees;

# select an employee whose salary is more than 21000
select*from employees where salary>21000;
#last name in asc order
select*from employees order by last_name asc;

set sql_safe_updates = 0;
update employees set salary=8000000 where first_name = "krish"; 
 select*from employees;
 
alter table employees add dept varchar(20);

select*from employees;

delete from employees where emp_ID=4;
#shortcut ctrl+enter

drop table if exists employees;
show databases;
create database sale;
drop database sale;

create database sales;
use sales;   #varchar takes alphnumeric
create table customer_info(
id int,
first_name varchar(25),  
last_name varchar(25)
);
show tables;
##insert rows inside customer_info
insert into customer_info values(1, "Simmi" , "Singh");
select*from customer_info;
insert into customer_info(id, first_name, last_name) values(2, "Krish" , "Nayak");
 
 #adding multiple records at a time
 insert into customer_info values(3, "Sush" , "Rajput"),(4, "sudh", "kumar");
# filter by specific value
select*from customer_info where last_name="Nayak";
select*from customer_info where last_name="Nayak" or last_name="Singh";
insert into customer_info values(5, "krish" , "Naik1");
select*from customer_info where first_name="krish" and last_name="Naik1";
drop table customer_info;

# Using auto increment
create table customer_info(
id int auto_increment,
first_name varchar(25),  
last_name varchar(25),
salary integer,
primary key(id)
);
describe customer_info;
select*from customer_info;
insert into customer_info(first_name, last_name, salary) values( "Krish", "Naik", "20000");
insert into customer_info(first_name, last_name, salary) values( "Krish1", "Naik1", "25000");

drop table customer_info;
create table customer_info(
id int auto_increment,
first_name varchar(25),  
last_name varchar(25),
salary integer,
primary key(id)
);
## Try to check krish's code
insert into customer_info(first_name, last_name, salary) values
("Krish","Naik", 200000),
("Sunny", "Savita", 150000),
("Darius", "Bengali", 100000),
("Rishav", "kumar", 20000)
;
select * from customer_info;
## update null values
select* from customer_info where salary is null;
update customer_info
set salary = 45000
where id =4;

## Constraint Not Null
alter table customer_info
modify column salary float not null;
describe table customer_info;


# SQL constraint Unique
create table employee(
id int,
house_num int unique,
pancard int unique,
first_name varchar(25),
last_name varchar(25),
salary int not null,
primary key(id)
);
describe employee;

alter table employee 
add constraint uc_employee unique(pancard, last_name);

insert into employee(id, house_num, pancard, first_name, last_name, salary) values(1,1,1,"Krish", "Naik", 20000);
insert into employee values(2,2,2, "Krish1", "Naik1", 20000);
create table student(
id int auto_increment,
first_name varchar(25),
last_name varchar(25),
primary key(id)
);
## Add Constraint unique key
alter table student
add constraint uc_student unique(first_name, last_name);

insert into student(first_name, last_name) values("Krish1", "Naik1"), ("Krish2", "Naik2");
#Drop index
alter table student
drop index uc_student;

#primary key
drop table student;

create table person(
id int not null,
first_name varchar(25),
last_name varchar(25),
age int,
primary key(id)
);
desc person;
alter table person
drop primary key;

alter table person
add constraint pk_student primary key(id, last_name);

insert into person values(1, "Krish", "Naik", 32), (2, "Krish", "Naik", 32); #id and last name combiningly be unique
alter table person
drop primary key;
drop table person;


create table orders(
orderid int not null,
ordernumber int not null,
id int,
primary key(orderid),
foreign key(id) references person(id)
);

select * from person;
insert into person values(1, "krish", "naik", 32);
insert into person values(2, "krish1", "naik1", 31);
insert into person values(3, "Sunny", "Savita", 30);
insert into person values(4, "Darius", "Bengali", 27);

insert into orders values(1,1,2);
select * from orders;

select * from person as ps inner join orders as od
on ps.id = od.id;
select * from person as ps left join orders as od
on ps.id = od.id;
select * from person as ps right join orders as od
on ps.id = od.id;

select * from person as ps left outer join orders as od
on ps.id = od.id;
select * from person as ps left outer join orders as od
on ps.id = od.id
order by age asc;

create table customers (
id int auto_increment,
first_name varchar(25),
country varchar(25),
capital varchar(25),
primary key(id)
);
insert into customers(id, first_name, country, capital) values
(1, "Krish", "India","Delhi"),
(2,"tom", "Australia", "Canberra"),
(3, "Sunny" ,"Maldives", "Male"),
(4, "Darius", "India", "Delhi")
;

select * from customers;
select * from customers where country = "India" or country = "Maldives";
select * from customers where country != "India";
select * from customers where not country = "India";

Create table if not exists bank_details(
age int,
job varchar(30),
marital varchar(30),
education varchar(30),
`default` varchar(30),
balance int,
housing varchar(30),
loan varchar(30),
contact varchar(30),
`day` int,
`month` varchar(30),
duration int,
campaign int,
pdays int,
previous int,
poutcome varchar(30),
y varchar(30));

select * from bank_details;
insert into bank_details values(58,"management","married","tertiary","no",2143,"yes","no","unknown",5,"may",261,1,-1,0,"unknown","no");

insert into bank_details values
(44,"technician","single","secondary","no",29,"yes","no","unknown",5,"may",151,1,-1,0,"unknown","no"),
(33,"entrepreneur","married","secondary","no",2,"yes","yes","unknown",5,"may",76,1,-1,0,"unknown","no"),
(47,"blue-collar","married","unknown","no",1506,"yes","no","unknown",5,"may",92,1,-1,0,"unknown","no"),
(33,"unknown","single","unknown","no",1,"no","no","unknown",5,"may",198,1,-1,0,"unknown","no"),
(35,"management","married","tertiary","no",231,"yes","no","unknown",5,"may",139,1,-1,0,"unknown","no"),
(28,"management","single","tertiary","no",447,"yes","yes","unknown",5,"may",217,1,-1,0,"unknown","no"),
(42,"entrepreneur","divorced","tertiary","yes",2,"yes","no","unknown",5,"may",380,1,-1,0,"unknown","no"),
(58,"retired","married","primary","no",121,"yes","no","unknown",5,"may",50,1,-1,0,"unknown","no"),
(43,"technician","single","secondary","no",593,"yes","no","unknown",5,"may",55,1,-1,0,"unknown","no"),
(41,"admin.","divorced","secondary","no",270,"yes","no","unknown",5,"may",222,1,-1,0,"unknown","no"),
(29,"admin.","single","secondary","no",390,"yes","no","unknown",5,"may",137,1,-1,0,"unknown","no"),
(53,"technician","married","secondary","no",6,"yes","no","unknown",5,"may",517,1,-1,0,"unknown","no"),
(58,"technician","married","unknown","no",71,"yes","no","unknown",5,"may",71,1,-1,0,"unknown","no"),
(57,"services","married","secondary","no",162,"yes","no","unknown",5,"may",174,1,-1,0,"unknown","no"),
(51,"retired","married","primary","no",229,"yes","no","unknown",5,"may",353,1,-1,0,"unknown","no"),
(45,"admin.","single","unknown","no",13,"yes","no","unknown",5,"may",98,1,-1,0,"unknown","no"),
(57,"blue-collar","married","primary","no",52,"yes","no","unknown",5,"may",38,1,-1,0,"unknown","no"),
(60,"retired","married","primary","no",60,"yes","no","unknown",5,"may",219,1,-1,0,"unknown","no"),
(33,"services","married","secondary","no",0,"yes","no","unknown",5,"may",54,1,-1,0,"unknown","no"),
(28,"blue-collar","married","secondary","no",723,"yes","yes","unknown",5,"may",262,1,-1,0,"unknown","no"),
(56,"management","married","tertiary","no",779,"yes","no","unknown",5,"may",164,1,-1,0,"unknown","no"),
(32,"blue-collar","single","primary","no",23,"yes","yes","unknown",5,"may",160,1,-1,0,"unknown","no"),
(25,"services","married","secondary","no",50,"yes","no","unknown",5,"may",342,1,-1,0,"unknown","no"),
(40,"retired","married","primary","no",0,"yes","yes","unknown",5,"may",181,1,-1,0,"unknown","no"),
(44,"admin.","married","secondary","no",-372,"yes","no","unknown",5,"may",172,1,-1,0,"unknown","no"),
(39,"management","single","tertiary","no",255,"yes","no","unknown",5,"may",296,1,-1,0,"unknown","no"),
(52,"entrepreneur","married","secondary","no",113,"yes","yes","unknown",5,"may",127,1,-1,0,"unknown","no"),
(46,"management","single","secondary","no",-246,"yes","no","unknown",5,"may",255,2,-1,0,"unknown","no"),
(36,"technician","single","secondary","no",265,"yes","yes","unknown",5,"may",348,1,-1,0,"unknown","no"),
(57,"technician","married","secondary","no",839,"no","yes","unknown",5,"may",225,1,-1,0,"unknown","no"),
(49,"management","married","tertiary","no",378,"yes","no","unknown",5,"may",230,1,-1,0,"unknown","no"),
(60,"admin.","married","secondary","no",39,"yes","yes","unknown",5,"may",208,1,-1,0,"unknown","no"),
(59,"blue-collar","married","secondary","no",0,"yes","no","unknown",5,"may",226,1,-1,0,"unknown","no"),
(51,"management","married","tertiary","no",10635,"yes","no","unknown",5,"may",336,1,-1,0,"unknown","no"),
(57,"technician","divorced","secondary","no",63,"yes","no","unknown",5,"may",242,1,-1,0,"unknown","no"),
(25,"blue-collar","married","secondary","no",-7,"yes","no","unknown",5,"may",365,1,-1,0,"unknown","no"),
(53,"technician","married","secondary","no",-3,"no","no","unknown",5,"may",1666,1,-1,0,"unknown","no"),
(36,"admin.","divorced","secondary","no",506,"yes","no","unknown",5,"may",577,1,-1,0,"unknown","no"),
(37,"admin.","single","secondary","no",0,"yes","no","unknown",5,"may",137,1,-1,0,"unknown","no"),
(44,"services","divorced","secondary","no",2586,"yes","no","unknown",5,"may",160,1,-1,0,"unknown","no"),
(50,"management","married","secondary","no",49,"yes","no","unknown",5,"may",180,2,-1,0,"unknown","no"),
(60,"blue-collar","married","unknown","no",104,"yes","no","unknown",5,"may",22,1,-1,0,"unknown","no"),
(54,"retired","married","secondary","no",529,"yes","no","unknown",5,"may",1492,1,-1,0,"unknown","no"),
(58,"retired","married","unknown","no",96,"yes","no","unknown",5,"may",616,1,-1,0,"unknown","no"),
(36,"admin.","single","primary","no",-171,"yes","no","unknown",5,"may",242,1,-1,0,"unknown","no"),
(58,"self-employed","married","tertiary","no",-364,"yes","no","unknown",5,"may",355,1,-1,0,"unknown","no"),
(44,"technician","married","secondary","no",0,"yes","no","unknown",5,"may",225,2,-1,0,"unknown","no"),
(55,"technician","divorced","secondary","no",0,"no","no","unknown",5,"may",160,1,-1,0,"unknown","no"),
(29,"management","single","tertiary","no",0,"yes","no","unknown",5,"may",363,1,-1,0,"unknown","no"),
(54,"blue-collar","married","secondary","no",1291,"yes","no","unknown",5,"may",266,1,-1,0,"unknown","no"),
(48,"management","divorced","tertiary","no",-244,"yes","no","unknown",5,"may",253,1,-1,0,"unknown","no"),
(32,"management","married","tertiary","no",0,"yes","no","unknown",5,"may",179,1,-1,0,"unknown","no"),
(42,"admin.","single","secondary","no",-76,"yes","no","unknown",5,"may",787,1,-1,0,"unknown","no"),
(24,"technician","single","secondary","no",-103,"yes","yes","unknown",5,"may",145,1,-1,0,"unknown","no"),
(38,"entrepreneur","single","tertiary","no",243,"no","yes","unknown",5,"may",174,1,-1,0,"unknown","no"),
(38,"management","single","tertiary","no",424,"yes","no","unknown",5,"may",104,1,-1,0,"unknown","no"),
(47,"blue-collar","married","unknown","no",306,"yes","no","unknown",5,"may",13,1,-1,0,"unknown","no"),
(40,"blue-collar","single","unknown","no",24,"yes","no","unknown",5,"may",185,1,-1,0,"unknown","no"),
(46,"services","married","primary","no",179,"yes","no","unknown",5,"may",1778,1,-1,0,"unknown","no"),
(32,"admin.","married","tertiary","no",0,"yes","no","unknown",5,"may",138,1,-1,0,"unknown","no"),
(53,"technician","divorced","secondary","no",989,"yes","no","unknown",5,"may",812,1,-1,0,"unknown","no"),
(57,"blue-collar","married","primary","no",249,"yes","no","unknown",5,"may",164,1,-1,0,"unknown","no"),
(33,"services","married","secondary","no",790,"yes","no","unknown",5,"may",391,1,-1,0,"unknown","no"),
(49,"blue-collar","married","unknown","no",154,"yes","no","unknown",5,"may",357,1,-1,0,"unknown","no"),
(51,"management","married","tertiary","no",6530,"yes","no","unknown",5,"may",91,1,-1,0,"unknown","no"),
(60,"retired","married","tertiary","no",100,"no","no","unknown",5,"may",528,1,-1,0,"unknown","no"),
(59,"management","divorced","tertiary","no",59,"yes","no","unknown",5,"may",273,1,-1,0,"unknown","no"),
(55,"technician","married","secondary","no",1205,"yes","no","unknown",5,"may",158,2,-1,0,"unknown","no"),
(35,"blue-collar","single","secondary","no",12223,"yes","yes","unknown",5,"may",177,1,-1,0,"unknown","no"),
(57,"blue-collar","married","secondary","no",5935,"yes","yes","unknown",5,"may",258,1,-1,0,"unknown","no"),
(31,"services","married","secondary","no",25,"yes","yes","unknown",5,"may",172,1,-1,0,"unknown","no"),
(54,"management","married","secondary","no",282,"yes","yes","unknown",5,"may",154,1,-1,0,"unknown","no"),
(55,"blue-collar","married","primary","no",23,"yes","no","unknown",5,"may",291,1,-1,0,"unknown","no"),
(43,"technician","married","secondary","no",1937,"yes","no","unknown",5,"may",181,1,-1,0,"unknown","no"),
(53,"technician","married","secondary","no",384,"yes","no","unknown",5,"may",176,1,-1,0,"unknown","no"),
(44,"blue-collar","married","secondary","no",582,"no","yes","unknown",5,"may",211,1,-1,0,"unknown","no"),
(55,"services","divorced","secondary","no",91,"no","no","unknown",5,"may",349,1,-1,0,"unknown","no"),
(49,"services","divorced","secondary","no",0,"yes","yes","unknown",5,"may",272,1,-1,0,"unknown","no"),
(55,"services","divorced","secondary","yes",1,"yes","no","unknown",5,"may",208,1,-1,0,"unknown","no"),
(45,"admin.","single","secondary","no",206,"yes","no","unknown",5,"may",193,1,-1,0,"unknown","no"),
(47,"services","divorced","secondary","no",164,"no","no","unknown",5,"may",212,1,-1,0,"unknown","no"),
(42,"technician","single","secondary","no",690,"yes","no","unknown",5,"may",20,1,-1,0,"unknown","no"),
(59,"admin.","married","secondary","no",2343,"yes","no","unknown",5,"may",1042,1,-1,0,"unknown","yes"),
(46,"self-employed","married","tertiary","no",137,"yes","yes","unknown",5,"may",246,1,-1,0,"unknown","no"),
(51,"blue-collar","married","primary","no",173,"yes","no","unknown",5,"may",529,2,-1,0,"unknown","no"),
(56,"admin.","married","secondary","no",45,"no","no","unknown",5,"may",1467,1,-1,0,"unknown","yes"),
(41,"technician","married","secondary","no",1270,"yes","no","unknown",5,"may",1389,1,-1,0,"unknown","yes"),
(46,"management","divorced","secondary","no",16,"yes","yes","unknown",5,"may",188,2,-1,0,"unknown","no"),
(57,"retired","married","secondary","no",486,"yes","no","unknown",5,"may",180,2,-1,0,"unknown","no"),
(42,"management","single","secondary","no",50,"no","no","unknown",5,"may",48,1,-1,0,"unknown","no"),
(30,"technician","married","secondary","no",152,"yes","yes","unknown",5,"may",213,2,-1,0,"unknown","no"),
(60,"admin.","married","secondary","no",290,"yes","no","unknown",5,"may",583,1,-1,0,"unknown","no");
use sales;
select * from bank_details;
select job, marital, education from bank_details;
select age, loan, job from bank_details;
select `default` from bank_details;
select * from bank_details limit 10;
select * from bank_details where age = 30;
# select all details having age between 30 to 35
select * from bank_details where age>=30 and age<=35;
select * from bank_details where age<=60 and job = "retired";
select * from bank_details where age>=60 and job = "retired";
select * from bank_details where education = "unkown" or balance>10;
select * from bank_details where education = "unkown" or marital = "single";
select * from bank_details where (education = "unkown" or marital = "single") and balance < 500 ;

# unique type of job/types of any column
select distinct job from bank_details;

 # using order by to order
select * from bank_details order by age;
select * from bank_details order by age desc;

# with this data try to fine out sum of balance
select sum(balance) from bank_details;

# Try to find out avarage of balance 
select avg(balance) from bank_details;

# try to find out who is having a min balance 
select * from bank_details where balance =(select  min(balance) from bank_details) ;

# try to find out who is having a mazxmim balance 
select * from bank_details where balance = (select max(balance) from bank_details);

# try to prepare a list of all the person who is having loan
select * from bank_details where loan = "yes";

# try to find out average balance for all the people whose job role is admin 
select avg(balance) , job from bank_details where job = "admin.";

# try to find out a record  without job whose age is below 45 
select * from bank_details where (job = "unknown"  or job = "retired") and age < 45;

#try to find out a record where education is primarty and person is jobless
select * from bank_details where education = "primary" and (job = "unknown"  or job = "retired");

# try to find out a record whose bank account is having a negative balance
select * from bank_details where balance < 0;

#try to find our a record who is not having house at all along with there balance 
select * from bank_details where housing = "no";


# stored procedure, Views, Indexes, CTE



