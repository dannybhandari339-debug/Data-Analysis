-- CREATE DATABASE Cofee;

Select * from coffee_shop;

desc coffee_shop;

-- Change data type -

SET SQL_SAFE_UPDATES = 0;

Update coffee_shop SET transaction_date = str_to_date(transaction_date, '%m/%d/%Y');

ALTER TABLE coffee_shop MODIFY COLUMN transaction_date DATE;

Select * from coffee_shop;
DESC coffee_shop ;

SELECT ﻿transaction_id FROM coffee_shop;

SELECT SUM(﻿transaction_id is null) AS null_transaction_id,
SUM(transaction_date is NULL) AS null_transaction_date,
SUM(transaction_time is NULL) AS null_transaction_time,
SUM(transaction_qty IS NULL) AS null_transaction_qty,
SUM(unit_price IS NULL) AS null_unit_price,
SUM(product_category IS NULL) AS null_product_category,
SUM(store_location IS NULL) AS null_store_location
FROM coffee_shop;

SELECT * from coffee_shop;

SELECT * FROM coffee_shop WHERE ﻿transaction_id =34;
SELECT * FROM coffee_shop WHERE transaction_qty <=0;
SELECT * FROM coffee_shop WHERE unit_price <=0;

-- Identify Duplicate transaction CHECK TABLE

SELECT transaction_id, COUNT(*) AS Duplicate_Count 
FROM coffee_shop GROUP BY transaction_id HAVING COUNT(*) > 1;


SELECT * FROM coffee_shop WHERE ﻿transaction_id = 34;
SELECT * FROM coffee_shop WHERE transaction_id = 34;

ALTER TABLE coffee_shop CHANGE COLUMN  ﻿transaction_id  transaction_id INT;

SELECT * FROM coffee_shop;

-- CREATE a view with Revenue calculations

CREATE VIEW revenue AS SELECT 
transaction_id, transaction_date, transaction_time, transaction_qty, store_id, store_location, product_id, unit_price, product_category, product_type, product_detail, transaction_qty * unit_price AS Total_Sales
FROM coffee_shop;

SELECT * FROM revenue;

-- TIme based attributes

CREATE VIEW TrendData AS SELECT *, hour(transaction_time) AS Sales_Hour,
dayname(transaction_date) AS Sales_Day, month(transaction_date) AS Sales_Month, year(transaction_date) AS Sales_Year FROM revenue;

SELECT * FROM TrendData;


-- Exploratory business analysis using sql

#Total Revenue

SELECT SUM(Total_Sales) AS total_revenue FROM revenue;

# Revenuse by location

SELECT store_location, sum(Total_Sales) AS total_Revenue FROM revenue GROUP BY store_Location ORDER BY total_revenue DESC;

#Revenue by product category

SELECT product_category, SUM(Total_Sales) AS Total_Revenue FROM revenue GROUP BY product_Category ORDER BY total_revenue DESC;

#4 Top 10 products by revenue

SELECT product_category, sum(Total_Sales) AS Total_Sales FROM revenue GROUP BY product_category ORDER BY Total_Sales DESC LIMIT 10;

SELECT * FROM coffee_shop;

-- -----------------
-- #5 Hour Sales Trend

SELECT sales_hour, SUM(Total_Sales) AS Hourly_Revenue FROM trend_data GROUP BY sales_hour ORDER BY sales_hour;

#6 Daily Sales Trend 

SELECT transaction_Date, SUM(Total_Sales) AS Daily_Revenue FROM revenue GROUP BY transaction_Date ORDER BY transaction_Date;

#7 Monthly Sales Trend 

SELECT sales_year, sales_month, SUM(Total_Sales) AS monthly_Revenue FROM trenddata GROUP BY sales_year, sales_month ORDER BY sales_year, sales_month;

SELECT sales_day, SUM(Total_Sales) AS Day_Sales FROM trenddata GROUP BY sales_day ORDER BY sales_day;

SELECT store_Location, sales_day, SUM(Total_Sales) AS Revenue FROM trenddata GROUP BY store_Location, sales_day ORDER BY Revenue DESC;




