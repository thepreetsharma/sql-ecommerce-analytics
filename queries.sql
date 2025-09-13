-- Monthly Revenue
SELECT strftime('%Y-%m', order_date) AS month,
       SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- Best-Selling Products
SELECT p.name, SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY units_sold DESC;

-- Top Customers
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

-- New vs Returning Customers (SQLite-friendly)
WITH customer_order_counts AS (
    SELECT c.customer_id,
           COUNT(o.order_id) AS order_count
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)
SELECT
    CASE
        WHEN order_count = 0 THEN 'No Orders'
        WHEN order_count = 1 THEN 'New'
        ELSE 'Returning'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_order_counts
GROUP BY customer_type
ORDER BY customer_type;

-- Low Stock Products
SELECT p.name, i.stock_level
FROM inventory i
JOIN products p ON i.product_id = p.product_id
WHERE i.stock_level < 10
ORDER BY i.stock_level ASC;

-- Fraud Detection (Orders > mean + 2 * stddev) - SQLite-safe
WITH mean_cte AS (
    SELECT AVG(total_amount) AS mean
    FROM orders
),
stats AS (
    SELECT
        m.mean,
        CASE
            WHEN COUNT(*) > 0 
                 THEN SQRT(SUM((o.total_amount - m.mean) * (o.total_amount - m.mean)) / COUNT(*))
            ELSE 0
        END AS stddev,
        COUNT(*) AS n_rows
    FROM orders o
    CROSS JOIN mean_cte m
)
SELECT o.order_id, o.total_amount
FROM orders o
CROSS JOIN stats s
WHERE s.n_rows > 0
  AND o.total_amount > (s.mean + 2 * s.stddev)
ORDER BY o.total_amount DESC;

