CREATE database if not exists coffee_shop_analysis;
use coffee_shop_analysis;
create table if not exists coffee_sales (
hour_of_day int,
cash_type varchar(20),
money int,
coffee_name varchar(30),
Time_of_Day varchar(20),
Weekday varchar(10),
Month_name varchar(20),
Weekdaysort int,
Monthsort int,
Date date,
Time time
);
describe coffee_sales;
alter table coffee_sales
modify column date varchar(20);
select * from coffee_sales;
select count(*) as total_sales
from coffee_sales;
select sum(money) as total_revenue,
count(money) as total_transactions,
round(avg(money),2) as average_revenue
from coffee_sales;
select coffee_name,sum(money) as total_revenue from coffee_sales
group by coffee_name
order by total_revenue desc;
select coffee_name, count(*) as purchase from coffee_sales
group by coffee_name
order by purchase desc;
select hour_of_day,sum(money) as total_revenue from coffee_sales
group by hour_of_day
order by total_revenue desc;
select 	Time_of_Day,sum(money) as total_revenue,count(money) as total_transactions from coffee_sales
group by Time_of_Day
order by total_revenue desc;
select 	Weekday,sum(money) as total_revenue,count(money) as total_transactions from coffee_sales
group by Weekday
order by total_revenue desc;
select 	Month_name,sum(money) as total_revenue,count(*) as total_transactions from coffee_sales
group by Month_name, Monthsort
order by Monthsort;
select 	cash_type,sum(money) as total_revenue,count(money) as total_transactions from coffee_sales
group by cash_type
order by total_revenue desc;
select coffee_name, sum(money) as revenue from coffee_sales
group by coffee_name
order by revenue desc
limit 3;
select coffee_name, Weekday, sum(money) as revenue from coffee_sales
group by  Weekday, coffee_name 
order by Weekday,revenue desc;
select coffee_name, sum(money) as revenue , rank() over (order by sum(money) desc) as revenue_rank
from coffee_sales
group by coffee_name;
with coffee_weekday_sales as (select coffee_name, Weekday, sum(money) as revenue from coffee_sales
group by  Weekday, coffee_name),
ranked_coffee as (
select coffee_name, Weekday, revenue,rank() over ( partition by Weekday order by revenue desc) as revenue_rank from coffee_weekday_sales
)
select coffee_name, Weekday, revenue from ranked_coffee
where revenue_rank =1
order by  Weekday;
select coffee_name, sum(money) as revenue from coffee_sales 
group by coffee_name
having sum(money) > (
select avg(product_revenue) from (
select sum(money) as product_revenue from coffee_sales
group by coffee_name) as product_sales)
order by revenue desc;
select hour_of_day , count(*) as sales ,sum(money) as revenue
from coffee_sales
group by hour_of_day
order by revenue desc
limit 1;
select coffee_name, sum(money) as revenue, round (sum(money)  * 100 / ( select sum(money) from coffee_sales) , 2)   as revenue_percentage
from coffee_sales
group by coffee_name
order by revenue desc;
select Month_name, Monthsort , sum(money) as monthly_revenue , sum(sum(money)) over( order by Monthsort)  as cumuliative_revenue
from coffee_sales
group by Month_name , Monthsort
order by Monthsort;
