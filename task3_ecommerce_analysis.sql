-- TASK 3: SQL FOR DATA ANALYSIS
-- Dataset: Simple Ecommerce Database
-- Tool: MySQL 8.0+
-- Run this complete file in MySQL Workbench.

CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

-- 1. Create tables
DROP VIEW IF EXISTS customer_order_summary;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(40),
    email VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(60) NOT NULL,
    category VARCHAR(40),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. Insert sample data
INSERT INTO customers VALUES
(1, 'Anita', 'Hyderabad', 'anita@email.com'),
(2, 'Rahul', 'Warangal', 'rahul@email.com'),
(3, 'Priya', 'Hyderabad', 'priya@email.com'),
(4, 'Kiran', 'Karimnagar', 'kiran@email.com'),
(5, 'Meena', 'Nizamabad', 'meena@email.com');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 45000.00),
(102, 'Headphones', 'Electronics', 1500.00),
(103, 'Office Chair', 'Furniture', 5500.00),
(104, 'Notebook Pack', 'Stationery', 250.00),
(105, 'Water Bottle', 'Accessories', 400.00);

INSERT INTO orders VALUES
(1001, 1, '2026-01-05', 'Delivered'),
(1002, 2, '2026-01-08', 'Delivered'),
(1003, 1, '2026-01-12', 'Pending'),
(1004, 3, '2026-01-15', 'Delivered'),
(1005, 4, '2026-01-20', 'Cancelled');

INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1001, 102, 2),
(3, 1002, 103, 1),
(4, 1003, 104, 5),
(5, 1004, 102, 1),
(6, 1004, 105, 2),
(7, 1005, 104, 3);

-- 3. SELECT: Display all customers
SELECT * FROM customers;

-- 4. WHERE: Find products costing more than 1000
SELECT product_name, category, price
FROM products
WHERE price > 1000;

-- 5. ORDER BY: Show products from highest to lowest price
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- 6. GROUP BY: Count customers in each city
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city;

-- 7. Aggregate functions: SUM and AVG
SELECT
    SUM(p.price * oi.quantity) AS total_sales_value,
    AVG(p.price) AS average_product_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 8. INNER JOIN: Show orders with customer names
SELECT o.order_id, c.customer_name, o.order_date, o.status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- 9. LEFT JOIN: Show all customers, including customers without orders
SELECT c.customer_name, o.order_id, o.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

-- 10. RIGHT JOIN: Show all customers and their orders (including unmatched customers)
-- MySQL supports RIGHT JOIN.
SELECT c.customer_name, o.order_id, o.status
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_id;

-- 11. Subquery: Find products priced above the average product price
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 12. Subquery: Find customers who have placed at least one order
SELECT customer_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- 13. Create a view for customer-wise order analysis
CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(p.price * oi.quantity), 0) AS order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name, c.city;

-- Display the view
SELECT * FROM customer_order_summary
ORDER BY customer_id;

-- 14. Indexes: Improve searching and joining on commonly used columns
CREATE INDEX idx_customers_city ON customers(city);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Example query that can benefit from the city index
SELECT customer_name, city
FROM customers
WHERE city = 'Hyderabad';

-- 15. Final analysis: Sales value by product
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(p.price * oi.quantity) AS sales_value
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY sales_value DESC;
