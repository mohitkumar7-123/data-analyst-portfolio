-- ====================
-- DATABASE SETUP & TABLES
-- ====================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

-- PRODUCTS TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    current_stock INT,
    reorder_level INT
);

-- ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    price DECIMAL(10,2),
    payment_status VARCHAR(20),
    shipping_method VARCHAR(50),
    promised_date DATE,
    ship_date DATE,
    employee_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- EMPLOYEES TABLE
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    hire_date DATE
);

-- TRANSACTIONS TABLE
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    transaction_date DATE,
    transaction_type VARCHAR(50),
    merchant_city VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ====================
-- SAMPLE DATA INSERTION
-- ====================

-- INSERT CUSTOMERS
INSERT INTO customers VALUES
(1, 'Aarav Sharma', 'aarav@email.com', 'Mumbai', '2023-01-15'),
(2, 'Priya Patel', 'priya@email.com', 'Delhi', '2023-02-20'),
(3, 'Rohan Kumar', 'rohan@email.com', 'Bangalore', '2023-03-10'),
(4, 'Neha Singh', 'neha@email.com', 'Mumbai', '2023-01-25'),
(5, 'Vikram Reddy', 'vikram@email.com', 'Hyderabad', '2023-04-05'),
(6, 'Ananya Gupta', 'ananya@email.com', 'Delhi', '2023-02-28'),
(7, 'Arjun Joshi', 'arjun@email.com', 'Mumbai', '2023-03-15'),
(8, 'Sneha Malhotra', 'sneha@email.com', 'Chennai', '2023-05-01');

-- INSERT PRODUCTS
INSERT INTO products VALUES
(101, 'iPhone 14', 'Electronics', 79999, 65000, 50, 10),
(102, 'Samsung Galaxy', 'Electronics', 69999, 58000, 30, 5),
(103, 'Nike Shoes', 'Fashion', 5999, 4500, 100, 20),
(104, 'Adidas T-Shirt', 'Fashion', 1999, 1200, 200, 50),
(105, 'MacBook Pro', 'Electronics', 199999, 165000, 20, 5),
(106, 'Dell Laptop', 'Electronics', 89999, 75000, 40, 10),
(107, 'Levi Jeans', 'Fashion', 2999, 1800, 150, 30),
(108, 'Woodland Shoes', 'Fashion', 4999, 3500, 80, 15);

-- INSERT EMPLOYEES
INSERT INTO employees VALUES
(501, 'Rajesh Kumar', 'Sales', '2022-01-15'),
(502, 'Sneha Verma', 'Sales', '2022-03-20'),
(503, 'Amit Singh', 'Operations', '2021-11-10');

-- INSERT ORDERS
INSERT INTO orders VALUES
(1001, 1, 101, '2024-01-15', 1, 79999, 'Paid', 'Express', '2024-01-18', '2024-01-17', 501),
(1002, 2, 103, '2024-01-16', 2, 5999, 'Paid', 'Standard', '2024-01-22', '2024-01-20', 502),
(1003, 3, 105, '2024-01-17', 1, 199999, 'Pending', 'Express', '2024-01-20', '2024-01-19', 501),
(1004, 4, 102, '2024-01-18', 1, 69999, 'Paid', 'Standard', '2024-01-25', '2024-01-23', 503),
(1005, 5, 107, '2024-01-19', 3, 2999, 'Paid', 'Express', '2024-01-22', '2024-01-21', 502),
(1006, 6, 104, '2024-01-20', 5, 1999, 'Paid', 'Standard', '2024-01-27', '2024-01-25', 501),
(1007, 7, 106, '2024-01-21', 1, 89999, 'Paid', 'Express', '2024-01-24', '2024-01-23', 503),
(1008, 8, 108, '2024-01-22', 2, 4999, 'Pending', 'Standard', '2024-01-29', '2024-01-28', 502),
(1009, 1, 103, '2024-02-01', 1, 5999, 'Paid', 'Standard', '2024-02-06', '2024-02-05', 501),
(1010, 2, 101, '2024-02-02', 1, 79999, 'Paid', 'Express', '2024-02-05', '2024-02-04', 502);

-- INSERT TRANSACTIONS
INSERT INTO transactions VALUES
(2001, 1, 79999, '2024-01-15', 'Purchase', 'Mumbai'),
(2002, 2, 11998, '2024-01-16', 'Purchase', 'Delhi'),
(2003, 1, 5999, '2024-02-01', 'Purchase', 'Mumbai'),
(2004, 2, 79999, '2024-02-02', 'Purchase', 'Delhi'),
(2005, 3, 199999, '2024-01-17', 'Purchase', 'Bangalore'),
(2006, 4, 69999, '2024-01-18', 'Purchase', 'Mumbai'),
(2007, 5, 8997, '2024-01-19', 'Purchase', 'Hyderabad'),
(2008, 6, 9995, '2024-01-20', 'Purchase', 'Delhi'),
(2009, 7, 89999, '2024-01-21', 'Purchase', 'Mumbai'),
(2010, 8, 9998, '2024-01-22', 'Purchase', 'Chennai'),
(2011, 1, 50000, '2024-01-23', 'Refund', 'Mumbai'),
(2012, 2, 20000, '2024-01-24', 'Refund', 'Delhi');

-- ====================
-- SALES ANALYSIS QUERIES
-- ====================

-- Top 5 Products by Revenue
SELECT p.product_name,
SUM(o.quantity* o.price) AS total_revenue
FROM orders o 
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name 
ORDER BY SUM(o.quantity * o.price) DESC
LIMIT 5;

-- Monthly Sales Trend
SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(quantity * price) AS monthly_revenue
FROM orders
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- Daily Revenue Report
SELECT 
    DATE(order_date) as day,
    SUM(quantity * price) as daily_revenue,
    COUNT(DISTINCT order_id) as order_count,
    ROUND(AVG(quantity * price), 2) as avg_order_value
FROM orders
GROUP BY DATE(order_date)
ORDER BY day DESC;

-- ====================
-- CUSTOMER ANALYTICS QUERIES
-- ====================

-- Customer Lifetime Value
SELECT 
c.customer_id,c.customer_name,
COUNT(DISTINCT order_id) as total_order,
ROUND(SUM(quantity * price),1) as total_spent,
ROUND(AVG(quantity * price),1) as avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id,c.customer_id 
ORDER BY total_spent DESC;

-- High Value Customers (top 10%)
WITH customer_stats AS (
    SELECT
        customer_id,
        SUM(quantity * price) as total_spent,
        NTILE(10) OVER (ORDER BY SUM(quantity * price) DESC) as percentile
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, total_spent
FROM customer_stats
WHERE percentile = 1;

-- Customer Geographic Distribution
SELECT 
    c.city,
    COUNT(DISTINCT o.customer_id) as customer_count,
    ROUND(SUM(o.quantity * o.price),1) as total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- NEW VS RETURNING CUSTOMER 
WITH customer_first_orders AS (
    SELECT
        customer_id,
        MIN(order_date) as first_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT
    TO_CHAR(o.order_date, 'YYYY-MM') as month,
    COUNT(DISTINCT o.customer_id) as total_customers,
    COUNT(DISTINCT CASE WHEN o.order_date = cfo.first_order_date THEN o.customer_id END) as new_customers,
    COUNT(DISTINCT CASE WHEN o.order_date > cfo.first_order_date THEN o.customer_id END) as returning_customers
FROM orders o
JOIN customer_first_orders cfo ON o.customer_id = cfo.customer_id
GROUP BY TO_CHAR(o.order_date, 'YYYY-MM')
ORDER BY month;

-- Customer Payment Behavior
SELECT 
    customer_id,
    COUNT(*) as total_orders,
    SUM(CASE WHEN payment_status = 'Paid' THEN 1 ELSE 0 END) as paid_orders,
    SUM(CASE WHEN payment_status = 'Pending' THEN 1 ELSE 0 END) as pending_orders,
    ROUND((SUM(CASE WHEN payment_status = 'Paid' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as payment_success_rate
FROM orders
GROUP BY customer_id
ORDER BY payment_success_rate ASC;

-- ====================
-- FRAUD DETECTION QUERIES
-- ====================

-- LARGE TRANSACTION ALERT 
SELECT 
    transaction_id,
    customer_id,
    amount,
    transaction_date
FROM transactions
WHERE amount > (SELECT AVG(amount) * 3 FROM transactions)
ORDER BY amount DESC;

-- Rapid Successive Transactions
SELECT 
    customer_id,
    COUNT(*) as transactions_count,
    SUM(amount) as total_amount
FROM transactions
GROUP BY customer_id
HAVING COUNT(*) > 3
ORDER BY transactions_count DESC;

-- ====================
-- INVENTORY MANAGEMENT QUERIES
-- ====================

-- INVENTORY MANAGEMENT 
SELECT 
    product_name,
    current_stock,
    reorder_level
FROM products
WHERE current_stock <= reorder_level
ORDER BY current_stock ASC;

-- Slow Moving Products
SELECT  
p.product_name,  
p.current_stock,  
COUNT(o.order_id) as times_ordered  
FROM products p  
LEFT JOIN orders o ON p.product_id = o.product_id  
WHERE o.order_date >= CURRENT_DATE - INTERVAL '90 DAYS'  
GROUP BY p.product_id, p.product_name, p.current_stock  
HAVING COUNT(o.order_id) < 5  
ORDER BY times_ordered ASC;

-- Inventory Turnover Ratio
SELECT 
    p.product_name,
    p.current_stock,
    COALESCE(SUM(o.quantity), 0) as units_sold,
    CASE 
        WHEN p.current_stock > 0 THEN COALESCE(SUM(o.quantity), 0) / p.current_stock 
        ELSE 0 
    END as turnover_ratio
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '30 DAYS' OR o.order_id IS NULL
GROUP BY p.product_id, p.product_name, p.current_stock
ORDER BY turnover_ratio DESC;

-- ====================
-- FINANCIAL ANALYSIS QUERIES
-- ====================

-- Profit Margin by Product
SELECT 
    p.product_name,
    COALESCE(SUM(o.quantity * o.price), 0) as total_revenue,
    COALESCE(SUM(o.quantity * p.cost_price), 0) as total_cost,
    COALESCE(SUM(o.quantity * o.price) - SUM(o.quantity * p.cost_price), 0) as total_profit,
    CASE 
        WHEN COALESCE(SUM(o.quantity * o.price), 0) > 0 
        THEN ROUND(((COALESCE(SUM(o.quantity * o.price), 0) - COALESCE(SUM(o.quantity * p.cost_price), 0)) / COALESCE(SUM(o.quantity * o.price), 0)) * 100, 2)
        ELSE 0 
    END as profit_margin
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY profit_margin DESC;

-- ====================
-- OPERATIONAL EFFICIENCY QUERIES
-- ====================

-- Employee Performance
SELECT 
    e.employee_name,
    COUNT(o.order_id) as orders_processed,
    COALESCE(SUM(o.quantity * o.price), 0) as revenue_generated,
    ROUND(AVG(DATE_PART('day', o.ship_date - o.order_date)), 2) as avg_processing_days
FROM employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.employee_name
ORDER BY revenue_generated DESC;

-- SHIPPING EFFICIENCY 
SELECT 
    shipping_method,
    COUNT(*) as total_orders,
    ROUND(AVG(DATE_PART('day', ship_date - order_date)), 2) as avg_shipping_days,
    SUM(CASE WHEN ship_date > promised_date THEN 1 ELSE 0 END) as delayed_orders,
    ROUND((SUM(CASE WHEN ship_date > promised_date THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as delay_percentage
FROM orders
GROUP BY shipping_method
ORDER BY avg_shipping_days ASC;

-- ====================
-- PRODUCT PERFORMANCE QUERIES
-- ====================

-- Product Never Sold 
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.product_id IS NULL;

-- ====================
-- CUSTOMER RETENTION QUERIES
-- ====================

-- CUSTOMER RETENTION RATE
CREATE TEMPORARY TABLE first_orders AS
SELECT 
    customer_id,
    MIN(order_date) as first_order_date,
    EXTRACT(YEAR FROM MIN(order_date)) as first_year
FROM orders
GROUP BY customer_id;

CREATE TEMPORARY TABLE orders_with_year AS
SELECT 
    *,
    EXTRACT(YEAR FROM order_date) as order_year
FROM orders;

SELECT
    f.first_year,
    COUNT(DISTINCT f.customer_id) AS total_customers,
    COUNT(DISTINCT o.customer_id) AS retained_customers,
    ROUND((COUNT(DISTINCT o.customer_id) * 100.0 / COUNT(DISTINCT f.customer_id)), 2) AS retention_rate
FROM first_orders f
LEFT JOIN orders_with_year o
    ON f.customer_id = o.customer_id
    AND o.order_year = f.first_year + 1
GROUP BY f.first_year
ORDER BY f.first_year;
