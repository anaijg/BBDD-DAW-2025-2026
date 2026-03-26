# 1.3.7 Subconsultas
    use ventas;
# 1.3.7.1 Con operadores básicos de comparación
# 1. Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).
SELECT *
FROM pedido
WHERE id_cliente = (
    SELECT id
    FROM cliente
    WHERE nombre = 'Adela'
      AND apellido1 = 'Salas'
      AND apellido2 = 'Díaz'
);

# 2. Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN)
SELECT COUNT(*)
FROM pedido
WHERE id_comercial = (
    SELECT id
    FROM comercial
    WHERE nombre = 'Daniel'
      AND apellido1 = 'Sáez'
      AND apellido2 = 'Vega'
);
# 3. Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER JOIN)
SELECT *
FROM cliente
WHERE id = (
    SELECT id_cliente
    FROM pedido
    WHERE YEAR(fecha) = 2019
      AND total = (
          SELECT MAX(total)
          FROM pedido
          WHERE YEAR(fecha) = 2019
      )
);
# 4. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
SELECT fecha, total
FROM pedido
WHERE id_cliente = (
    SELECT id
    FROM cliente
    WHERE nombre = 'Pepe'
      AND apellido1 = 'Ruiz'
      AND apellido2 = 'Santana'
)
AND total = (
    SELECT MIN(total)
    FROM pedido
    WHERE id_cliente = (
        SELECT id
        FROM cliente
        WHERE nombre = 'Pepe'
          AND apellido1 = 'Ruiz'
          AND apellido2 = 'Santana'
    )
);
# 5. Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año.
SELECT *
FROM cliente c, pedido p
WHERE c.id = p.id_cliente
  AND YEAR(p.fecha) = 2017
  AND p.total >= (
      SELECT AVG(total)
      FROM pedido
      WHERE YEAR(fecha) = 2017
  );
# 1.3.7.2 Subconsultas con ALL y ANY
# 6. Devuelve el pedido más caro que existe en la tabla pedido sin hacer uso de MAX, ORDER BY ni LIMIT.
SELECT *
FROM pedido
WHERE total >= ALL (
    SELECT total
    FROM pedido
);

# 7. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT *
FROM cliente
WHERE id != ALL (
    SELECT id_cliente
    FROM pedido
);

# 8. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT *
FROM comercial
WHERE id != ALL (
    SELECT id_comercial
    FROM pedido
);

# 1.3.7.3 Subconsultas con IN y NOT IN
# 9. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT *
FROM cliente
WHERE id NOT IN (
    SELECT id_cliente
    FROM pedido
);

# 10. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT *
FROM comercial
WHERE id NOT IN (
    SELECT id_comercial
    FROM pedido
);

# 1.3.7.4 Subconsultas con EXISTS y NOT EXISTS
# 11. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
-- No entra
# 12. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
-- No entra