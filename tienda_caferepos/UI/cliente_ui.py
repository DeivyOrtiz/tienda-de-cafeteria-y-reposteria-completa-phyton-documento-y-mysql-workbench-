import tkinter as tk
from tkinter import ttk, messagebox
from BL.business_logic import ClienteBL

class ClienteUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Gestión de Clientes")

        self.cliente_bl = ClienteBL()

        # Frame para botones
        self.button_frame = tk.Frame(self.root)
        self.button_frame.pack(pady=10)

        # Botones
        self.btn_agregar = tk.Button(self.button_frame, text="Agregar Cliente", command=self.agregar_cliente)
        self.btn_agregar.grid(row=0, column=0, padx=10)

        self.btn_modificar = tk.Button(self.button_frame, text="Modificar Cliente", command=self.modificar_cliente)
        self.btn_modificar.grid(row=0, column=1, padx=10)

        self.btn_eliminar = tk.Button(self.button_frame, text="Eliminar Cliente", command=self.eliminar_cliente)
        self.btn_eliminar.grid(row=0, column=2, padx=10)

        self.btn_mostrar = tk.Button(self.button_frame, text="Mostrar Clientes", command=self.mostrar_clientes)
        self.btn_mostrar.grid(row=0, column=3, padx=10)

        # Tabla para mostrar clientes
        self.tree = ttk.Treeview(self.root, columns=("ID", "Nombre", "Apellido", "Correo", "Teléfono", "Dirección"), show="headings")
        self.tree.heading("ID", text="ID")
        self.tree.heading("Nombre", text="Nombre")
        self.tree.heading("Apellido", text="Apellido")
        self.tree.heading("Correo", text="Correo Electrónico")
        self.tree.heading("Teléfono", text="Teléfono")
        self.tree.heading("Dirección", text="Dirección")
        self.tree.pack(pady=20)

    def agregar_cliente(self):
        self.popup_cliente("Agregar Cliente")

    def modificar_cliente(self):
        selected_item = self.tree.selection()
        if selected_item:
            item = self.tree.item(selected_item)
            cliente_data = item['values']
            self.popup_cliente("Modificar Cliente", cliente_data)
        else:
            messagebox.showwarning("Advertencia", "Selecciona un cliente para modificar")

    def eliminar_cliente(self):
        selected_item = self.tree.selection()
        if selected_item:
            item = self.tree.item(selected_item)
            cliente_id = item['values'][0]
            self.cliente_bl.eliminar_cliente(cliente_id)
            messagebox.showinfo("Información", "Cliente eliminado exitosamente")
            self.mostrar_clientes()
        else:
            messagebox.showwarning("Advertencia", "Selecciona un cliente para eliminar")

    def mostrar_clientes(self):
        for row in self.tree.get_children():
            self.tree.delete(row)
        clientes = self.cliente_bl.obtener_todos_los_clientes()
        for cliente in clientes:
            self.tree.insert('', 'end', values=cliente)

    def popup_cliente(self, title, cliente_data=None):
        popup = tk.Toplevel(self.root)
        popup.title(title)

        # Campos de entrada
        tk.Label(popup, text="Nombre:").grid(row=0, column=0, padx=10, pady=5)
        nombre_entry = tk.Entry(popup)
        nombre_entry.grid(row=0, column=1, padx=10, pady=5)

        tk.Label(popup, text="Apellido:").grid(row=1, column=0, padx=10, pady=5)
        apellido_entry = tk.Entry(popup)
        apellido_entry.grid(row=1, column=1, padx=10, pady=5)

        tk.Label(popup, text="Correo:").grid(row=2, column=0, padx=10, pady=5)
        correo_entry = tk.Entry(popup)
        correo_entry.grid(row=2, column=1, padx=10, pady=5)

        tk.Label(popup, text="Teléfono:").grid(row=3, column=0, padx=10, pady=5)
        telefono_entry = tk.Entry(popup)
        telefono_entry.grid(row=3, column=1, padx=10, pady=5)

        tk.Label(popup, text="Dirección:").grid(row=4, column=0, padx=10, pady=5)
        direccion_entry = tk.Entry(popup)
        direccion_entry.grid(row=4, column=1, padx=10, pady=5)

        # Si hay datos (en caso de modificación), rellenar los campos
        if cliente_data:
            nombre_entry.insert(0, cliente_data[1])
            apellido_entry.insert(0, cliente_data[2])
            correo_entry.insert(0, cliente_data[3])
            telefono_entry.insert(0, cliente_data[4])
            direccion_entry.insert(0, cliente_data[5])

        # Botón de guardar
        def guardar():
            nombre = nombre_entry.get()
            apellido = apellido_entry.get()
            correo = correo_entry.get()
            telefono = telefono_entry.get()
            direccion = direccion_entry.get()

            if cliente_data:
                idcliente = cliente_data[0]
                self.cliente_bl.modificar_cliente(idcliente, nombre, apellido, correo, telefono, direccion)
                messagebox.showinfo("Información", "Cliente modificado exitosamente")
            else:
                self.cliente_bl.agregar_cliente(nombre, apellido, correo, telefono, direccion)
                messagebox.showinfo("Información", "Cliente agregado exitosamente")

            popup.destroy()
            self.mostrar_clientes()

        btn_guardar = tk.Button(popup, text="Guardar", command=guardar)
        btn_guardar.grid(row=5, column=0, columnspan=2, pady=10)










