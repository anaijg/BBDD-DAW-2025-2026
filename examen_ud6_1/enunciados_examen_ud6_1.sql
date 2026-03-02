

-- 1. (0,5 puntos)
-- Muestra pedido_id, fecha y total de los pedidos con total mayor que 500, ordenados por total de mayor a menor.


-- 2. (0,5 puntos)
-- Muestra pedido_id y cliente_nombre_completo de los pedidos cuyo nombre de cliente contenga la cadena "ez".


-- 3. (0,5 puntos)
-- Muestra los 4 pedidos más recientes (pedido_id, fecha y total).
-- Si hay empate de fecha, muestra primero el de mayor pedido_id.


-- 4. (0,5 puntos)
-- Muestra (sin repetir) el nombre completo de los clientes que empiezan por vocal
-- y una columna llamada inicial con esa primera letra. Ordena alfabéticamente por nombre.


-- 5. (0,5 puntos)
-- Muestra los pedidos del año 2019 (pedido_id y fecha).


-- 6. (0,5 puntos)
-- Cuenta cuántos pedidos hay con cliente_categoria igual a 200.


-- 7. (0,5 puntos)
-- Muestra comercial_id, total, comercial_comision y una columna importe_comision = total * comercial_comision,
-- redondeado a 4 decimales. Ordena por importe_comision de mayor a menor.


-- 8. (0,5 puntos)
-- Muestra el nombre de cada comercial y el total de comisiones cobradas por cada uno (total_importe_comision).
-- Redondea a 2 decimales. Ordena alfabéticamente por nombre del comercial.


-- 9. (0,5 puntos)
-- Muestra los pedidos realizados en el mes de octubre, ordenados por fecha.
-- Devuelve pedido_id y fecha.


-- 10. (0,5 puntos)
-- Muestra el número de pedidos por ciudad. Devuelve cliente_ciudad y num_pedidos.


-- 11. (0,5 puntos)
-- Muestra los clientes que han realizado más de un pedido. Devuelve cliente_nombre_completo y num_pedidos.


-- 12. (0,5 puntos)
-- Muestra (sin repetir) los clientes cuyo IMPORTE TOTAL gastado es superior a 3000 €.


-- 13. (0,5 puntos)
-- Muestra el total vendido por año, ordenado por año ascendente.


-- 14. (0,5 puntos)
-- Muestra para cada ciudad: cliente_ciudad, num_pedidos, total_vendido y media_pedido.
-- Ordena por total_vendido de mayor a menor.


-- 15. (0,5 puntos)
-- Muestra pedido_id, fecha y los días transcurridos desde el pedido hasta hoy (día en que se ejecuta la consulta).


-- 16. (0,5 puntos)
-- Muestra los años en los que el importe medio de los pedidos fue superior a 1000 €.
-- Devuelve año y media_anual (redondeada a 2 decimales).


-- 17. (0,5 puntos)
-- Muestra las ciudades que tienen más de un cliente distinto.
-- Devuelve cliente_ciudad y num_clientes.


-- 18. (0,5 puntos)
-- Muestra las ciudades donde el total vendido supera 2000 € y el número de pedidos es mayor que 2.
-- Devuelve: cliente_ciudad, total_vendido, num_pedidos, media_pedido (media redondeada a 2 decimales).


-- 19. (1 punto)
-- Muestra los 2 clientes que más han gastado, SOLO si:
--  - su nombre contiene la letra "o"
--  - y la ciudad empieza por "A" o "G"
--  - y han realizado al menos 2 pedidos
-- Devuelve: cliente_nombre_completo.
