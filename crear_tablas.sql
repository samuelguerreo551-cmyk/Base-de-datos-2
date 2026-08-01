-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Base de Datos PostgreSQL
-- Autor: Samuel Guerrero
-- ======================================================

-- =====================================
-- TABLA CLIENTES
-- =====================================

CREATE TABLE clientes (

    id_cliente SERIAL PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,

    telefono VARCHAR(20),

    direccion TEXT

);

-- =====================================
-- TABLA PRODUCTOS
-- =====================================

CREATE TABLE productos (

    id_producto SERIAL PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,

    precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0),

    stock INTEGER NOT NULL CHECK (stock >= 0)

);

-- =====================================
-- TABLA PEDIDOS
-- =====================================

CREATE TABLE pedidos (

    id_pedido SERIAL PRIMARY KEY,

    id_cliente INTEGER NOT NULL,

    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    estado VARCHAR(30) DEFAULT 'Pendiente',

    CONSTRAINT fk_cliente

    FOREIGN KEY(id_cliente)

    REFERENCES clientes(id_cliente)

);

-- =====================================
-- TABLA DETALLE DEL PEDIDO
-- =====================================

CREATE TABLE detalle_pedido (

    id_detalle SERIAL PRIMARY KEY,

    id_pedido INTEGER NOT NULL,

    id_producto INTEGER NOT NULL,

    cantidad INTEGER NOT NULL CHECK (cantidad > 0),

    precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0),

    CONSTRAINT fk_pedido

    FOREIGN KEY(id_pedido)

    REFERENCES pedidos(id_pedido),

    CONSTRAINT fk_producto

    FOREIGN KEY(id_producto)

    REFERENCES productos(id_producto)

);

-- =====================================
-- TABLA ENTREGAS
-- =====================================

CREATE TABLE entregas (

    id_entrega SERIAL PRIMARY KEY,

    id_pedido INTEGER NOT NULL,

    repartidor VARCHAR(100),

    fecha_entrega TIMESTAMP,

    estado VARCHAR(30),

    CONSTRAINT fk_entrega_pedido

    FOREIGN KEY(id_pedido)

    REFERENCES pedidos(id_pedido)

);