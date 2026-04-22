# Crea una base de datos llamada test que contenga una tabla llamada alumno. La tabla debe tener cuatro columnas:
# id: entero sin signo (clave primaria).
# nombre: cadena de 50 caracteres.
# apellido1: cadena de 50 caracteres.
# apellido2: cadena de 50 caracteres.
# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado insertar_alumno con las siguientes características:
# el procedimiento recibe cuatro parámetros de entrada (id, nombre, apellido1, apellido2)
# y los insertará en la tabla alumno.
# El procedimiento devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la operación se ha podido realizar con éxito y un valor igual a 1 en caso contrario.
# Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que contiene una clave primaria repetida.

-- Paso 1: crear tabla alumno
USE test;
DROP TABLE IF EXISTS alumno;
CREATE TABLE alumno
(
    id        INT UNSIGNED PRIMARY KEY,
    nombre    VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50)
);

-- Paso 2 - crear procedimiento
DELIMITER //
DROP PROCEDURE IF EXISTS insertar_alumno;
CREATE PROCEDURE insertar_alumno(IN id INT UNSIGNED,
                                 nombre VARCHAR(50),
                                 apellido1 VARCHAR(50),
                                 apellido2 VARCHAR(50), OUT error INT UNSIGNED)
BEGIN
    DECLARE EXIT HANDLER FOR SQLSTATE '23000'
        BEGIN
            SET error = 0;
        END; -- decimos que si intentamos una entrada duplicada, ponga en la variable @error un 0 y salga del procedimiento
    SET error = 1; -- iniciamos el procedimiento poniendo @error a 0; si no salta el error, en la salida del procedimiento seguirá valiendo lo misno
    INSERT INTO alumno VALUES (id, nombre, apellido1, apellido2);
end //

CALL insertar_alumno(1, 'Víctor', 'Osito', 'Riquiño', @error);
SELECT @error; -- 1
CALL insertar_alumno(1, 'Víctor', 'Osito', 'Riquiño', @error);
SELECT @error; -- 0