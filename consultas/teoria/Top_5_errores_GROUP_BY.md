# 🚩 Top 5 Errores Comunes con GROUP BY
## 1. El error del "Campo Huérfano" (SQL no determinista)
Es el error más frecuente. El alumno selecciona columnas que no están en el GROUP BY ni tienen una función de agregado.

❌ Error: SELECT nombre, gama, SUM(cantidad_en_stock) FROM producto GROUP BY gama;

💡 Por qué falla: SQL sabe sumar el stock por gama, pero si en una gama hay 20 productos, ¿qué nombre de la columna nombre debe mostrar? El motor se bloquea (o devuelve un dato aleatorio en versiones antiguas de MySQL).

✅ Solución: Todas las columnas del SELECT que no tengan SUM, COUNT, etc., deben estar en el GROUP BY.

## 2. Confundir WHERE con HAVING
El alumno intenta filtrar el resultado de una suma o conteo usando WHERE.

❌ Error: SELECT gama, COUNT(*) FROM producto WHERE COUNT(*) > 5 GROUP BY gama;

💡 Por qué falla: El WHERE filtra filas individuales antes de que se haga la suma. El HAVING filtra grupos después de sumar.

✅ Solución: Usa HAVING para condiciones que involucren funciones de agregado.

## 3. Usar Alias del SELECT en el WHERE
El alumno intenta usar el nombre que le ha dado a una columna calculada para filtrar filas.

❌ Error: SELECT (precio_venta * 1.21) AS precio_iva FROM producto WHERE precio_iva > 100;

💡 Por qué falla: El orden de ejecución de SQL es FROM -> WHERE -> SELECT. Cuando se ejecuta el WHERE, el alias precio_iva aún no existe.

✅ Solución: Repite la operación en el WHERE o usa una subconsulta/CTE.

## 4. Contar columnas con nulos (COUNT(columna) vs COUNT(*))
⚠️ El despiste: El alumno usa COUNT(apellido2) pensando que contará a todos los empleados.

💡 Resultado: Como apellido2 puede ser NULL, ese empleado no se contará.

✅ Solución: Usa COUNT(*) si quieres contar registros totales, o COUNT(columna) solo si quieres ignorar los nulos de forma consciente.

## 5. Agrupar por columnas que no son clave primaria
❌ Error: Agrupar solo por ciudad en la tabla cliente.

💡 El riesgo: Si tienes dos ciudades que se llaman igual en países distintos, SQL las mezclará en una sola fila.

✅ Solución: Es una buena práctica incluir siempre la clave primaria o un identificador único en el GROUP BY si quieres diferenciar entidades con nombres iguales.

## 🛠️ Visualización del Flujo de Ejecución

*FROM / JOIN:* ¿De dónde saco los datos?

*WHERE:* ¿Qué filas individuales me sirven?

*GROUP BY: ¿Cómo las agrupo?*

*HAVING: ¿Qué grupos cumplen mi condición?*

*SELECT:* ¿Qué columnas muestro?

*ORDER BY:* ¿Cómo los ordeno al final?