# 1.1.6 Consultas resumen
use tienda;
# 1. Calcula el número total de productos que hay en la tabla productos.
select count(*)
from producto;
-- 11
# 2. Calcula el número total de fabricantes que hay en la tabla fabricante.
select count(*)
from fabricante;
-- 9
# 3. Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos.
select count(distinct id_fabricante)
from producto;
-- 7

# 4. Calcula la media del precio de todos los productos.
select avg(precio)
from producto;
-- 271.7236363636364

# 5. Calcula el precio más barato de todos los productos.
select min(precio)
from producto;
-- 59.99

# 6. Calcula el precio más caro de todos los productos.
select max(precio)
from producto;
-- 755

# 7. Lista el nombre y el precio del producto más barato.
select nombre, precio
from producto
order by precio
limit 1;
-- Impresora HP Deskjet 3720,59.99

# 8. Lista el nombre y el precio del producto más caro.
select nombre, precio
from producto
order by precio desc
limit 1;
-- GeForce GTX 1080 Xtreme,755

# 9. Calcula la suma de los precios de todos los productos.
select sum(precio)
from producto;
-- 2988.96

# 10. Calcula el número de productos que tiene el fabricante Asus.
select count(*)
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id
where f.nombre = 'Asus';
-- 2

# 11. Calcula la media del precio de todos los productos del fabricante Asus.
select avg(precio)
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id
where f.nombre = 'Asus';
-- 223.995

# 12. Calcula el precio más barato de todos los productos del fabricante Asus.
select min(precio)
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id
where f.nombre = 'Asus';
-- 202

# 13. Calcula el precio más caro de todos los productos del fabricante Asus.
select max(precio)
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id
where f.nombre = 'Asus';
-- 245.99

# 14. Calcula la suma de todos los productos del fabricante Asus.
select sum(precio)
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id
where f.nombre = 'Asus';
-- 447.99

# 15. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
select max(precio) as precio_maximo,
       min(precio) as precio_minimo,
       avg(precio) as precio_medio,
       count(*)    as num_productos
from producto as p
         join fabricante as f
              on p.id_fabricante = f.id
where f.nombre = 'Crucial';
-- 755,120,437.5,2

# 16. Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también debe incluir los fabricantes que no tienen ningún producto. El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.
#
# 17. Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
#
# 18. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente.
#
# 19. Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.
#
# 20. Calcula el número de productos que tienen un precio mayor o igual a 180€.
#
# 21. Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
#
# 22. Lista el precio medio los productos de cada fabricante, mostrando solamente el identificador del fabricante.
#
# 23. Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
#
# 24. Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.
#
# 25. Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
#
# 26. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
#
# Ejemplo del resultado esperado:
#
# nombre	total
# Lenovo	2
# Asus	1
# Crucial	1
# 27. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. El listado debe mostrar el nombre de todos los fabricantes, es decir, si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ deberá aparecer en el listado con un valor igual a 0 en el número de productos.
# Ejemplo del resultado esperado:
#
# nombre	total
# Lenovo	2
# Crucial	1
# Asus	1
# Huawei	0
# Samsung	0
# Gigabyte	0
# Hewlett-Packard	0
# Xiaomi	0
# Seagate	0
# 28. Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.
#
# 29. Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante. El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.