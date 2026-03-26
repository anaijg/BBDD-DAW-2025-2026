###################################################################################################
# Examen de SQL: Base de Datos Jardinería (RA 3)
# Instrucciones:
#
# El examen consta de 20 consultas. 10 corresponden a la UD 6 (Unitabla) y 10 a la UD 7 (Multitabla/Subconsultas).
#
# Cada respuesta correcta vale 1 punto para su unidad correspondiente.
#
# Debes rellenar debajo de cada enunciado la consulta SQL que creas que lo resuelve. Cuando termines, adjunta este documento en la tarea correspondiente del Aula Virtual, en la UD 7
#
# Nota: Las preguntas están mezcladas. Debes identificar si la solución requiere una o varias tablas según el esquema.
#
# Otra nota: respecto a la UD 6, se tendrá en cuenta la nota más alta obtenida en los dos exámenes realizados en esta unidad; en el caso de que la nota de este examen mejore la del que se realizó en la semana de exámenes, se sustituirá la nota en la tarea correspondiente al examen de la UD 6.
####################################################################################################


use jardineria;

# 1. Lista el nombre del cliente, su teléfono y la ciudad de aquellos clientes que no tienen informada su región (su campo región es nulo).
# (5 rows)
SELECT nombre_cliente, telefono, ciudad
FROM cliente
WHERE region IS NULL;

# 2. Muestra las distintas ciudades donde residen nuestros clientes ordenadas alfabéticamente.
# (16 rows)
SELECT DISTINCT ciudad
FROM cliente
ORDER BY ciudad;

# 3. Muestra el código de pedido, la fecha del pedido y el estado, de aquellos pedidos cuyo estado sea 'Rechazado' o 'Pendiente'.
# (54 rows)
SELECT codigo_pedido, fecha_pedido, estado
FROM pedido
WHERE estado IN ('Rechazado', 'Pendiente');

# 4. Muestra el nombre, ciudad y límite de crédito de los clientes que viven en España (Spain), cuyo límite de crédito sea superior a 3000 euros.
# (26 rows)
SELECT nombre_cliente, ciudad, limite_credito
FROM cliente
WHERE pais = 'Spain'
  AND limite_credito > 3000;

# 5. Lista el nombre y los apellidos de los contactos de clientes cuyo apellido empiece por la letra 'J' o por la letra 'A'.
# (2 rows)
SELECT nombre_contacto, apellido_contacto
FROM cliente
WHERE apellido_contacto LIKE 'J%'
   OR apellido_contacto LIKE 'A%';

# 6. Devuelve el nombre del producto, el precio de venta, el precio del proveedor y el beneficio neto (precio de venta menos precio de proveedor) de todos los productos de la gama 'Ornamentales'.
# (154 rows)
SELECT nombre, precio_venta, precio_proveedor, (precio_venta - precio_proveedor) AS beneficio_neto
FROM producto
WHERE gama = 'Ornamentales';

# 7. Devuelve un listado con el nombre y la cantidad en stock de los 5 productos con menos stock en el almacén (que tengan al menos 1 unidad).
# (5 rows)
SELECT nombre, cantidad_en_stock
FROM producto
WHERE cantidad_en_stock > 0
ORDER BY cantidad_en_stock
LIMIT 5;

# 8. Devuelve la suma total de los pagos realizados por el cliente con código 16.
# (1 row)
SELECT SUM(total) AS total_pagado
FROM pago
WHERE codigo_cliente = 16;

# 9. Muestra el nombre de cada empleado junto con el nombre de la ciudad de la oficina donde trabaja.
# (31 rows)
SELECT e.nombre, e.apellido1, o.ciudad
FROM empleado e
         INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

# 10. Devuelve el nombre de los clientes que no han realizado ningún pago y cuyo límite de crédito sea superior a la media de todos los clientes.
# (1 row)
SELECT DISTINCT c.nombre_cliente
FROM cliente c
         LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL
  AND c.limite_credito > (SELECT AVG(limite_credito) FROM cliente);

# 11. Lista el nombre de los productos que pertenecen a una gama cuya descripción en texto contenga la palabra "planta".
# (132 rows)
SELECT distinct p.nombre, g.descripcion_texto
FROM producto p
         INNER JOIN gama_producto g ON p.gama = g.gama
WHERE g.descripcion_texto LIKE '%planta%';

# 12. Lista de los nombres de clientes y el nombre de su representante de ventas para aquellos clientes que NO residan en la misma ciudad que la oficina de su representante.
# (25 rows)
SELECT DISTINCT c.nombre_cliente, e.nombre
FROM cliente c
         INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
         INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.ciudad != o.ciudad;

SELECT DISTINCT c.nombre_cliente, e.nombre
FROM cliente c
         INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
         INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE NOT c.ciudad = o.ciudad;

# 13. Calcula la suma total del límite de crédito (credito_total) que tienen concedido los clientes, agrupado por cada país.
# (5 rows)
SELECT pais, SUM(limite_credito) AS credito_total
FROM cliente
GROUP BY pais;

# 14. Calcula cuántos productos de la gama 'Herramientas' tenemos en total en stock en el inventario.
# (1 row)
SELECT SUM(cantidad_en_stock) AS stock_total_herramientas
FROM producto p
WHERE gama = 'Herramientas';

# 15. Muestra el código de la oficina y el número de empleados que tiene cada una, pero solo de aquellas oficinas que tengan más de 4 empleados.
# (1 row)
SELECT codigo_oficina, COUNT(*) AS num_empleados
FROM empleado
GROUP BY codigo_oficina
HAVING num_empleados > 4;

SELECT codigo_oficina, COUNT(*) AS num_empleados
FROM empleado
GROUP BY codigo_oficina
HAVING COUNT(*) > 4;

# 16. Muestra el identificador de la transacción, la fecha, el nombre del cliente y el importe total, pero solo de los pagos que superen la media de todos los pagos realizados en la empresa.
# (10 rows)
SELECT p.id_transaccion, p.fecha_pago, c.nombre_cliente, p.total
FROM pago p
         INNER JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
WHERE p.total > (SELECT AVG(total) FROM pago);

# 17. Calcula el importe total a pagar de cada uno de los pedidos que ha realizado el cliente 'GoldFish Garden'. Muestra el código del pedido, la fecha y el importe total.
# (11 rows)
SELECT DISTINCT p.codigo_pedido, p.fecha_pedido, SUM(dp.cantidad * dp.precio_unidad) AS total_pedido
FROM pedido p
         JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
         JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
WHERE c.nombre_cliente = 'GoldFish Garden'
GROUP BY p.codigo_pedido, p.fecha_pedido;

# 18. Devuelve el nombre del cliente que ha realizado el pago por el importe más alto de la historia de la empresa.
# (1 row)
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente = (SELECT codigo_cliente
                        FROM pago
                        WHERE total = (SELECT MAX(total) FROM pago));

SELECT DISTINCT c.nombre_cliente
FROM cliente c
JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.total = (SELECT MAX(total) FROM pago);

# 19. Devuelve un listado con el nombre de los clientes que han realizado al menos un pedido pero cuyo límite de crédito es inferior a 2000 euros.
# (1 row)
SELECT nombre_cliente
FROM cliente
WHERE limite_credito < 2000
  AND codigo_cliente IN (SELECT codigo_cliente
                         FROM pedido);

# 20. Encuentra a los representantes de ventas (nombre y apellidos) que no han conseguido que sus clientes realicen ningún pago.
# (7 rows)
SELECT DISTINCT e.nombre, e.apellido1
FROM empleado e
         INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
         LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;