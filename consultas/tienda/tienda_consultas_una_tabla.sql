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
-- todo

# 9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.

# 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
#
# 11. Lista el identificador de los fabricantes que tienen productos en la tabla producto.
#
# 12. Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.
#
# 13. Lista los nombres de los fabricantes ordenados de forma ascendente.
#
# 14. Lista los nombres de los fabricantes ordenados de forma descendente.
#
# 15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
#
# 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
#
# 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
#
# 18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
#
# 19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
#
# 20. Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.
#
# 21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
#
# 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
#
# 23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
#
# 24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
#
# 25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
#
# 26. Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.
#
# 27. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
#
# 28. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.
#
# 29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
#
# 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
#
# 31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
#
# 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
#
# 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
#
# 34. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
#
# 35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
#
# 36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).