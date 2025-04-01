--find top 10 highest reveue generating products 
select top 10 product_id,sum(sale_price) as sales
from df_orders
group by product_id
order by sales desc

--find top 5 highest selling products in each region
with cte as (
select region,product_id,sum(sale_price) as sales
from df_orders
group by region,product_id)
select * from (
select *
, row_number() over(partition by region order by sales desc) as rn
from cte) A
where rn<=5

--find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023
with cte as (
select year(order_date) as order_year,month(order_date) as order_month,
sum(sale_price) as sales
from df_orders
group by year(order_date),month(order_date)
--order by year(order_date),month(order_date)
	)
select order_month
, sum(case when order_year=2022 then sales else 0 end) as sales_2022
, sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte 
group by order_month
order by order_month


--for each category which month had highest sales 
with cte as (
select category,format(order_date,'yyyyMM') as order_year_month
, sum(sale_price) as sales 
from df_orders
group by category,format(order_date,'yyyyMM')
)
select * from (
select *,
row_number() over(partition by category order by sales desc) as rn
from cte
) a
where rn=1


--which sub category had highest growth by profit in 2023 compare to 2022
with cte as (
select sub_category,year(order_date) as order_year,
sum(sale_price) as sales
from df_orders
group by sub_category,year(order_date)
--order by year(order_date),month(order_date)
	)
, cte2 as (
select sub_category
, sum(case when order_year=2022 then sales else 0 end) as sales_2022
, sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte 
group by sub_category
)
select top 1 *
,(sales_2023-sales_2022)
from  cte2
order by (sales_2023-sales_2022) desc

--Region with the Highest Number of Orders in 2023
SELECT top 1 region, COUNT(*) AS order_count
FROM df_orders
WHERE year(order_date) = 2023
GROUP BY region
ORDER BY order_count DESC;

--Average Discount Percent by Segment�
SELECT segment, AVG(discount) AS avg_discount
FROM df_orders
GROUP BY Segment;

--Which Category Had the Highest Revenue in 2023?
SELECT top 1 Category, SUM(sale_price) AS revenue
FROM df_orders
WHERE year(order_date) = 2023
GROUP BY Category
ORDER BY revenue DESC

--Average Quantity Sold Per Order by Sub-Category
SELECT sub_category, AVG(Quantity) AS avg_quantity
FROM df_orders
GROUP BY sub_category
ORDER BY avg_quantity DESC

--Which State Had the Highest Total Sales in 2023?�
SELECT top 1 State, SUM(sale_price) AS total_sales
FROM df_orders
WHERE year(order_date) = 2023
GROUP BY State
ORDER BY total_sales DESC

--Number of Orders Per Month in 2023
SELECT month(order_date) as months, COUNT(*) AS order_count
FROM df_orders
WHERE year(order_date) = 2023
GROUP BY month(order_date)
ORDER BY month(order_date);

--Average Sale Price by Region in 2023
SELECT Region, AVG(sale_price) AS avg_sale_price
FROM df_orders
WHERE year(order_date) = 2023
GROUP BY Region ;