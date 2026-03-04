use ventas;
# 1. Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.
select *
from pedido
order by fecha desc;
# 2. Devuelve todos los datos de los dos pedidos de mayor valor.
select total, id, fecha, id_cliente, id_comercial
from pedido
limit 2;
# 3. Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
select distinct id_cliente
from pedido;
# 4. Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.
SELECT *
FROM pedido
WHERE YEAR(fecha) = 2017
  AND total > 500;
# 5. Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.
SELECT nombre, apellido1, apellido2
FROM comercial
WHERE comision BETWEEN 0.05 AND 0.11;
# 6. Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.
select max(comision)
from comercial;
# 7. Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. El listado deberá estar ordenado alfabéticamente por apellidos y nombre.
select id, nombre , apellido1 , apellido2
    from cliente
where apellido2 is not null
order by apellido2 , nombre desc ;
# 8. Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. El listado deberá estar ordenado alfabéticamente.
SELECT nombre
FROM cliente
WHERE nombre LIKE 'a%' AND nombre LIKE '%n'
   OR nombre LIKE 'p%'
ORDER BY nombre;
# 9. Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.
SELECT nombre
FROM cliente
WHERE nombre NOT LIKE 'A%'
ORDER BY nombre;
# 10. Devuelve un listado con los nombres de los comerciales que terminan por el o o. Tenga en cuenta que se deberán eliminar los nombres repetidos.
SELECT DISTINCT nombre
FROM comercial
WHERE nombre LIKE '%el'
   OR nombre LIKE '%o'; 