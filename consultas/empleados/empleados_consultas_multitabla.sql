# 1.2.4 Consultas multitabla (Composición interna)
use empleados;
# 1. Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
select e.nombre, e.apellido1, d.*
from empleado as e
         join departamento as d
              on e.id_departamento = d.id;
# 2. Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
select e.nombre, e.apellido1, e.apellido2, d.*
from empleado as e
         join departamento as d
              on e.id_departamento = d.id
order by d.nombre, e.apellido1, e.apellido2, e.nombre;

# 3. Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
select distinct d.id, d.nombre
from empleado as e
         join departamento as d
              on e.id_departamento = d.id;


# 4. Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).
select distinct d.id, d.nombre, (d.presupuesto - d.gastos) as 'presupuesto actual'
from empleado as e
         join departamento as d
              on e.id_departamento = d.id;

# 5. Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
select d.nombre
from empleado as e
         join departamento as d
              on e.id_departamento = d.id
where e.nif = '38382980M';

# 6. Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
select d.nombre
from empleado as e
         join departamento as d
              on e.id_departamento = d.id
where e.nombre = 'Pepe'
  and e.apellido1 = 'Ruiz'
  and e.apellido2 = 'Santana';

# 7. Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
select e.*
from empleado as e
         join departamento as d
              on e.id_departamento = d.id
where d.nombre = 'I+D'
order by e.apellido1, e.apellido2, e.nombre;


# 8. Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
select e.*
from empleado as e
         join departamento as d
              on e.id_departamento = d.id
where d.nombre in ('Sistemas', 'Contabilidad', 'I+D');

# 9. Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
select e.nombre
from empleado as e
         join departamento as d
              on e.id_departamento = d.id
where d.presupuesto not between 100000 and 200000;

# 10. Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
    select distinct d.nombre
    from empleado as e join departamento as d
on e.id_departamento = d.id
where e.apellido2 is null;


# 1.2.5 Consultas multitabla (Composición externa)
# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

# 1. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los empleados que no tienen ningún departamento asociado.

# 2. Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.

# 3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.

# 4. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

# 5. Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.