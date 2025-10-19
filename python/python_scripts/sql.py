# sql.py
import mysql.connector
from mysql.connector import Error

def connectDB():
    """Establish a MySQL database connection and return the connection object."""
    try:
        conn = mysql.connector.connect(
            host="data-management-server-2.cbxlqxkadwhn.us-east-1.rds.amazonaws.com",       
            user="KaterinaShvetsova",   
            password="ff4c56b129336d7fff5ffe82cd23024e9fc10e6e", 
            database="dbKaterinaShvetsova"
        )
        if conn.is_connected():
            print("✅ Connection successful")
            return conn
    except Error as e:
        print("❌ Error while connecting to MySQL:", e)
        return None
