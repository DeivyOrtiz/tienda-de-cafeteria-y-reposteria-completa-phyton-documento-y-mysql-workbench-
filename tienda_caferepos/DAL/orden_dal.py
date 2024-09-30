from db_connection import create_connection

def insert_orden(orden):
    conn = create_connection()
    cursor = conn.cursor()
    sql = "INSERT INTO orden (idorden, fecha, total, fkidcliente, fkidempleado, fkidpago, estado) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(sql, orden)
    conn.commit()
    cursor.close()
    conn.close()

def update_orden(orden):
    conn = create_connection()
    cursor = conn.cursor()
    sql = "UPDATE orden SET fecha = %s, total = %s, fkidcliente = %s, fkidempleado = %s, fkidpago = %s, estado = %s WHERE idorden = %s"
    cursor.execute(sql, orden)
    conn.commit()
    cursor.close()
    conn.close()

def delete_orden(idorden):
    conn = create_connection()
    cursor = conn.cursor()
    sql = "DELETE FROM orden WHERE idorden = %s"
    cursor.execute(sql, (idorden,))
    conn.commit()
    cursor.close()
    conn.close()

def get_ordenes():
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM orden")
    ordenes = cursor.fetchall()
    cursor.close()
    conn.close()
    return ordenes 
