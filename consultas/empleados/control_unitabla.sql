use empleados;

# 1. Devuelve id, nif, nombre y apellido1 de los empleados cuyo nif no tenga 9 caracteres.
select id, nif, nombre, apellido1
from empleado
where length(nif) != 9;

# 2. De los empleados, devuelve id, nif, una columna nif_numero (solo dígitos, sin letra) y otra nif_letra.
# Ordena por nif_numero ascendente.
select id, nif, left(nif, 8) as nif_numero, right(nif, 1) as nif_letra
from empleado
order by nif_numero;

# 3. De los empleados, devuelve id, nombre, apellido1, apellido2 y la longitud de su nombre completo. Muestra los 3 empleados con mayor longitud.
select id, nombre, apellido1, apellido2, (length(nombre) + length(apellido1) + length(apellido2)) as longitud_nombre
from empleado
order by longitud_nombre desc
limit 3;
# nota: habría que resolver el tema de que los NULL en apellido2 los hace mal, pero es una función que no hemos dado

# 4. Empleados cuyo nombre contiene una “a” (sin importar mayúsculas/minúsculas) y tiene 5 o más letras
# Devuelve id, nombre y nif filtrando por esas dos condiciones.
select id, nombre, nif
from empleado
where nombre like '%a%'
  and length(nombre) >= 5;

# 5. Devuelve nombre y una columna impacto calculada como:
# (presupuesto − gastos) / presupuesto * 100
# Redondea el resultado a 1 decimal.
select nombre, round((presupuesto - gastos) / presupuesto * 100, 1) as impacto
from departamento;