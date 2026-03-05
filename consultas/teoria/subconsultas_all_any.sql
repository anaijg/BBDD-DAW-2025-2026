## Subconsultas con ALL y ANY
#
# Estas cláusulas se utilizan para comparar un valor individual con un conjunto de valores devueltos por una subconsulta.
#
# Siempre van precedidas de un operador de comparación: =, <>, <, >, <=, >=.
#
#
## 1. El operador ALL (Todos)
# La condición se cumple solo si la comparación es verdadera para todos los elementos de la lista.
#     > ALL: El valor debe ser mayor que el máximo del conjunto.
#     < ALL: El valor debe ser menor que el mínimo del conjunto.
#
# Ejemplo práctico:
# "Queremos encontrar los productos cuyo precio sea mayor que el precio de todos los productos del fabricante 'Lenovo'
use tienda;
SELECT p.nombre, p.precio, f.nombre
FROM producto p join fabricante f on p.id_fabricante = f.id
WHERE precio > ALL (
     SELECT precio
     FROM producto
     WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Hewlett-Packard')
 );


# 2. El operador ANY / (Cualquiera, alguno)
# La condición se cumple si la comparación es verdadera para al menos uno de los elementos de la lista.
#     > ANY: El valor debe ser mayor que el mínimo del conjunto.
#     < ANY: El valor debe ser menor que el máximo del conjunto.
#     = ANY: Es exactamente lo mismo que usar el operador IN.

# Ejemplo práctico: "Queremos encontrar los productos que tengan un precio igual al de cualquier producto del fabricante 'Asus'.
SELECT nombre, precio
FROM producto
WHERE precio = ANY (
     SELECT precio
     FROM producto
     WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Asus')
 );
#
# Tabla de referencia rápida
# Operador  Significado Lógico              Equivalencia Común
# > ALL     Mayor que el valor máximo           —
# < ALL     Menor que el valor mínimo           —
# = ANY     Igual a cualquiera de la lista      IN
# != ALL    No es igual a ninguno               NOT IN
# > ANY     Mayor que el valor más pequeño      —

# ⚠️ Nota: El peligro de los NULLs
# Ten mucho cuidado: si la subconsulta devuelve un valor NULL, la comparación con ALL puede devolver un resultado vacío o desconocido (unknown). Asegúrate siempre de que tus datos están limpios o usa WHERE columna IS NOT NULL en la subconsulta si es necesario.