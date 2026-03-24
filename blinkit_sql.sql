select * from blinkit_1;
select count(*) from blinkit_1;

# cleaning of data
set sql_safe_updates=0;
update blinkit_1
set `ï»¿Item Fat Content`=
case 
	when `ï»¿Item Fat Content` in('LF','low fat') THEN 'Low Fat'
	when `ï»¿Item Fat Content`= 'reg' THEN 'Regular'
	else `ï»¿Item Fat Content`
end;

#checking of cleaned data whweather it is cleaned or not 
select distinct (`ï»¿Item Fat Content`) from blinkit_1;

# sum of sales
select sum(sales) as total_sales from blinkit_1;
select concat(cast(sum(sales)/1000000 as decimal(10,2)),"M" )as total_sales_millions from blinkit_1;
# sum for low fat
select cast(sum(sales)/1000000 as decimal(10,2)) as total_sales_low_fat
from blinkit_1
where `ï»¿Item Fat Content`='Low Fat';

# avg of sales
select avg(sales) as sales_avg from blinkit_1;
select cast(avg(sales) as decimal(10,2)) as avg_sales_decimal from blinkit_1;
select cast(avg(sales) as decimal(10,0)) as avg_sales_decimal from blinkit_1;

# no. of item = total no. rows
select count(*) as no_of_items from blinkit_1;
# no. of item in year 2022
select count(*) as no_of_item_2022 from blinkit_1
where `Outlet Establishment Year`=2022;

# avg rating
select cast(avg(rating) as decimal(10,2))as avg_rating from blinkit_1;

## granular requerments

# total sales by fat content
select `ï»¿Item Fat Content` , 
		concat(cast(sum(Sales)/1000 as decimal(10,2)) ,"k")as total_sales_fat_content_thousand,
        cast(avg(Sales) as decimal(10,2)) as avg__sales,
        cast(avg(Rating) as decimal(10,2)) as avg_rating,
        count(*)	 as no_of_items
from blinkit_1
group by `ï»¿Item Fat Content`
order by total_sales_fat_content_thousand desc;

# total sales by item_type
select `Item Type` , 
		concat(cast(sum(Sales)/1000 as decimal(10,2)), "k") as total_Sales_item_type_thousands,
        cast(avg(Sales) as decimal(10,2)) as avg_sales_item_type,
        count(*) as no_of_item, 
        cast(avg(Rating) as decimal(10,2)) as avg_rating_itemtype
from blinkit_1
group by `Item Type`
order by sum(Sales) desc
limit 5;

# fat content by outlet for total sales
select `Outlet Location Type`,`ï»¿Item Fat Content` ,
		concat(cast(sum(sales)/1000 as decimal(10,2)) , "k") as total_Sales,
        cast(avg(sales)as decimal(10,2)) as avg_sales,
        count(*) as no_of_items,
        cast(avg(rating) as decimal(10,2)) as avg_rating
from blinkit_1
group by `ï»¿Item Fat Content`,`Outlet Location Type`
order by total_sales desc
limit 5;

# total sales by outlet eastablishment
select `Outlet Establishment Year` , 
		concat(cast(sum(sales)/1000 as decimal(10,2)),"k")as total_sales,
        cast(avg(sales) as decimal(10,2)) as avg_Sales,
        count(*) no_of_item,
        cast(avg(rating) as decimal(10,2))as avg_rating
from blinkit_1
group by `Outlet Establishment Year`
order by sum(sales) desc;

# percentage of sales by outlet size
select `Outlet Size`, 
		concat(cast(sum(sales)/1000 as decimal(10,2)) ,"k")as total_sales,
        cast((sum(sales)*100/sum(sum(sales)) over())as decimal(10,2)) as sales_per
from blinkit_1
group by `Outlet Size`
order by sum(sales) desc;

# sales by outlet location
select `Outlet Location Type`,
		concat(cast(sum(sales)/1000 as decimal(10,2)) ,"k") as total_sales,
        cast(avg(sales) as decimal(10,2)) as avg_Sales,
        count(*) no_of_item,
        cast(avg(rating) as decimal(10,2))as avg_rating
from blinkit_1
group by `Outlet Location Type`
order by sum(sales) desc;

# all metrics by outlet type
select `Outlet Type` ,
		concat(cast(sum(sales)/1000 as decimal(10,2)) ,"k") as total_sales,
        cast(avg(sales) as decimal(10,2)) as avg_Sales,
        count(*) no_of_item,
        cast(avg(rating) as decimal(10,2))as avg_rating
from blinkit_1
group by `Outlet Type`
order by sum(sales) desc;
		


