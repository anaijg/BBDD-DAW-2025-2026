# composición interna (INNER JOIN)
use tienda;
# 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
select p.nombre, p.precio, f.nombre
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id;

# 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
select p.nombre, p.precio, f.nombre
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id
order by f.nombre;

# 3. Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.
select p.id, p.nombre, f.id, f.nombre
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id

# 4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select p.nombre, p.precio, f.nombre
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id
order by p.precio
limit 1;

# 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.


# 6. Devuelve una lista de todos los productos del fabricante Lenovo.


# 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.


# 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
#
# 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
#
# 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
#
# 11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
#
# 12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
#
# 13. Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.

# composición externa (OUTER JOIN)
# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
#
# 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
#
# 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
#
# 3. ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.