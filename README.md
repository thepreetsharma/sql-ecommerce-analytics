# 🏪 S-Mart SQL Analytics (SQLite Project)

This project simulates a **retail business database** for S-Mart and demonstrates how to design a relational schema, load data, and extract **business insights** using SQL. The project is built with **SQLite**, making it lightweight and portable, and is also ready to connect with **Power BI/Tableau** for dashboards.

---

## 📂 Project Structure

s-mart-sql-analytics/
│── main.db # SQLite database file (created after running schema + data)
│── schema.sql # Database schema (tables + relationships)
│── data.sql # Sample dataset inserts (customers, products, orders, etc.)
│── queries.sql # Business analytics queries (KPIs & insights)
│── README.md # Project documentation


---

## 🗄️ Database Schema

The database consists of **5 interconnected tables**:

1. **customers** – who is shopping  
   - Columns: `customer_id`, `name`, `region`, `join_date`  
   - Primary Key: `customer_id`  

2. **products** – what is being sold  
   - Columns: `product_id`, `name`, `category`, `price`  
   - Primary Key: `product_id`  

3. **orders** – purchase details  
   - Columns: `order_id`, `customer_id`, `order_date`, `total_amount`  
   - Primary Key: `order_id`  
   - Foreign Key: `customer_id → customers(customer_id)`  

4. **order_items** – items inside each order  
   - Columns: `order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`  
   - Primary Key: `order_item_id`  
   - Foreign Keys:  
     - `order_id → orders(order_id)`  
     - `product_id → products(product_id)`  

5. **inventory** – stock tracking  
   - Columns: `product_id`, `stock_level`, `last_updated`  
   - Primary Key: `product_id`  
   - Foreign Key: `product_id → products(product_id)`  

---

## 🔑 Relationships

- **One customer** → can place **many orders**  
- **One order** → can contain **many products** (via order_items)  
- **One product** → can appear in **many orders**  
- **One product** → has exactly **one inventory record**  

📌 **Schema Flow:**  
`customers → orders → order_items → products → inventory`

---

## 📊 Example Business Queries

Some of the key insights included in `queries.sql`:

- **Monthly Revenue** – trend of total sales by month  
- **Best-Selling Products** – most popular items by units sold  
- **Top Customers** – customers contributing the most revenue  
- **New vs Returning Customers** – customer loyalty analysis  
- **Low Stock Products** – items that need restocking  
- **Fraud Detection** – unusually large orders (2 std. dev. above average)  

---

## 🚀 How to Run

1. Open VS Code (with SQLite extension) or DB Browser for SQLite.  
2. Run `schema.sql` → creates tables in `main.db`.  
3. Run `data.sql` → loads sample dataset.  
4. Run queries from `queries.sql` → generate insights.  
5. (Optional) Connect `main.db` to **Power BI/Tableau** for interactive dashboards.  

---

## 📈 Portfolio Value

This project demonstrates:  
- **Database design skills** (schema + relationships)  
- **SQL expertise** (data analysis & business KPIs)  
- **ETL workflow** (schema → data → queries)  
- **Dashboard readiness** (Power BI integration)  

---

## 📌 Next Steps (Optional Enhancements)

- Expand dataset to **50–100+ rows** across multiple months/customers  
- Add **indexes** for performance optimization  
- Connect with Python (Pandas/SQLite3) for additional analysis  
- Build interactive **Power BI dashboard**  

---

## 📷 ER Diagram


<img width="1536" height="1024" alt="ER diagram for S-Mart SQL Analytics" src="https://github.com/user-attachments/assets/9bc3094b-3b1c-4c71-9b73-a80570f28eec" />

