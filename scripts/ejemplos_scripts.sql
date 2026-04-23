###############################################################
# EJEMPLOS PROCEDIMIENTOS       ###############################
###############################################################

USE jardineria;

-- Pasos:
-- 1) DELIMITER
-- 2) DROP PROCEDURE
-- 3) CREATE PROCEDURE... BEGIN...END (sin rellenar nada)
-- 4) Pienso / diseño el contenido del procedimiento, y "lo relleno"
-- 5) Ejecutamos el CREATE PROCEDURE (se nos guarda en routines)
-- 6) Llamamos al procedimiento con CALL

-- Ejemplo 1: procedimiento que lista los productos de la ga
DELIMITER $$
DROP PROCEDURE IF EXISTS listar_productos;
CREATE PROCEDURE listar_productos(
    IN gama VARCHAR(50)
)
BEGIN
    -- DENTRO DE BEGIN METEMOS EL CÓDIGO SQL (O NO) QUE QUEREMOS QUE HAGA
    SELECT *
    FROM producto p
    WHERE p.gama = gama;
end $$

-- al ejecutar lo anterior, se nos guarda el procedimiento, pero el código, la consulta, no se ejecuta porque no lo estamos llamando
CALL listar_productos('Herramientas');
CALL listar_productos('Aromáticas');
CALL listar_productos('Frutales');


-- Ejemplo 2: procedimiento que cuenta los productos de una determinada gama
DELIMITER SS
DROP PROCEDURE IF EXISTS contar_productos;
CREATE PROCEDURE contar_productos(
    IN gama VARCHAR(50),
    OUT total INT UNSIGNED
)
BEGIN
    -- para crear la variable de salida la creamos con SET
    -- y le asignamos el resultado de la consulta
    -- ¡¡Ojo con los paréntesis!!
    SET total = (SELECT COUNT(*) FROM producto p WHERE p.gama = gama);
end SS

-- en la llamada, pones el nombre del parámetro OUT con un @
CALL contar_productos('Frutales', @total);
SELECT @total;

-- Ejemplo 3 - dentro de una nueva base de datos test, crea el procedimiento calcular_area_circulo: recibe como entrada el radio de un círculo y devuelve como salida el área del círculo
-- area = pi * radio al cuadrado
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_area_circulo;
CREATE PROCEDURE calcular_area_circulo(
    IN radio DOUBLE,
    OUT area DOUBLE
)
BEGIN
    SET area = (PI() * POW(radio, 2));
end $$

CALL calcular_area_circulo(1, @area);
SELECT @area;

-- Ejemplo 4 - dentro de la base de datos test, crea un procedimiento  calcular_volumen_cilindro: recibe como entrada el radio y la altura, y devuelve como salida el volumen del cilindro; el procedimiento hace uso del procedimiento calcular_area_circulo
-- volumen = area * altura
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_volumen_cilindro;
CREATE PROCEDURE calcular_volumen_cilindro(
    IN radio DOUBLE,
    IN altura DOUBLE,
    OUT volumen DOUBLE
)
BEGIN
    CALL calcular_area_circulo(radio, @area);
    SET volumen = @area * altura;
end $$

CALL calcular_volumen_cilindro(4.5, 6, @volumen);
SELECT @volumen;

-- Ejemplo 5. Procedimiento calcular_max_min_media
-- recibe: gama del producto
-- devuelve: precio máximo
--           precio mínimo
--           precio medio
-- de los productos de esa gama
USE jardineria;
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_max_min_media;
CREATE PROCEDURE calcular_max_min_media(
    IN gama VARCHAR(50),
    OUT precio_maximo DECIMAL(15, 2),
    OUT precio_minimo DECIMAL(15, 2),
    OUT precio_medio DECIMAL(15, 2)
)
BEGIN
    SET precio_maximo = (SELECT MAX(precio_venta)
                         FROM producto p
                         WHERE p.gama = gama);
    SET precio_minimo = (SELECT MIN(precio_venta)
                         FROM producto p
                         WHERE p.gama = gama);
    SET precio_medio = (SELECT AVG(precio_venta)
                        FROM producto p
                        WHERE p.gama = gama);
end $$

CALL calcular_max_min_media('Herramientas', @precio_maximo, @precio_minimo, @precio_medio);
SELECT ROUND(@precio_maximo, 2), @precio_minimo, @precio_medio;


###############################################################
# EJEMPLOS FUNCIONES            ###############################
###############################################################

-- Pasos:
-- 1) DELIMITER
-- 2) DROP FUNCTION IF EXISTS
-- 3) CREATE FUNCTION...
-- 4) RETURNS tipo_de_dato_que_devuelve
-- 5) DETERMINISTIC | CONTAINS SQL | NO SQL | MODIFIES SQL DATA | READS SQL DATA
-- 5) BEGIN...
-- 6) Pienso / diseño el contenido del procedimiento, y "lo relleno"
-- 7) RETURN para devolver la variable
-- 8) END (sin rellenar nada)
-- 9) Ejecutamos el CREATE FUNCTION (se nos guarda en routines)
-- 10) Llamamos al procedimiento con SELECT

USE jardineria;
DELIMITER $$
DROP FUNCTION IF EXISTS devuelve_cuatro;
CREATE FUNCTION devuelve_cuatro() -- ya no ponemos IN ni OUT
    RETURNS INT UNSIGNED -- no damos nombre a la variable de salida, solo el tipo, como en java
    DETERMINISTIC
BEGIN
    -- EN ALGÚN MOMENTO CREAMOS LA VARIABLE DE SALIDA, total
    RETURN 4;
end $$

SELECT devuelve_cuatro();

###############################################################
# EJEMPLOS IF-ELSEIF-ELSE-ENDIF ###############################
###############################################################
# Ejemplo1: Escribe un procedimiento que reciba la edad de una persona y devuelva:
# "MENOR" si tiene menos de 18 años
# "MAYOR", en caso contrario
USE test;
DELIMITER $$
DROP PROCEDURE IF EXISTS es_mayor_o_menor;
CREATE PROCEDURE es_mayor_o_menor(IN edad INT UNSIGNED, OUT cadena VARCHAR(5))
BEGIN
    IF edad < 18 THEN
        SET cadena = 'MENOR';
    ELSE
        SET cadena = 'MAYOR';
    END IF;
end $$

CALL es_mayor_o_menor(15, @cadena);
SELECT @cadena;

# Ejemplo2: Escribe una función que reciba una hora (0–23) y devuelva: "MADRUGADA" si está entre 0 y 5 "MAÑANA" si está entre 6 y 11 "TARDE" si está entre 12 y 19 "NOCHE" si está entre 20 y 23
DELIMITER //
DROP FUNCTION IF EXISTS calcular_tramo_dia;
CREATE FUNCTION calcular_tramo_dia(hora INT UNSIGNED)
    RETURNS VARCHAR(9)
    NO SQL
BEGIN
    IF hora >= 0 AND hora <= 5 THEN
        RETURN 'MADRUGADA';
    ELSEIF hora >= 6 AND hora <= 11 THEN
        RETURN 'MAÑANA';
    ELSEIF hora >= 12 AND hora <= 19 THEN
        RETURN 'TARDE';
    ELSE
        RETURN 'NOCHE';
    END IF;
end //

SELECT calcular_tramo_dia(20);

###############################################################
# EJEMPLOS CASE                 ###############################
###############################################################
# Ejemplo1: Escribe un procedimiento que reciba la edad de una persona y devuelva:
# "MENOR" si tiene menos de 18 años
# "MAYOR", en caso contrario
DELIMITER //
DROP PROCEDURE IF EXISTS ejemplo1_CASE;
CREATE PROCEDURE ejemplo1_CASE(IN edad INT UNSIGNED, OUT cadena VARCHAR(5))
BEGIN
    CASE
        WHEN edad < 18 THEN SET cadena = 'MENOR';
        ELSE SET cadena = 'MAYOR';
        END CASE;
end //

CALL ejemplo1_CASE(18, @cadena);
SELECT @cadena;

# Ejemplo2: Escribe una función que reciba una hora (0–23) y devuelva: "MADRUGADA" si está entre 0 y 5 "MAÑANA" si está entre 6 y 11 "TARDE" si está entre 12 y 19 "NOCHE" si está entre 20 y 23
DELIMITER //
DROP FUNCTION IF EXISTS calcular_tramo_dia;
CREATE FUNCTION calcular_tramo_dia(hora INT UNSIGNED)
    RETURNS VARCHAR(9)
    NO SQL
BEGIN
    CASE
        WHEN hora BETWEEN 0 AND 5 THEN RETURN 'MADRUGADA';
        WHEN hora BETWEEN 6 AND 11 THEN RETURN 'MAÑANA';
        WHEN hora BETWEEN 12 AND 19 THEN RETURN 'TARDE';
        WHEN hora BETWEEN 20 AND 23 THEN RETURN 'NOCHE';
        END CASE;
end //

SELECT calcular_tramo_dia(20);

###############################################################
# EJEMPLOS LOOP                 ###############################
###############################################################
# Ejemplo 1: escribe un procedimiento que utilice un bucle para imprimir todos los números impares del 1 al 30
USE procedimientos;
CREATE TABLE ejemplo1_LOOP
(
    numero_impar INT UNSIGNED
);
DELIMITER //
DROP PROCEDURE IF EXISTS ejemplo1_LOOP;
CREATE PROCEDURE ejemplo1_LOOP()
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT 1;
    -- borramos el contenido de la tabla
    DELETE FROM ejemplo1_LOOP;
    -- ahora la rellenamos con el bucle
    buclecito:
    LOOP
        IF contador % 2 != 0 THEN
            INSERT INTO ejemplo1_LOOP VALUE (contador);
        END IF;
        SET contador = contador + 1;
        IF contador = 30 THEN
            LEAVE buclecito;
        end if;
    end loop;
end //
CALL ejemplo1_LOOP();

###############################################################
# EJEMPLOS WHILE                 ##############################
###############################################################
# Ejemplo 1: escribe un procedimiento que utilice un bucle para imprimir todos los números impares del 1 al 30
USE procedimientos;
CREATE TABLE ejemplo1_WHILE
(
    numero_impar INT UNSIGNED
);
DELIMITER //
DROP PROCEDURE IF EXISTS ejemplo1_WHILE;
CREATE PROCEDURE ejemplo1_WHILE()
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT 1;
    -- borramos el contenido de la tabla
    DELETE FROM ejemplo1_LOOP;
    -- ahora la rellenamos con el bucle
    WHILE contador <= 30
        DO
            IF contador % 2 != 0 THEN
                INSERT INTO ejemplo1_LOOP VALUE (contador);
            END IF;
            SET contador = contador + 1;

        end WHILE;
end //
CALL ejemplo1_WHILE();

###############################################################
# EJEMPLOS REPEAT                 #############################
###############################################################
# Ejemplo 1: escribe un procedimiento que utilice un bucle para imprimir todos los números impares del 1 al 30
USE procedimientos;
CREATE TABLE ejemplo1_REPEAT
(
    numero_impar INT UNSIGNED
);
DELIMITER //
DROP PROCEDURE IF EXISTS ejemplo1_REPEAT;
CREATE PROCEDURE ejemplo1_REPEAT()
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT 1;
    -- borramos el contenido de la tabla
    DELETE FROM ejemplo1_REPEAT;
    -- ahora la rellenamos con el bucle
    REPEAT
        IF contador % 2 != 0 THEN
            INSERT INTO ejemplo1_REPEAT VALUE (contador);
        END IF;
        SET contador = contador + 1;
    UNTIL contador > 30
        end REPEAT;
end //
CALL ejemplo1_REPEAT();

###############################################################
# EJEMPLOS HANDLER                 #############################
###############################################################
# Ejemplo 1 - Error de clave duplicada - 23000
-- Paso 1
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

-- Paso 2
CREATE TABLE test.t
(
    s1 INT,
    PRIMARY KEY (s1)
);

-- Paso 3
DELIMITER $$
DROP PROCEDURE IF EXISTS handlerdemo;
CREATE PROCEDURE handlerdemo()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @x = 100;
    SET @x = 1;
    INSERT INTO test.t VALUES (2);
    SET @x = 2;
    INSERT INTO test.t VALUES (2);
    SET @x = 3;
END
$$

DELIMITER ;
CALL handlerdemo();
SELECT @x;

###############################################################
# EJEMPLOS TRANSACCIONES          #############################
###############################################################
# ## 🎯 Ejemplo práctico de transacciones en MySQL
#
# ### 🧩 Escenario
#
# Vamos a simular una **transferencia de dinero entre cuentas bancarias**:
#
# - Cuenta A → tiene dinero
# - Cuenta B → recibe dinero
#
# 👉 Queremos que:
# - Si todo va bien → se guarde (COMMIT)
# - Si algo falla → no se haga nada (ROLLBACK)
#
# ---
#
# ## 🔹 1. Crear la tabla
USE test;

DROP TABLE IF EXISTS cuentas;

CREATE TABLE cuentas
(
    id      INT PRIMARY KEY,
    titular VARCHAR(50),
    saldo   DECIMAL(10, 2)
);

INSERT INTO cuentas
VALUES (1, 'Ana', 1000);
INSERT INTO cuentas
VALUES (2, 'Luis', 500);

# Creamos el procedimiento con la transacción:
DELIMITER $$

DROP PROCEDURE IF EXISTS transferencia;

CREATE PROCEDURE transferencia(
    IN origen INT,
    IN destino INT,
    IN cantidad DECIMAL(10, 2)
)
BEGIN
    -- Handler para errores y warnings (si salta cualquier error o warning durante la transacción, hace ROLLBACK
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
        BEGIN
            ROLLBACK;
        END;

    START TRANSACTION;

    -- Restar dinero de la cuenta origen
    UPDATE cuentas
    SET saldo = saldo - cantidad
    WHERE id = origen;

    -- Añade la cantidad a la cuenta destino
    UPDATE cuentas
    SET saldo = saldo + cantidad
    WHERE id = destino;
    COMMIT;

END$$

-- Hacemos una llamada en que to-do va bien:
SELECT *
FROM cuentas;

CALL transferencia(1, 2, 100);

SELECT *
FROM cuentas;

-- Hacemos una llamada en que falla algo: ejemplo: cuenta que no existe
CALL transferencia(5, 2, 1000);

CALL transferencia(1, 999, 100);
SELECT *
FROM cuentas;

################################################
# EJEMPLOS TRIGGER #############################
################################################
# **Ejemplo 1: trigger para poner nombre en mayúsculas**
#
# Crea una base de datos llamada test que contenga una tabla llamada personas con las siguientes columnas:
# - id (entero sin signo, clave primaria, autoincremental)
# - nombre (cadena de caracteres)
USE test;
CREATE TABLE personas
(
    id     INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);
# Una vez creada la tabla, escribe un trigger con las siguientes características:
# - Nombre del trigger: trigger_mayusculas_before_insert
# - Se ejecuta sobre la tabla personas
# - Se ejecuta antes de una operación de inserción (BEFORE INSERT)
# - Para cada fila (FOR EACH ROW)
# Si el nombre está vacío (''), se almacene el valor 'SIN NOMBRE'
# - Convierte el valor del campo nombre a mayúsculas antes de almacenarlo en la tabla
DELIMITER //
DROP TRIGGER IF EXISTS trigger_mayusculas_before_insert;
CREATE TRIGGER trigger_mayusculas_before_insert -- creat trigger con su nombre
    BEFORE INSERT -- Se ejecuta antes de una operación de inserción (BEFORE INSERT)
    ON personas -- Se ejecuta sobre la tabla personas
    FOR EACH ROW -- Para cada fila (FOR EACH ROW)
BEGIN
    -- Comprobar si el nombre está vacío y sustitirlo por 'SIN NOMBRE'
    IF NEW.nombre = '' THEN
        SET NEW.nombre = 'SIN NOMBRE';
    end iF;
    -- Convierte el valor del campo nombre a mayúsculas antes de almacenarlo en la tabla
    SET NEW.nombre = UPPER(NEW.nombre);
end //
# Para comprobar si el trigger funciona correctamente,
# - Inserta al menos 3 registros en la tabla personas con nombres en minúsculas o mezcla de mayúsculas y minúsculas.
INSERT INTO personas (nombre)
VALUES ('diego');
INSERT INTO personas (nombre)
VALUES ('jOrGe');
INSERT INTO personas (nombre)
VALUES ('AleXANdre');
INSERT INTO personas (nombre)
VALUES ('');

# - Realiza una consulta para comprobar que los nombres se han almacenado correctamente en mayúsculas.
SELECT *
FROM personas;

# **Ejemplo 2:**
# Crea una base de datos llamada _test_ que contenga una tabla llamada _alumnos_ con las siguientes columnas.
USE test;
# Tabla `alumnos`:
#
# - `id` (entero sin signo)
# - `nombre` (cadena de caracteres)
# - `apellido1` (cadena de caracteres)
# - `apellido2` (cadena de caracteres)
# - `nota` (número real)
CREATE TABLE alumnos
(
    id        INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre    VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    nota      REAL
);
# Una vez creada la tabla,  escriba **dos triggers** con las siguientes características:
#
# - Trigger 1: `trigger_check_nota_before_insert`
#   - Se ejecuta sobre la tabla alumnos.
#   - Se ejecuta antes de una operación de inserción.
#   - Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
#   - Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.
DELIMITER //
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert;
CREATE TRIGGER trigger_check_nota_before_insert
    BEFORE INSERT -- Se ejecuta antes de una operación de inserción.
    ON alumnos -- Se ejecuta sobre la tabla alumnos
    FOR EACH ROW
BEGIN
    -- Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
#   - Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.
    IF NEW.nota < 0 THEN
        SET NEW.nota = 0;
    ELSEIF NEW.nota > 10 THEN
        SET NEW.nota = 10;
    END IF;
end //
# - Trigger2 : `trigger_check_nota_before_update`
#   - Se ejecuta sobre la tabla alumnos.
#   - Se ejecuta antes de una operación de actualización.
#   - Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.
#   - Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.
DELIMITER //
DROP TRIGGER IF EXISTS trigger_check_nota_before_update;
CREATE TRIGGER trigger_check_nota_before_update
    BEFORE UPDATE -- Se ejecuta antes de una operación de actualización.
    ON alumnos -- Se ejecuta sobre la tabla alumnos
    FOR EACH ROW
BEGIN
    -- Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
#   - Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.
    IF NEW.nota < 0 THEN
        SET NEW.nota = 0;
    ELSEIF NEW.nota > 10 THEN
        SET NEW.nota = 10;
    END IF;
end //


# Una vez creados los triggers, escriba varias sentencias de inserción y actualización sobre la tabla `alumnos` y verifica que los triggers se están ejecutando correctamente.
INSERT INTO alumnos (nombre, apellido1, apellido2, nota) VALUES ('Daftne', 'Osuna', 'Cabrera', 11);
INSERT INTO alumnos (nombre, apellido1, apellido2, nota) VALUES ('Ana', 'Mala', 'Profe', -1);
INSERT INTO alumnos (nombre, apellido1, apellido2, nota) VALUES ('Álvaro', 'Davidez', 'Elizabeth', 9);
SELECT * FROM alumnos;

UPDATE alumnos SET nota = 11 WHERE id IN (1,4);
UPDATE alumnos SET nota = -1 WHERE id IN (2,5);
SELECT * FROM alumnos;

