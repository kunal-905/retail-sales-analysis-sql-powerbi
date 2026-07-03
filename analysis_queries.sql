/* ============================================================
   RETAIL SALES ANALYSIS - SQL QUERIES
   Dataset: Sample Superstore (9,800 transactions, 2015-2018)
   Tool: DB Browser for SQLite
   ============================================================ */


/* ------------------------------------------------------------
   1. Total Sales by Region
   Purpose: Identify which region drives the most revenue
   ------------------------------------------------------------ */
SELECT Region, ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;


/* ------------------------------------------------------------
   2. Top 10 Products by Revenue
   Purpose: Find best-selling products by total sales value
   ------------------------------------------------------------ */
SELECT "Product Name", ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY "Product Name"
ORDER BY total_sales DESC
LIMIT 10;


/* ------------------------------------------------------------
   3. Monthly Sales Trend
   Purpose: Spot seasonality and growth/decline patterns over time
   ------------------------------------------------------------ */
SELECT substr("Order Date", 4, 7) AS order_month_raw,
       ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY order_month_raw
ORDER BY order_month_raw;


/* ------------------------------------------------------------
   4. Sales by Category and Sub-Category
   Purpose: Identify strongest and weakest product lines
   ------------------------------------------------------------ */
SELECT Category, "Sub-Category", ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY Category, "Sub-Category"
ORDER BY total_sales DESC;


/* ------------------------------------------------------------
   5. Top 10 Customers by Total Spend
   Purpose: Identify highest-value customers for targeting/loyalty programs
   ------------------------------------------------------------ */
SELECT "Customer Name",
       ROUND(SUM(Sales), 2) AS total_spent,
       COUNT(DISTINCT "Order ID") AS num_orders
FROM superstore
GROUP BY "Customer Name"
ORDER BY total_spent DESC
LIMIT 10;


/* ------------------------------------------------------------
   6. Average Order Value by Segment
   Purpose: Compare spending behavior across Consumer, Corporate,
            and Home Office segments
   ------------------------------------------------------------ */
SELECT Segment,
       COUNT(DISTINCT "Order ID") AS num_orders,
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Sales) * 1.0 / COUNT(DISTINCT "Order ID"), 2) AS avg_order_value
FROM superstore
GROUP BY Segment
ORDER BY avg_order_value DESC;


/* ------------------------------------------------------------
   7. Year-over-Year Sales
   Purpose: Track overall business growth or decline across years
   ------------------------------------------------------------ */
SELECT substr("Order Date", 7, 4) AS order_year,
       ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY order_year
ORDER BY order_year;
