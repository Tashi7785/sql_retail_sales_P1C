-- SQL Retail Sales Analysis - 1

-- create table 
CREATE TABLE retail_sales 
 	(			transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR (15),
				age INT,
				category VARCHAR (15),
				quantiy	INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
	);


SELECT* from retail_sales
where 
sale_time is null
OR 
transactions_id is null
OR 
sale_date is null
OR 
gender is null
OR 
category is null
OR 
quantiy is null
OR
cogs is null
OR
total_sale is null;

-- Data Cleaning 

Delete from retail_sales
where 
sale_time is null
OR 
transactions_id is null
OR 
sale_date is null
OR 
gender is null
OR 
category is null
OR 
quantiy is null
OR
cogs is null
OR
total_sale is null;

-- Data Exploration
-- how many sales we have 
Select count(*) as total_sales from retail_sales;

-- how many unique customers we have?
Select count(DISTINCT customer_id) as total_sales from retail_sales;

Select DISTINCT category from retail_sales;

-- Data Analysis & Business Key Problems and Answers
-- Q1 write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
Where sale_date = '2022-11-05';

--Q2 write a SQL query to retrieve all transactions where the category is "Clothing" and quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales 
where category = 'Clothing'
and to_char(sale_date, 'yyyy-mm') = '2022-11'
and quantiy >=4

-- Q3 write a SQL query to calculate the total sales (total_sales) for each category.
select 
	category,
	sum(total_sale)as net_sale,
	count(*) as total_orders
from retail_sales
group by 1;

-- Q4 write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
	ROUND(avg(age), 2) as avg_age
from retail_sales
where category = 'Beauty';

-- Q5 where a SQL query to find all transactions where the total_sale greater than 1000.
select * from retail_sales
where total_sale > 1000;
-- Q6 write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category. 
select category, gender, count(*) as total_trans
from retail_sales 
group by category, gender
order by 1;

-- Q7 write a SQl query to calculate the average sale for each month. find out best selling month in each year.
Select year, month, avg_sale
from 
(
select
	Extract(year from sale_date)as year,
	Extract(month from sale_date)as month,
	Avg(total_sale) as avg_sale,
	Rank() Over(Partition by Extract(year from sale_date) Order by Avg(total_sale)DESC) as rank
	from retail_sales
	group by 1,2) as t1
	where rank = 1;

-- Q8 write a SQL query to find the top 5 customers based on the highest total sales
select customer_id, SUM(total_sale)as total_sales
from retail_sales
group by 1
order by 2 DESC
limit 5;

-- Q9 write a SQL query to find the number of unique customers who purchased items from each category.
Select 
	category,
	Count(Distinct customer_id) as cnt_unique_cs
from retail_sales
group by category;

-- Q10 write a SQl query to create each shift and number of orders( example Morning <=12, Afternoon Between 12 & 17, Evenin >17)
with hourly_sale
AS 
(
select *,
	Case
		When Extract(hour from sale_time) < 12 Then 'Morning'
		When Extract(hour from sale_time) Between 12 and 17 Then 'Afternoon'
		Else 'Evening'
	End as shift
from retail_sales
)
Select shift,
count(*)as total_orders
from hourly_sale
Group by shift;

-- End of project






























	
