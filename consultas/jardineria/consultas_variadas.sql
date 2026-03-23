# # 1.4.9 Consultas variadas
use jardineria;
# # 1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
select c.nombre_cliente, ifnull(count(p.codigo_pedido), 0) as numero_pedidos
from cliente c
         left join pedido p on c.codigo_cliente = p.codigo_cliente
group by c.nombre_cliente;
# # 2. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
select c.nombre_cliente, ifnull(sum(p.total))
from cliente c
         left join pago p on c.codigo_cliente = p.codigo_cliente
group by c.nombre_cliente;
# # 3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
select c.nombre_cliente
from cliente c
         join pedido p on c.codigo_cliente = p.codigo_cliente
where year(p.fecha_pedido) = 2008
group by c.nombre_cliente
order by c.nombre_cliente;
# # 4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
select distinct c.nombre_cliente, e.nombre, e.apellido1, o.telefono
from cliente c
         join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
         join oficina o on e.codigo_oficina = o.codigo_oficina
         left join pago p on c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente is null;
######################
# El LEFT JOIN se usa solo para la tabla donde buscamos la "ausencia" de datos (en este caso, pago).
######################
# # 5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.
select distinct c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
    from cliente c join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
join oficina o on e.codigo_oficina = o.codigo_oficina;
# # 6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
select distinct e.nombre, e.apellido1, e.puesto, o.telefono
from empleado e
         left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
         join oficina o on e.codigo_oficina = o.codigo_oficina
where c.codigo_cliente is null;
# # 7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
select o.ciudad, ifnull(count(e.codigo_empleado), 0)
from oficina o
         left join empleado e on o.codigo_oficina = e.codigo_oficina
group by o.ciudad;
