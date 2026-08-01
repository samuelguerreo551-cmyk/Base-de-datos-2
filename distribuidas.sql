-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Bases de Datos Distribuidas (PostgreSQL FDW)
-- ======================================================

-- =====================================
-- Habilitar la extensión FDW
-- =====================================

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- =====================================
-- Crear un servidor remoto
-- (Ejemplo de otra sucursal)
-- =====================================

CREATE SERVER sucursal_secundaria
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (
    host '192.168.1.100',
    port '5432',
    dbname 'colmado_sucursal'
);

-- =====================================
-- Crear el mapeo de usuario
-- =====================================

CREATE USER MAPPING FOR CURRENT_USER
SERVER sucursal_secundaria
OPTIONS (
    user 'postgres',
    password '123456'
);

-- =====================================
-- Importar tablas de la sucursal remota
-- =====================================

IMPORT FOREIGN SCHEMA public
LIMIT TO (productos)
FROM SERVER sucursal_secundaria
INTO public;

-- =====================================
-- Consulta de ejemplo
-- =====================================

SELECT *
FROM productos;
