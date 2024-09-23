create database tienda_cafeteria_pasteleria;
use tienda_cafeteria_pasteleria;

-- tabla de cliente 
create table cliente
(
idcliente int not null primary key,
nombre varchar(100) not null,
apellido varchar(100) not null,
correo_electronico varchar(100) not null,
telefono varchar(20) not null
);
alter table cliente add direccion varchar(255) null;
drop table cliente;
truncate cliente;
rename table cliente TO CLIENTE;

-- tabla de empleado
create table empleado
(
idempleado int not null primary key,
nombre varchar(100) not null,
apellido varchar(100) not null,
correo_electronico varchar(100) not null,
telefono varchar(20) not null
);
alter table empleado add cargo varchar(100) not null;
drop table empleado;
truncate empleado;
rename table empleado TO EMPLEADO;

-- tabla de pago
create table pago
(
idpago int not null primary key,
metodo_pago varchar(50) not null,
monto decimal (10,2) not null
);
alter table pago add fecha_pago datetime not null;
drop table pago;
truncate pago;
rename table pago TO PAGO;

-- tabla de orden relacionado con cliente, empleado y pago
create table orden
(
idorden int not null primary key,
fecha datetime not null,
total decimal(10,2) not null,
fkidcliente int not null,
fkidempleado int not null,
fkidpago int not null,
foreign key(fkidcliente)references cliente(idcliente),
foreign key(fkidempleado)references empleado(idempleado),
foreign key(fkidpago)references pago(idpago)
);
alter table orden add estado varchar(50) not null;
drop table orden;
truncate orden;
rename table orden TO ORDEN;

-- tabla de categoria
create table categoria
(
idcategoria int not null primary key,
nombre varchar(100) not null
);
alter table categoria add descripcion text null;
drop table categoria;
truncate categoria;
rename table categoria TO CATEGORIA;

-- tabla promocion relacionado con producto y producto_promocion
create table promocion
(
idpromocion int not null primary key
);
alter table promocion add nombre varchar(100) not null;
drop table promocion;
truncate promocion;
rename table promocion TO PROMOCION;

-- tabla de producto relacionado con orden, detalle_orden, categoria, inventario, producto, producto_promocion, receta y producto_receta 
create table producto
(
idproducto int not null primary key,
nombre varchar(100) not null,
descripcion text null,
precio decimal (10,2) not null,
fkidcategoria int not null,
foreign key(fkidcategoria)references categoria(idcategoria)
);
alter table producto add stock_disponible int not null;
drop table producto;
truncate producto;
rename table producto TO PRODUCTO;

-- tabla de proveedor relacionado con producto y producto_proveedor
create table proveedor
(
idproveedor int not null primary key,
nombre varchar(100) not null,
telefono varchar(20) not null,
correo_electronico varchar(100) not null
);
alter table proveedor add direccion text null;
drop table proveedor;
truncate proveedor;
rename table proveedor TO PROVEEDOR;

-- tabla de producto_proveedor relacionado con producto y proveedor
create table producto_proveedor
(
id_producto_proveedor int not null,
precio_compra decimal(10,2) not null,
fecha_suministro date not null,
fkidproducto int not null,
fkidproveedor int not null,
foreign key(fkidproducto)references producto(idproducto),
foreign key(fkidproveedor)references proveedor(idproveedor)
);
alter table producto_proveedor add cantidad_suministrada int not null;
drop table producto_proveedor;
truncate producto_proveedor;
rename table producto_proveedor TO PRODUTO_PROVEEDOR;

-- tabla producto_promocion relacionado con promocion y producto
create table producto_promocion
(
idproducto_promocion int not null,
descuento decimal(5,2) not null,
fecha_inicio datetime not null,
fecha_fin datetime not null,
fkidproducto int not null,
fkidpromocion int not null,
foreign key(fkidproducto)references producto(idproducto),
foreign key(fkidpromocion)references promocion(idpromocion)
);
alter table producto_promocion add estado varchar(50) not null;
drop table producto_promocion;
truncate producto_promocion;
rename table producto_promocion TO PRODUTO_PROMOCION;

-- tabla de receta relacionado con producto y producto_receta
create table receta
(
idreceta int not null primary key,
nombre varchar(100) not null,
descripcion text
);
alter table receta add instrucciones text null;
drop table receta;
truncate receta;
rename table receta TO RECETA;

-- tabla de ingrediente relacionado receta y receta_ingrediente
create table ingrediente
(
idingrediente int not null primary key,
nombre varchar(100) not null
);
alter table ingrediente add descripcion text null;
drop table ingrediente;
truncate ingrediente;
rename table ingrediente TO INGREDIENTE;

-- tabla de receta_ingrediente relacionado con receta y ingrediente
create table receta_ingrediente
(
idreceta_ingrediente int not null,
fkidreceta int not null,
fkidingrediente int not null,
foreign key(fkidreceta)references receta(idreceta),
foreign key(fkidingrediente)references ingrediente(idingrediente)
);
alter table receta_ingrediente add cantidad_necesaria decimal(10,2) not null;
drop table receta_ingrediente;
truncate receta_ingrediente;
rename table receta_ingrediente TO RECETA_INGREDIENTE;

-- tabla producto_receta relacionado con producto y receta
create table producto_receta
(
id_producto_receta int not null,
cantidad_producto int not null,
unidad_medida varchar(50) not null,
fkidproducto int not null,
fkidreceta int not null,
foreign key(fkidproducto)references producto(idproducto),
foreign key(fkidreceta)references receta(idreceta)
);
alter table producto_receta add instrucciones_adicionales text null;
drop table producto_receta;
truncate producto_receta;
rename table producto_receta TO PRODUCTO_RECETA;


-- tabla de inventario relacionado con producto
create table inventario
(
fkidinventario int not null primary key,
cantidad_disponible int not null,
foreign key(fkidinventario)references producto(idproducto)
);
alter table inventario add fecha_ultima_actualizacion date not null;
drop table inventario;
truncate inventario;
rename table inventario TO INVENTARIO;

-- tabla de detalle_orden relacionado con orden y producto
create table detalle_orden
(
iddetalle_orden int not null,
cantidad int not null,
precio_unitario decimal(10,2) not null,
fkidorden int not null,
fkidproducto int not null,
foreign key(fkidorden)references orden(idorden),
foreign key(fkidproducto)references producto(idproducto)
);
alter table detalle_orden add subtotal decimal(10,2) not null;
drop table detalle_orden;
truncate detalle_orden;
rename table detalle_orden TO DETALLE_ORDEN;

select*from cliente;
INSERT INTO cliente (idcliente, nombre, apellido, correo_electronico, telefono, direccion)
VALUES (1, 'Juan', 'Pérez', 'juan.perez@email.com', '1234567890', 'Calle Falsa 123, Ciudad A');

INSERT INTO cliente (idcliente, nombre, apellido, correo_electronico, telefono, direccion)
VALUES (2, 'María', 'Gómez', 'maria.gomez@email.com', '0987654321', 'Avenida Siempreviva 456, Ciudad B');

INSERT INTO cliente (idcliente, nombre, apellido, correo_electronico, telefono, direccion)
VALUES (3, 'Pedro', 'Ramírez', 'pedro.ramirez@email.com', '5551234567', 'Calle Luna 789, Ciudad C');

INSERT INTO cliente (idcliente, nombre, apellido, correo_electronico, telefono, direccion)
VALUES (4, 'Ana', 'López', 'ana.lopez@email.com', '4449876543', 'Calle Sol 321, Ciudad D');

INSERT INTO cliente (idcliente, nombre, apellido, correo_electronico, telefono, direccion)
VALUES (5, 'Carlos', 'Hernández', 'carlos.hernandez@email.com', '3336547890', 'Avenida del Parque 999, Ciudad E');
truncate table cliente;