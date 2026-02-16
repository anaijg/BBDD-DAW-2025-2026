# 1.3.6 Consultas resumen
use ventas;
# 1. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
select sum(total)
from pedido;
-- 20992.829999999998

# 2. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
select avg(total)
from pedido;
-- 1312.0518749999999

# 3. Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
select count(distinct id_comercial)
from pedido;
-- 6

# 4. Calcula el número total de clientes que aparecen en la tabla cliente.
select count(*)
from cliente;
-- 10

# 5. Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
select max(total)
from pedido;
-- 5760

# 6. Calcula cuál es la menor cantidad que aparece en la tabla pedido.
select min(total)
from pedido;
-- 65.26

# 7. Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.
select c.ciudad, max(categoria)
from cliente as c
group by c.ciudad;
/*
 +-------+--------------+
|ciudad |max(categoria)|
+-------+--------------+
|Almería|200           |
|Granada|225           |
|Sevilla|300           |
|Jaén   |300           |
|Cádiz  |100           |
|Huelva |200           |
+-------+--------------+
 */

# 8. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.
select c.id, c.nombre, c.apellido1, c.apellido2, p.fecha, max(p.total)
from cliente as c
         join pedido as p on c.id = p.id_cliente
group by c.id, p.fecha;
/*
 +--+------+---------+---------+----------+------------+
|id|nombre|apellido1|apellido2|fecha     |max(p.total)|
+--+------+---------+---------+----------+------------+
|5 |Marcos|Loyola   |Méndez   |2017-10-05|150.5       |
|1 |Aarón |Rivero   |Gómez    |2016-09-10|270.65      |
|2 |Adela |Salas    |Díaz     |2017-10-05|65.26       |
|8 |Pepe  |Ruiz     |Santana  |2016-08-17|110.5       |
|5 |Marcos|Loyola   |Méndez   |2017-09-10|948.5       |
|7 |Pilar |Ruiz     |null     |2016-07-27|2400.6      |
|2 |Adela |Salas    |Díaz     |2015-09-10|5760        |
|4 |Adrián|Suárez   |null     |2017-10-10|1983.43     |
|8 |Pepe  |Ruiz     |Santana  |2016-10-10|2480.4      |
|8 |Pepe  |Ruiz     |Santana  |2015-06-27|250.45      |
|3 |Adolfo|Rubio    |Flores   |2016-08-17|75.29       |
|2 |Adela |Salas    |Díaz     |2017-04-25|3045.6      |
|6 |María |Santana  |Moreno   |2019-01-25|545.75      |
|6 |María |Santana  |Moreno   |2017-02-02|145.82      |
|1 |Aarón |Rivero   |Gómez    |2019-03-11|2389.23     |
+--+------+---------+---------+----------+------------+
 */
# 9. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.
select c.id, c.nombre, c.apellido1, c.apellido2, p.fecha, max(p.total)
from cliente as c
         join pedido as p on c.id = p.id_cliente
where p.total > 2000
group by c.id, p.fecha;
/*
 +--+------+---------+---------+----------+------------+
|id|nombre|apellido1|apellido2|fecha     |max(p.total)|
+--+------+---------+---------+----------+------------+
|7 |Pilar |Ruiz     |null     |2016-07-27|2400.6      |
|2 |Adela |Salas    |Díaz     |2015-09-10|5760        |
|8 |Pepe  |Ruiz     |Santana  |2016-10-10|2480.4      |
|2 |Adela |Salas    |Díaz     |2017-04-25|3045.6      |
|1 |Aarón |Rivero   |Gómez    |2019-03-11|2389.23     |
+--+------+---------+---------+----------+------------+

 */
# 10. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.
select c.id, c.nombre, c.apellido1, c.apellido2, max(p.total)
from comercial as c
         join pedido as p on c.id = p.id_comercial
where p.fecha = '2016-08-17'
group by c.id;
/*
 +--+-------+---------+---------+------------+
|id|nombre |apellido1|apellido2|max(p.total)|
+--+-------+---------+---------+------------+
|3 |Diego  |Flores   |Salas    |110.5       |
|7 |Antonio|Vega     |Hernández|75.29       |
+--+-------+---------+---------+------------+
 */
# 11. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.


# 12. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017.
select c.id, c.nombre, c.apellido1, c.apellido2, count(p.id)
from cliente as c
         join pedido as p on c.id = p.id_cliente
where year(p.fecha) = 2017
group by c.id;
/*
 +--+------+---------+---------+-----------+
|id|nombre|apellido1|apellido2|count(p.id)|
+--+------+---------+---------+-----------+
|5 |Marcos|Loyola   |Méndez   |2          |
|2 |Adela |Salas    |Díaz     |2          |
|4 |Adrián|Suárez   |null     |1          |
|6 |María |Santana  |Moreno   |1          |
+--+------+---------+---------+-----------+

 */
# 13. Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados es 0. Puede hacer uso de la función IFNULL.


# 14. Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.


# 15. Devuelve el número total de pedidos que se han realizado cada año.