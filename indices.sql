-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Creación de Índices
-- ======================================================

-- =====================================
-- ÍNDICES PARA CLIENTES
-- =====================================

CREATE INDEX idx_clientes_nombre
ON clientes(nombre);

CREATE INDEX idx_clientes_telefono
ON clientes(telefono);

-- =====================================
-- ÍNDICES PARA PRODUCTOS
-- =====================================

CREATE INDEX idx_productos_nombre
ON productos(nombre);

CREATE INDEX idx_productos_precio
ON productos(precio);

-- =====================================
-- ÍNDICES PARA PEDIDOS
-- =====================================

CREATE INDEX idx_pedidos_fecha
ON pedidos(fecha);

CREATE INDEX idx_pedidos_estado
ON pedidos(estado);

-- =====================================
-- ÍNDICES PARA DETALLE DE PEDIDOS
-- =====================================

CREATE INDEX idx_detalle_pedido
ON detalle_pedido(id_pedido);

CREATE INDEX idx_detalle_producto
ON detalle_pedido(id_producto);

-- =====================================
-- ÍNDICES PARA ENTREGAS
-- =====================================

CREATE INDEX idx_entregas_estado
ON entregas(estado);

CREATE INDEX idx_entregas_repartidor
ON entregas(repartidor);