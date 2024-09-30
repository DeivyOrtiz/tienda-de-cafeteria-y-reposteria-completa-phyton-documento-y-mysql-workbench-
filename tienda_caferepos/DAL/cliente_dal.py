from db_connection import DBConnection

class ClienteDAL:
    def __init__(self):
        self.db = DBConnection()

    def add_cliente(self, nombre, apellido, correo_electronico, telefono, direccion):
        connection = self.db.create_connection()
        cursor = connection.cursor()
        query = """INSERT INTO cliente (nombre, apellido, correo_electronico, telefono, direccion)
                   VALUES (%s, %s, %s, %s, %s)"""
        cursor.execute(query, (nombre, apellido, correo_electronico, telefono, direccion))
        connection.commit()
        cursor.close()
        connection.close()

    def update_cliente(self, idcliente, nombre, apellido, correo_electronico, telefono, direccion):
        connection = self.db.create_connection()
        cursor = connection.cursor()
        query = """UPDATE cliente 
                   SET nombre=%s, apellido=%s, correo_electronico=%s, telefono=%s, direccion=%s 
                   WHERE idcliente=%s"""
        cursor.execute(query, (nombre, apellido, correo_electronico, telefono, direccion, idcliente))
        connection.commit()
        cursor.close()
        connection.close()

    def delete_cliente(self, idcliente):
        connection = self.db.create_connection()
        cursor = connection.cursor()
        query = "DELETE FROM cliente WHERE idcliente = %s"
        cursor.execute(query, (idcliente,))
        connection.commit()
        cursor.close()
        connection.close()

    def get_all_clientes(self):
        connection = self.db.create_connection()
        cursor = connection.cursor()
        query = "SELECT idcliente, nombre, apellido, correo_electronico, telefono, direccion FROM cliente"
        cursor.execute(query)
        clientes = cursor.fetchall()
        cursor.close()
        connection.close()
        return clientes
