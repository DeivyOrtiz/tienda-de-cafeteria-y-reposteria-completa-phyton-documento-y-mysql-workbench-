-- trigger
delimiter $$
create trigger actualizar_stock_producto
after insert on detalle_orden
for each row
begin
    update producto
    set stock_disponible = stock_disponible - new.cantidad
    where idproducto = new.fkidproducto;
end$$

delimiter $$
create trigger actualizar_stock_producto_after_delete
after delete on detalle_orden
for each row
begin
    update producto
    set stock_disponible = stock_disponible + old.cantidad
    where idproducto = old.fkidproducto;
end$$


delimiter $$
create trigger evitar_eliminacion_producto_con_stock
before delete on producto
for each row
begin
    declare stock_count int;
    select count(*) into stock_count
    from inventario
    where fkidinventario = old.idproducto;
    
    if stock_count > 0 then
        signal sqlstate '45000' set message_text = 'No se puede eliminar el producto porque tiene stock disponible.';
    end if;
end$$

delimiter $$
create trigger registrar_cambio_precio_producto
before update on producto
for each row
begin
    if old.precio <> new.precio then
        insert into historial_precios (idproducto, precio_anterior, precio_nuevo, fecha_cambio)
        values (old.idproducto, old.precio, new.precio, now());
    end if;
end$$

delimiter $$
create trigger actualizar_estado_orden_after_update
after update on orden
for each row
begin
    if new.total = 0 then
        update orden
        set estado = 'completado'
        where idorden = new.idorden;
    end if;
end$$

delimiter $$
create trigger actualizar_estado_promocion_after_update
after update on producto_promocion
for each row
begin
    if new.fecha_fin < curdate() then
        update producto_promocion
        set estado = 'expirada'
        where idproducto_promocion = new.idproducto_promocion;
    end if;
end$$

delimiter $$
create trigger registrar_cambio_precio_compra
before update on producto_proveedor
for each row
begin
    if old.precio_compra <> new.precio_compra then
        insert into historial_precios_compra (id_producto_proveedor, precio_anterior, precio_nuevo, fecha_cambio)
        values (old.id_producto_proveedor, old.precio_compra, new.precio_compra, now());
    end if;
end$$

delimiter $$
create trigger verificar_total_orden_after_update
before update on orden
for each row
begin
    if new.total < 0 then
        signal sqlstate '45000' set message_text = 'El total de la orden no puede ser negativo.';
    end if;
end$$

delimiter $$
create trigger validar_ingredientes_receta_before_insert
before insert on receta_ingrediente
for each row
begin
    declare ingrediente_exists int;
    
    -- Verificar si el ingrediente existe
    select count(*) into ingrediente_exists
    from ingrediente
    where idingrediente = new.fkidingrediente;
    
    -- Si el ingrediente no existe, se produce un error
    if ingrediente_exists = 0 then
        signal sqlstate '45000' set message_text = 'El ingrediente no existe en la base de datos.';
    end if;
end$$
-- usuario que tendra la base de datos

delimiter $$
create trigger after_insert_cliente
after insert on cliente
for each row
begin
    insert into cliente_log (idcliente, accion)
    values (new.idcliente, 'INSERT');
end $$
drop trigger after_insert_cliente;

SELECT * FROM cliente_log;

GRANT ALL PRIVILEGES ON tienda_cafeteria_pasteleria.* TO 'DEIVY'@'localhost';
