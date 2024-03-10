DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda;
USE tienda;

SHOW DATABASES;

CREATE TABLE cliente (
	id INT PRIMARY KEY AUTO_INCREMENT,
    dni CHAR(9) UNIQUE,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(50),
    telefono CHAR(9)
);
DESCRIBE cliente;

CREATE TABLE categoria (
	id INT PRIMARY KEY AUTO_INCREMENT,
    temporada VARCHAR(30),
    tipo VARCHAR(30)
);
DESCRIBE categoria;

CREATE TABLE producto (
	id INT PRIMARY KEY AUTO_INCREMENT,
    cod_barras CHAR(13) UNIQUE,
    precio DECIMAL(5,2),
    descuento DECIMAL(5,2),
	talla CHAR(2),
    color VARCHAR(30),
    id_categoria INT,
    CONSTRAINT chk_talla CHECK (talla IN ('S','M','L','XL','36','37','38','39','40','41','42','43','44')),
    CONSTRAINT fk_producto_id_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id) 
);
DESCRIBE producto;

CREATE TABLE compra(
	fecha_compra DATE,
    id_cliente INT,
    id_producto INT,
    CONSTRAINT pk_fecha_compra PRIMARY KEY (fecha_compra, id_cliente, id_producto),
    CONSTRAINT fk_compra_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    CONSTRAINT fk_compra_id_producto FOREIGN KEY (id_producto) REFERENCES producto(id)
);
DESCRIBE compra;

CREATE TABLE licencia (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30),
    origen VARCHAR(30)
);
DESCRIBE licencia;

CREATE TABLE adquisicion (
	fecha_adquisicion DATE,
    id_producto INT,
    id_licencia INT,
    CONSTRAINT pk_fecha_adquisicion PRIMARY KEY (fecha_adquisicion, id_producto, id_licencia),
    CONSTRAINT fk_adquisicion_id_producto FOREIGN KEY (id_producto) REFERENCES producto(id),
    CONSTRAINT fk_adquisicion_id_licencia FOREIGN KEY (id_licencia) REFERENCES licencia(id)
);
DESCRIBE adquisicion;

-- DATOS DE PRUEBA
INSERT INTO cliente (dni, nombre, apellidos, telefono) VALUES
('11111111A', 'Ángel', 'Domínguez Rodríguez', '687654321'),
('22222222B', 'Javier', 'Alonso Madroñal', '654321987'),
('33333333C', 'Adrián', 'Martínez Rodríguez', '623456789'),
('44444444D', 'Laura', 'Fernández Ruiz', '667890123'),
('55555555E', 'Carlos', 'Sánchez González', '645678901'),
('66666666F', 'Ana', 'Díaz Jiménez', '676543210'),
('77777777G', 'Francisco', 'Hernández López', '634567890'),
('88888888H', 'Elena', 'Ramírez Martín', '689012345'),
('99999999I', 'Luis', 'Torres Soto', '632109876'),
('11111112J', 'Carmen', 'Moreno Castro', '610987654');
SELECT * FROM cliente;

INSERT INTO categoria (temporada, tipo) VALUES
('Verano', 'Ropa'),
('Invierno', 'Zapatos'),
('Primavera', 'Accesorio'),
('Otoño', 'Ropa'),
('Primavera', 'Ropa'),
('Otoño', 'Zapatos'),
('Invierno', 'Mochila'),
('Verano', 'Zapatos'),
('Primavera', 'Accesorio'),
('Otoño', 'Ropa');
SELECT * FROM categoria;

INSERT INTO producto (cod_barras, precio, descuento, talla, color, id_categoria) VALUES
('1234567890345', 29.99, 0.10, 'M', 'Azul', 1),
('9876543210424', 59.99, 0.05, '44', 'Negro', 2),
('5555555550234', 39.99, 0.15, 'S', 'Rojo', 3),
('1111111110234', 79.99, 0.10, 'XL', 'Blanco', 1),
('9999999990754', 49.99, 0.20, '39', 'Verde', 2),
('4444444440345', 29.99, 0.08, 'S', 'Amarillo', 3),
('7777777770432', 129.99, 0.12, 'L', 'Gris', 1),
('2222222220754', 19.99, 0.10, '42', 'Naranja', 2),
('6666666660266', 14.99, 0.05, 'S', 'Rojo', 3),
('8888888880233', 39.99, 0.18, 'M', 'Azul', 1);
SELECT * FROM producto;

INSERT INTO compra (fecha_compra, id_cliente, id_producto) VALUES
('2024-03-05', 1, 1),
('2024-03-01', 2, 4),
('2024-03-04', 2, 5),
('2024-03-06', 4, 8),
('2024-03-07', 5, 6),
('2024-03-02', 6, 2),
('2024-03-09', 7, 2),
('2024-03-10', 8, 1),
('2024-03-04', 9, 7),
('2024-03-10', 10, 7);
SELECT * FROM compra;

INSERT INTO licencia (nombre, origen) VALUES
('New', 'Inglaterra'),
('One Piece', 'Japón'),
('Artistic Collection', 'Francia'),
('Music', 'Italia'),
('Movies & Shows', 'EE.UU'),
('Lee', 'China'),
('2PAC', 'EE.UU'),
('Pull & Bear', 'España');
SELECT * FROM licencia;

INSERT INTO adquisicion (fecha_adquisicion, id_producto, id_licencia) VALUES
('2021-03-10', 1, 3),
('2020-12-15', 2, 5),
('2020-05-11', 3, 7),
('2022-12-24', 4, 7),
('2023-11-03', 5, 2),
('2011-03-31', 6, 4),
('2014-01-25', 7, 6),
('2014-06-29', 8, 8),
('2019-08-03', 9, 2),
('2019-07-07', 9, 2);
SELECT * FROM adquisicion;
