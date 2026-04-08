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
        FROM producto p WHERE p.gama = gama;
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