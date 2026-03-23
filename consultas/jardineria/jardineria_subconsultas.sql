# 1.4.8 Subconsultas
# 1.4.8.1 Con operadores básicos de comparación
use jardineria;
# 1. Devuelve el nombre del cliente con mayor límite de crédito.
-- Opción 1) Subconsulta
SELECT nombre_cliente
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

-- Opción 2) ORDER BY y LIMIT
SELECT nombre_cliente
FROM cliente
ORDER BY limite_credito DESC
LIMIT 1;

# 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
-- Opción 1) Subconsulta
SELECT nombre
FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

-- Opción 2) ORDER BY y LIMIT
SELECT nombre
FROM producto
ORDER BY precio_venta DESC
LIMIT 1;
# 3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido)
SELECT nombre
FROM producto
WHERE codigo_producto = (SELECT codigo_producto
                         FROM detalle_pedido
                         GROUP BY codigo_producto
                         ORDER BY SUM(cantidad) DESC
                         LIMIT 1);

SELECT nombre
FROM producto p JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.codigo_producto
ORDER BY SUM(cantidad)  DESC
LIMIT 1;

# 4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
SELECT nombre_cliente
FROM cliente c
WHERE limite_credito > COALESCE((SELECT SUM(total)
                                 FROM pago p
                                 WHERE p.codigo_cliente = c.codigo_cliente), 0);

# 5. Devuelve el producto que más unidades tiene en stock.
SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

# 6. Devuelve el producto que menos unidades tiene en stock.
SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

# 7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = (SELECT codigo_empleado
                     FROM empleado
                     WHERE nombre = 'Alberto'
                       AND apellido1 = 'Soria');

# 1.4.8.2 Subconsultas con ALL y ANY
# 8. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente
FROM cliente
WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente WHERE limite_credito IS NOT NULL);

# 9. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre
FROM producto
WHERE precio_venta >= ALL (SELECT precio_venta FROM producto WHERE precio_venta IS NOT NULL);

# 10. Devuelve el producto que menos unidades tiene en stock.
SELECT nombre
FROM producto
WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock FROM producto);
  
# 1.4.8.3 Subconsultas con IN y NOT IN
# 11. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas
                              FROM cliente
                              WHERE codigo_empleado_rep_ventas IS NOT NULL);

# 12. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT *
FROM cliente
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

# 13. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT *
FROM cliente
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);

# 14. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT *
FROM producto
WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

# 15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre,
       e.apellido1,
       e.apellido2,
       e.puesto,
       (SELECT telefono FROM oficina o WHERE o.codigo_oficina = e.codigo_oficina) AS telefono
FROM empleado e
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas
                                FROM cliente
                                WHERE codigo_empleado_rep_ventas IS NOT NULL);

# 16. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT *
FROM oficina
WHERE codigo_oficina NOT IN (SELECT codigo_oficina
                             FROM empleado
                             WHERE codigo_empleado IN (SELECT codigo_empleado_rep_ventas
                                                       FROM cliente
                                                       WHERE codigo_cliente IN (SELECT codigo_cliente
                                                                                FROM pedido
                                                                                WHERE codigo_pedido IN
                                                                                      (SELECT codigo_pedido
                                                                                       FROM detalle_pedido
                                                                                       WHERE codigo_producto IN
                                                                                             (SELECT codigo_producto
                                                                                              FROM producto
                                                                                              WHERE gama = 'Frutales')))));

# 17. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT *
FROM cliente
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pedido)
  AND codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

# 1.4.8.4 Subconsultas con EXISTS y NOT EXISTS
# 18. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT *
FROM cliente c
WHERE NOT EXISTS (SELECT 1
                  FROM pago p
                  WHERE p.codigo_cliente = c.codigo_cliente);
  
# 19. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT *
FROM cliente c
WHERE EXISTS (SELECT 1
              FROM pago p
              WHERE p.codigo_cliente = c.codigo_cliente);

# 20. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT *
FROM producto p
WHERE NOT EXISTS (SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = p.codigo_producto);

# 21. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
SELECT *
FROM producto p
WHERE EXISTS (SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = p.codigo_producto);
