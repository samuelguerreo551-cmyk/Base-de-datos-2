-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Inserción de datos de prueba
-- ======================================================

-- =====================================
-- CLIENTES
-- =====================================

INSERT INTO clientes (nombre, telefono, direccion)
VALUES
('Juan Pérez', '809-555-1001', 'Higüey'),
('María Gómez', '829-555-2002', 'Verón'),
('Carlos Rodríguez', '849-555-3003', 'Bávaro'),
('Ana Martínez', '809-555-4004', 'La Romana'),
('Luis Fernández', '829-555-5005', 'Punta Cana');

-- =====================================
-- PRODUCTOS
-- =====================================

INSERT INTO productos (nombre, precio, stock)
VALUES
('Arroz Selecto 5 lb', 240.00, 50),
('Azúcar 2 lb', 95.00, 80),
('Aceite Mazola 900 ml', 210.00, 40),
('Leche Carnation', 85.00, 100),
('Pan de Molde', 120.00, 35),
('Huevos (30 unidades)', 280.00, 25),
('Refresco Cola 2.5L', 150.00, 60),
('Café Santo Domingo 1 lb', 320.00, 30);

-- =====================================
-- PEDIDOS
-- =====================================

INSERT INTO pedidos (id_cliente, estado)
VALUES
(1, 'Pendiente'),
(2, 'Entregado'),
(3, 'En camino');

-- =====================================
-- DETALLE DE PEDIDOS
-- =====================================

INSERT INTO detalle_pedido
(id_pedido, id_producto, cantidad, precio)
VALUES
(1,1,2,240.00),
(1,3,1,210.00),
(2,2,3,95.00),
(2,4,5,85.00),
(3,7,2,150.00),
(3,5,1,120.00);

-- =====================================
-- ENTREGAS
-- =====================================

INSERT INTO entregas
(id_pedido, repartidor, fecha_entrega, estado)
VALUES
(2,'Pedro López',CURRENT_TIMESTAMP,'Entregado'),
(3,'José Ramírez',CURRENT_TIMESTAMP,'En camino');