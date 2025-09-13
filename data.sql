-- Customers
INSERT INTO customers (name, region, join_date) VALUES
('Alice', 'North', '2023-01-15'),
('Bob', 'South', '2023-02-10'),
('Charlie', 'East', '2023-03-05'),
('Diana', 'West', '2023-04-12'),
('Ethan', 'North', '2023-06-20');

-- Products
INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 1000.00),
('Headphones', 'Electronics', 100.00),
('T-Shirt', 'Clothing', 20.00),
('Sneakers', 'Clothing', 80.00),
('Coffee Maker', 'Home Appliances', 150.00);

-- Orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-05-10', 1100.00),
(2, '2023-05-12', 100.00),
(3, '2023-06-01', 1000.00),
(4, '2023-06-15', 170.00),
(5, '2023-07-02', 120.00);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1000.00),
(1, 2, 1, 100.00),
(2, 2, 1, 100.00),
(3, 1, 1, 1000.00),
(4, 3, 2, 20.00),
(4, 5, 1, 150.00),
(5, 4, 1, 80.00),
(5, 3, 2, 20.00);

-- Inventory
INSERT INTO inventory (product_id, stock_level, last_updated) VALUES
(1, 5, '2023-07-01'),
(2, 15, '2023-07-01'),
(3, 50, '2023-07-01'),
(4, 8, '2023-07-01'),
(5, 2, '2023-07-01');
