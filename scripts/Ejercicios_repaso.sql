# 1. Realice los siguientes procedimientos y funciones sobre la base de datos `jardineria`.
# **a)**  Función: `calcular_precio_total_pedido`
#   - Descripción: Dado un código de pedido la función debe calcular la suma total del pedido. Tenga en cuenta que un pedido puede contener varios productos diferentes y varias cantidades de cada producto.
#   - Parámetros de entrada: `codigo_pedido` (INT)
#   - Parámetros de salida: El precio total del pedido (DECIMAL)
#
# **b)** Función: `calcular_suma_pedidos_cliente`
#   - Descripción: Dado un código de cliente la función debe calcular la suma total de todos los pedidos realizados por el cliente. Deberá hacer uso de la función `calcular_precio_total_pedido` que ha desarrollado en el apartado anterior.
#   - Parámetros de entrada: `codigo_cliente` (INT)
#   - Parámetros de salida: La suma total de todos los pedidos del cliente (DECIMAL)
#
# **c)** Función: `calcular_suma_pagos_cliente`
#   - Descripción: Dado un código de cliente la función debe calcular la suma total de los pagos realizados por ese cliente.
#   - Parámetros de entrada: `codigo_cliente` (INT)
#   - Parámetros de salida: La suma total de todos los pagos del cliente (DECIMAL)
#
# **d)** Procedimiento: `calcular_pagos_pendientes`
#   - Descripción: Deberá calcular los pagos pendientes de todos los clientes. Para saber si un cliente tiene algún pago pendiente deberemos calcular cuál es la cantidad de todos los pedidos y los pagos que ha realizado. Si la cantidad de los pedidos es mayor que la de los pagos entonces ese cliente tiene pagos pendientes.
#   - Deberá utilizar las funciones `calcular_suma_pedidos_cliente` y `calcular_suma_pagos_cliente`, que ha desarrollado en los ejercicios anteriores.
#   - Deberá insertar en una tabla llamada `clientes_con_pagos_pendientes` los siguientes datos:
#     - `codigo_cliente`
#     - `suma_total_pedidos`
#     - `suma_total_pagos`
#     - `pendiente_de_pago`
# 2. Escriba un procedimiento llamado `obtener_numero_empleados` que reciba como parámetro de entrada el código de una oficina y devuelva el número de empleados que tiene.
# Escriba una sentencia SQL que realice una llamada al procedimiento realizado para comprobar que se ejecuta correctamente.
# 3. Escriba una función llamada `cantidad_total_de_productos_vendidos` que reciba como parámetro de entrada el código de un producto y devuelva la cantidad total de productos que se han vendido con ese código.
# Escriba una sentencia SQL que realice una llamada a la función realizada para comprobar que se ejecuta correctamente.
# 4. Crea una tabla que se llame `productos_vendidos` que tenga las siguientes columnas:
# - `id` (entero sin signo, auto incremento y clave primaria)
# - `codigo_producto` (cadena de caracteres)
# - `cantidad_total` (entero)
# Escriba un procedimiento llamado `estadísticas_productos_vendidos`, que para cada uno de los productos de la tabla producto,  calcule la cantidad total de unidades que se han vendido y almacene esta información en la tabla `productos_vendidos`.
#
# El procedimiento tendrá que realizar las siguientes acciones:
# - Borrar el contenido de la tabla `productos_vendidos`.
# - Calcular la cantidad total de productos vendidos. En este paso será necesario utilizar la función `cantidad_total_de_productos_vendidos` desarrollada en el ejercicio anterior.
# - Insertar en la tabla `productos_vendidos` los valores del código de producto y la cantidad total de unidades que se han vendido para ese producto en concreto.
#
# 5. Crea una tabla que se llame `notificaciones` que tenga las siguientes columnas:
# - `id` (entero sin signo, autoincremento y clave primaria)
# - `fecha_hora`: marca de tiempo con el instante del pago (fecha y hora)
# - `total`: el valor del pago (real)
# - `codigo_cliente`: código del cliente que realiza el pago (entero)
# Escriba un trigger que nos permita llevar un control de los pagos que van realizando los clientes. Los detalles de implementación son los siguientes:
#
# - Nombre: `trigger_notificar_pago`
# - Se ejecuta sobre la tabla `pago`.
# - Se ejecuta después de hacer la inserción de un pago.
# - Cada vez que un cliente realice un pago (es decir, se hace una inserción en la tabla `pago`), el trigger deberá insertar un nuevo registro en una tabla llamada `notificaciones`.
# Escriba algunas sentencias SQL para comprobar que el trigger funciona correctamente.