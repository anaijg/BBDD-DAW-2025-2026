use empleados;
# 1.2.7 Subconsultas
# 1.2.7.1 Con operadores básicos de comparación
# 1. Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN). Nombre, apellido1 y apellido 2 de los empleados
select nombre, apellido1, apellido2
from empleado
where id_departamento = (select id
                         from departamento
                         where nombre = 'Sistemas');

# 2. Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. (Sin utilizar order by ni limit)
select nombre, presupuesto
from departamento
where presupuesto = (select max(presupuesto)
                     from departamento);

# 3. Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.
select nombre, presupuesto
from departamento
where presupuesto = (select min(presupuesto)
                     from departamento);

# 1.2.7.2 Subconsultas con ALL y ANY
# 4. Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MAX, ORDER BY ni LIMIT.
#
# 5. Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MIN, ORDER BY ni LIMIT.
#
# 6. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).
#
# 7. Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando ALL o ANY).
#
# 1.2.7.3 Subconsultas con IN y NOT IN
# 8. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).
#
# 9. Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando IN o NOT IN).
#
# 1.2.7.4 Subconsultas con EXISTS y NOT EXISTS
# 10. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).
#
# 11. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).