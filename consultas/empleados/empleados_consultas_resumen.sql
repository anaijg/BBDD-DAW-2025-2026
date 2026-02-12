# 1.2.6 Consultas resumen
use empleados;
# 1. Calcula la suma del presupuesto de todos los departamentos.
select sum(presupuesto)
from departamento;
# 2. Calcula la media del presupuesto de todos los departamentos.
select avg(presupuesto)
from departamento;

# 3. Calcula el valor mínimo del presupuesto de todos los departamentos.
select min(presupuesto)
from departamento;

# 4. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
select nombre, presupuesto
from departamento
order by presupuesto
limit 1;

# 5. Calcula el valor máximo del presupuesto de todos los departamentos.
select max(presupuesto)
from departamento;

# 6. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
select nombre, presupuesto
from departamento
order by presupuesto desc
limit 1;

# 7. Calcula el número total de empleados que hay en la tabla empleado.
select count(*)
from empleado;

# 8. Calcula el número de empleados que no tienen NULL en su segundo apellido.
select count(apellido2)
from empleado;

# 9. Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.


# 10. Calcula el nombre de los departamentos que tienen más de 2 empleados. El resultado debe tener dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.

# 11. Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.

# 12. Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros.