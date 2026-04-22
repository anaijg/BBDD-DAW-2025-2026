# Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
# Tabla cuentas:
#
# id_cuenta: entero sin signo (clave primaria).
# saldo: real sin signo.
# Tabla entradas:
#
# id_butaca: entero sin signo (clave primaria).
# nif: cadena de 9 caracteres.
# Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado comprar_entrada con las siguientes características:
# el procedimiento recibe 3 parámetros de entrada (nif, id_cuenta, id_butaca)
# y devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual a 1 en caso contrario.
#
# El procedimiento de compra realiza los siguientes pasos:
#
# Inicia una transacción.
# Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta adecuado.
# Inserta una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el usuario (nif).
# Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún error entonces aplica un COMMIT a la transacción y si ha ocurrido algún error aplica un ROLLBACK.
# Deberá manejar los siguientes errores que puedan ocurrir durante el proceso:
#
# ERROR 1264 (Out of range value)
# ERROR 1062 (Duplicate entry for PRIMARY KEY)
DROP DATABASE IF EXISTS cine;
CREATE DATABASE cine;
USE cine;

DROP TABLE IF EXISTS cuentas;
CREATE TABLE cuentas
(
    id_cuenta INT UNSIGNED PRIMARY KEY,
    saldo     REAL UNSIGNED
);

DROP TABLE IF EXISTS entradas;
CREATE TABLE entradas
(
    id_butaca INT UNSIGNED PRIMARY KEY,
    nif       VARCHAR(9)
);

DELIMITER //
DROP PROCEDURE IF EXISTS comprar_entrada;
CREATE PROCEDURE comprar_entrada(
    IN nif VARCHAR(9), id_cuenta INT UNSIGNED, id_butaca INT UNSIGNED,
    OUT error INT UNSIGNED
)
BEGIN
    DECLARE EXIT HANDLER FOR 1264, 1062
        BEGIN
            SET error = 1;
        end;

    START TRANSACTION ;

    COMMIT;


end //