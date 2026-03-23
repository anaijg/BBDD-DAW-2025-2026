# 1.4.5 Consultas multitabla (Composición interna)
# Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.
use jardineria;
# 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
FROM cliente as c
         INNER JOIN empleado as e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
-- 36 rows
# 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT c.nombre_cliente, e.nombre
FROM cliente c
         INNER JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
         INNER JOIN pago p on c.codigo_cliente = p.codigo_cliente;
-- 18 rows

# 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
-- Opción 1
SELECT DISTINCT c.nombre_cliente,
                CONCAT(e.nombre, ' ', e.apellido1) AS representante
FROM cliente c
         JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente
                               FROM pago);

-- Opción 2
SELECT DISTINCT c.nombre_cliente,
                CONCAT(e.nombre, ' ', e.apellido1) AS representante
FROM cliente c
         JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
         LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.total IS NULL;

-- Opción 3
SELECT DISTINCT c.nombre_cliente,
                CONCAT(e.nombre, ' ', e.apellido1) AS representante
FROM cliente c
         JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE NOT EXISTS(SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

# 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente AS c
         INNER JOIN empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
         INNER JOIN pago as p ON p.codigo_cliente = c.codigo_cliente
         INNER JOIN oficina as o ON o.codigo_oficina = e.codigo_oficina;
-- 18 rows

# 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
-- El p.total no lo piden pero como Álvaro lo ha puesto con to-do su cariño lo dejamos
SELECT DISTINCT c.nombre_cliente,
                e.nombre,
                o.ciudad,
                IFNULL(
                        p.total
                    , 0) AS total
FROM cliente AS c
         INNER JOIN empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
         INNER JOIN oficina AS o ON e.codigo_oficina = o.codigo_oficina
         LEFT JOIN pago AS p ON c.codigo_cliente = p.codigo_cliente
WHERE p.total IS NULL;
-- 17 rows

# 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT DISTINCT o.linea_direccion1, o.linea_direccion2, o.ciudad
FROM oficina o
         JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
         JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Fuenlabrada';
-- 3 rows

# 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente AS c
         INNER JOIN empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
         INNER JOIN oficina AS o ON e.codigo_oficina = o.codigo_oficina;
-- 35 rows
# 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT jefe.nombre AS jefe_de, subordinado.nombre AS empleado
FROM empleado AS jefe
         JOIN empleado AS subordinado ON jefe.codigo_empleado = subordinado.codigo_jefe;
-- 30 rows

SELECT IFNULL(e1.nombre, 'no tiene jefe') AS jefe_de, e2.nombre AS empleado
FROM empleado AS e1
         RIGHT JOIN empleado e2 ON e1.codigo_empleado = e2.codigo_jefe;
-- 31 rows
# 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
SELECT DISTINCT CONCAT(e.nombre, ' ', e.apellido1)   AS empleado,
                CONCAT(j.nombre, ' ', j.apellido1)   AS jefe,
                CONCAT(jj.nombre, ' ', jj.apellido1) AS jefe_del_jefe
FROM empleado e
         JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
         JOIN empleado jj ON j.codigo_jefe = jj.codigo_empleado;
-- 29 rows
# 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select distinct nombre_cliente
from cliente c
         inner join pedido p on c.codigo_cliente = p.codigo_cliente
where fecha_esperada < fecha_entrega;
-- 15 rows
# 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT DISTINCT c.nombre_cliente, pr.gama
FROM cliente AS c
         JOIN pedido AS p ON c.codigo_cliente = p.codigo_cliente
         JOIN detalle_pedido AS d ON p.codigo_pedido = d.codigo_pedido
         INNER JOIN producto AS pr ON d.codigo_producto = pr.codigo_producto;

# 1.4.6 Consultas multitabla (Composición externa)
# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.
#
# 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT c.nombre_cliente
FROM cliente c
         LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);

# 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT c.nombre_cliente
FROM cliente c
         LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pedido);

# 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
# Solamente deben aparecer si no han hecho ni pedido, ni pago
SELECT DISTINCT c.nombre_cliente
FROM cliente c LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
WHERE pa.codigo_cliente IS NULL AND pe.codigo_cliente IS NULL;

# 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT e.nombre, e.apellido1
    FROM empleado e LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    WHERE e.codigo_oficina IS NULL;

SELECT nombre, apellido1
    FROM empleado
WHERE codigo_oficina NOT IN (SELECT codigo_oficina FROM oficina);

# 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT e.nombre, e.apellido1
    FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    WHERE c.codigo_empleado_rep_ventas IS NULL;

SELECT nombre, apellido1
    FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

# 6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
SELECT DISTINCT e.nombre, e.apellido1, o.*
    FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    WHERE c.codigo_empleado_rep_ventas IS NULL;

# 7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
SELECT e.*
FROM empleado e
         LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
         LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL
  AND c.codigo_cliente IS NULL;

# 8. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT p.nombre, p.descripcion, g.imagen
FROM producto p
         JOIN gama_producto g ON p.gama = g.gama
         LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

# 9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.
SELECT p.nombre, p.descripcion, g.imagen
FROM producto p
         JOIN gama_producto g ON p.gama = g.gama
         LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

# 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT DISTINCT o.*
FROM oficina o
         LEFT JOIN (SELECT DISTINCT e.codigo_oficina
                    FROM empleado e
                             JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
                             JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
                             JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
                             JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
                    WHERE pr.gama = 'Frutales') AS oficinas_frutales
                   ON o.codigo_oficina = oficinas_frutales.codigo_oficina
WHERE oficinas_frutales.codigo_oficina IS NULL;

# 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT DISTINCT c.*
FROM cliente c
         JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
         LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
WHERE pa.codigo_cliente IS NULL;

# 12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
SELECT e.nombre AS empleado_sin_clientes, j.nombre AS nombre_jefe
FROM empleado e
         LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
         LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE c.codigo_cliente IS NULL;         
