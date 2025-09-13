import sqlite3
from faker import Faker
import random
import datetime

# Setup
fake = Faker()
conn = sqlite3.connect("main.db")
cur = conn.cursor()

# Clear existing data
cur.execute("DELETE FROM order_items")
cur.execute("DELETE FROM orders")
cur.execute("DELETE FROM inventory")
cur.execute("DELETE FROM products")
cur.execute("DELETE FROM customers")
conn.commit()

# ---------------- Customers ----------------
regions = ["North", "South", "East", "West"]
for _ in range(100):
    cur.execute("""
        INSERT INTO customers (name, region, join_date)
        VALUES (?, ?, ?)
    """, (
        fake.name(),
        random.choice(regions),
        fake.date_between(start_date="-2y", end_date="today")
    ))

# ---------------- Products ----------------
categories = ["Electronics", "Clothing", "Home Appliances", "Sports", "Books"]
for _ in range(50):
    cur.execute("""
        INSERT INTO products (name, category, price)
        VALUES (?, ?, ?)
    """, (
        fake.word().capitalize(),
        random.choice(categories),
        round(random.uniform(10, 2000), 2)
    ))

# Get real customer IDs
customer_ids = [row[0] for row in cur.execute("SELECT customer_id FROM customers").fetchall()]

# Orders
for _ in range(300):
    customer_id = random.choice(customer_ids)   # ✅ always valid
    order_date = fake.date_between(start_date="-1y", end_date="today")
    total_amount = round(random.uniform(20, 5000), 2)
    cur.execute("""
        INSERT INTO orders (customer_id, order_date, total_amount)
        VALUES (?, ?, ?)
    """, (customer_id, order_date, total_amount))


# ---------------- Order Items ----------------
order_ids = [row[0] for row in cur.execute("SELECT order_id FROM orders").fetchall()]
product_ids = [row[0] for row in cur.execute("SELECT product_id FROM products").fetchall()]

for order_id in order_ids:
    for _ in range(random.randint(1, 4)):  # 1-4 items per order
        product_id = random.choice(product_ids)
        quantity = random.randint(1, 5)
        price = cur.execute("SELECT price FROM products WHERE product_id=?", (product_id,)).fetchone()[0]
        cur.execute("""
            INSERT INTO order_items (order_id, product_id, quantity, unit_price)
            VALUES (?, ?, ?, ?)
        """, (order_id, product_id, quantity, price))

# ---------------- Inventory ----------------
for product_id in product_ids:
    cur.execute("""
        INSERT INTO inventory (product_id, stock_level, last_updated)
        VALUES (?, ?, ?)
    """, (
        product_id,
        random.randint(0, 100),
        fake.date_between(start_date="-1y", end_date="today")
    ))


# Inject fraud orders (very high amounts)
for _ in range(5):
    cust_id = random.choice(customer_ids)
    cur.execute("""
        INSERT INTO orders (customer_id, order_date, total_amount)
        VALUES (?, ?, ?)
    """, (cust_id, fake.date_between(start_date="-6m", end_date="today"), random.randint(20000, 50000)))


# Commit + Close
conn.commit()
conn.close()

print("✅ Mock data generated: 100 customers, 50 products, 300 orders, order items, and inventory.")
