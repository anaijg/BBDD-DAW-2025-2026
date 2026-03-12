# 1.4.7 Consultas resumen
use jardineria;
# 1. ¿Cuántos empleados hay en la compañía?
select count(codigo_empleado)
from empleado;
/*
 31
 */
# 2. ¿Cuántos clientes tiene cada país?

# 3. ¿Cuál fue el pago medio en 2009?
select avg(total)
from pago
where year(fecha_pago) = '2009';
/*
 4504.076923
 */
# 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT estado, COUNT(*) AS num_pedidos
FROM pedido
GROUP BY estado
ORDER BY num_pedidos DESC;
/*
 +---------+-----------+
|estado   |num_pedidos|
+---------+-----------+
|Entregado|61         |
|Pendiente|30         |
|Rechazado|24         |
+---------+-----------+
 */
# 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT MAX(precio_venta) AS precio_maximo,
       MIN(precio_venta) AS precio_minimo
FROM producto;
/*
 +-------------+-------------+
|precio_maximo|precio_minimo|
+-------------+-------------+
|462.00       |1.00         |
+-------------+-------------+

 */
# 6. Calcula el número de clientes que tiene la empresa.
select count(codigo_cliente)
from cliente;
/*
 36
 */
# 7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
SELECT ciudad, COUNT(codigo_cliente) AS numero_clientes
FROM cliente
GROUP BY ciudad
HAVING ciudad LIKE 'Madrid';
/*
 +------+---------------+
|ciudad|numero_clientes|
+------+---------------+
|Madrid|11             |
+------+---------------+

 */
# 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
select count(codigo_cliente), ciudad
from cliente
where ciudad like 'M%'
group by ciudad;
/*
 +---------------------+--------------------+
|count(codigo_cliente)|ciudad              |
+---------------------+--------------------+
|2                    |Miami               |
|11                   |Madrid              |
|1                    |Montornes del valles|
+---------------------+--------------------+

 */
# 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT e.nombre, e.apellido1, COUNT(c.codigo_cliente) AS num_clientes
FROM empleado e
         INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.codigo_empleado, e.nombre, e.apellido1;

# 10. Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT COUNT(*) AS clientes_sin_representante
FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;
/*
 0
 */
SELECT base_imponible,
       base_imponible * 0.21 AS iva,
       base_imponible * 1.21 AS total_facturado
FROM (SELECT SUM(precio_unidad * cantidad) AS base_imponible
      FROM detalle_pedido) AS facturacion;
# 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
select c.nombre_contacto, c.apellido_contacto, min(p.fecha_pago), max(p.fecha_pago)
from cliente c
         join pago p
              on c.codigo_cliente = p.codigo_cliente
group by c.nombre_contacto, c.apellido_contacto;

# 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT codigo_pedido, count(codigo_producto)
FROM detalle_pedido
GROUP BY codigo_pedido, codigo_producto
order by codigo_pedido;


# 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
select pedido.codigo_pedido,
       fecha_pedido,
       sum(detalle_pedido.cantidad)             as cantidad_de_productos,
       group_concat(distinct (producto.nombre)) as productos_del_pedido
from pedido
         inner join detalle_pedido on pedido.codigo_pedido = detalle_pedido.codigo_pedido
         inner join producto on detalle_pedido.codigo_producto = producto.codigo_producto
group by pedido.codigo_pedido;
# 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT p.nombre, SUM(dp.cantidad) AS total_unidades_vendidas
FROM producto p
         INNER JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.codigo_producto, p.nombre
ORDER BY total_unidades_vendidas DESC
LIMIT 20;
# 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
SELECT SUM(precio_unidad * cantidad)        AS base_imponible,
       SUM(precio_unidad * cantidad) * 0.21 AS iva,
       SUM(precio_unidad * cantidad) * 1.21 AS total_facturado
FROM detalle_pedido;
/*
 +--------------+----------+---------------+
|base_imponible|iva       |total_facturado|
+--------------+----------+---------------+
|217738.00     |45724.9800|263462.9800    |
+--------------+----------+---------------+

 */
SELECT SUM(precio_unidad * cantidad)                                        AS base_imponible,
       SUM(precio_unidad * cantidad) * 0.21                                 AS iva,
       SUM(precio_unidad * cantidad) + SUM(precio_unidad * cantidad) * 0.21 AS total_facturado
FROM detalle_pedido;
# 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
#
# 17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
#
# 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
#
# 19. Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
SELECT YEAR(fecha_pago) AS año, SUM(total) AS suma_total_pagos
FROM pago
GROUP BY YEAR(fecha_pago);