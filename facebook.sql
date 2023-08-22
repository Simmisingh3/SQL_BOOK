create database facebook;
use facebook;
create table product_info(
Prod_ID int,
Prod_name varchar (30)
);
select*from product_info;
describe product_info;
insert into product_info values
(1001,'Blog'),
(1002,'Youtube'),
(1003, 'Education');
select*from product_info;

create table Product_info_likes(
User_ID Int,
Prod_ID int ,
Liked_date date
);

select*from Product_info_likes;
desc Product_info_likes;
insert into Product_info_likes values(1, 1001, '2023-08-19'),(2, 1003, '2023-08-18');
select*from Product_info_likes;

select * from product_info left join Product_info_likes on product_info.Prod_ID=Product_info_likes.Prod_ID;

select * from product_info left join Product_info_likes on product_info.Prod_ID=Product_info_likes.Prod_ID where Product_info_likes.Prod_ID is Null ;

select Prod_ID from product_info left join Product_info_likes on product_info.Prod_ID=Product_info_likes.Prod_ID where Product_info_likes.Prod_ID is Null ;
