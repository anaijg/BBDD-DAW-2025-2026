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


# 8. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.


# 9. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.


# 10. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.


# 11. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.


# 12. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017.


# 13. Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados es 0. Puede hacer uso de la función IFNULL.


# 14. Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.


# 15. Devuelve el número total de pedidos que se han realizado cada año.