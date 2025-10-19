import sql   # this imports connectDB from sql.py
import csv

def main():
    conn = sql.connectDB()
    if conn:
        print("Connected:", conn.is_connected())

        # 👇 Example: check which database is active
        cursor = conn.cursor()
        cursor.execute("SELECT DATABASE();")
        db = cursor.fetchone()
        print("📂 Current database:", db[0])

        conn.close()

if __name__ == "__main__":
    main()
    
    import sql  # your sql.py file

def main():
    conn = sql.connectDB()
    if conn:
        try:
            print("Connected:", conn.is_connected())

            # ✅ Run your query here
            cursor = conn.cursor()
            cursor.execute("SHOW TABLES;")
            tables = cursor.fetchall()
            print("📂 Tables in the database:")
            for table in tables:
                print("🗂️", table[0])
            cursor.close()

        finally:
            conn.close()
            print("Connection closed ✅")

if __name__ == "__main__":
    main()
    

def export_all_tables_to_single_csv(filename="all_tables.csv"):
    conn = sql.connectDB()
    if conn:
        try:
            cursor = conn.cursor(buffered=True)  # ✅ buffered cursor
            cursor.execute("SHOW TABLES;")
            tables = cursor.fetchall()
            table_names = [table[0] for table in tables]

            with open(filename, "w", newline="", encoding="utf-8") as csvfile:
                writer = csv.writer(csvfile)

                for table_name in table_names:
                    writer.writerow([f"--- Table: {table_name} ---"])
                    
                    # Buffered cursor for each table
                    table_cursor = conn.cursor(buffered=True)
                    
                    # Get column names
                    table_cursor.execute(f"SELECT * FROM {table_name} LIMIT 0;")
                    columns = [i[0] for i in table_cursor.description]
                    writer.writerow(columns)

                    # Get all rows
                    table_cursor.execute(f"SELECT * FROM {table_name};")
                    rows = table_cursor.fetchall()
                    writer.writerows(rows)
                    writer.writerow([])  # empty line between tables

                    table_cursor.close()

            print(f"✅ All tables exported to {filename}")
            cursor.close()
        finally:
            conn.close()
            print("Connection closed ✅")

if __name__ == "__main__":
    export_all_tables_to_single_csv()



    
