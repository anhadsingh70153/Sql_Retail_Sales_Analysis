	--SQL Retail Analysis
create database sql_project_p2;
--Create Table
Create table Retail_Sales (	transactions_id	int primary key,
                            sale_date date,	
                            sale_time	time,	
                            customer_id	int,
                            gender	varchar(15),
                            age	int,
                            category varchar(15),	
                            quantiy	int,
                            price_per_unit	float,
                            cogs	float,
                            total_sale float
                          );
select * 
from Retail_Sales

--Retrieves The Total number 
select count(*) 
from Retail_Sales

--Renaming the wrong column name 
ALTER TABLE Retail_Sales
RENAME COLUMN quantiy TO quantity;



-- Data Cleaning 
select * 
from Retail_Sales 
where transactions_id is null
or 
sale_date is null 
or
sale_time is null 
or
customer_id is null 
or
gender is null 
or
age is null 
or
category is null 
or
quantity is null 
or
price_per_unit is null 
or
cogs is null 
or
total_sale is null 


-- 
delete from Retail_Sales 
where transactions_id is null
or 
sale_date is null 
or
sale_time is null 
or
customer_id is null 
or
gender is null 
or
age is null 
or
category is null 
or
quantity is null 
or
price_per_unit is null 
or
cogs is null 
or
total_sale is null 

--Data Exploration 
--BQ1) How many Sales we have?

select count(*) as Total_sales from Retail_sales

--BQ2) How many unique customers we have?

select count (Distinct Customer_id) as Total_sale from Retail_Sales

--BQ3) --BQ2) How many unique Categories we have?

select Distinct Category from Retail_Sales

--DATA ANALYSIS AND BUSINESS KEY PROBLEMS	

--Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from retail_sales
where sale_date = '2022-11-05'

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4

--	Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 	avg(age) as avg_age_for_beauty
from retail_sales
where category = 'Beauty'


--Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from retail_sales
where total_sale>1000

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select category, gender,
count(*) as total_trans
from retail_sales
group by category,gender 

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

--Write a SQL query to find the top 5 customers based on the highest total sales :


select customer_id,sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc 
limit 5

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

select category,count (Distinct customer_id) as unique_customers
from retail_sales
group by category 

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

With hourly_sale
as
(
select *,	case
when extract(hour from sale_time) < 12 then 'Morning' 
     when extract(hour from sale_time) between 12 and 17 then 'Afternoon' 
	 else 'Evening'
end as Part_of_Day 	 
	 from retail_sales
	 )
	 select Part_of_Day,
	 count(*) as total_orders_of_a_shift
	 from hourly_sale
	 group by Part_of_Day


-- Project End















