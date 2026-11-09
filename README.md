# Task 3: SQL for Data Analysis

## Project
Simple Ecommerce Database using MySQL 8.0+

## Objective
Use SQL queries to retrieve, filter, sort, group, join and analyze ecommerce data.

## Files
- `task3_ecommerce_analysis.sql` — creates the database and tables, inserts the sample data, and runs all required analysis queries.

## Database tables
1. `customers` — customer details
2. `products` — product names, categories and prices
3. `orders` — order dates and statuses
4. `order_items` — products and quantities in each order

## How to run
1. Install/open MySQL Workbench and connect to your MySQL server.
2. Choose **File > Open SQL Script**.
3. Open `task3_ecommerce_analysis.sql`.
4. Click the lightning bolt **Execute** button to run the complete script.
5. If needed, execute selected query blocks separately to view each result grid.

## SQL concepts demonstrated
- SELECT, WHERE and ORDER BY
- GROUP BY and COUNT
- SUM and AVG aggregate functions
- INNER JOIN, LEFT JOIN and RIGHT JOIN
- Subqueries
- CREATE VIEW
- CREATE INDEX

## Expected checks
- 5 customers, 5 products, 5 orders and 7 order-item rows are inserted.
- Average product price = 10,530.00
- Total order-item sales value = 56,400.00
- Customer Anita has 2 orders.
- Meena has no orders and appears in the LEFT/RIGHT JOIN customer results.
- The customer order summary view includes all 5 customers.

## Screenshots for submission
After running the SQL script in MySQL Workbench, take screenshots of:
1. The four tables or SELECT * results showing inserted sample data.
2. WHERE and ORDER BY results.
3. GROUP BY and SUM/AVG results.
4. INNER JOIN, LEFT JOIN and RIGHT JOIN results.
5. Subquery results.
6. The `customer_order_summary` view result.
7. Index creation statements and the final product-wise sales result.

Save the screenshots in a folder named `screenshots` and submit them with this SQL file.
