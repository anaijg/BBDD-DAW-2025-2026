# El operador UNION se utiliza para combinar el conjunto de resultados de dos o más sentencias SELECT en un único resultado.
#
# Piénsalo como "pegar" una tabla debajo de otra, a diferencia de los JOIN que pegan las tablas de lado (columnas).
#
# 1. Reglas de Oro para usar UNION
# Para que MySQL no te lance un error, debes cumplir tres condiciones:
#
#     a) Mismo número de columnas: Si el primer SELECT tiene 3 columnas, el segundo debe tener 3.
#
#     b) Tipo de datos compatibles: Las columnas en la misma posición deben tener tipos de datos similares (no puedes unir un INT con un BLOB gigante).
#
#     c) Orden de las columnas: Deben estar en el mismo orden semántico (Nombre con Nombre, ID con ID).
#
#
# Si como resultado de la consulta salen filas duplicadas, UNION las elimina. Es decir, si un registro aparece en ambas consultas, solo te lo muestra una vez.
#
# 3. Ejemplo práctico con la base de datos empleados
# Imagina que quieres una lista única de "Nombres" que aparecen en la base de datos, ya sean nombres de empleados o nombres de departamentos:
#
use empleados;
SELECT nombre FROM empleado
UNION
SELECT nombre FROM departamento;

# En la práctica lo utilizaremos cuando el enunciado "nos pida" hacer un left join y un right join a la vez, como en el ejercicio 4. de consultas multitabla (composición externa) para la base de datos de empleados