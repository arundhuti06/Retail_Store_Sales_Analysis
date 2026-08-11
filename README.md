# Retail Sales Analysis SQL Project

## Project Overview

**Project Title:** Retail Sales Analysis  
**Level:** Beginner / Intermediate  
**Database:** PostgreSQL  

This project focuses on analyzing retail sales data using SQL to understand **sales performance, profitability, customer behavior, sales trends, and category contribution**.

The project starts with data cleaning and basic exploration, followed by business-driven SQL analysis. The aim is to practice SQL in a way that goes beyond retrieving data and instead uses query results to answer practical business questions and draw meaningful insights.

## Objectives

1. **Data Setup:** Create and populate the `retail_sales` table with the provided retail transaction data.
2. **Data Cleaning:** Check the dataset for missing or NULL values in important fields.
3. **Data Exploration:** Understand the number of transactions, customers, and product categories.
4. **Business Analysis:** Use SQL to analyze revenue, profit, customers, trends, and category performance.
5. **Business Insights:** Translate the analysis into practical findings and recommendations.

## Project Structure

### 1. Database & Table Setup

The project uses PostgreSQL and a table named `retail_sales`.

The table contains:

- Transaction ID
- Sale Date
- Sale Time
- Customer ID
- Gender
- Age
- Category
- Quantity
- Price per Unit
- COGS
- Total Sale

```sql
CREATE TABLE retail_sales(
    transactions_id INT PRIMARY KEY,
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
```

### 2. Data Exploration & Cleaning

The dataset was checked for missing values across transaction, customer, product, cost, and sales fields.

Basic exploration was also performed to identify:

- Total number of sales transactions
- Number of unique customers
- Available product categories

The CSV dataset used for the project is included in the repository.

### 3. Data Analysis & Findings

The SQL analysis contains the following business-focused sections.

#### Analysis 1 — Revenue & Profitability

Analyzed revenue, COGS, total profit and profit margin by category.

Key questions:
- Which category generates the highest revenue?
- Which category generates the highest profit?
- Which category has the highest profit margin?
- Does the highest-revenue category also have the highest margin?

#### Analysis 2 — Category Performance

Compared categories using:

- Transactions
- Units sold
- Unique customers
- Revenue
- Profit
- Profit margin
- AOV

#### Analysis 3 — Customer Spending & AOV

Analyzed AOV and revenue by:

- Gender
- Age group
- Time of day

#### Analysis 4 — Customer Segmentation

Identified:

- Top 10 highest-spending customers
- Customers with the most transactions
- Highest-AOV customers
- Customers purchasing the highest quantity
- Revenue contribution from the top 10 customers

#### Analysis 5 — Repeat vs One-Time Customers

Classified customers by transaction frequency and compared:

- Number of customers
- Transactions
- Revenue
- AOV

#### Analysis 6 — Year-over-Year Growth

Compared 2022 and 2023 using revenue, profit and transactions.

`LAG()` was used to calculate revenue and profit growth.

#### Analysis 7 — Monthly Revenue & Profit Trend

Compared monthly:

- Revenue
- Profit
- Profit margin
- Transactions
- AOV

for 2022 and 2023.

#### Analysis 8 — Shift / Time-of-Day Performance

Compared Morning, Afternoon and Evening using:

- Transactions
- Units sold
- Revenue
- Profit
- Profit margin
- AOV

#### Analysis 9 — Category Revenue Contribution

Calculated each category's percentage contribution to total revenue and total profit.

## Findings

### Category Performance

- **Electronics** generated the highest revenue.
- **Clothing** generated the highest total profit.
- **Beauty** had the highest profit margin.
- Clothing led transactions, units sold and unique customers.
- Beauty had the highest AOV.

**Insight:** The highest-revenue category was not the most profitable by margin. Clothing was the strongest overall category when revenue, profit and customer demand were considered together.

### Customer Insights

- **Female** customers had the highest AOV and revenue.
- The **18–25** age group had the highest AOV.
- The **40–59** age group generated the highest revenue.
- The top 10 customers generated **₹214,400**, representing **23.61% of total revenue**.

### Repeat Customer Behavior

- The dataset contains **155 customers**.
- Every customer made at least two purchases.
- Therefore, **100% of the recorded revenue came from repeat customers**.

This does not mean the business has a 100% retention rate; customers who purchased only once may simply not be represented in this dataset.

### Year-over-Year Growth

| Metric | 2022 | 2023 |
|---|---:|---:|
| Transactions | 966 | 1,021 |
| Revenue | ₹449,335 | ₹458,895 |
| Profit | ₹354,160.50 | ₹365,141.70 |

- Revenue increased by **2.13%**.
- Profit increased by **3.10%**.
- Transactions increased.
- Overall performance showed **growth**, with profit growing faster than revenue.

### Monthly Trends

- **December** generated the highest revenue in both 2022 and 2023.
- December also generated the highest profit in both years.
- The lowest-revenue months were **February 2022** and **March 2023**.
- The highest AOV occurred in **July 2022** and **February 2023**.
- The highest profit margin occurred in **January 2022** and **February 2023**.

### Time-of-Day Performance

- **Evening** had the most transactions and units sold and generated the highest revenue and profit.
- **Morning** had the highest AOV and profit margin.

**Insight:** Evening is the strongest period for sales volume, while Morning shows stronger transaction value and profitability efficiency.

### Category Contribution

| Category | Revenue Contribution | Profit Contribution |
|---|---:|---:|
| Electronics | 34.29% | 34.03% |
| Clothing | 34.13% | 34.19% |
| Beauty | 31.58% | 31.58% |

The business is **not heavily dependent on one category**, as revenue and profit are relatively evenly distributed.

## Business Recommendations

- **Focus on high-value customer retention:** The top 10 customers contribute 23.61% of revenue.
- **Use December performance for planning:** Inventory, staffing and promotions can be planned around the recurring December peak.
- **Investigate category strengths:** Clothing's profit performance and Beauty's margin performance may reveal useful pricing, cost or product-mix practices.
- **Optimize time-of-day operations:** Evening can be optimized for volume, while Morning can be explored for higher-value or margin-focused offers.
- **Use lower-performing months strategically:** Targeted promotions can be considered during weaker periods without losing the benefit of the balanced category mix.

## Conclusion

This project demonstrates how SQL can be used to move from transaction-level data to **business-focused analysis**. The findings show that revenue, profit, customer demand, AOV and margin can tell different stories, while time and category patterns reveal opportunities for better business decisions.

## Reports & Visualizations

- **SQL Analysis:** `SQL_Queries.sql`
- **Dataset:** `SQL - Retail Sales Analysis_utf .csv`
- **Project Report:** `Retail_Sales_Analysis_Report.docx`
- **Visualizations:** Selected SQL findings can be visualized separately in Excel.

## How to Use

1. Clone or download this repository.
2. Create the `retail_sales` table in PostgreSQL using the SQL table definition.
3. Import the provided CSV data into the `retail_sales` table.
4. Run `SQL_Queries.sql`.
5. Review the query results and compare them with the documented findings.
6. Use the outputs for further analysis or visualization in Excel.

> **Note:** The SQL file contains the analysis queries and data-cleaning checks. Data import into PostgreSQL is performed separately.

## Author

**Arundhuti Mukhopadhyay**

This project is part of my learning portfolio as I build practical skills in **SQL and Data Analytics**.
