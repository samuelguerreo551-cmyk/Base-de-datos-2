-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Creación de Vistas
-- ======================================================

-- =====================================
-- Vista de Ventas
-- =====================================

CREATE OR REPLACE VIEW vista_ventas AS

SELECT

p.id_pedido,

c.nombre AS cliente,

p.fecha,

p.estado,

SUM(d.cantidad * d.precio) AS total

FROM pedidos p

INNER JOIN clientes c
ON p.id_cliente = c.id_cliente

INNER JOIN detalle_pedido d
ON p.id_pedido = d.id_pedido

GROUP BY

p.id_pedido,
c.nombre,
p.fecha,
p.estado;

-- =====================================
-- Vista del Inventario
-- =====================================

CREATE OR REPLACE VIEW vista_inventario AS

SELECT

id_producto,
nombre,
precio,
stock

FROM productos;

-- =====================================
-- Vista de Entregas
-- =====================================

CREATE OR REPLACE VIEW vista_entregas AS

SELECT

e.id_entrega,

c.nombre AS cliente,

e.repartidor,

e.fecha_entrega,

e.estado

FROM entregas e

INNER JOIN pedidos p
ON e.id_pedido = p.id_pedido

INNER JOIN clientes c
ON p.id_cliente = c.id_cliente;
