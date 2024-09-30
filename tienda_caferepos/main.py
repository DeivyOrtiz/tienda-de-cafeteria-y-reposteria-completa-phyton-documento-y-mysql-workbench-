import tkinter as tk
from UI.cliente_ui import ClienteUI

if __name__ == "__main__":
    root = tk.Tk()
    app = ClienteUI(root)
    root.mainloop()
