import tkinter as tk
from tkinter import messagebox, ttk
from BL.business_logic import (
    agregar_producto,
    modificar_producto,
    eliminar_producto,
    listar_productos
)

class ProductoUI:
    def __init__(self, master):
        self.master = master
        self.master.title("Gestión de Productos")

        # Widgets
        self.tree = ttk.Treeview(master, columns=("ID", "Nombre", "Descripción", "Precio", "Categoría", "Stock"), show='headings')
        self.tree.heading("ID", text="ID")
        self.tree.heading("Nombre", text="Nombre")
        self.tree.heading("Descripción", text="Descripción")
        self.tree.heading("Precio", text="Precio")
        self.tree.heading("Categoría", text="Categoría")
        self.tree.heading("Stock", text="Stock")
        self.tree.pack()

        self.entry_id = tk.Entry(master)
        self.entry_id.pack()
        tk.Label(master, text="Nombre").pack()
        self.entry_nombre = tk.Entry(master)
        self.entry_nombre.pack()
        tk.Label(master, text="Descripción").pack()
        self.entry_descripcion = tk.Entry(master)
        self.entry_descripcion.pack()
        tk.Label(master, text="Precio").pack()
        self.entry_precio = tk.Entry(master)
        self.entry_precio.pack()
        tk.Label(master, text="Categoría").pack()
        self.entry_categoria = tk.Entry(master)
        self.entry_categoria.pack()
        tk.Label(master, text="Stock").pack()
        self.entry_stock = tk.Entry(master)
        self.entry_stock.pack()

        tk.Button(master, text="Agregar", command=self.agregar_producto).pack()
        tk.Button(master, text="Modificar", command=self.modificar_producto).pack()
        tk.Button(master, text="Eliminar", command=self.eliminar_producto).pack()
        tk.Button(master, text="Listar", command=self.listar_productos).pack()

    def agregar_producto(self):
        producto = (
            self.entry_id.get(),
            self.entry_nombre.get(),
            self.entry_descripcion.get(),
            self.entry_precio.get(),
            self.entry_categoria.get(),
            self.entry_stock.get()
        )
        agregar_producto(*producto)
        self.listar_productos()

    def modificar_producto(self):
        producto = (
            self.entry_nombre.get(),
            self.entry_descripcion.get(),
            self.entry_precio.get(),
            self.entry_categoria.get(),
            self.entry_stock.get(),
            self.entry_id.get()
        )
        modificar_producto(*producto)
        self.listar_productos()

    def eliminar_producto(self):
        eliminar_producto(self.entry_id.get())
        self.listar_productos()

    def listar_productos(self):
        for row in self.tree.get_children():
            self.tree.delete(row)
        productos = listar_productos()
        for producto in productos:
            self.tree.insert("", "end", values=producto)

if __name__ == "__main__":
    root = tk.Tk()
    app = ProductoUI(root)
    root.mainloop() 
