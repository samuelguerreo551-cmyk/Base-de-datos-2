-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Ejemplos de Transacciones
-- ======================================================

-- =====================================
-- TRANSACCIÓN 1
-- Registrar un nuevo pedido
-- =====================================

BEGIN;

INSERT INTO pedidos (id_cliente, estado)
VALUES (1, 'Pendiente');

INSERT INTO detalle_pedido
(id_pedido, id_producto, cantidad, precio)
VALUES
(currval('pedidos_id_pedido_seq'), 2, 3, 95.00);

COMMIT;

-- =====================================
-- TRANSACCIÓN 2
-- Actualizar el inventario después de una venta
-- =====================================

BEGIN;

UPDATE productos
SET stock = stock - 3
WHERE id_producto = 2;

COMMIT;

-- =====================================
-- TRANSACCIÓN 3
-- Ejemplo de ROLLBACK
-- Si ocurre un error, se cancelan todos los cambios
-- =====================================

BEGIN;

INSERT INTO pedidos (id_cliente, estado)
VALUES (2, 'Pendiente');

UPDATE productos
SET stock = stock - 1000
WHERE id_producto = 1;

ROLLBACK;
