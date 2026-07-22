select * from blinkit_sales

-- Database Exploration
select * from INFORMATION_SCHEMA.TABLES

select * from INFORMATION_SCHEMA.COLUMNS

select
	column_name,
	data_type
from INFORMATION_SCHEMA.COLUMNS
/*
item_fat_content
item_identifier
item_type
outlet_establishment_year
outlet_identifier
outlet_location_type
outlet_size
outlet_type

item_visibility
item_weight
sales
rating
*/

----------------------------------
--Date Dimention Exploration

select
	min(outlet_establishment_year) as Minimum_year,
	max(outlet_establishment_year) as Maximum_year,
	max(outlet_establishment_year)- min(outlet_establishment_year) as lifespan
from blinkit_sales
--------------------
--Key Metrix

select 'Total Sales' as Metrix, SUM(sales) as Value from blinkit_sales
union all
select 'Average Sales', ROUND(AVG(sales),2) from blinkit_sales
union all
select 'Number of Items', COUNT(item_identifier) from blinkit_sales
union all
select 'Average Rating', ROUND(AVG(rating),2) from blinkit_sales
------------------------------
--Magnitude Analysis

--item_fat_content
--Sales 
select *,
	sum(total_sales) over() as overall_sales,
	concat(round(total_sales/sum(total_sales) over()*100.0,2),'%') as Proportion
from
(
select
	item_fat_content,
	round(sum(sales),0) as total_sales
from blinkit_sales
	group by item_fat_content) a
--------------------
--Orders

select *,
	sum(total_orders) over() as overall_orders,
	concat(round(cast(total_orders as float)/sum(total_orders) over()*100,2),'%') as proportion

from
	(select
		item_fat_content,
		count(item_identifier) as total_orders
	from blinkit_sales
		group by item_fat_content) a

-----------------------
--item_type top 10
--sales
select TOP 10 *,
	sum(total_sales) over() as overall_sales,
	concat(round(total_sales/sum(total_sales) over()*100.0,2),'%') as Proportion
from
(
select
	item_type,
	round(sum(sales),0) as total_sales
from blinkit_sales
	group by item_type) a
order by total_sales desc
-----------
--Orders

select TOP 10 *,
	sum(total_orders) over() as overall_orders,
	concat(round(cast(total_orders as float)/sum(total_orders) over()*100,2),'%') as proportion

from
	(select
		item_type,
		count(item_identifier) as total_orders
	from blinkit_sales
		group by item_type) a
order by total_orders desc
-------------------
--outlet_identifier
--Sales
select  *,
	sum(total_sales) over() as overall_sales,
	concat(round(total_sales/sum(total_sales) over()*100.0,2),'%') as Proportion
from
(
select
	outlet_identifier,
	round(sum(sales),0) as total_sales
from blinkit_sales
	group by outlet_identifier) a
order by total_sales desc
---------------
--Orders

select  *,
	sum(total_orders) over() as overall_orders,
	concat(round(cast(total_orders as float)/sum(total_orders) over()*100,2),'%') as proportion

from
	(select
		outlet_identifier,
		count(item_identifier) as total_orders
	from blinkit_sales
		group by outlet_identifier) a
order by total_orders desc
-------------------
--outlet_location_type
select  *,
	sum(total_sales) over() as overall_sales,
	concat(round(total_sales/sum(total_sales) over()*100.0,2),'%') as Proportion
from
(
select
	outlet_location_type,
	round(sum(sales),0) as total_sales
from blinkit_sales
	group by outlet_location_type) a
order by total_sales desc
-------------
--Orders

select  *,
	sum(total_orders) over() as overall_orders,
	concat(round(cast(total_orders as float)/sum(total_orders) over()*100,2),'%') as proportion

from
	(select
		outlet_location_type,
		count(item_identifier) as total_orders
	from blinkit_sales
		group by outlet_location_type) a
order by total_orders desc
--------------
--outlet_size
--Sales
select  *,
	sum(total_sales) over() as overall_sales,
	concat(round(total_sales/sum(total_sales) over()*100.0,2),'%') as Proportion
from
(
select
	outlet_size,
	round(sum(sales),0) as total_sales
from blinkit_sales
	group by outlet_size) a
order by total_sales desc
---------------
--Orders

select  *,
	sum(total_orders) over() as overall_orders,
	concat(round(cast(total_orders as float)/sum(total_orders) over()*100,2),'%') as proportion

from
	(select
		outlet_size,
		count(item_identifier) as total_orders
	from blinkit_sales
		group by outlet_size) a
order by total_orders desc
------------------
--outlet_type
--Sales
select  *,
	sum(total_sales) over() as overall_sales,
	concat(round(total_sales/sum(total_sales) over()*100.0,2),'%') as Proportion
from
(
select
	outlet_type,
	round(sum(sales),0) as total_sales
from blinkit_sales
	group by outlet_type) a
order by total_sales desc
------
--orders
select  *,
	sum(total_orders) over() as overall_orders,
	concat(round(cast(total_orders as float)/sum(total_orders) over()*100,2),'%') as proportion

from
	(select
		outlet_type,
		count(item_identifier) as total_orders
	from blinkit_sales
		group by outlet_type) a
order by total_orders desc
------------------------
--Trend
--outlet_establishment_year
--Sales
select  *,
	sum(total_sales) over() as overall_sales,
	concat(round(total_sales/sum(total_sales) over()*100.0,2),'%') as Proportion
from
(
select
	outlet_establishment_year as Year,
	round(sum(sales),0) as total_sales
from blinkit_sales
	group by outlet_establishment_year) a
order by Year
----------
--orders
select  *,
	sum(total_orders) over() as overall_orders,
	concat(round(cast(total_orders as float)/sum(total_orders) over()*100,2),'%') as proportion

from
	(select
		outlet_establishment_year as Year,
		count(item_identifier) as total_orders
	from blinkit_sales
		group by outlet_establishment_year) a
order by Year
------------------------------

select
	CAST(CONCAT(outlet_establishment_year,'-01-01') as DATE) as DATE
from blinkit_sales

ALTER TABLE blinkit_sales
add Dates Date

select * from blinkit_sales

update blinkit_sales
set Dates = CAST(CONCAT(outlet_establishment_year,'-01-01') as DATE)

ALTER TABLE blinkit_sales
drop column outlet_establishment_year