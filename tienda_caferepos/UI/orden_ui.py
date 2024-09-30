import tkinter as tk
from tkinter import messagebox, ttk
from BL.business_logic import (
    agregar_orden,
    modificar_orden,
    eliminar_orden,
    listar_ordenes
)

class OrdenUI:
    def __init__(self, master):
        self.master = master
        self.master.title("Gestión de Órdenes")

        # Widgets
        self.tree = ttk.Treeview(master, columns=("ID", "Fecha", "Total", "Cliente", "Estado"), show='headings')
        self.tree.heading("ID", text="ID")
        self.tree.heading("Fecha", text="Fecha")
        self.tree.heading("Total", text="Total")
        self.tree.heading("Cliente", text="Cliente")
        self.tree.heading("Estado", text="Estado")
        self.tree.pack()

        self.entry_id = tk.Entry(master)
        self.entry_id.pack()
        tk.Label(master, text="Fecha").pack()
        self.entry_fecha = tk.Entry(master)
        self.entry_fecha.pack()
        tk.Label(master, text="Total").pack()
        self.entry_total = tk.Entry(master)
        self.entry_total.pack()
        tk.Label(master, text="Cliente ID").pack()
        self.entry_cliente_id = tk.Entry(master)
        self.entry_cliente_id.pack()
        tk.Label(master, text="Estado").pack()
        self.entry_estado = tk.Entry(master)
        self.entry_estado.pack()

        tk.Button(master, text="Agregar", command=self.agregar_orden).pack()
        tk.Button(master, text="Modificar", command=self.modificar_orden).pack()
        tk.Button(master, text="Eliminar", command=self.eliminar_orden).pack()
        tk.Button(master, text="Listar", command=self.listar_ordenes).pack()

    def agregar_orden(self):
        orden = (
            self.entry_id.get(),
            self.entry_fecha.get(),
            self.entry_total.get(),
            self.entry_cliente_id.get(),
            self.entry_estado.get()
        )
        agregar_orden(*orden)
        self.listar_ordenes()

    def modificar_orden(self):
        orden = (
            self.entry_fecha.get(),
            self.entry_total.get(),
            self.entry_cliente_id.get(),
            self.entry_estado.get(),
            self.entry_id.get()
        )
        modificar_orden(*orden)
        self.listar_ordenes()

    def eliminar_orden(self):
        eliminar_orden(self.entry_id.get())
        self.listar_ordenes()

    def listar_ordenes(self):
        for row in self.tree.get_children():
            self.tree.delete(row)
        ordenes = listar_ordenes()
        for orden in ordenes:
            self.tree.insert("", "end", values=orden)

if __name__ == "__main__":
    root = tk.Tk()
    app = OrdenUI(root)
    root.mainloop() 
