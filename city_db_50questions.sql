create database city_db;
use city_db;
create table city_table(
ID int,
`NAME` varchar(17),
COUNTRYCODE varchar(10),
DISTRICT varchar(20),
POPULATION int
);
drop table city_table;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\City_Table.csv'
into table city_table
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows;

desc city_table;
select*from city_table;

## Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
select * from city_table where POPULATION>100000 and COUNTRYCODE='USA';

## Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
select `NAME` from city_table where POPULATION>120000 and COUNTRYCODE='usa';

## Q3. Query all columns (attributes) for every row in the CITY table.
select*from city_table;

## Q4. Query all columns for a city in CITY with the ID 1661.
select*from city_table where ID=1661;

## Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN
select * from city_table where COUNTRYCODE='JPN';

## Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN
select `NAME` from city_table where countrycode='jpn';


### CREATING NEW TABLE
create table station(
ID INT,
CITY VARCHAR(50),
STATE VARCHAR(21),
LAT_N INT,
LONG_W INT
);

drop table station;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\stationdata.csv'
into table station
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows;

describe station;
select * from station;

## Q7. Query a list of CITY and STATE from the STATION table
select city, state from station;

## Q8.Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
select distinct city from station where mod(ID,2)=0;

## Q9. Find the difference between the total number of CITY entries in the table and the number of 
##distinct CITY entries in the table.
select*from station;
select count(city) from station;
select count(distinct city) from station;
select count(city), count(distinct city), count(city)-count(distinct city)  from station;

# Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
#respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
#largest city, choose the one that comes first when ordered alphabetically.
select city, length(city) from station;
select max(length(city)) from station;
## Actual answers(these 2 lines below as we can write separate querries)
select city as short_city_name, length(city)  from station order by length(city) asc, city asc limit 1 ;
select city as long_city_name, length(city) from station order by length(city) desc , city asc limit 1;

(select city , length(city) from station order by length(city) desc , city asc limit 1)
union
(select  city , char_length(city) from station order by char_length(city) asc, city asc limit 1 );


## Q 11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
##cannot contain duplicates.
select city from station where left(city,1) in ('a','e','i','o','u');
select distinct city from station where left(city,1) in ('a','e','i','o','u') order by city asc;


## Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
#contain duplicates
select distinct city from station where right(city,1) in ('a','e','i','o','u') order by city asc;

## Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
#contain duplicates.
select distinct city from station where left(city,1) not in ('a','e','i','o','u') order by city asc;

## Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
#contain duplicates.
select distinct city from station where right(city,1) not in ('a','e','i','o','u') order by city asc;

## Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
#with vowels. Your result cannot contain duplicates.
select distinct city from station where right(city,1) not in ('a','e','i','o','u') or left(city,1) not in ('a','e','i','o','u') order by city asc;

## Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with
# vowels. Your result cannot contain duplicates.
select distinct city from station where right(city,1) not in ('a','e','i','o','u') and left(city,1) not in ('a','e','i','o','u') order by city asc;

# 17th Question
use city_db;
select*from product;
select*from sales;
## 17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
#between 2019-01-01 and 2019-03-31 inclusive
select product_id, product_name from product where product_id = (select product_id from sales where sale_date='2019-01-21');
# OR
SELECT product_id, product_name FROM product WHERE  product_id NOT IN 
(SELECT product_id FROM  sales WHERE  sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31'); 


# 18th Question
use city_db;
create table Views(
article_id int,
author_id int,
viewer_id int,
view_dats date
);
 
# Write an SQL query to find all the authors that viewed at least one of their own articles.
# Return the result table sorted by id in ascending order.
insert into views values(1,3,5,'2019-08-01'),
(1,3,6,'2019-08-02'),
(2,7,7,'2019-08-01'),
(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'),
(3,4,4,'2019-07-21');

select author_id as id from views where author_id=viewer_id order by id asc;


# 19th Question
create table Delivery(
delivery_id int,
customer_id int,
order_date date,
customer_pref_delivery_date date,
primary key(delivery_id)
);

insert into Delivery values(1,1,'2019-08-01','2019-08-02'),
(2,5,'2019-08-02','2019-08-02'),
(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),
(5,4,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13');

# Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
#places.
select round(
(select count(order_date) from delivery where order_date = customer_pref_delivery_date) /
(select count(order_date) from delivery) * 100, 2) as immidiate_percentage;

# Actul answer i need to understand

select round(   
(select count(*) from Delivery where order_date = customer_pref_delivery_date) /
(select count(*) from Delivery) * 100,   2) as immediate_percentage; 
select round(  
sum(case when order_date = customer_pref_delivery_date then 1 else 0 end) / count(delivery_id) * 100, 2) as immediate_percentage from Delivery;



# 20th Question
create table Ads(
ad_id int,
user_id int,
action enum('Clicked', 'Viewed', 'Ignored'),
primary key(ad_id, user_id)
);

insert into Ads values(1,1,'Clicked');
insert into Ads values(2,2,'Clicked'),
(3,3,'Viewed'),
(5,5,'Ignored'),
(1,7,'Ignored'),
(2,7,'Viewed'),
(3,5,'Clicked'),
(1,4,'Viewed'),
(2,11,'Viewed'),
(1,2,'Clicked');

select*from Ads;
#Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
#Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
#tie.

select ad_id, 
       ifnull(round(sum(action='clicked')/sum(action !='ignored')*100, 2),0) as ctr
       from Ads 
       group by ad_id
       order by ctr desc, ad_id;
       
       
# 21st Question
create table employee(
employee_id int,
team_id int,
primary key(employee_id)
);

insert into employee values(1,8),
(2,8), (3,8), (4,7), (5,9),(6,9);

#Write an SQL query to find the team size of each of the employees.
select e.employee_id, 
(select count(*) team_id from employee where e.team_id=team_id) as team_size from employee as e;


# 22nd Question
create table countries(
country_id int,
country_name varchar(50),
primary key(country_id)
);

create table Weather(
country_id int,
weather_state int,
`day` date,
primary key(country_id,`day`)
);

# 22 Write an SQL query to find the type of weather in each country for November 2019.
#The type of weather is:
#● Cold if the average weather_state is less than or equal 15,
#● Hot if the average weather_state is greater than or equal to 25, and
#● Warm otherwise

insert into countries values(2,'USA'),(3,'Australia'),(7,'Peru'),
(5,'China'),(8,'Morocco'),(9,'Spain');

insert into weather values(2, 15, '2019-11-01'),
(2, 12, '2019-10-28'),
(2, 12, '2019-10-27'),
(3, -2, '2019-11-10'),
(3, 0, '2019-11-11'),
(3, 3, '2019-11-12'),
(5, 16, '2019-11-07'),
(5, 18, '2019-11-09'),
(5, 21, '2019-11-23'),
(7, 25, '2019-11-28'),
(7, 22, '2019-12-01'),
(7, 20, '2019-12-02'),
(8, 25, '2019-11-05'),
(8, 27, '2019-11-15'),
(8, 31, '2019-11-25'),
(9, 7, '2019-10-23'),
(9, 3, '2019-12-23');
                    
select*from countries;
select*from weather;
# Inner joining two tables to fing the country name and weather state
select * from countries as cd inner join weather as we on cd.country_id = we.country_id; 
select cd.country_name, we.weather_state from countries as cd inner join weather as we on cd.country_id = we.country_id; 

# Finding the november month
select cd.country_name, we.weather_state from weather as we inner join countries as cd  on cd.country_id = we.country_id where `day` between '2019-11-01' and '2019-11-30'; 

# Finding weather type in november month by finding average
select cd.country_name, (sum(we.weather_state)/count(we.weather_state)) as weather_type
 from weather as we inner join countries as cd on cd.country_id = we.country_id where `day` between '2019-11-01' and '2019-11-30' group by cd.country_name; 
# or
select cd.country_name, (avg(we.weather_state)) as weather_type
 from weather as we inner join countries as cd on cd.country_id = we.country_id where `day` between '2019-11-01' and '2019-11-30' group by cd.country_name; 

# Finding weather type in november month by giving them weather name
select cd.country_name, 
case when avg(we.weather_state) <= 15 then 'Cold'
      when avg(we.weather_state) >= 25 then 'Hot'
      else 'Warm' end as weather_type
 from weather as we 
 inner join countries as cd 
 on cd.country_id = we.country_id 
 where `day` between '2019-11-01' and '2019-11-30' 
 group by cd.country_name; 
 
 # Or
 SELECT
c.country_name,
CASE 
    WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
    WHEN AVG(w.weather_state) >= 25 THEN 'Hot' 
    else 'Warm' END AS weather_type
FROM
Weather w
INNER JOIN 
Countries c
ON 
w.country_id = c.country_id
WHERE
LEFT(w.day, 7) = '2019-11'
GROUP BY c.country_name; 

use city_db;
# 23rd Question
create table Prices(
product_id int,
start_date date,
end_date date,
price int
);

alter table prices
add constraint primary key(product_id, start_date, end_date);
desc prices;

create table UnitsSold(
product_id int,
purchase_date date,
units int
);

# 23) Write an SQL query to find the average selling price for each product. average_price should be
#rounded to 2 decimal places.

insert into Prices values(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);
select*from prices;
insert into UnitsSold values(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);
select*from UnitsSold;
select*from UnitsSold u inner join prices p on u.product_id=p.product_id;
select p.product_id,
round( sum(p.price*u.units)/sum(u.units),2) as average_id  
from UnitsSold u 
inner join prices p 
on (u.product_id=p.product_id
     and u.purchase_date >= p.start_date
     and u.purchase_date <= p.end_date)
group by p.product_id;

select p.product_id,
round( sum(p.price*u.units)/sum(u.units),2) as average_id  
from UnitsSold u 
inner join prices p 
on (u.product_id=p.product_id 
     and u.purchase_date >= p.start_date
     and u.purchase_date <= p.end_date)
group by p.product_id;

# 24th Question
create table Activity(
player_id int,
device_id int,
event_date date,
games_played int,
primary key(player_id, event_date)
);

insert into Activity values(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5)
;
# 24) Write an SQL query to report the first login date for each player
select*from Activity;
select player_id, min(event_date) as first_login from Activity group by player_id;

# 25th Question
#Write an SQL query to report the device that is first logged in for each player.
select player_id, device_id from activity 
where (player_id, event_date)
in 
(select player_id, min(event_date) as first_login from Activity group by player_id);
# or
select player_id, device_id from activity 
where event_date
in 
(select min(event_date) from Activity group by player_id);

# 26th Question
create table if not exists Products (
product_id int,
product_name varchar(30),
product_category varchar(30),
primary key(product_id)
);
create table orders(
product_id int,
order_date date,
unit int,
foreign key(product_id) references products(product_id)
);

insert into Products values(1,'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');
select*from products;

insert into Orders values (1, '2020-02-05', 60),
(1, '2020-02-10', 70),
(2, '2020-01-18', 30),
(2, '2020-02-11', 80),
(3, '2020-02-17', 2),
(3, '2020-02-24', 3),
(4, '2020-03-01', 20),
(4, '2020-03-04', 30),
(4, '2020-03-04', 60),
(5, '2020-02-25', 50),
(5, '2020-02-27', 50),
(5, '2020-03-01', 50);
select*from Orders;

# Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
# and their amount.
select product_name, unit from orders od inner join products pd on pd.product_id=od.product_id;
select product_name, unit, order_date from orders od inner join products pd on pd.product_id=od.product_id;

select product_name, sum(unit) from orders od inner join products pd on pd.product_id=od.product_id where order_date between '2020-02-01' and '2020-02-28'  group by product_name ;

select product_name, sum(unit) as unit 
from orders od 
inner join products pd 
on pd.product_id=od.product_id
where order_date between '2020-02-01' and '2020-02-28'
group by product_name
having sum(unit)>=100 ;

# 27th Question
Create table users(
user_id int,
`name` varchar(30),
mail varchar(30),
primary key(user_id)
);

insert into users values(1, 'Winston', 'winston@leetcode.com'),
(2, 'Jonathan', 'jonathanisgreat'),
(3, 'Annabelle', 'bella-@leetcode.com'),
(4, 'Sally', 'sally.come@leetcode.com'),
(5, 'Marwan', 'quarz#2020@leetcode.com'),
(6, 'David', 'david69@gmail.com'),
(7, 'Shapiro','.shapo@leetcode.com')
;
select*from users;

# Q 28) Write an SQL query to find the users who have valid emails.
# A valid e-mail has a prefix name and a domain where:
# ● The prefix name is a string that may contain letters (upper or lower case), digits, underscore
# '_', period '.', and/or dash '-'. The prefix name must start with a letter.
# ● The domain is '@leetcode.com'.
 select*from users
 where REGEXP_like(mail, '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode.com');
 
 # Explaination for Regular Expresssions or REGEXP_LIKE
 # (If you would like a alphabetical character followed by any number of non-white-space
 #characters (note that it would also include numbers!) then you should use this:
#^[A-Za-z]\S*$
#If you would like to include only alpha-numeric characters and certain symbols, then use this:
#^[A-Za-z][A-Za-z0-9!@#$%^&*]*$
#Your original question looks like you are trying to include the space character as well, so you probably want something like this:
#^[A-Za-z ][A-Za-z0-9!@#$%^&* ]*$)



# Q 28 Write an SQL query to report the customer_id and customer_name of customers who have spent at
# least $100 in each month of June and July 2020.

# I have made the tables, but the code wasnt saved..

select*from customers;
select*from product28;
select*from orders_28;

select od.customer_id, cs.name from orders_28 od
inner join customers cs
on od.customer_id=cs.customer_id
where order_date between '2020-06-01' and '2020-07-31';

select pd.product_id, (pd.price*od.quantity) as tprice from product28 pd 
inner join orders_28 od
on od.product_id=pd.product_id
where order_date between '2020-06-01' and '2020-07-31'
order by pd.product_id;

select pd.product_id, (pd.price*od.quantity) as tprice from product28 pd 
inner join orders_28 od
on od.product_id=pd.product_id
where (order_date between '2020-06-01' and '2020-07-31')
and (pd.price*od.quantity)>=100
order by pd.product_id;
select cs.customer_id, cs.name,
sum(case when order_date between '2020-06-01' and '2020-06-30' then
pd.price*od.quantity else 0 end) as june_expence,
sum(case when order_date between '2020-07-01' and '2020-07-31' then
pd.price*od.quantity else 0 end) as july_expence
from orders_28 od
left join
product28 pd
on od.product_id=pd.product_id
left join
customers cs
on od.customer_id=cs.customer_id
group by cs.customer_id;

select t.customer_id, t.name from
( select cs.customer_id, cs.name,
sum(case when order_date between '2020-06-01' and '2020-06-30' then
pd.price*od.quantity else 0 end) as june_expence,
sum(case when order_date between '2020-07-01' and '2020-07-31' then
pd.price*od.quantity else 0 end) as july_expence
from orders_28 od
left join
product28 pd
on od.product_id=pd.product_id
left join
customers cs
on od.customer_id=cs.customer_id
group by cs.customer_id
) t
where june_expence>=100 and july_expence>=100;

# Q 29
create table if not exists TVProgram(
program_date date,
content_id int,
`channel` varchar(30),
primary key(program_date, content_id)
);

create table content(
content_id varchar(30),
title varchar(30),
kids_content enum('Y','N'),
content_type varchar(30)
);
alter table content
add constraint primary key(content_id);
desc content;

# Q 29 Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
insert into TVProgram values
('2020-06-10 08:00', 1, 'LC-Channel'),
('2020-05-11 12:00', 2, 'LC-Channel'),
('2020-05-12 12:00', 3, 'LC-Channel'),
('2020-05-13 14:00', 4, 'Disney Ch'),
('2020-06-18 14:00', 4, 'Disney Ch'),
('2020-07-15 16:00', 5, 'Disney Ch');
select*from TVProgram;

insert into content values
(1, 'Leetcode Movie', 'N', 'Movies'),
(2, 'Alg. for Kids', 'Y', 'Series'),
(3, 'Database Sols', 'N', 'Series'),
(4, 'Aladdin', 'Y', 'Movies'),
(5, 'Cinderella', 'Y', 'Movies');

select*from TVProgram;
select*from content;

# Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020

select distinct c.title from content c 
inner join  tvprogram t
on c.content_id
=t.content_id
where year(program_date)='2020' and month(program_date)='06' and kids_content='Y';

# Q 30
create table NPY(
id int,
`year` int,
npv int,
primary key(id, `year`)
);

create table if not exists queries(
id int,
year int,
primary key(id,year)
);

insert into NPY values
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

insert into Queries values
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

select * from NPY;
select*from queries;
# Q 30) Write an SQL query to find the npv of each query of the Queries table.

select q.*,  n.npv from queries q
left join NPY n
on q.id = n.id and q.year=n.year;

# coalace gives zero where value of NPV is null or not given
select q.*, coalesce(n.npv,0) from queries q
left join NPY n
on q.id = n.id and q.year=n.year;

# Q 31 Same querry same output as Q 30

# Q 32

create table employees_32 (
id int,
`name` varchar(30),
primary key(id)
);

create table EmployeeUNI(
id int,
unique_id int,
primary key(id, unique_id)
);

insert into employees_32 values
(1, 'Alice'),
(7, 'Bob'),
(11, 'Meir'),
(90, 'Winston'),
(3, 'Jonathan');

insert into EmployeeUNI values
(3, 1),
(11, 2),
(90, 3);

select*from employees_32;
select*from employeeuni;

# Q Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
# show null.
select eu.unique_id, e.name from employeeuni eu
right join employees_32 e
on eu.id = e.id
order by `name` asc;

# Q 33
create table users33(
id int,
`name` varchar(25),
primary key(id)
);

create table Rides(
id int,
user_id int,
distance int,
primary key(id)
);

insert into users33 values
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alex'),
(4, 'Donald'),
(7, 'Lee'),
(13, 'Jonathan'),
(19, 'Elvis');

insert into rides values 
(1, 1, 120),
(2, 2, 317),
(3, 3, 222),
(4, 7, 100),
(5, 13, 312),
(6, 19, 50),
(7, 7, 120),
(8, 19, 400),
(9, 7, 230);

# Write an SQL query to report the distance travelled by each user.
# Return the result table ordered by travelled_distance in descending order, if two or more users
# travelled the same distance, order them by their name in ascending order
select*from users33;
select*from rides;

select `name`, coalesce(sum(distance),0) as travelled_distance from  users33 us
left join rides rd
on us.id = rd.user_id
group by `name`
order by travelled_distance desc, `name` ;

# Q 34
create table if not exists Products34(
product_id int,
product_name varchar(25),
product_category varchar(25),
primary key(product_id)
);

create table Orders34 (
product_id int,
order_date date,
unit int,
foreign key (product_id) references Products34(product_id)
);

insert into Products34 values
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');

insert into orders34 values
(1, '2020-02-05', 60),
(1, '2020-02-10', 70),
(2, '2020-01-18', 30),
(2, '2020-02-11', 80),
(3, '2020-02-17', 2),
(3, '2020-02-24', 3),
(4, '2020-03-01', 20),
(4, '2020-03-04', 30),
(4, '2020-03-04', 60),
(5, '2020-02-25', 50),
(5, '2020-02-27', 50),
(5, '2020-03-01', 50);

select*from Products34;
select*from orders34;
# Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
# and their amount

select product_name, sum(unit) as total_unit from Products34 pd
left join orders34 od
on pd.product_id=od.product_id
where (order_date between '2020-02-01' and '2020-02-29') 
group by product_name 
having total_unit>=100;

# 35 
create table movies (
movie_id int,
title varchar(30),
primary key(movie_id)
);
create table users35 (
user_id int,
`name` varchar(30),
primary key(user_id)
);
create table MovieRating(
movie_id int,
user_id int,
rating int,
created_at date,
primary key(movie_id,user_id)
);
insert into movies values
(1, 'Avengers'),
(2, 'Frozen 2'),
(3, 'Joker');
insert into users35 values
(1, 'Daniel'),
(2, 'Monica'),
(3, 'Maria'),
(4, 'James');
insert into Movierating values
(1, 1, 3, '2020-01-12'),
(1, 2, 4, '2020-02-11'),
(1, 3, 2, '2020-02-12'),
(1, 4, 1, '2020-01-01'),
(2, 1, 5, '2020-02-17'),
(2, 2, 2, '2020-02-01'),
(2, 3, 2, '2020-03-01'),
(3, 1, 3, '2020-02-22'),
(3, 2, 4, '2020-02-25');
# Write an SQL query to:
# ● Find the name of the user who has rated the greatest number of movies. In case of a tie,
# return the lexicographically smaller user name.
# ● Find the movie name with the highest average rating in February 2020. In case of a tie, return
# the lexicographically smaller movie name.
select*from movies;
select*from users35;
select*from movierating;

select t1.name as Results from
(select u.name, count(u.user_id), dense_rank() over(order by count(user_id) 
desc, u.name) as r1 FROM
Users35 u
left join
MovieRating m
on u.user_id = m.user_id
group by u.user_id) t1
where r1 = 1
union
(select t2.title as Results from
(select mo.title, avg(m.rating), dense_rank() over(order by avg(m.rating)desc, 
mo.title) as r2 from
Movies mo
left join
MovieRating m
on mo.movie_id = m.movie_id
where month(m.created_at) = 2 and year(m.created_at) = 2020
group by m.movie_id)t2
where r2 = 1);

# Q 36 and Q37 Already done

# Q 38
create table Departments (
id int,
name varchar(30),
primary key(id)
);

create table students(
id int,
`name` varchar(30),
department_id int,
primary key(id)
);
insert into departments values
(1, 'Electrical Engineering'),
(7, 'Computer Engineering'),
(13, 'Business Administration');
insert into students values
(23, 'Alice', 1),
(1, 'Bob', 7),
(5, 'Jennifer', 13),
(2, 'John', 14),
(4, 'Jasmine', 77),
(3, 'Steve', 74),
(6, 'Luis', 1),
(8, 'Jonathan', 7),
(7, 'Daiana', 33),
(11, 'Madelynn', 1);
# Write an SQL query to find the id and the name of all students who are enrolled in departments that no
# longer exist
select id, name from students
where department_id not in (select id from departments);
 
# Q 39
create table calls (
from_id int,
to_id int,
duration int
);
insert into calls values 
(1, 2, 59),
(2, 1, 11),
(1, 3, 20),
(3, 4, 100),
(3, 4, 200),
(3, 4, 200),
(4, 3, 499);
# Write an SQL query to report the number of calls and the total call duration between each pair of
# distinct persons (person1, person2) where person1 < person2

select*from calls; 
select t.person1, t.person2,
count(*) as call_count,
sum(t.duration) as total_duration
from 
(select duration,
case when from_id<to_id then from_id else to_id end as person1,
case when from_id>to_id then from_id else to_id end as person2
 from calls) t
group by person1, person2;

# Q 40
create table prices40(
product_id int,
start_date date,
end_date date,
price int,
primary key(product_id, start_date, end_date)
);
create table UnitsSold40(
product_id int,
purchase_date date,
units int
);

# 40) Write an SQL query to find the average selling price for each product. average_price should be
#rounded to 2 decimal places.

insert into Prices40 values(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);
select*from prices40;
insert into UnitsSold values(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);
select*from unitssold40;
select p.product_id,
round((sum(p.price * u.units))/(sum(u.units)), 2) as average_price from Prices40 p
inner join unitssold40 u on
p.product_id=u.product_id
where purchase_date>= start_date and purchase_date<=end_date
group by p.product_id;

# Q 41
create table Warehouse(
`name` varchar(30),
product_id int,
units int,
primary key(`name`, product_id)
);
create table products41(
product_id int,
product_name varchar(30),
Width int,
Length int,
Height int,
primary key(product_id)
);
insert into Warehouse values
('LCHouse1', 1, 1),
('LCHouse1', 2, 10),
('LCHouse1', 3, 5),
('LCHouse2', 1, 2),
('LCHouse2', 2, 2),
('LCHouse3', 4, 1);
insert into products41 values
(1, 'LC-TV', 5, 50, 40),
(2, 'LC-KeyChain', 5, 5, 5),
(3, 'LC-Phone', 2, 10, 10),
(4, 'LC-T-Shirt', 4, 10, 20);
select*from Warehouse;
select*from products41;
# Write an SQL query to report the number of cubic feet of volume the inventory occupies in each
# warehouse.
select w.name, sum(p.width*p.length*p.height*w.units) as volume from Warehouse w
left join products41 p on
w.product_id=p.product_id
group by w.name ;

# Q42)
create table Sales42(
sale_date date,
fruit enum('apples','oranges'),
sold_num int,
primary key(sale_date, fruit)
);
insert into sales42 values
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15),
('2020-05-04', 'oranges', 16);

# Write an SQL query to report the difference between the number of apples and oranges sold each day.
# Return the result table ordered by sale_date
select*from sales42;
select  d.sale_date, ( d.apples_sold-d.oranges_sold) as diff 
from  (select sale_date, 
max(case when fruit= 'apples' then sold_num else 0 end) as apples_sold,
max(case when fruit='oranges' then sold_num else 0 end) as oranges_sold
from sales42
group by sale_date) d
 order by d.sale_date;

# Q 43
create table Activity43(
player_id int,
device_id int,
event_date date,
games_played int,
primary key (player_id, event_date) 
);

insert into Activity43 values 
(1, 2, '2016-03-01', 5),
(1, 2, '2016-03-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);
select*from activity43;
select count(distinct player_id) from activity43;
select distinct player_id,
datediff(event_date, lead(event_date,1) over (partition by player_id order by 
event_date)) from activity43;
#Write an SQL query to report the fraction of players that logged in again on the day after the day they
#first logged in, rounded to 2 decimal places. In other words, you need to count the number of players
#that logged in for at least two consecutive days starting from their first login date, then divide that
#number by the total number of players
select round(t.player_id/(select count(distinct player_id) from activity43 ),2) as
fraction
from
(select distinct player_id,
datediff(event_date, lead(event_date,1) over(partition by player_id order by
event_date)) as diff
from activity43) t
where diff = -1;

# Q 44 
create table Employee44(
id int,
`name` varchar(30),
department varchar(30),
managerId int,
primary key(id)
);
insert into Employee44 values
(101, 'John', 'A', Null),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);
# Q Write an SQL query to report the managers with at least five direct reports.
select * from employee44;
select t.name from
(select a.id, a.name, count(b.managerID) as no_of_direct_reports from
employee44 a
inner join
employee44 b
on a.id = b.managerID
group by b.managerID) t
where no_of_direct_reports >= 5
order by t.name;

# Q 45
create table department_45(
dept_id int,
dept_name varchar(30),
primary key(dept_id)
); 
insert into department_45 values
(1, 'Engineering'),
(2, 'Science'),
(3, 'Law');

create table student45(
student_id int,
student_name varchar(30),
gender varchar(30),
dept_id int,
primary key(student_id),
foreign key(dept_id) references department_45(dept_id)
);
insert into student45 values
(1, 'Jack', 'M', 1),
(2, 'Jane', 'F', 1),
(3, 'Mark', 'M', 2);

# Q Write an SQL query to report the respective department name and number of students majoring in
# each department for all departments in the Department table (even ones with no current students).
# Return the result table ordered by student_number in descending order. In case of a tie, order them by
# dept_name alphabetically
select*from department_45;
select*from student45;
select d.dept_name, count(distinct s.student_id) as no_of_students from 
student45 s
Right join 
department_45 d
on d.dept_id = s.dept_id 
group by d.dept_name
order by no_of_students desc;

# Both answers are correct

select d.dept_name, count(s.dept_id) as student_number from
department_45 d
left join
student45 s
on s.dept_id = d.dept_id
group by d.dept_id
order by student_number desc, dept_name;

# Q 46
create table Product_46(
product_key int,
primary key(product_key)
);
insert into Product_46 values
(5),
(6);

create table Customer_46 (
customer_id int,
product_key int,
foreign key(product_key) references product_46(product_key)
);

insert into Customer_46 values
(1, 5),
(2, 6),
(3, 5),
(3, 6),
(1, 6);

# Q Write an SQL query to report the customer ids from the Customer table that bought all the products in
# the Product table
select*from Product_46;
select*from Customer_46;
select distinct c.customer_id from Customer_46 c
inner join 
Product_46 p
on 
p.product_key = c.product_key
group by c.customer_id
having count(distinct p.product_key)=(select count(*) from product_46);

# Q 47
create table employee_47
(
employee_id int,
`name` varchar(30),
experience_years int,
primary key(employee_id)
);

create table Project_47
(
project_id int,
employee_id int,
primary key(project_id, employee_id),
foreign key(employee_id) references employee_47(employee_id)
);

insert into employee_47 values
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 3),
(4, 'Doe', 2);

insert into project_47 values
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);

select*from project_47;
select*from employee_47;
# Write an SQL query that reports the most experienced employees in each project. In case of a tie,
# report all employees with the maximum number of experience years.


select t.project_id, t.employee_id
from
(select p.project_id, e.employee_id, dense_rank() over(partition by p.project_id 
order by e.experience_years desc) as r
from
project_47 p
left join
employee_47 e
on p.employee_id = e.employee_id) t
where r = 1
order by t.project_id;