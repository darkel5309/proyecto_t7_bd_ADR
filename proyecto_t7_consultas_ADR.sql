-- 3 CONSULTAS SIMPLES
-- 1. Muestra los nombres de aquellos clientes cuyo nombre contiene una "e".
SELECT nombre FROM cliente
WHERE nombre LIKE '%e%';

-- 2. Muestra el mensaje "El número de teléfono XXXXXXXXX pertenece al cliente (nombre) YYYYYY
-- con dni ZZZZZZZZZ, con el nombre de informacion_cliente
SELECT CONCAT('El número de teléfono ', telefono,' pertenece al cliente ', nombre, ' con DNI ', dni) AS informacion_cliente FROM cliente;

-- 3. Muestra toda la información del producto más caro
SELECT * FROM producto
ORDER BY precio DESC
LIMIT 1;

-- 10 CONSULTAS COMPLEJAS
-- 1. Muestra el total de dinero que ha gastado (dinero_gastado) cada cliente (nombre y apellidos)
SELECT cl.nombre, cl.apellidos, SUM(p.precio) AS dinero_gastado FROM cliente cl
	JOIN compra co ON cl.id = co.id_cliente
	JOIN producto p ON co.id_producto = p.id
GROUP BY cl.nombre, cl.apellidos;

-- 2. Muestra toda la informacion de los clientes que han adquirido algun producto con mas del 10% de descuento
SELECT * FROM cliente cl
	JOIN compra co ON cl.id = co.id_cliente
	JOIN producto p ON co.id_producto = p.id
WHERE p.descuento > 0.10;

-- 3. Muestra los DNI de los clientes que han comprado en el mes de marzo junto a la fecha de compra
SELECT DISTINCT cl.dni, co.fecha_compra FROM cliente cl
	JOIN compra co ON cl.id = co.id_cliente
WHERE MONTH(co.fecha_compra) = 3 AND DAY(co.fecha_compra) = 10;

-- 4. Muestra el nombre y telefono de los clientes que han adquirido algún producto
-- que tenga la licencia de One Piece, como licencia
SELECT cl.nombre, cl.telefono, l.nombre AS licencia
FROM cliente cl
	JOIN compra co ON cl.id = co.id_cliente
	JOIN producto p ON co.id_producto = p.id
	JOIN adquisicion a ON p.id = a.id_producto
	JOIN licencia l ON a.id_licencia = l.id
WHERE l.nombre = 'One Piece';

-- 5. Muestra el tipo de categorias que tengan al menos un producto comprado, como categoria
SELECT DISTINCT ca.tipo AS categoria FROM categoria ca
	JOIN producto p ON ca.id = p.id_categoria
	JOIN compra co ON p.id = co.id_producto;

-- 6. Muestra un mensaje en el que aparezca "el cliente XXXXXXXX XXXXXXXXXX XXXXXXXXX (nombre y apellidos)
-- ha comprado XXXXXXXX (tipo de ropa) de color YYYYY (color)"
-- con el nombre de historial
SELECT CONCAT('El usuario ', cl.nombre, ' ', cl.apellidos, ' ha comprado ', c.tipo, ' de color ', p.color) AS historial FROM cliente cl
	JOIN compra co ON cl.id = co.id_cliente
	JOIN producto p ON co.id_producto = p.id
    JOIN categoria c ON c.id = p.id;

-- 7. Muestra el codigo de barras y precio de los productos que no han adquirido licencias
SELECT p.cod_barras, p.precio FROM producto p
	LEFT JOIN adquisicion a ON p.id = a.id_producto
WHERE a.id_licencia IS NULL;

-- 8. Muestra el nombre del cliente, la fecha de compra, el codigo de barras del producto y el precio de las compras
-- realizadas el dia 05 de marzo de 2024. 
SELECT cl.nombre, co.fecha_compra, p.cod_barras, p.precio FROM compra co
	JOIN cliente cl ON co.id_cliente = cl.id
	JOIN producto p ON co.id_producto = p.id
WHERE co.fecha_compra = '2024-03-05';

-- 9. Muestra que tallas de productos ha comprado Javier, junto su codigo de barras
SELECT DISTINCT p.talla, p.cod_barras FROM cliente cl
	JOIN compra co ON cl.id = co.id_cliente
	JOIN producto p ON co.id_producto = p.id
WHERE cl.nombre = 'Javier';

-- 10. Muestra de que temporadas han comprado los clientes sus productos. El nombre y apellidos del cliente, el telefono y la temporada
SELECT DISTINCT cl.nombre, cl.apellidos, cl.telefono, ca.temporada FROM cliente cl
	JOIN compra co ON cl.id = co.id_cliente
	JOIN producto pr ON co.id_producto = pr.id
	JOIN categoria ca ON pr.id_categoria = ca.id;
