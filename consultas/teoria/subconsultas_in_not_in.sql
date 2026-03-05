# 1. El operador IN
# Se utiliza para filtrar registros cuyo valor coincide con cualquiera de los valores devueltos por la subconsulta.
# Es como un OR múltiple y automático.
# Sintaxis:
# SELECT columnas
# FROM tabla
# WHERE columna IN (SELECT columna FROM otra_tabla WHERE condicion);
# Ejemplo práctico:
# Queremos obtener todos los datos de los productos que pertenecen a los fabricantes 'Asus' o 'Samsung'.
use tienda;
SELECT * FROM producto
WHERE id_fabricante IN (
    SELECT id
    FROM fabricante
    WHERE nombre = 'Asus' OR nombre = 'Samsung'
);
# 2. El operador NOT IN
# Funciona de forma inversa: selecciona los registros cuyo valor no se encuentra en el conjunto devuelto por la subconsulta.
# Ejemplo práctico:
# Queremos saber qué profesores no tienen asignada ninguna tutoría este año.
SELECT nombre
FROM fabricante
WHERE id NOT IN (
    SELECT DISTINCT id_fabricante
    FROM producto
);
# ⚠️ El peligro de los valores NULL
# Ten mucho cuidado con NOT IN si la subconsulta devuelve un NULL.
# Si la subconsulta devuelve un NULL entre sus resultados, la consulta principal con NOT IN no devolverá ninguna fila.
# Consejo: Usa siempre un WHERE columna IS NOT NULL en tu subconsulta si vas a usar NOT IN.
