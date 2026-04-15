# Sin sentencias SQL
USE test;
# Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.
DELIMITER //
DROP FUNCTION IF EXISTS hipotenusa;
CREATE FUNCTION hipotenusa(cateto1 DOUBLE, cateto2 DOUBLE)
    RETURNS DOUBLE
    NO SQL
BEGIN
    RETURN SQRT(POW(cateto1, 2) + POW(cateto2, 2));
end //

SELECT hipotenusa(4, 5);
# Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá como parámetro de entrada.
DELIMITER //
DROP FUNCTION IF EXISTS area_circulo;
CREATE FUNCTION area_circulo(radio DOUBLE)
    RETURNS DOUBLE
    NO SQL
BEGIN
    RETURN PI() * POW(radio, 2);
end //

SELECT area_circulo(5);
# Escribe una función que devuelva como salida el número de años que han transcurrido entre dos fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.

# Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona MySQL:
#
# DATEDIFF TRUNCATE
#
DELIMITER //
DROP FUNCTION IF EXISTS años_transcurridos;
CREATE FUNCTION años_transcurridos(fecha1 DATE, fecha2 DATE)
    RETURNS INT
    NO SQL
BEGIN
    RETURN TRUNCATE((ABS(DATEDIFF(fecha1, fecha2))) / 365, 0) ;
end //
SELECT años_transcurridos('2000-05-12', now());

# Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento. Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.
DELIMITER //
DROP FUNCTION IF EXISTS quitar_tildes;
CREATE FUNCTION quitar_tildes(cadena VARCHAR(50))
    RETURNS VARCHAR(50)
    NO SQL
BEGIN
    SET cadena = REPLACE(cadena, 'Á', 'A');
    SET cadena = REPLACE(cadena, 'É', 'E');
    SET cadena = REPLACE(cadena, 'Í', 'I');
    SET cadena = REPLACE(cadena, 'Ó', 'O');
    SET cadena = REPLACE(cadena, 'Ú', 'U');
    SET cadena = REPLACE(cadena, 'á', 'a');
    SET cadena = REPLACE(cadena, 'é', 'e');
    SET cadena = REPLACE(cadena, 'í', 'i');
    SET cadena = REPLACE(cadena, 'ó', 'o');
    SET cadena = REPLACE(cadena, 'ú', 'u');
    RETURN cadena;
end //

SELECT quitar_tildes('MúrcÍélÁgó');

# Con sentencias SQL
# Escribe una función para la base de datos tienda que devuelva el número total de productos que hay en la tabla productos.
USE tienda;
DELIMITER //
DROP FUNCTION IF EXISTS contar_productos;
CREATE FUNCTION contar_productos()
    RETURNS INT UNSIGNED
    READS SQL DATA
BEGIN
    RETURN (SELECT COUNT(*) FROM producto);
end //

SELECT contar_productos();

# Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.

# Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.

# Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
#
