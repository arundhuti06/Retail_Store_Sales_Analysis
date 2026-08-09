# Retail Sales Analysis — SQL Project

A SQL-based retail sales analysis project using **PostgreSQL** to understand revenue, profitability, customer behavior, sales trends, and category performance.

## Project Objective

The goal was to move beyond basic SQL queries and use transaction-level data to answer practical business questions and turn the results into meaningful insights.

## Tools

- PostgreSQL
- SQL
- GitHub
- Excel for selected visualizations

## Analysis Performed

1. **Revenue & Profitability** — revenue, COGS, profit and profit margin by category.
2. **Category Performance** — transactions, units sold, customers, revenue, profit, margin and AOV.
3. **Customer Spending & AOV** — spending patterns by gender, age group and sales shift.
4. **Customer Segmentation** — top-spending customers, transaction frequency and customer contribution to revenue.
5. **Repeat vs One-Time Customers** — customer purchase frequency and revenue contribution.
6. **Year-over-Year Growth** — revenue, profit and transaction growth using `LAG()`.
7. **Monthly Trends** — monthly revenue, profit, margin, transactions and AOV across 2022–2023.
8. **Time-of-Day Performance** — Morning, Afternoon and Evening sales performance.
9. **Category Revenue Contribution** — each category's share of total revenue and profit.

## Key Business Insights

### Category Performance
- **Electronics** generated the highest revenue.
- **Clothing** generated the highest total profit and led transactions, units sold and unique customers.
- **Beauty** had the highest profit margin and AOV.
- The highest-revenue category was therefore **not** the highest-margin category.

### Customer Behavior
- **Female customers** generated the highest revenue and AOV.
- The **18–25** age group had the highest AOV, while the **40–59** group generated the highest revenue.
- The **top 10 customers generated ₹214,400**, representing **23.61% of total revenue**.

### Repeat Purchasing
- The dataset contains **155 customers**, all of whom made at least two purchases.
- Recorded revenue therefore comes entirely from repeat customers.
- This should not be interpreted as a 100% retention rate because the dataset may not include customers who purchased only once.

### Growth & Trends
- Revenue increased from **₹449,335 in 2022 to ₹458,895 in 2023**, a **2.13% increase**.
- Profit increased from **₹354,160.50 to ₹365,141.70**, a **3.10% increase**.
- Profit grew faster than revenue, indicating improved profitability in 2023.
- **December** was the highest-revenue and highest-profit month in both years.
- **Evening** led transactions, units sold, revenue and profit.
- **Morning** had the highest AOV and profit margin.

### Category Contribution
Revenue was relatively balanced across the three categories:

| Category | Revenue Share | Profit Share |
|---|---:|---:|
| Electronics | 34.29% | 34.03% |
| Clothing | 34.13% | 34.19% |
| Beauty | 31.58% | 31.58% |

This indicates that the business is **not heavily dependent on a single category**.

## Business Takeaways

- Retaining high-value customers is important because a small group contributes a meaningful share of revenue.
- December and strong evening demand can inform inventory, staffing and promotional planning.
- Beauty's strong margin and Clothing's strong profitability are worth investigating for successful pricing, cost or product-mix practices.
- Lower-performing months could be targeted with focused promotions while maintaining the balanced category mix.

## SQL Skills Demonstrated

`SELECT` • `WHERE` • `GROUP BY` • `ORDER BY` • `SUM()` • `COUNT()` • `AVG()` • `COUNT(DISTINCT)` • `CASE` • date/time functions • type casting • subqueries • CTEs • `LAG()` • `RANK()` • business metrics and interpretation.



## Conclusion

This project helped me practice using SQL not only to retrieve data, but to **investigate business performance, identify patterns and explain what the numbers mean**. The analysis combines technical SQL skills with practical business interpretation.
