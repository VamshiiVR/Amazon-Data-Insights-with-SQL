# Amazon Data Insights with SQL
Welcome to my deep dive into the Amazon e-commerce universe! This project is not just an exploration—it's a strategic analysis of a complex, data-rich environment akin to Amazon's vast operation. The analysis covers several key aspects of the business, including customer behavior, product performance, seller metrics, and overall sales trends. The queries provided solve specific business problems and provide actionable insights that can help drive decision-making.

**RDMBS:** Postgresql

**Approach:** Data Exploration 

# Highlights
- **Aggregations**: Functions like `SUM()`, `COUNT()`, and `AVG()` are heavily used to calculate total sales, order counts, return rates, and customer spend.
  
- **Ranking and Segmentation**: `RANK()` and `CASE` statements are employed to rank products and sellers, and segment customers based on different criteria such as sales volume or spending levels.

- **Time-based Filtering**: `WHERE` clauses with `INTERVAL` are applied to focus on recent data (e.g., orders within the past year or six months).

- **Joins**: Various types of joins (e.g., `INNER JOIN`, `LEFT JOIN`) are used to combine data from multiple tables, such as orders, customers, products, and returns.

- **Subqueries and CTEs**: Common Table Expressions (`WITH` clauses) and subqueries are used to organize complex calculations, like finding top-selling products by region or customer order trends.

- **Conditionals**: `HAVING` and `CASE` are used to filter results and categorize data based on specific conditions (e.g., identifying high-spending customers or top-ranked sellers).

- **Sorting and Limiting**: Results are ordered and limited using `ORDER BY` and `LIMIT` to focus on top performers, best-selling products, or specific customer behaviors.


# Database Schema
The database consists of the following tables:

**Customers:** Information about Amazon's customers, including customer ID, name, and contact details.

**Orders:** Data on all orders placed on the platform, including order ID, customer ID, product ID, order date, order amount, and seller ID.

**Products:** Details of the products available for sale, including product ID, product name, category, and price.

**Returns:** Records of products that have been returned by customers, including return ID, order ID, customer ID.

**Sellers:** Information about sellers on Amazon's platform, including seller ID, seller name.

![Amazon ERD](https://github.com/user-attachments/assets/2026fd46-1d96-4ca2-bf7c-07d0cf6eda9a)

# Scenarios and Approach
**Scenario 1:** Amazon's marketing team is planning a new loyalty rewards program and wants to 
target customers who have shown a high frequency of purchases. By identifying customers who 
have made more than five orders in the past year, the team can tailor exclusive offers or 
discounts to these loyal customers, encouraging further engagement and retention.

**Scenario 2:** Amazon is preparing for the holiday season and wants to optimize inventory levels. 
The operations team needs to know which products are the top sellers in each category to 
ensure they are well-stocked. This information helps in managing supply chain logistics 
and reducing the risk of stockouts during peak shopping periods.

**Scenario 3:** Amazon's customer analytics team is developing a new strategy for customer 
relationship management (CRM). They need to calculate the customer lifetime value (CLV) to 
segment customers based on their total spend. By understanding CLV, the team can focus marketing 
efforts on high-value customers, offering personalized deals to maximize long-term revenue

**Scenario 4:** Amazon is considering a new incentive program for third-party sellers on its 
platform. To determine which sellers should qualify for performance-based rewards, 
the e-commerce team needs to rank sellers by their total sales. This ranking helps 
in recognizing top performers and encouraging others to improve their sales.

**Scenario 5:** The sales analytics team at Amazon wants to analyze how sales fluctuate across 
different days of the week. This will help in optimizing marketing campaigns and inventory 
management.

**Scenario 6**: Amazon wants to evaluate how well different sellers are performing in various regions. 
This analysis will support decisions about regional promotions and logistics improvements.

**Scenario 7:** Amazon's customer experience team is trying to identify customers who are 
at risk of churning (i.e., stopping their purchases). They want to find customers who haven't 
placed an order in the last six months but were active before that period.

**Scenario 8:** Amazon’s marketing team wants to segment customers into different categories 
based on their total spending in the last year. This segmentation will help in creating 
personalized marketing campaigns.

**Scenario 9:** Amazon wants to know the top 5 best-selling products in each region to ensure they 
are well-stocked and to plan regional promotions.

**Scenario 10:** The retention team is looking to re-engage customers who haven’t placed any orders
in the last year. They need a list of such customers to target with special offers.

**Scenario 11:** The analytics team wants to examine how sales have trended over time for different
product categories. This will help them understand seasonal trends and plan marketing campaigns.

**Scenario 12:** By focusing on the highest and second-highest orders, Amazon can spot trends such 
as customers reducing their purchase amounts, which might signal a decline in their engagement.

**Scenario 13:** Amazon’s quality assurance team is interested in identifying products that have a 
high return rate so they can investigate potential quality issues.

**Scenario 14:** Amazon’s customer service team wants to identify the customer with the most returns. This 
information could be useful for investigating whether there are underlying issues, such as 
product quality problems or misunderstandings about how to use the products.

**Scenario 15:** Amazon’s marketing team wants to know which product categories generate the most 
sales so they can focus their advertising efforts on these categories.

**Scenario 16:**  Amazon’s premium services team is interested in identifying customers 
who have a high average order value, as these customers might be interested 
in premium memberships or exclusive offers.










































