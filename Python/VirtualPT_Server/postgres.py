import psycopg2
from psycopg2 import sql
import os
from dotenv import load_dotenv

load_dotenv()

# PostgreSQL configuration
DB_HOST = os.getenv('DB_HOST')
DB_NAME = os.getenv('DB_NAME')
DB_USER = os.getenv('DB_USER')
DB_PASS = os.getenv('DB_PASS')

def get_db_connection():
    conn = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )
    return conn

def execute_query(query, params=None):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query, params)
        if cursor.description:  # If the query returns data
            results = cursor.fetchall()
        else:  # If the query is an INSERT/UPDATE/DELETE
            conn.commit()
            results = None
        cursor.close()
        conn.close()
        return results
    except (Exception, psycopg2.DatabaseError) as error:
        cursor.close()
        conn.close()
        raise error  # Raise the exception to be handled by the calling code