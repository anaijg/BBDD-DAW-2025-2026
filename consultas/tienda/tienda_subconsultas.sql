use tienda;
# 1.1.7 Subconsultas (En la cláusula WHERE)
# 1.1.7.1 Con operadores básicos de comparación
# 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select *
from producto
where id_fabricante = (select id
                       from fabricante
                       where nombre = 'Lenovo');

# 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
select *
from producto
where precio = (select max(precio)
                from producto
                where id_fabricante = (select id
                                       from fabricante
                                       where nombre = 'Lenovo'));

# 3. Lista el nombre del producto más caro del fabricante Lenovo. (Es decir, se tienen que cumplir dos condiciones: que el precio sea el más caro del fabricante Lenovo, y además que el fabricante sea Lenovo)
select nombre
from producto
where precio = (select max(precio)
                from producto
                where id_fabricante = (select id
                                       from fabricante
                                       where nombre = 'Lenovo'))
  and id_fabricante = (select id from fabricante where nombre = 'Lenovo');


# 4. Lista el nombre del producto más barato del fabricante Hewlett-Packard.
select nombre
from producto
where precio =
(select min(precio)
from producto
where id_fabricante = (select id
                       from fabricante
                       where nombre = 'Hewlett-Packard')
  and id_fabricante = (select id
                       from fabricante
                       where nombre = 'Hewlett-Packard'));

# 5. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
#
# 6. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
# 
# 1.1.7.2 Subconsultas con ALL y ANY
# 7. Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.
#
# 8. Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.
#
# 9. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).
#
# 10. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).
#
# 1.1.7.3 Subconsultas con IN y NOT IN
# 11. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
#
# 12. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
#
# 1.1.7.4 Subconsultas con EXISTS y NOT EXISTS
# 13. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
#
# 14. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
#
# 1.1.7.5 Subconsultas correlacionadas
# 15. Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
#
# 16. Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.
#
# 17. Lista el nombre del producto más caro del fabricante Lenovo.
#
# 1.1.8 Subconsultas (En la cláusula HAVING)
# 18. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.