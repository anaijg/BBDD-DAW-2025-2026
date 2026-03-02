# 1.1.7 Subconsultas (En la cláusula WHERE)
# 1.1.7.1 Con operadores básicos de comparación
# Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
#
# Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
#
# Lista el nombre del producto más caro del fabricante Lenovo.
#
# Lista el nombre del producto más barato del fabricante Hewlett-Packard.
#
# Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
#
# Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
# 
# 1.1.7.2 Subconsultas con ALL y ANY
# Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.
#
# Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.
#
# Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).
#
# Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).
#
# 1.1.7.3 Subconsultas con IN y NOT IN
# Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
#
# Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
#
# 1.1.7.4 Subconsultas con EXISTS y NOT EXISTS
# Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
#
# Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
#
# 1.1.7.5 Subconsultas correlacionadas
# Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
#
# Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.
#
# Lista el nombre del producto más caro del fabricante Lenovo.
#
# 1.1.8 Subconsultas (En la cláusula HAVING)
# Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.