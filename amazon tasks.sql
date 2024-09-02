---------SITUATIONS AND APPROACH--------

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM sellers;
SELECT * FROM orders;
SELECT * FROM returns;


/*
Scenario 1: Amazon's marketing team is planning a new loyalty rewards program and wants to 
target customers who have shown a high frequency of purchases. By identifying customers who 
have made more than five orders in the past year, the team can tailor exclusive offers or 
discounts to these loyal customers, encouraging further engagement and retention.
--Identify Loyal Customers:
*/

SELECT c.customer_id, c.customer_name, COUNT(order_id) AS total_orders
FROM orders as o
JOIN
customers as c
ON c.customer_id=o.customer_id
WHERE order_date >= NOW() - INTERVAL '1 year'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(order_id) > 5
ORDER BY 3;


/*
Scenario 2: Amazon is preparing for the holiday season and wants to optimize inventory levels. 
The operations team needs to know which products are the top sellers in each category to 
ensure they are well-stocked. This information helps in managing supply chain logistics 
and reducing the risk of stockouts during peak shopping periods.
Top-Selling Products by Category:
*/

WITH ProductSales AS (
    SELECT o.product_id, o.category, SUM(quantity) AS total_quantity
    FROM orders o
    JOIN 
	products p 
	ON o.product_id = p.product_id
    GROUP BY 1,2
)

SELECT product_id, category, total_quantity
FROM (
    SELECT product_id, category, total_quantity,
           RANK() OVER (PARTITION BY category ORDER BY total_quantity DESC) AS rank
    FROM ProductSales
) 
WHERE rank <= 3;


/*
Scenario 3: Amazon's customer analytics team is developing a new strategy for customer 
relationship management (CRM). They need to calculate the customer lifetime value (CLV) to 
segment customers based on their total spend. By understanding CLV, the team can focus marketing 
efforts on high-value customers, offering personalized deals to maximize long-term revenue
Customer Lifetime Value (CLV):
*/

SELECT c.customer_id, c.customer_name, SUM(o.sale) AS customer_lifetime_value
FROM customers c
JOIN 
orders o 
ON c.customer_id = o.customer_id
GROUP BY 1,2
ORDER BY 3 DESC;


/*
Scenario 4: Amazon is considering a new incentive program for third-party sellers on its 
platform. To determine which sellers should qualify for performance-based rewards, 
the e-commerce team needs to rank sellers by their total sales. This ranking helps 
in recognizing top performers and encouraging others to improve their sales.
Sales Performance by Seller:
*/

SELECT s.seller_id, s.seller_name, SUM(sale) AS total_sales,
       RANK() OVER (ORDER BY SUM(sale) DESC) AS seller_rank
FROM orders o
JOIN 
sellers s
ON o.seller_id = s.seller_id
GROUP BY 1,2
ORDER BY 3 DESC;


/*
Scenario 5: The sales analytics team at Amazon wants to analyze how sales fluctuate across 
different days of the week. This will help in optimizing marketing campaigns and inventory 
management.
Sales Trends by Day of the Week:
*/

SELECT TO_CHAR(order_date,'Day') as order_day, sum(sale) as total_sales_by_day
FROM orders
GROUP BY 1
ORDER BY 2 DESC;


/*
Scenario 6: Amazon wants to evaluate how well different sellers are performing in various regions. 
This analysis will support decisions about regional promotions and logistics improvements.
Seller Performance in Different Regions:
*/

SELECT o.seller_id, s.seller_name, o.state, sum(sale) as total_sales_by_country
FROM orders as o
JOIN
sellers as s
on o.seller_id=s.seller_id
GROUP BY 1,2,3
ORDER BY 4 DESC;


/*
Scenario 7: Amazon's customer experience team is trying to identify customers who are 
at risk of churning (i.e., stopping their purchases). They want to find customers who haven't 
placed an order in the last six months but were active before that period.
--Customer Churn Prediction:
*/

SELECT c.customer_id, c.customer_name, max(o.order_date) as recent_order_date
FROM customers c
JOIN
orders o 
ON c.customer_id = o.customer_id
GROUP BY 1,2
HAVING MAX(o.order_date) < NOW() - INTERVAL '6 months'
   AND MAX(o.order_date) >= NOW() - INTERVAL '12 months'
ORDER BY 3 DESC;


/*
Scenario 8: Amazon’s marketing team wants to segment customers into different categories 
based on their total spending in the last year. This segmentation will help in creating 
personalized marketing campaigns.
--Segmenting customers
*/

SELECT c.customer_id, c.customer_name, SUM(o.sale) as total_spent,
       CASE 
           WHEN SUM(o.sale) > 1000 THEN 'High Spender'
           WHEN SUM(o.sale) BETWEEN 500 AND 1000 THEN 'Medium Spender'
           ELSE 'Low Spender'
       END AS spending_category
FROM customers c
JOIN 
orders o 
ON c.customer_id = o.customer_id
WHERE o.order_date >= NOW() - INTERVAL '1 year'
GROUP BY 1,2
ORDER BY 3 DESC;


/*
Scenario 9: Amazon wants to know the top 5 best-selling products in each region to ensure they 
are well-stocked and to plan regional promotions.
-- Top 5 Selling Products in Each State:
*/

CREATE TABLE RegionalSales AS (
    SELECT p.product_id, p.product_name, o.state, SUM(o.quantity) AS total_quantity
    FROM orders o
    JOIN 
	products p 
	ON o.product_id = p.product_id
    GROUP BY 1,2,3
)

--

SELECT product_id, product_name, state, total_quantity
FROM (
    SELECT product_id, product_name, state, total_quantity,
           RANK() OVER (PARTITION BY state ORDER BY total_quantity DESC) AS rank
    FROM RegionalSales
) 
WHERE rank <= 5;


/*
Scenario 10: The retention team is looking to re-engage customers who haven’t placed any orders
in the last year. They need a list of such customers to target with special offers.
Customers with No Orders in the Past Year:
*/

SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN 
orders o 
ON c.customer_id = o.customer_id 
                   AND o.order_date >= NOW() - INTERVAL '1 year'
WHERE o.order_id IS NULL;


/*
Scenario 11: The analytics team wants to examine how sales have trended over time for different
product categories. This will help them understand seasonal trends and plan marketing campaigns.
--Sales Trends Over months by Product Category:
*/

SELECT TO_CHAR(o.order_date, 'month') AS month, o.category, SUM(o.sale) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY 1,2
ORDER BY 1,2;


/*
Scenario 12: By focusing on the highest and second-highest orders, Amazon can spot trends such 
as customers reducing their purchase amounts, which might signal a decline in their engagement.
--Highest and second highest order value
*/

WITH RankedOrders AS (
    SELECT o.customer_id,c.customer_name ,o.order_id, o.order_date, o.sale,
        RANK() OVER (PARTITION BY o.customer_id ORDER BY o.sale DESC) AS rank
    FROM orders as o
	JOIN
	customers as c
	ON c.customer_id = o.customer_id
)
SELECT customer_id,customer_name, order_id, order_date, sale
FROM RankedOrders
WHERE rank IN (1, 2)
ORDER BY customer_id, rank;


/*
Scenario 13: Amazon’s quality assurance team is interested in identifying products that have a 
high return rate so they can investigate potential quality issues.
--Identify Products That Are Frequently Returned
*/

SELECT p.product_id, p.product_name, COUNT(r.return_id) AS return_count, COUNT(o.order_id) AS order_count,
    (COUNT(r.return_id) * 100.0 / COUNT(o.order_id)) AS return_rate
FROM products p
JOIN 
orders o 
ON p.product_id = o.product_id
LEFT JOIN 
returns r 
ON o.order_id = r.order_id
GROUP BY 1,2
HAVING COUNT(r.return_id) > 1
ORDER BY 5 DESC;


/*
Scenario 14: Amazon’s customer service team wants to identify the customer with the most returns. This 
information could be useful for investigating whether there are underlying issues, such as 
product quality problems or misunderstandings about how to use the products.
--To identify the customer with the most returns:
*/

SELECT r.order_id, o.customer_id, COUNT(r.return_id) as total_returns
FROM returns as r
JOIN 
orders as o 
ON r.order_id = o.order_id
GROUP BY 1,2
ORDER BY 3 DESC;


/*
Scenario 15: Amazon’s marketing team wants to know which product categories generate the most 
sales so they can focus their advertising efforts on these categories.
--Identify the Most Popular Categories by Sales Volume:
*/
SELECT o.category, SUM(o.quantity) AS total_sold
FROM orders as o
JOIN 
products as p 
ON o.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC;

/*
Scenario 16: Amazon’s premium services team is interested in identifying customers 
who have a high average order value, as these customers might be interested 
in premium memberships or exclusive offers.
--Find Customers with the Highest Average Order Value:
*/

SELECT o.customer_id, c.customer_name, AVG(o.sale) AS average_order_value
FROM orders as o
JOIN 
customers as c 
ON o.customer_id = c.customer_id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;

