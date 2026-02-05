# composición cruzada -> producto cartesiano - combinaciones de cada registro de una tabla tabla con todos los registros de la otra (esta no mola, salen resultados duplicados)
# ejemplo:
use empleados;
select * from empleado, departamento;

# composición interna -> intersección - el resultado contiene solo los elementos comunes de ambas tablas (esta sí)
select *
from empleado, departamento
where empleado.id_departamento = departamento.id;

# lo anterior se expresa con la palabra JOIN
# JOIN (unir) sirve para unir dos tablas
# tenemos cinco tipos de JOIN:
# CROSS JOIN -> devuelve el producto cartesiano (combinaciones de todos con todos -> no mola)
# (INNER) JOIN -> devuelve la intersección entre dos tablas relacionadas -> esta es la buena
# LEFT (OUTER) JOIN -> intersección + datos de la tabla de la izquierda
# RIGHT (OUTER) JOIN -> intersección + datos de la tabla de la derecha
# FULL (OUTER) JOIN -> datos de ambas tablas, pero no combinados

# la sintaxis de JOIN requiere que añadamos la palabra ON, y a continuación indicamos los campos en común (clave primaria en una tabla, clave foránea en la otra)

#################################
# INNER JOIN  (o JOIN a secas)  #
#################################
# ejemplo
SELECT *
FROM empleado JOIN departamento
ON empleado.id_departamento = departamento.id;

# si depuramos un poco la consulta para que no muestre todos los datos, sino solamente los "interesantes", quedaría
SELECT empleado.nombre, empleado.apellido1, empleado.apellido2, departamento.nombre
FROM empleado JOIN departamento
ON empleado.id_departamento = departamento.id;

