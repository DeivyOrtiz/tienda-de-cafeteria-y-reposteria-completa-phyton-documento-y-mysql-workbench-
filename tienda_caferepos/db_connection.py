import mysql.connector

class DBConnection:
    def create_connection(self):
        connection = mysql.connector.connect(
            host='localhost',
            user='DEIVY',
            password='2003',
            database='tienda_cafeteria_pasteleria'
        )
        return connection
