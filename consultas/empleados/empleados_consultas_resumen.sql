# 1.2.6 Consultas resumen
use empleados;
# 1. Calcula la suma del presupuesto de todos los departamentos.
select sum(presupuesto)
from departamento;
-- 1035000

# 2. Calcula la media del presupuesto de todos los departamentos.
select avg(presupuesto)
from departamento;
-- 147857.14285714287

# 3. Calcula el valor mínimo del presupuesto de todos los departamentos.
select min(presupuesto)
from departamento;
-- 0

# 4. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
select nombre, presupuesto
from departamento
order by presupuesto
limit 1;
-- Proyectos|0


# 5. Calcula el valor máximo del presupuesto de todos los departamentos.
select max(presupuesto)
from departamento;
-- 375000

# 6. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
select nombre, presupuesto
from departamento
order by presupuesto desc
limit 1;
-- I+D|375000


# 7. Calcula el número total de empleados que hay en la tabla empleado.
select count(*)
from empleado;
-- 13

# 8. Calcula el número de empleados que no tienen NULL en su segundo apellido.
select count(apellido2)
from empleado;
-- 11

# 9. Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.
select d.nombre, count(e.id)
from departamento as d
         join empleado as e on d.id = e.id_departamento
group by d.id;
/*
 +----------------+-----------+
|nombre          |count(e.id)|
+----------------+-----------+
|Desarrollo      |3          |
|Sistemas        |3          |
|Recursos Humanos|2          |
|Contabilidad    |1          |
|I+D             |2          |
+----------------+-----------+
 */

# 10. Calcula el nombre de los departamentos que tienen más de 2 empleados. El resultado debe tener dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.
select d.nombre, count(e.id)
from departamento as d
         join empleado as e on d.id = e.id_departamento
group by d.id
having count(e.id) > 2;
/*
 +----------+-----------+
|nombre    |count(e.id)|
+----------+-----------+
|Desarrollo|3          |
|Sistemas  |3          |
+----------+-----------+
 */
# 11. Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.
select d.nombre, count(e.id)
from departamento as d
         left join empleado as e on d.id = e.id_departamento
group by d.nombre;
/*
 +----------------+-----------+
|nombre          |count(e.id)|
+----------------+-----------+
|Desarrollo      |3          |
|Sistemas        |3          |
|Recursos Humanos|2          |
|Contabilidad    |1          |
|I+D             |2          |
|Proyectos       |0          |
|Publicidad      |0          |
+----------------+-----------+
 */

# 12. Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros.
select d.nombre, count(e.id)
from departamento as d
         join empleado as e on d.id = e.id_departamento
where d.presupuesto > 200000
group by d.nombre;
/*
 +----------------+-----------+
|nombre          |count(e.id)|
+----------------+-----------+
|Recursos Humanos|2          |
|I+D             |2          |
+----------------+-----------+
 */