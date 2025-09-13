import sqlite3
import pandas as pd

# Connect to your database
conn = sqlite3.connect("main.db")

# Get all table names
tables = conn.execute("SELECT name FROM sqlite_master WHERE type='table';").fetchall()

# Export each table to CSV
for table in tables:
    table_name = table[0]
    df = pd.read_sql_query(f"SELECT * FROM {table_name}", conn)
    df.to_csv(f"{table_name}.csv", index=False)
    print(f"Exported {table_name}.csv")

conn.close()
