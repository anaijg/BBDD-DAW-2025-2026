USE ventas;

-- 1. (0,5 puntos)
-- Muestra pedido_id, fecha y total de los pedidos con total mayor que 500, ordenados por total de mayor a menor.
SELECT pedido_id, fecha, total
FROM ventas_unica
WHERE total > 500
ORDER BY total DESC;


-- 2. (0,5 puntos)
-- Muestra pedido_id y cliente_nombre_completo de los pedidos cuyo nombre de cliente contenga la cadena "ez".
SELECT pedido_id, cliente_nombre_completo
FROM ventas_unica
WHERE cliente_nombre_completo LIKE '%ez%';


-- 3. (0,5 puntos)
-- Muestra los 4 pedidos más recientes (pedido_id, fecha y total).
-- Si hay empate de fecha, muestra primero el de mayor pedido_id.
SELECT pedido_id, fecha, total
FROM ventas_unica
ORDER BY fecha DESC, pedido_id DESC
LIMIT 4;


-- 4. (0,5 puntos)
-- Muestra (sin repetir) el nombre completo de los clientes que empiezan por vocal
-- y una columna llamada inicial con esa primera letra. Ordena alfabéticamente por nombre.
SELECT DISTINCT
       cliente_nombre_completo,
       LEFT(cliente_nombre_completo, 1) AS inicial
FROM ventas_unica
WHERE UPPER(LEFT(cliente_nombre_completo, 1)) IN ('A','E','I','O','U')
ORDER BY cliente_nombre_completo;


-- 5. (0,5 puntos)
-- Muestra los pedidos del año 2019 (pedido_id y fecha).
SELECT pedido_id, fecha
FROM ventas_unica
WHERE YEAR(fecha) = 2019
ORDER BY fecha, pedido_id;


-- 6. (0,5 puntos)
-- Cuenta cuántos pedidos hay con cliente_categoria igual a 200.
SELECT COUNT(*) AS num_pedidos
FROM ventas_unica
WHERE cliente_categoria = 200;


-- 7. (0,5 puntos)
-- Muestra comercial_id, total, comercial_comision y una columna importe_comision = total * comercial_comision,
-- redondeado a 4 decimales. Ordena por importe_comision de mayor a menor.
SELECT comercial_id,
       total,
       comercial_comision,
       ROUND(total * comercial_comision, 4) AS importe_comision
FROM ventas_unica
ORDER BY importe_comision DESC;


-- 8. (0,5 puntos)
-- Muestra el nombre de cada comercial y el total de comisiones cobradas por cada uno (total_importe_comision).
-- Redondea a 2 decimales. Ordena alfabéticamente por nombre del comercial.
SELECT comercial_nombre_completo,
       ROUND(SUM(total * comercial_comision), 2) AS total_importe_comision
FROM ventas_unica
GROUP BY comercial_nombre_completo
ORDER BY comercial_nombre_completo;


-- 9. (0,5 puntos)
-- Muestra los pedidos realizados en el mes de octubre (MONTH(fecha)=10), ordenados por fecha.
-- Devuelve pedido_id y fecha.
SELECT pedido_id, fecha
FROM ventas_unica
WHERE MONTH(fecha) = 10
ORDER BY fecha, pedido_id;


-- 10. (0,5 puntos)
-- Muestra el número de pedidos por ciudad. Devuelve cliente_ciudad y num_pedidos.
SELECT cliente_ciudad,
       COUNT(*) AS num_pedidos
FROM ventas_unica
GROUP BY cliente_ciudad;


-- 11. (0,5 puntos)
-- Muestra los clientes que han realizado más de un pedido. Devuelve cliente_nombre_completo y num_pedidos.
SELECT cliente_nombre_completo,
       COUNT(*) AS num_pedidos
FROM ventas_unica
GROUP BY cliente_nombre_completo
HAVING COUNT(*) > 1;


-- 12. (0,5 puntos)
-- Muestra (sin repetir) los clientes cuyo IMPORTE TOTAL gastado (suma de sus pedidos) es superior a 3000 €.
SELECT cliente_nombre_completo
FROM ventas_unica
GROUP BY cliente_nombre_completo
HAVING SUM(total) > 3000;


-- 13. (0,5 puntos)
-- Muestra el total vendido por año, ordenado por año ascendente.
SELECT YEAR(fecha) AS anio,
       ROUND(SUM(total), 2) AS total_vendido
FROM ventas_unica
GROUP BY anio
ORDER BY anio;


-- 14. (0,5 puntos)
-- Muestra para cada ciudad: cliente_ciudad, num_pedidos, total_vendido y media_pedido.
-- Ordena por total_vendido de mayor a menor.
SELECT cliente_ciudad,
       COUNT(*) AS num_pedidos,
       ROUND(SUM(total), 2) AS total_vendido,
       ROUND(AVG(total), 2) AS media_pedido
FROM ventas_unica
GROUP BY cliente_ciudad
ORDER BY total_vendido DESC;


-- 15. (0,5 puntos)
-- Muestra pedido_id, fecha y los días transcurridos desde el pedido hasta hoy (día en que se ejecuta la consulta).
SELECT pedido_id,
       fecha,
       DATEDIFF(CURDATE(), fecha) AS dias_desde_pedido
FROM ventas_unica
ORDER BY pedido_id;


-- 16. (0,5 puntos)
-- Muestra los años en los que el importe medio de los pedidos fue superior a 1000 €.
-- Devuelve anio y media_anual (redondeada a 2 decimales).
SELECT YEAR(fecha) AS anio,
       ROUND(AVG(total), 2) AS media_anual
FROM ventas_unica
GROUP BY anio
HAVING AVG(total) > 1000
ORDER BY anio;


-- 17. (0,5 puntos)
-- Muestra las ciudades que tienen más de un cliente distinto.
-- Devuelve cliente_ciudad y num_clientes.
SELECT cliente_ciudad,
       COUNT(DISTINCT cliente_id) AS num_clientes
FROM ventas_unica
GROUP BY cliente_ciudad
HAVING COUNT(DISTINCT cliente_id) > 1;


-- 18. (0,5 puntos)
-- Muestra las ciudades donde el total vendido supera 2000 € y el número de pedidos es mayor que 2.
-- Devuelve: cliente_ciudad, total_vendido, num_pedidos, media_pedido (media redondeada a 2 decimales).
SELECT cliente_ciudad,
       ROUND(SUM(total), 2) AS total_vendido,
       COUNT(*) AS num_pedidos,
       ROUND(AVG(total), 2) AS media_pedido
FROM ventas_unica
GROUP BY cliente_ciudad
HAVING SUM(total) > 2000
   AND COUNT(*) > 2;


-- 19. (1 punto)
-- Muestra los 2 clientes que más han gastado, SOLO si:
--  - su nombre contiene la letra "o"
--  - y la ciudad empieza por "A" o "G"
--  - y han realizado al menos 2 pedidos
-- Devuelve: cliente_nombre_completo.
SELECT cliente_nombre_completo
FROM ventas_unica
WHERE cliente_nombre_completo LIKE '%o%'
  AND (cliente_ciudad LIKE 'A%' OR cliente_ciudad LIKE 'G%')
GROUP BY cliente_nombre_completo
HAVING COUNT(*) >= 2
ORDER BY SUM(total) DESC
LIMIT 2;
