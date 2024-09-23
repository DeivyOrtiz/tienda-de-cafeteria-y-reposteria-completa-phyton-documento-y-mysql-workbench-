-- procedimiento almacenado para insertar 
delimiter $$
create procedure insertarcliente
(
 in idcliente int,
 in nombre varchar(100),
 in apellido varchar (100),
 in correo_electronico varchar(100),
 in telefono varchar(20),
 in direccion varchar(255)
 )
 begin
 insert into cliente values(idcliente,nombre,apellido,correo_electronico,telefono,direccion);
 end$$
 
delimiter $$
create procedure insertarorden
(
 in idorden int,
 in fecha datetime,
 in total decimal(10,2),
 in estado varchar(50),
 in idcliente int,
 in idempleado int,
 in idpago int
)
begin
insert into orden values(idorden,fecha,total,estado,idcliente,idempleado,idpago);
end$$

delimiter $$
create procedure insertarpago
(
 in idpago int,
 in metodo_pago varchar(50),
 in monto decimal (10,2),
 in fecha_pago datetime
)
begin
insert into pago values(idpago,metodo_pago,monto,fecha_pago);
end$$

delimiter $$
create procedure insertarempleado
(
 in idempleado int,
 in nombre varchar(100),
 in apellido varchar(100),
 in correo_electronico varchar(100),
 in telefono varchar(20),
 in cargo varchar(100)
)
begin
insert into empleado values(idempleado,nombre,apellido,correo_electronico,telefono,cargo);
end$$

delimiter $$
create procedure insertarproducto
(
 in idproducto int,
 in nombre varchar(100),
 in descripcion text,
 in precio decimal (10,2),
 in stock_disponible int,
 in idcategoria int
)
begin
insert into  producto values(idproducto,nombre,descripcion,precio,stock_disponible,idcategoria);
end$$

delimiter $$
create procedure insertardetalleorden
(
 in iddetalle_orden int,
 in cantidad int,
 in precio_unitario decimal(10,2),
 in subtotal decimal(10,2),
 in idorden int,
 in idproducto int
)
begin
insert into detalle_orden values(iddetalle_orden,cantidad,precio_unitario,subtotal,idorden,idproducto);
end$$

delimiter $$
create procedure insertarcategoria
(
  in idcategoria int,
  in nombre varchar(100),
  in descripcion text
)
begin
insert into  categoria values(idcategoria,nombre,descripcion);
end$$

delimiter $$
create procedure insertarinventario
(
  in idproducto int,
  in cantidad_disponible int,
  in fecha_ultima_actualizacion date
)
begin
insert into inventario values(idproducto,cantidad_disponible,fecha_ultima_actualizacion);
end $$

delimiter $$
create procedure insertarproveedor
(
  in idproveedor int,
  in nombre varchar(100),
  in telefono varchar(20),
  in correo_electronico varchar(100),
  in direccion text
)
begin
insert into proveedor values(idproveedor,nombre,telefono,correo_electronico,direccion);
end $$

delimiter $$
create procedure insertarproductoproveedor
(
  in id_producto_proveedor int,
  in precio_compra decimal(10,2),
  in fecha_suministro date,
  in cantidad_suministrada int,
  in idproducto int,
  in idproveedor int
)
begin
insert into producto_proveedor values(id_producto_proveedor,precio_compra,fecha_suministro,cantidad_suministrada,idproducto,idproveedor);
end $$

delimiter $$
create procedure insertarreceta
(
 in idreceta int,
 in nombre varchar(100),
 in descripcion text,
 in instrucciones text
)
begin
insert into receta values(idreceta,nombre,descripcion,instrucciones);
end$$

delimiter $$
create procedure insertarproductoreceta
(
 in id_producto_receta int,
 in cantidad_producto int,
 in unidad_medida varchar(50),
 in instrucciones_adicionales text,
 in idproducto int,
 in idreceta int
)
begin
insert into producto_receta values(id_producto_receta,cantidad_producto,unidad_medida,instrucciones_adicionales,idproducto,idreceta);
end$$

delimiter $$
create procedure insertaringrediente
(
 in idingrediente int,
 in nombre varchar(100),
 in descripcion text
)
begin
insert into ingrediente values(idingrediente,nombre,descripcion);
end$$

delimiter $$
create procedure insertarrecetaingrediente
(
 in idreceta_ingrediente int,
 in cantidad_necesaria decimal(10,2),
 in idreceta int,
 in idingrediente int
)
begin
insert into receta_ingrediente values(idreceta_ingrediente,cantidad_necesaria,idreceta,idingrediente);
end$$

delimiter $$
create procedure insertarpromocion
(
 in idpromocion int,
 in nombre varchar(100)
)
begin
insert into promocion values(idpromocion,nombre);
end$$

delimiter $$
create procedure insertarproductopromocion
(
 in idproducto_promocion int,
 in descuento decimal(5,2),
 in fecha_inicio datetime,
 in fecha_fin datetime,
 in estado varchar(50),
 in idproducto int,
 in idpromocion int
)
begin
insert into producto_promocion values (idproducto_promocion,descuento,fecha_inicio,fecha_fin,estado,idproducto,idpromocion);
end$$

-- procedimiento almacenado en lista y muestra
delimiter $$
create procedure listarproductoconcategoria()
begin 
select p.nombre, p.stock_disponible,p.precio,c.nombre
from producto as p
join categoria as c on p.fkidcategoria=c.idcategoria;
end$$

delimiter $$
create procedure mostrarempleadoscargo()
begin
select*from empleado
where cargo='';
end $$

delimiter $$
create procedure listarproductosbajoseninventarios
(
in cantidadminima int
)
begin
select p.nombre,i.cantidad_disponible
from producto as p
join inventario as i on p.idproducto=i.fkidinventario
where i.cantidad_disponible<cantidadminima;
end$$

delimiter $$
create procedure mostrarpagosordenpormonto
(
 in idorden int,
 in montominimo decimal(10,2)
)
begin
select*from pago
where idpago=idorden and monto>=montominimo;
end $$

delimiter $$
create procedure mostrardetalleordenconcategoria
(
 in idorden int
)
begin
select d.fkidproducto,p.nombre,d.cantidad,c.nombre
from detalle_orden as d
join producto as p on d.fkidproducto=p.idproducto
join categoria as c on p.fkidcategoria=c.idcategoria
where d.fkidorden=idorden;
end$$

delimiter $$
create procedure mostrarproveedorporfecha
(
 in fechadeinicio date,
 in fechafin date
)
begin
select distinct pr.nombre, ps.fkidproducto
from proveedor as pr
join producto_proveedor as ps on pr.idproveedor=ps.fkidproveedor
where ps.fecha_suministro between fechadeinicio and fechafin;
end$$

delimiter $$
create procedure listarrecetaconingredientes()
begin
select r.idreceta,r.nombre,i.nombre,ri.cantidad_necesaria
from receta as r
join receta_ingrediente as ri on r.idreceta=ri.fkidreceta
join ingrediente as i on ri.fkidingrediente=i.idingrediente;
end$$

delimiter $$
create procedure mostrarpromocionesactivas()
begin
select p.nombre,pr.nombre
from producto_promocion as pp
join promocion as pr on pp.fkidpromocion=pr.idpromocion
join producto as p on pp.fkidproducto=p.idproducto
where pp.fecha_inicio<=curdate() and pp.fecha_fin>=curdate();
end$$

delimiter $$
create procedure mostraringredientesreceta
(
 in idreceta int
)
begin 
select i.nombre, ri.cantidad_necesaria
from receta_ingrediente as ri
join ingrediente as i on ri.fkidingrediente=i.idingrediente
where ri.fkidreceta=idreceta;
end$$

