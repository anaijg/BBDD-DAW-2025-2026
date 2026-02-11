## count(*) cuenta el número de filas que tiene el resultado de la consulta
use universidad;
# quiero saber cuántos alumnos tengo en la base de datos
select count(*)
from alumno;
-- 12 alumnos

# si lo que quiero es contar los valores no nulos en una columna, entonces es count(columna)
# ejemplo: número de alumnos con número de teléfono (o sea, que en teléfono no sea null)
select count(telefono)
from alumno;
-- tengo 10 teléfonos

# quiero saber cuántos alumnos hombres hay
select count(*)
from alumno
where sexo = 'H';

# quiero saber cuántas alumnas hay
select count(*)
from alumno
where sexo = 'M';


# si quieres saber cuántos hay distintos, tienes que añadir DISTINCT
select count(curso)
from asignatura; -- esto me dice cuántas filas tengo en curso, pero no cuántos cursos distintos hay, eso se haría así

select count(distinct curso)
from asignatura;

## hemos visto: count(*), count(columna), count(distinct columna)

## otras funci0nes de agregación QUE SOLO FUNCIONAN EN CAMPOS NUMÉRICOS:

# max -> te devuelve el número más grande
# min -> te devuelve el número más pequeño
# avg -> te devuelve la media de los números de esa columna
# sum -> te devuelve la suma de los números de esa columna

# quiero saber el curso más alto y el más bajo que se imparte
select max(curso), min(curso)
from asignatura;

# quiero la media de los créditos de las asignaturas
select avg(creditos)
from asignatura;

# quiero sumar los id de los alumnos
select sum(id)
from alumno;

# quiero saber cuántas letras tiene el nombre del alumno con el nombre más largo
select max(length(nombre))
from alumno;