# Procedimientos
# 1. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo, negativo o cero.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;
USE procedimientos;

DELIMITER //
DROP PROCEDURE IF EXISTS signo_numero;
CREATE PROCEDURE signo_numero(IN numero INTEGER)
BEGIN
    IF numero > 0 THEN
        SELECT 'Positivo';
    ELSEIF numero = 0 THEN
        SELECT 'Cero';
    ELSE
        SELECT 'Negativo';
    end if;
END //

CALL signo_numero(0);

# 2. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor un número real, y un parámetro de salida, con una cadena de caracteres indicando si el número es positivo, negativo o cero.
DELIMITER //
DROP PROCEDURE IF EXISTS signo_numero;
CREATE PROCEDURE signo_numero(IN numero INTEGER, OUT mensaje VARCHAR(8))
BEGIN
    IF numero > 0 THEN
        SET mensaje = 'Positivo';
    ELSEIF numero = 0 THEN
        SET mensaje = 'Cero';
    ELSE
        SET mensaje = 'Negativo';
    end if;
END //

CALL signo_numero(0, @mensaje);
SELECT @mensaje;

# 3. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones:
#
# [0,5) = Insuficiente
# [5,6) = Aprobado
# [6, 7) = Bien
# [7, 9) = Notable
# [9, 10] = Sobresaliente En cualquier otro caso la nota no será válida.
DELIMITER //
DROP PROCEDURE IF EXISTS convertir_nota;
CREATE PROCEDURE convertir_nota(IN nota DOUBLE)
BEGIN
    IF nota >= 0 AND nota < 5 THEN
        SELECT 'Insuficiente';
    ELSEIF nota >= 5 AND nota < 6 THEN
        SELECT 'Aprobado';
    ELSEIF nota >= 6 AND nota < 7 THEN
        SELECT 'Bien';
    ELSEIF nota >= 7 AND nota < 9 THEN
        SELECT 'Notable';
    ELSEIF nota >= 9 AND nota <= 10 THEN
        SELECT 'Sobresaliente';
    ELSE
        SELECT 'Nota no válida';
    END IF;
end //

CALL convertir_nota(6.9999);

# 4. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de texto indicando la nota correspondiente.
DELIMITER //
DROP PROCEDURE IF EXISTS convertir_nota;
CREATE PROCEDURE convertir_nota(IN nota DOUBLE, OUT mensaje VARCHAR(20))
BEGIN
    IF nota >= 0 AND nota < 5 THEN
        SET mensaje = 'Insuficiente';
    ELSEIF nota >= 5 AND nota < 6 THEN
        SET mensaje = 'Aprobado';
    ELSEIF nota >= 6 AND nota < 7 THEN
        SET mensaje = 'Bien';
    ELSEIF nota >= 7 AND nota < 9 THEN
        SET mensaje = 'Notable';
    ELSEIF nota >= 9 AND nota <= 10 THEN
        SET mensaje = 'Sobresaliente';
    ELSE
        SET mensaje = 'Nota no válida';
    END IF;
end //

CALL convertir_nota(6.9999, @mensaje);
SELECT @mensaje;


# 5. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.
DELIMITER //
DROP PROCEDURE IF EXISTS convertir_nota;
CREATE PROCEDURE convertir_nota(IN nota DOUBLE, OUT mensaje VARCHAR(20))
BEGIN
    CASE
        WHEN nota >= 0 AND nota < 5 THEN SET mensaje = 'Insuficiente';
        WHEN nota >= 5 AND nota < 6 THEN SET mensaje = 'Aprobado';
        WHEN nota >= 6 AND nota < 7 THEN SET mensaje = 'Bien';
        WHEN nota >= 7 AND nota < 9 THEN SET mensaje = 'Notable';
        WHEN nota >= 9 AND nota <= 10 THEN SET mensaje = 'Sobresaliente';
        ELSE SET mensaje = 'Nota no válida';
        END CASE;
end //

CALL convertir_nota(4.9999, @mensaje);
SELECT @mensaje;


# 6. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes. Resuelva el procedimiento haciendo uso de la estructura de control IF.
#
# 7. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.
#
# 8. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La tabla cuadrados debe tener dos columnas de tipo INT UNSIGNED, una columna llamada número y otra columna llamada cuadrado. Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados con las siguientes características: el procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y calculará el valor de los cuadrados de los primeros números naturales hasta el valor introducido como parámetro. El valor del número y de sus cuadrados deberán ser almacenados en la tabla cuadrados que hemos creado previamente.

# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores de los cuadrados que va a calcular.
# CON LOOP
USE procedimientos;
CREATE TABLE cuadrados
(
    numero   INT UNSIGNED,
    cuadrado INT UNSIGNED
);
DELIMITER //
DROP PROCEDURE IF EXISTS calcular_cuadrados;
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT 1;
    DELETE FROM cuadrados;
    bucle_cuadrado:
    LOOP
        INSERT INTO cuadrados VALUES (contador, POW(contador, 2));
        SET contador = contador + 1;
        IF contador > tope THEN
            LEAVE bucle_cuadrado;
        END IF;
    end loop;
end //

CALL calcular_cuadrados(12);

# 9. Utilice un bucle WHILE para resolver el procedimiento.
USE procedimientos;
DELIMITER //
DROP PROCEDURE IF EXISTS calcular_cuadrados;
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT 1;
    DELETE FROM cuadrados;
    WHILE contador <= tope DO -- mientras contador sea menor o igual que tope, sigo con la siguiente iteración cada vez
        INSERT INTO cuadrados VALUES (contador, POW(contador, 2));
        SET contador = contador + 1;
    end WHILE ;
end //

CALL calcular_cuadrados(12);

# 10. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
USE procedimientos;
DELIMITER //
DROP PROCEDURE IF EXISTS calcular_cuadrados;
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT 1;
    DELETE FROM cuadrados;
    REPEAT
        INSERT INTO cuadrados VALUES (contador, POW(contador, 2));
        SET contador = contador + 1;
        UNTIL contador > tope -- mientras contador sea menor o igual que tope, sigo con la siguiente iteración cada vez
    end REPEAT ;
end //

CALL calcular_cuadrados(9);
# 11. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
-- es el ejercicio 8
# 12. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. La tabla debe tener una única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.
USE procedimientos;
CREATE TABLE ejercicio(
    numero INT UNSIGNED
)
# 13. Una vez creada la base de datos y la tabla deberá
# crear un procedimiento llamado calcular_números con las siguientes características: El procedimiento
# recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED
# y deberá almacenar en la tabla ejercicio toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.

# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.

#Utilice un bucle WHILE para resolver el procedimiento.
DELIMITER //
DROP PROCEDURE IF EXISTS calcular_numeros;
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT valor_inicial;
    DELETE FROM ejercicio;
    WHILE contador >= 1 DO
        INSERT INTO ejercicio VALUES (contador);
        SET contador = contador - 1;
        end while;
end //
CALL calcular_numeros(15);
SELECT * FROM ejercicio;
# 14. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
DELIMITER //
DROP PROCEDURE IF EXISTS calcular_numeros;
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT valor_inicial;
    DELETE FROM ejercicio;
    REPEAT
        INSERT INTO ejercicio VALUES (contador);
        SET contador = contador - 1;
    until contador = 0 end repeat;
end //
CALL calcular_numeros(20);
SELECT * FROM ejercicio;
# 15. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
DELIMITER //
DROP PROCEDURE IF EXISTS calcular_numeros;
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
BEGIN
    DECLARE contador INT UNSIGNED DEFAULT valor_inicial;
    DELETE FROM ejercicio;
    bucle: LOOP
        INSERT INTO ejercicio VALUES (contador);
        SET contador = contador - 1;
        IF contador = 0 THEN
            LEAVE bucle;
        end if;
    END LOOP ;
end //
CALL calcular_numeros(30);
SELECT * FROM ejercicio;

# 16. Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra tabla llamada impares. Las dos tablas deben tener única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.
#
# 17. Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado calcular_pares_impares con las siguientes características: el procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla pares aquellos números pares que existan entre el número 1 el valor introducido como parámetro. Habrá que realizar la misma operación para almacenar los números impares en la tabla impares.
#
# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
#
# 18. Utilice un bucle WHILE para resolver el procedimiento.
#
# 19. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
#
# 20. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
#
# Funciones
# 21. Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número es par o FALSE en caso contrario.
CREATE DATABASE funciones;
USE funciones;

DELIMITER //;
DROP FUNCTION IF EXISTS devuelve_par_impar;
CREATE FUNCTION devuelve_par_impar(numero INTEGER)
RETURNS VARCHAR(5)
NO SQL
BEGIN
    IF numero % 2 = 0 THEN
        RETURN 'TRUE';
    ELSE
        RETURN 'FALSE';
    end if;
end //;

SELECT devuelve_par_impar(25);
# 22. Escribe una función que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.

# 23. Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor de los tres.