DROP DATABASE IF EXISTS ventas;
CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;

CREATE TABLE ventas_unica (
  pedido_id INT UNSIGNED PRIMARY KEY,
  total DOUBLE NOT NULL,
  fecha DATE,

  cliente_id INT UNSIGNED NOT NULL,
  cliente_nombre_completo VARCHAR(255) NOT NULL,
  cliente_ciudad VARCHAR(100),
  cliente_categoria INT UNSIGNED,

  comercial_id INT UNSIGNED NOT NULL,
  comercial_nombre_completo VARCHAR(255) NOT NULL,
  comercial_comision FLOAT NOT NULL
);

INSERT INTO ventas_unica VALUES
(1,  150.5,   '2022-10-05', 5,  'Marcos Loyola Méndez',   'Almería', 200, 2, 'Juan Gómez López',      0.13),
(2,  270.65,  '2021-09-10', 1,  'Aarón Rivero Gómez',     'Almería', 100, 5, 'Antonio Carretero Ortega', 0.12),
(3,  65.26,   '2022-10-05', 2,  'Adela Salas Díaz',       'Granada', 200, 1, 'Daniel Sáez Vega',      0.15),
(4,  110.5,   '2021-08-17', 8,  'Pepe Ruiz Santana',      'Huelva',  200, 3, 'Diego Flores Salas',    0.11),
(5,  948.5,   '2022-09-10', 5,  'Marcos Loyola Méndez',   'Almería', 200, 2, 'Juan Gómez López',      0.13),
(6,  2400.6,  '2021-07-27', 7,  'Pilar Ruiz',             'Sevilla', 300, 1, 'Daniel Sáez Vega',      0.15),
(7,  5760,    '2020-09-10', 2,  'Adela Salas Díaz',       'Granada', 200, 1, 'Daniel Sáez Vega',      0.15),
(8,  1983.43, '2022-10-10', 4,  'Adrián Suárez',          'Jaén',    300, 6, 'Manuel Domínguez Hernández', 0.13),
(9,  2480.4,  '2021-10-10', 8,  'Pepe Ruiz Santana',      'Huelva',  200, 3, 'Diego Flores Salas',    0.11),
(10, 250.45,  '2020-06-27', 8,  'Pepe Ruiz Santana',      'Huelva',  200, 2, 'Juan Gómez López',      0.13),
(11, 75.29,   '2021-08-17', 3,  'Adolfo Rubio Flores',    'Sevilla', NULL, 7, 'Antonio Vega Hernández', 0.11),
(12, 3045.6,  '2022-04-25', 2,  'Adela Salas Díaz',       'Granada', 200, 1, 'Daniel Sáez Vega',      0.15),
(13, 545.75,  '2024-01-25', 6,  'María Santana Moreno',   'Cádiz',   100, 1, 'Daniel Sáez Vega',      0.15),
(14, 145.82,  '2022-02-02', 6,  'María Santana Moreno',   'Cádiz',   100, 1, 'Daniel Sáez Vega',      0.15),
(15, 370.85,  '2024-03-11', 1,  'Aarón Rivero Gómez',     'Almería', 100, 5, 'Antonio Carretero Ortega', 0.12),
(16, 2389.23, '2024-03-11', 1,  'Aarón Rivero Gómez',     'Almería', 100, 5, 'Antonio Carretero Ortega', 0.12);
