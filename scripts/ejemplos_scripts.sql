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
    OUT precio_maximo DECIMAL(15,2),
    OUT precio_minimo DECIMAL(15,2),
    OUT precio_medio DECIMAL(15, 2)
)
BEGIN
    SET precio_maximo = (SELECT MAX(precio_venta)
        FROM producto p WHERE p.gama = gama);
    SET precio_minimo = (SELECT MIN(precio_venta)
        FROM producto p WHERE p.gama = gama);
    SET precio_medio = (SELECT AVG(precio_venta)
        FROM producto p WHERE p.gama = gama);
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


