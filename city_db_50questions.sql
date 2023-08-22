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