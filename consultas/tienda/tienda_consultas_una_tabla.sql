# 1.1.3 Consultas sobre una tabla
use tienda;
# 1. Lista el nombre de todos los productos que hay en la tabla producto.
select nombre
from producto;

# 2. Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre, precio
from producto;

# 3. Lista todas las columnas de la tabla producto.
select *
from producto;

# 4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
select nombre, precio as 'precio en €', round((precio * 1.18), 4) as 'precio en USD'
from producto;

# 5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
-- visto

# 6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
select upper(nombre), precio
from producto;

# 7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
select lower(nombre), precio
from producto;

# 8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
select nombre, upper(left(nombre, 2))
from fabricante;

# Idea de la profesora:
# Mostrar los nombres completos con solo las dos primeras letras en mayúscula

select concat(upper(left(nombre, 2)), right(nombre, length(nombre) - 2))
from fabricante;

-- otra forma
select concat(upper(left(nombre, 2)), substring(nombre, 3))
from fabricante;


# 9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select nombre, round(precio)
from producto;

# 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select nombre, truncate(precio, 0)
from producto;

# 11. Lista el identificador de los fabricantes que tienen productos en la tabla producto.
select id_fabricante
from producto;

# 12. Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.
select distinct id_fabricante
from producto;

# 13. Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre
from fabricante
order by nombre;

# 14. Lista los nombres de los fabricantes ordenados de forma descendente.
select nombre
from fabricante
order by nombre desc;

# 15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
select nombre
from producto
order by nombre, precio desc;

# 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select *
from fabricante
limit 5;

# 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
select *
from fabricante
limit 3, 2;
-- a partir de la fila 3 cojo las dos filas siguientes

# 18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio
from producto
order by precio
limit 1;

# 19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio
from producto
order by precio desc
limit 1;

# 20. Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.
select nombre
from producto
where id_fabricante = 2;

# 21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
select nombre
from producto
where precio <= 120;

# 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
select nombre
from producto
where precio >= 400;

# 23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
select nombre
from producto
where not precio >= 400;

# 24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
select *
from producto
where precio >= 80
  and precio <= 300;

# 25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
select *
from producto
where precio between 60 and 200;

# 26. Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.
select *
from producto
where precio > 200
  and id_fabricante = 6;

# 27. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
select *
from producto
where id_fabricante = 1
   or id_fabricante = 3
   or id_fabricante = 5;

# 28. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.
select *
from producto
where id_fabricante in (1, 3, 5);

# 29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
select nombre, precio * 100 as 'céntimos'
from producto;

# 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
select nombre
from fabricante
where nombre like 'S%'
   or nombre like 's%';

# 31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
select nombre
from fabricante
where nombre like '%e';

# 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
select nombre
from fabricante
where nombre like '%w%';

# 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
select nombre
from fabricante
where nombre like '____';

-- otra forma
select nombre
from fabricante
where length(nombre) = 4;

# 34. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
select nombre
from producto
where nombre like '%Portátil%';

# 35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
select nombre
from producto
where nombre like '%Monitor%'
  and precio < 215;

# 36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
select nombre, precio
from producto
where precio >= 180
order by precio desc, nombre;