use jardineria;
# 1.4.4 Consultas sobre una tabla
# 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select codigo_oficina, ciudad
from oficina;
/*
 +--------------+--------------------+
|codigo_oficina|ciudad              |
+--------------+--------------------+
|BCN-ES        |Barcelona           |
|BOS-USA       |Boston              |
|LON-UK        |Londres             |
|MAD-ES        |Madrid              |
|PAR-FR        |Paris               |
|SFC-USA       |San Francisco       |
|SYD-AU        |Sydney              |
|TAL-ES        |Talavera de la Reina|
|TOK-JP        |Tokyo               |
+--------------+--------------------+

 */
# 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select ciudad, telefono
from oficina;
/*
 +--------------------+---------------+
|ciudad              |telefono       |
+--------------------+---------------+
|Barcelona           |+34 93 3561182 |
|Boston              |+1 215 837 0825|
|Londres             |+44 20 78772041|
|Madrid              |+34 91 7514487 |
|Paris               |+33 14 723 4404|
|San Francisco       |+1 650 219 4782|
|Sydney              |+61 2 9264 2451|
|Talavera de la Reina|+34 925 867231 |
|Tokyo               |+81 33 224 5000|
+--------------------+---------------+

 */
# 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe LIKE '7';
# 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe IS NULL;
/*
 +----------------+------+---------+---------+--------------------+
|puesto          |nombre|apellido1|apellido2|email               |
+----------------+------+---------+---------+--------------------+
|Director General|Marcos|Magaña   |Perez    |marcos@jardineria.es|
+----------------+------+---------+---------+--------------------+

 */
# 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto NOT LIKE 'Representante Ventas';
/*
 +--------+----------+---------+---------------------+
|nombre  |apellido1 |apellido2|puesto               |
+--------+----------+---------+---------------------+
|Marcos  |Magaña    |Perez    |Director General     |
|Ruben   |López     |Martinez |Subdirector Marketing|
|Alberto |Soria     |Carrasco |Subdirector Ventas   |
|Maria   |Solís     |Jerez    |Secretaria           |
|Carlos  |Soria     |Jimenez  |Director Oficina     |
|Emmanuel|Magaña    |Perez    |Director Oficina     |
|Francois|Fignon    |         |Director Oficina     |
|Michael |Bolton    |         |Director Oficina     |
|Hilary  |Washington|         |Director Oficina     |
|Nei     |Nishikori |         |Director Oficina     |
|Amy     |Johnson   |         |Director Oficina     |
|Kevin   |Fallmer   |         |Director Oficina     |
+--------+----------+---------+---------------------+

 */
# 6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT *
FROM cliente
WHERE pais LIKE 'Spain';
# 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.

select distinct(estado) as estados_de_pedido
from pedido;
/*
 +-----------------+
|estados_de_pedido|
+-----------------+
|Entregado        |
|Rechazado        |
|Pendiente        |
+-----------------+

 */
# 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
SELECT DISTINCT codigo_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;
/*
 +--------------+
|codigo_cliente|
+--------------+
|1             |
|13            |
|14            |
|26            |
+--------------+

 */
# a) Utilizando la función YEAR de MySQL.
# b) Utilizando la función DATE_FORMAT de MySQL.
# c) Sin utilizar ninguna de las funciones anteriores.

# 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE TIMESTAMPDIFF(DAY, fecha_entrega, fecha_esperada) < 0;
-- (también valdría poner where fecha_entrega > fecha_esperada)

# 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

# a) Utilizando la función ADDDATE de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where fecha_entrega <= adddate(fecha_esperada, -2);

# b) Utilizando la función DATEDIFF de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where datediff(fecha_esperada, fecha_entrega) >= 2;

SELECT codigo_pedido,
       codigo_cliente,
       fecha_esperada,
       fecha_entrega,
       DATEDIFF(fecha_esperada, fecha_entrega) AS diferencia
FROM pedido
GROUP BY codigo_pedido
HAVING diferencia >= 2;


# c) ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where fecha_entrega <= fecha_esperada - 2;
/*
 +-------------+--------------+--------------+-------------+
|codigo_pedido|codigo_cliente|fecha_esperada|fecha_entrega|
+-------------+--------------+--------------+-------------+
|2            |5             |2007-10-28    |2007-10-26   |
|24           |14            |2008-07-31    |2008-07-25   |
|30           |13            |2008-09-03    |2008-08-31   |
|36           |14            |2008-12-15    |2008-12-10   |
|53           |13            |2008-11-15    |2008-11-09   |
|89           |35            |2007-12-13    |2007-12-10   |
|91           |27            |2009-03-29    |2009-03-27   |
|93           |27            |2009-05-30    |2009-05-17   |
+-------------+--------------+--------------+-------------+

 */
# 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select *
from pedido
where estado = 'Rechazado'
  and year(fecha_pedido) = '2009';

# 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT *
FROM pedido
WHERE MONTH(fecha_entrega) = 1;

# 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
SELECT *
FROM pago
WHERE YEAR(fecha_pago) = 2008
  AND forma_pago LIKE 'PayPal'
ORDER BY total DESC;
/*
 +--------------+----------+--------------+----------+--------+
|codigo_cliente|forma_pago|id_transaccion|fecha_pago|total   |
+--------------+----------+--------------+----------+--------+
|26            |PayPal    |ak-std-000020 |2008-03-18|18846.00|
|14            |PayPal    |ak-std-000015 |2008-07-15|4160.00 |
|13            |PayPal    |ak-std-000014 |2008-08-04|2246.00 |
|1             |PayPal    |ak-std-000001 |2008-11-10|2000.00 |
|1             |PayPal    |ak-std-000002 |2008-12-10|2000.00 |
+--------------+----------+--------------+----------+--------+

 */

# 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT (forma_pago)
FROM pago;
/*
 +-------------+
|forma_pago   |
+-------------+
|PayPal       |
|Transferencia|
|Cheque       |
+-------------+

 */
# 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
select *
from producto
where gama = 'Ornamentales'
  and cantidad_en_stock > 100
order by precio_venta desc;


# 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
SELECT *
FROM cliente
WHERE ciudad = 'Madrid'
  AND codigo_empleado_rep_ventas IN (11, 30);
