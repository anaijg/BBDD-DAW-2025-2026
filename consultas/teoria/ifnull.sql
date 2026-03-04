# # La función IFNULL se utiliza para manejar valores nulos (NULL) en las consultas, permitiendo sustituirlos por un valor alternativo predefinido.
# #
# # Sintaxis: IFNULL(expresion, valor_sustituto)
# # Donde:
# #   expresion: El campo o cálculo que quieres comprobar.
# #   valor_sustituto: El valor que se mostrará si la expresión es NULL.
#
# # Funcionamiento lógico:
# # La función evalúa el primer argumento:
# #   Si no es NULL, devuelve el valor original de la expresión.
# #   Si es NULL, devuelve el segundo argumento.
# #
# # Ejemplo práctico en la base de datos ventas
# # Si consultamos la tabla cliente, el campo apellido2 o categoria pueden contener nulos.SQL-- Si la categoría es NULL, mostramos 'Sin categoría'
use ventas;
# SELECT nombre, IFNULL(categoria, 0)
# FROM cliente;
# #
# # -- En el caso de Adolfo (ID 3), el resultado sería 0 en lugar de NULL.