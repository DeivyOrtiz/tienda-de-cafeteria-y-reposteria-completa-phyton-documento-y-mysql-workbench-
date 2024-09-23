-- funciones
delimiter $$
create function obtenerpreciototalorden
(
 ordenid int
)
returns decimal(10,2)
begin
declare total decimal(10,2);
select sum(de.cantidad*p.precio) into total
from detalle_orden as de
join producto as p on de.fkidproducto=p.idproducto
where de.fkidorden=ordenid;
return total;
end$$

delimiter $$
create function contarproductosencategoria
(
  categoriaid int
)
returns int
begin
declare total int;
select count(*) into total
from producto
where fkidcategoria = categoriaid;
return total;
end$$

delimiter $$
create function	obtenercantidaddisponibleproducto
(
 productoid int
)
returns int 
begin
declare cantidad int;
select cantidad_disponible into cantidad
from inventario
where fkidinventario = productoid;
return cantidad;
end$$

delimiter $$
create function obtenernombrecompletocliente
(
 clienteid int
)
returns varchar(255)
begin
declare nombre_completo varchar(255);
select concat(nombre, apellido) into nombre_completo
from cliente
where idcliente=clienteid;
return nombre_completo;
end$$
SELECT idcliente, obtenernombrecompletocliente(1) AS nombre_completo
FROM cliente;

delimiter $$
create function obtenerpreciopromediocategoria
(
 categoriaid int
)
returns decimal(10,2)
begin
declare precio_promedio decimal(10,2);
select avg(precio) into precio_promedio
from producto
where fkidcategoria=categoriaid;
return precio_promedio;
end $$

delimiter $$
create function obtenerproveedorprincipalproducto
(
 productoid int
)
returns varchar(255)
begin
declare proveedor_nombre varchar(255);
select p.nombre into proveedor_nombre
from proveedor as p
join producto_proveedor as pp on p.idproveedor = pp.fkidproveedor
where pp.fkidproducto = productoid
order by pp.cantidad_suministrada desc
limit 1;
return proveedor_nombre;
end $$

delimiter $$
create function obteneringredientesreceta
(
 recetaid int
)
returns text
begin
declare ingredientes text;
select group_concat(i.nombre) into ingredientes
from receta_ingrediente as ri
join ingrediente as i on ri.fkidingrediente=i.idingrediente
where ri.fkidreceta=recetaid;
return ingredientes;
end $$

delimiter $$
create function obtenerdescuentopromocion
(
 promocionid int
)
returns decimal(5,2)
begin
declare descuentos decimal(5,2);
select descuento into descuentos
from producto_promocion
where fkidpromocion=promocionid;
return descuentos;
end $$

delimiter $$
create function calcularstocktotalproducto
(
productoid int
)
returns int
begin
declare	stocktotal int;
select sum(cantidad_disponible) into stocktotal
from inventario
where fkidinventario=productoid;
return stocktotal;
end $$

delimiter $$
create function contarrecetasconingredientes
(
 ingredientesid int
)
returns int
begin
declare totalrecetas int;
select count(*) into totalrecetas
from  receta_ingrediente
where fkidingrediente=ingredientesid;
return totalrecetas;
end $$