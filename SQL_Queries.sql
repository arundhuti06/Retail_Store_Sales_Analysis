-- SQL Retail Sales Analysis
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(20),
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales;

-- DATA CLEANING
SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
-- 
DEL FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- DATA EXPLORATION

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

-- How many categories we have ?
SELECT DISTINCT category FROM retail_sales;

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS
-- My Analysis & Findings :
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity > 3;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	category, gender, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category, gender
ORDER BY total_orders DESC;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT *
FROM (
		SELECT
			EXTRACT(YEAR FROM sale_date) AS year,
			EXTRACT(MONTH FROM sale_date) AS month,
			AVG(total_sale) AS avg_sales,
			RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
		FROM retail_sales
		GROUP BY year, month
) AS monthly_sales
WHERE rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT DISTINCT customer_id, SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales
GROUP BY category
ORDER BY total_customers DESC;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
	shift, 
	COUNT(*) AS total_orders
FROM 
(
	SELECT *,
		CASE
			WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
	FROM retail_sales
) AS hourly_sales
GROUP BY shift
ORDER BY total_orders DESC;

-- ## ANALYSIS 1 — REVENUE & PROFITABILITY ## --
SELECT
    category,
    SUM(total_sale) AS revenue,
    SUM(cogs) AS total_cogs,
    SUM(total_sale - cogs) AS total_profit,
    ROUND(
        (SUM(total_sale - cogs) / SUM(total_sale) * 100)::numeric,
        2
    ) AS profit_margin
FROM retail_sales
GROUP BY category;

-- INSIGHTS
	-- Q1. Which category generates the highest revenue? -> ELECTRONICS
	-- Q2. Which category generates the highest total profit? -> CLOTHING
	-- Q3. Which category has the highest profit margin? -> BEAUTY
	-- Q4. Does the highest-revenue category also have the highest profit margin? -> NO
	-- Q5. Are there high-revenue but low-margin categories? -> YES, ELECTRONICS CATEGORY
	-- Q6. Are there low-revenue but high-margin categories? -> YES, BEAUTY CATEGORY
	-- Q7. Which categories contribute most to overall profit? -> CLOTHING



-- ## ANALYSIS 2 - CATEGORY PERFORMANCE ## --
SELECT 
	category,
	COUNT(*) AS total_transactions,
	SUM(quantity) AS units_sold,
	COUNT(DISTINCT customer_id) AS unique_customers,
	SUM(total_sale) AS revenue,
	SUM(total_sale - cogs) AS total_profit,
	ROUND((SUM(total_sale - cogs) / SUM(total_sale) * 100)::numeric, 2) AS profit_margin,
	ROUND((SUM(total_sale) / COUNT(*))::numeric, 2) AS AOV
FROM retail_sales
GROUP BY category;

-- INSIGHTS
-- Q1. Which category has the most transactions? -> CLOTHING
-- Q2. Which category sells the most units? -> CLOTHING
-- Q3. Which category has the most unique customers? -> CLOTHING
-- Q4. Which category has the highest AOV? -> BEAUTY
-- Q5. Does the category with the most transactions also have the highest revenue? -> NO
-- Q6. Does the category with the most customers also generate the most profit? -> YES, CLOTHING CATEGORY
-- Q7. Which category appears strongest overall when considering revenue + profit + customer demand? -> CLOTHING

-- ## ANALYSIS 3 — CUSTOMER SPENDING & AOV ## --
-- 3A. AOV by Gender :
SELECT
	gender,
	COUNT(*) AS total_transactions,
	SUM(total_sale) AS revenue,
	ROUND((SUM(total_sale) / COUNT(*))::numeric, 2) AS AOV
FROM retail_sales
GROUP BY gender
ORDER BY AOV DESC;
	
-- INSIGHTS :
-- Q1. Which gender has the highest AOV? -> FEMALE
-- Q2. Which gender generates the highest revenue? -> FEMALE
-- Q3. Does the gender with the highest AOV also generate the highest revenue? -> YES, FEMALE GENDER

-- 3B. AOV by Age :
SELECT
	CASE
		WHEN age <18 THEN 'Below 18'
		WHEN age BETWEEN 18 AND 25 THEN '18-25'
		WHEN age BETWEEN 26 AND 39 THEN '26-39' 
		WHEN age BETWEEN 40 AND 59 THEN '40-59'
		ELSE '60+'
	END AS age_group,
	COUNT(*) AS total_transactions,
	SUM(total_sale) AS revenue,
	ROUND((SUM(total_sale) / COUNT(*))::numeric, 2) AS AOV
FROM retail_sales
GROUP BY age_group
ORDER BY AOV DESC;

-- INSIGHTS :
-- Q4. Which age group has the highest AOV? -> 18-25
-- Q5. Which age group generates the highest revenue? -> 40-59
-- Q6. Does the age group with the highest AOV also generate the highest revenue? -> NO

-- 3C. AOV by Shift :
SELECT
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
		ELSE 'EVENING'
	END AS shift,
	COUNT(*) AS total_transactions,
	SUM(total_sale) AS revenue,
	ROUND((SUM(total_sale)/COUNT(*))::numeric, 2) AS AOV
FROM retail_sales
GROUP BY shift
ORDER BY revenue DESC;

-- INSIGHTS :
-- Q7. Which shift has the highest AOV? -> MORNING
-- Q8. Which shift generates the highest revenue? -> EVENING
-- Q9. Does the busiest shift also have the highest AOV? -> NO


-- ## ANALYSIS 4 — CUSTOMER SEGMENTATION ## --
SELECT
	customer_id,
	COUNT(*) AS total_transactions,
	SUM(quantity) AS total_quantity,
	SUM(total_sale) AS total_spendings,
	ROUND((SUM(total_sale) / COUNT(*))::numeric, 2) AS AOV
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spendings DESC
LIMIT 10;

-- INSIGHTS :
-- Q1. Who are the top 10 highest-spending customers? -> 3,1,5,2,4,87,54,71,55,84
-- Q2. Which customers make the most transactions? -> 1,3
-- Q3. Which customers have the highest average transaction value? -> 34
-- Q4. Which customers purchase the highest quantity? -> 3

SELECT
    SUM(total_spending) AS top_10_revenue
FROM (
    SELECT
        customer_id,
        SUM(total_sale) AS total_spending
    FROM retail_sales
    GROUP BY customer_id
    ORDER BY total_spending DESC
    LIMIT 10
) AS top_customers;
-- Q5. How much revenue is generated by the top 10 customers? -> 214400

SELECT
    ROUND(
        (
            SUM(total_spending) /
            (SELECT SUM(total_sale) FROM retail_sales)
            * 100
        )::numeric,
        2
    ) AS top_10_revenue_percentage
FROM (
    SELECT
        customer_id,
        SUM(total_sale) AS total_spending
    FROM retail_sales
    GROUP BY customer_id
    ORDER BY total_spending DESC
    LIMIT 10
) AS top_customers;
-- Q6. Do a small number of customers contribute a large portion of total revenue? -> YES. The top 10 customers contribute 23.61% of total revenue.


-- ## ANALYSIS 5 - REPEAT VS ONE-TIME CUSTOMERS ## --
SELECT
    customer_type,
    COUNT(*) AS customers,
    SUM(total_transactions) AS transactions,
    SUM(total_spending) AS revenue,
    ROUND(
        (SUM(total_spending) / SUM(total_transactions))::numeric,
        2
    ) AS AOV
FROM (
    SELECT
        customer_id,
        COUNT(*) AS total_transactions,
        SUM(total_sale) AS total_spending,
        CASE
            WHEN COUNT(*) > 1 THEN 'Repeat'
            ELSE 'One-Time'
        END AS customer_type
    FROM retail_sales
    GROUP BY customer_id
) AS customer_segment
GROUP BY customer_type
ORDER BY AOV DESC;

-- INSIGHTS :
-- Q1. How many one-time customers are there? -> 0
-- Q2. How many repeat customers are there? -> 155
-- Q3. Which group generates more revenue? -> REPEAT (₹9,08,230)
-- Q4. Which group has the higher AOV? -> REPEAT (₹457.09)
-- Q5. What percentage of total revenue comes from repeat customers? -> 100%
-- Q6. Is the business more dependent on repeat or one-time customers? -> REPEAT CUSTOMERS


-- ## ANALYSIS 6 — YEAR-OVER-YEAR GROWTH ## --
WITH yearly_sales AS(
		SELECT 
			EXTRACT(YEAR FROM sale_date) AS YEAR,
			COUNT(*) AS TRANSACTIONS,
			SUM(total_sale) AS REVENUE,
			SUM(total_sale - cogs) AS PROFIT
		FROM retail_sales
		GROUP BY YEAR
)
SELECT 
		YEAR,
		TRANSACTIONS,
		REVENUE,
		PROFIT,
		LAG(REVENUE) OVER (ORDER BY YEAR) AS PREVIOUS_YEAR_REVENUE,
		LAG(PROFIT) OVER (ORDER BY YEAR) AS PREVIOUS_YEAR_PROFIT,
		ROUND(((REVENUE - LAG(REVENUE) OVER (ORDER BY YEAR)) / LAG(REVENUE) OVER (ORDER BY year)* 100)::numeric, 2) AS REVENUE_GROWTH_PERCENT,
		ROUND(((PROFIT - LAG(PROFIT) OVER (ORDER BY YEAR)) / LAG(PROFIT) OVER (ORDER BY year)* 100)::numeric, 2) AS PROFIT_GROWTH_PERCENT
FROM yearly_sales
ORDER BY YEAR;

-- INSIGHTS :
-- Q1. Which year generated the highest revenue? -> 2023
-- Q2. Which year generated the highest profit? -> 2023
-- Q3. How much did revenue grow compared with the previous year? -> 2.13%
-- Q4. How much did profit grow compared with the previous year? -> 3.10%
-- Q5. Did revenue and profit grow at the same rate? -> NO, PROFIT GREW BY 3.10% WHILE REVENUE GREW BY 2.13%
-- Q6. Did the number of transactions increase or decrease? -> INCREASE
-- Q7. Is the business showing overall growth or decline? -> GROWTH

-- ## ANALYSIS 7 — MONTHLY REVENUE & PROFIT TREND ## --
SELECT
	EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month_number,
    TO_CHAR(sale_date, 'Month') AS month,
	COUNT(*) AS transactions,
	SUM(total_sale) AS revenue,
	ROUND(SUM(total_sale - cogs)::numeric, 2) AS profit,
	ROUND((SUM(total_sale - cogs) / SUM(total_sale) * 100)::numeric, 2) AS profit_margin,
	ROUND((SUM(total_sale) / COUNT(*))::numeric, 2) AS AOV
FROM retail_sales
GROUP BY 
		EXTRACT(YEAR FROM sale_date),
    	EXTRACT(MONTH FROM sale_date),
    	TO_CHAR(sale_date, 'Month')
ORDER BY 
		year,
		profit_margin desc ;

-- INSIGHTS : 
-- Q1. Which month generates the highest revenue? -> 2022, december(Rs.71880) & 2023, december(Rs.69145)
-- Q2. Which month generates the lowest revenue? -> 2022, february(Rs.16110) & 2023, march(Rs.20530)
-- Q3. Which month generates the highest profit? -> 2022, december(Rs.54171.90) & 2023, december(Rs.54108.60)
-- Q4. Which month has the highest number of transactions? -> 2022, december(156) & 2023, september(146)
-- Q5. Which month has the highest AOV? -> 2022, july(Rs.541.34) & 2023, february(Rs.535.53)
-- Q6. Which month has the highest profit margin? -> 2022, january(85.83%) & 2023, february(85.12%)
-- Q7. Does the month with the highest revenue also have the highest profit? -> YES
-- Q8. Are there noticeable high-performing or low-performing months? -> YES. December consistently performs strongly in both revenue and profit, while February 2022 and March 2023 have the lowest revenue.


-- ## ANALYSIS 8 — SHIFT / TIME-OF-DAY PERFORMANCE ## --
SELECT
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
		ELSE 'EVENING'
	END AS shift,
	COUNT(*) AS total_transactions,
	SUM(quantity) AS units_sold,
	SUM(total_sale) AS revenue,
	ROUND(SUM(total_sale - cogs)::numeric, 2) AS profit,
	ROUND((SUM(total_sale - cogs) / SUM(total_sale) * 100)::numeric, 2) AS profit_margin,
	ROUND((SUM(total_sale) / COUNT(*))::numeric, 2) AS AOV
FROM retail_sales
GROUP BY shift
ORDER BY revenue DESC;

-- Q1. Which shift has the most transactions? -> EVENING
-- Q2. Which shift sells the most units? -> EVENING
-- Q3. Which shift generates the highest revenue? -> EVENING
-- Q4. Which shift generates the highest profit? -> EVENING
-- Q5. Which shift has the highest profit margin? -> MORNING
-- Q6. Which shift has the highest AOV? -> MORNING
-- Q7. Does the busiest shift also generate the highest revenue? -> YES (EVENING SHIFT)
-- Q8. Does the busiest shift also have the highest AOV? -> NO
-- Q9. Which shift appears strongest overall? -> EVENING


-- ## ANALYSIS 9 — CATEGORY REVENUE CONTRIBUTION ## --
SELECT
	category,
	SUM(total_sale) AS revenue,
	ROUND((SUM(total_sale) / (SELECT SUM(total_sale) FROM retail_sales) * 100)::numeric, 2) AS revenue_contribution_pct,
	ROUND(SUM(total_sale - cogs)::numeric, 2) AS profit,
	ROUND((SUM(total_sale - cogs) / (SELECT SUM(total_sale - cogs) FROM retail_sales) * 100)::numeric, 2) AS profit_contribution_pct
FROM retail_sales
GROUP BY category
ORDER BY PROFIT DESC;


-- INSIGHTS : 
-- Q1. Which category contributes the most revenue? -> ELECTRONICS
-- Q2. What percentage of total revenue comes from each category? -> ELECTRONICS(34.29%), CLOTHING(34.13%), BEAUTY(31.58%)
-- Q3. Which category contributes the most profit? -> CLOTHING
-- Q4. What percentage of total profit comes from each category? -> CLOTHING(34.19%), ELECTRONICS(34.03%), BEAUTY(31.58%)
-- Q5. Is the business heavily dependent on one or two categories? -> NO


