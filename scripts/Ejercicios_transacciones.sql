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
    IN p_nif VARCHAR(9), p_id_cuenta INT UNSIGNED, p_id_butaca INT UNSIGNED,
    OUT error INT UNSIGNED
)
BEGIN
    DECLARE EXIT HANDLER FOR 1264, 1062
        BEGIN
            SET error = 1;
            ROLLBACK;
        end;

    START TRANSACTION ;
    -- Solamente haremos el commit si la cuenta existe realmente (al no dar problemas con SQL, no saltaría error, por lo que este error lo controlamos de forma lógica

    IF (SELECT COUNT(*) FROM cuentas WHERE id_cuenta = p_id_cuenta) > 0 THEN
        -- Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta adecuado.
        UPDATE cuentas SET saldo = saldo - 5 WHERE id_cuenta = p_id_cuenta;
        -- Inserta una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el usuario (nif).
        INSERT INTO entradas VALUES (p_id_butaca, p_nif);
        COMMIT;
        SET error = 0;
    ELSE
        SET error = 1;
        ROLLBACK;
    END IF;
end //

-- Comprobamos que funciona
-- Metemos datos en la tabla cuentas
INSERT INTO cuentas
VALUES (1, 10000);
INSERT INTO cuentas
VALUES (2, 5000);
SELECT *
FROM cuentas;

-- Operación válida
CALL comprar_entrada('11111111A', 1, 2, @error);
SELECT @error;
SELECT *
FROM cuentas;
SELECT *
FROM entradas;

-- Operación no válida
CALL comprar_entrada('11111111A', 1, 2, @error); --
SELECT @error;
SELECT *
FROM cuentas;
SELECT *
FROM entradas;

-- Probamos una cuenta que no existe (esto no es un error MySQL, simplemente no devuelve nada, entonces es lo que controlamos con ID)
CALL comprar_entrada('22222222B', 100, 3, @error);
SELECT @error;
SELECT *
FROM cuentas;
SELECT *
FROM entradas;

# 2. Crea una base de datos llamada banco con la siguiente tabla:
# Tabla cuentas
# - id_cuenta: entero sin signo (clave primaria)
# - saldo: real sin signo
DROP DATABASE IF EXISTS banco;
CREATE DATABASE banco;
USE banco;
CREATE TABLE cuentas
(
    id_cuenta INT UNSIGNED PRIMARY KEY,
    saldo     REAL UNSIGNED
);
# Procedimiento: transferir_dinero
# - Debe:
#   - Recibir: p_origen, p_destino, p_cantidad
#   - Devolver: error (0 = OK, 1 = error)
# Operaciones
#   - Iniciar transacción
#   - Restar p_cantidad a la cuenta origen
#   - Sumar p_cantidad a la cuenta destino
#   - Si todo va bien → COMMIT
#   - Si ocurre error → ROLLBACK
# Errores a manejar
#   - 1264 → saldo negativo
#   - cuenta inexistente
DELIMITER //
DROP PROCEDURE IF EXISTS transferir_dinero;
CREATE PROCEDURE transferir_dinero(IN p_origen INT UNSIGNED, p_destino INT UNSIGNED, p_cantidad REAL UNSIGNED,
                                   OUT error INT UNSIGNED)
BEGIN
    # Errores a manejar
#   - 1264 → saldo negativo
#   - cuenta inexistente --> esto no tiene código de error en MySQL -> lo controlamos de forma lógica con IF
    DECLARE EXIT HANDLER FOR 1264
        BEGIN
            SET error = 1;
            ROLLBACK;
        end;

#   - Iniciar transacción
    START TRANSACTION ;
-- Lo primero que hago es entrar sólo si existe las cuentas de origen o destino; si no, p'atrás
    IF (SELECT COUNT(*) FROM cuentas WHERE id_cuenta = p_origen > 0) AND
       (SELECT COUNT(*) FROM cuentas WHERE id_cuenta = p_destino > 0) THEN
        #   - Restar p_cantidad a la cuenta origen
        UPDATE cuentas SET saldo = saldo - p_cantidad WHERE id_cuenta = p_origen;
        #   - Sumar p_cantidad a la cuenta destino
        UPDATE cuentas SET saldo = saldo + p_cantidad WHERE id_cuenta = p_destino;
        #   Si todo va bien → COMMIT
        COMMIT;
        SET error = 0;
    ELSE
        SET error = 1;
#   - Si ocurre error → ROLLBACK
        ROLLBACK;
    END IF;
end //

-- Probamos si funciona
DELETE
FROM cuentas;
INSERT INTO cuentas
VALUES (1, 500);
INSERT INTO cuentas
VALUES (2, 100);
SELECT *
FROM cuentas;
-- Operación válida
CALL transferir_dinero(1, 2, 200, @error);
SELECT @error;
SELECT *
FROM cuentas;
-- Operación no válida: saldo negativo
CALL transferir_dinero(1, 2, 2000, @error);
SELECT @error;
SELECT *
FROM cuentas;
-- Operación no válida: cuenta origen inexistente
CALL transferir_dinero(100, 2, 2, @error);
SELECT @error;
SELECT *
FROM cuentas;

-- Operación no válida: cuenta destino inexistente
CALL transferir_dinero(1, 200, 2, @error);
SELECT @error;
SELECT *
FROM cuentas;

# 3. Crea una base de datos llamada hotel con las siguientes tablas:
# Tabla habitaciones:
# id_habitacion: entero sin signo (clave primaria)
# disponible: boolean (1 = libre, 0 = ocupada)
# Tabla reservas
# id_reserva: entero autoincremental (clave primaria)
# nif: varchar(9)
# id_habitacion: entero sin signo
# Procedimiento: reservar_habitacion
# Debe:
# Recibir: p_nif, p_id_habitacion
# Devolver: error (0 = OK, 1 = error)
# Operaciones
# Iniciar transacción
# Comprobar que la habitación está disponible
# Marcarla como no disponible
# Insertar la reserva
# Si todo va bien → COMMIT
# Si ocurre error → ROLLBACK
# Errores a manejar
# 1062 → duplicado (si decides evitar reservas repetidas)
# Habitación no disponible
# Habitación inexistente
