from db_connection import create_connection

def insert_producto(producto):
    conn = create_connection()
    cursor = conn.cursor()
    sql = "INSERT INTO producto (idproducto, nombre, descripcion, precio, fkidcategoria, stock_disponible) VALUES (%s, %s, %s, %s, %s, %s)"
    cursor.execute(sql, producto)
    conn.commit()
    cursor.close()
    conn.close()

def update_producto(producto):
    conn = create_connection()
    cursor = conn.cursor()
    sql = "UPDATE producto SET nombre = %s, descripcion = %s, precio = %s, fkidcategoria = %s, stock_disponible = %s WHERE idproducto = %s"
    cursor.execute(sql, producto)
    conn.commit()
    cursor.close()
    conn.close()

def delete_producto(idproducto):
    conn = create_connection()
    cursor = conn.cursor()
    sql = "DELETE FROM producto WHERE idproducto = %s"
    cursor.execute(sql, (idproducto,))
    conn.commit()
    cursor.close()
    conn.close()

def get_productos():
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM producto")
    productos = cursor.fetchall()
    cursor.close()
    conn.close()
    return productos 
