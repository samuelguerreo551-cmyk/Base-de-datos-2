-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Procedimientos Almacenados (PL/pgSQL)
-- ======================================================

-- =====================================
-- PROCEDIMIENTO:
-- Registrar un nuevo pedido
-- =====================================

CREATE OR REPLACE PROCEDURE registrar_pedido(
    p_id_cliente INTEGER,
    p_id_producto INTEGER,
    p_cantidad INTEGER
)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_pedido INTEGER;
    v_precio NUMERIC(10,2);
BEGIN

    -- Obtener el precio del producto
    SELECT precio
    INTO v_precio
    FROM productos
    WHERE id_producto = p_id_producto;

    -- Verificar que el producto exista
    IF v_precio IS NULL THEN
        RAISE EXCEPTION 'El producto no existe.';
    END IF;

    -- Verificar stock disponible
    IF (SELECT stock
        FROM productos
        WHERE id_producto = p_id_producto) < p_cantidad THEN

        RAISE EXCEPTION 'Stock insuficiente.';
    END IF;

    -- Crear el pedido
    INSERT INTO pedidos(id_cliente, estado)
    VALUES(p_id_cliente, 'Pendiente')
    RETURNING id_pedido INTO v_id_pedido;

    -- Registrar el detalle del pedido
    INSERT INTO detalle_pedido(
        id_pedido,
        id_producto,
        cantidad,
        precio
    )
    VALUES(
        v_id_pedido,
        p_id_producto,
        p_cantidad,
        v_precio
    );

    -- Actualizar inventario
    UPDATE productos
    SET stock = stock - p_cantidad
    WHERE id_producto = p_id_producto;

END;
$$;

-- =====================================
-- EJEMPLO DE USO
-- =====================================

CALL registrar_pedido(1, 2, 3);
