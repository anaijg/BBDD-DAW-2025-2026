USE test;
# Sin sentencias SQL
# 1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!.
DELIMITER $$
DROP PROCEDURE IF EXISTS hola_mundo;
CREATE PROCEDURE hola_mundo()
BEGIN
    SELECT 'Hola, mundo';
end $$
CALL hola_mundo();

# Con sentencias SQL
# 2. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese país.
USE jardineria;
DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_país;
CREATE PROCEDURE clientes_pais(IN pais VARCHAR(50))
BEGIN
    SELECT * FROM cliente c WHERE c.pais = pais;
end $$

CALL clientes_pais('Australia');

# 3. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo valor realizado para esa forma de pago. Deberá hacer uso de la tabla pago de la base de datos jardineria.
DELIMITER $$
DROP PROCEDURE IF EXISTS maximo_pago;
CREATE PROCEDURE maximo_pago(
    IN forma_pago VARCHAR(40),
    OUT total_maximo DECIMAL(15, 2)
)
BEGIN
    SET total_maximo = (SELECT MAX(total)
                        FROM pago p
                        WHERE p.forma_pago = forma_pago);
end $$

CALL maximo_pago('Cheque', @total_maximo);
SELECT @total_maximo;

# 4. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
#
# el pago de máximo valor,
# el pago de mínimo valor,
# el valor medio de los pagos realizados,
# la suma de todos los pagos,
# el número de pagos realizados para esa forma de pago. Deberá hacer uso de la tabla pago de la base de datos jardineria.
DELIMITER $$
DROP PROCEDURE IF EXISTS resumen_pagos;
CREATE PROCEDURE resumen_pagos(
    IN forma_pago VARCHAR(40),
    OUT maximo_pago DECIMAL(15, 2),
    OUT minimo_pago DECIMAL(15, 2),
    OUT pago_medio DECIMAL(15, 2),
    OUT suma_pagos DECIMAL(15, 2),
    OUT numero_pagos INT UNSIGNED
)
BEGIN
    SET maximo_pago = (SELECT MAX(total) FROM pago p WHERE p.forma_pago = forma_pago);
    SET minimo_pago = (SELECT MIN(total) FROM pago p WHERE p.forma_pago = forma_pago);
    SET pago_medio = (SELECT AVG(total) FROM pago p WHERE p.forma_pago = forma_pago);
    SET suma_pagos = (SELECT SUM(total) FROM pago p WHERE p.forma_pago = forma_pago);
    SET numero_pagos = (SELECT COUNT(*) FROM pago p WHERE p.forma_pago = forma_pago);
end $$

CALL resumen_pagos('PayPal', @maximo_pago, @minimo_pago, @pago_medio, @suma_pagos, @numero_pagos);
SELECT ROUND(@maximo_pago, 2), ROUND(@minimo_pago, 2) , ROUND(@pago_medio, 2), ROUND(@suma_pagos, 2), @numero_pagos;