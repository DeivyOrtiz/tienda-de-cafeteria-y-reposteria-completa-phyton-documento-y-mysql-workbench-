from DAL.cliente_dal import ClienteDAL

class ClienteBL:
    def __init__(self):
        self.cliente_dal = ClienteDAL()

    def agregar_cliente(self, nombre, apellido, correo_electronico, telefono, direccion):
        self.cliente_dal.add_cliente(nombre, apellido, correo_electronico, telefono, direccion)

    def modificar_cliente(self, idcliente, nombre, apellido, correo_electronico, telefono, direccion):
        self.cliente_dal.update_cliente(idcliente, nombre, apellido, correo_electronico, telefono, direccion)

    def eliminar_cliente(self, idcliente):
        self.cliente_dal.delete_cliente(idcliente)

    def obtener_todos_los_clientes(self):
        return self.cliente_dal.get_all_clientes()
