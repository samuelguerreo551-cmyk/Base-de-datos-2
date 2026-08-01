-- =====================================================================
-- Archivo: procedimientos.sql
-- Descripción: Procedimientos almacenados (PROCEDURE) que automatizan
--              tareas de negocio completas: registrar un pedido,
--              actualizar inventario y cancelar un pedido.
-- =====================================================================

-- ---------------------------------------------------------------------
-- sp_registrar_pedido
-- Crea la cabecera del pedido y un ítem de detalle, verificando stock.
-- El total y el descuento de stock los completan los triggers
-- (ver triggers.sql). Se puede llamar varias veces (una por producto)
-- para armar un pedido con varios artículos.
-- ---------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_registrar_pedido(
    IN  p_id_cliente    INTEGER,
    IN  p_id_empleado   INTEGER,
    IN  p_id_sucursal   INTEGER,
    IN  p_id_producto   INTEGER,
    IN  p_cantidad      INTEGER,
    INOUT p_id_pedido   INTEGER DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_precio NUMERIC(10,2);
BEGIN
    -- Verifica stock disponible antes de continuar
    IF NOT fn_stock_disponible(p_id_producto, p_cantidad) THEN
        RAISE EXCEPTION 'Stock insuficiente para el producto % (cantidad solicitada: %)',
            p_id_producto, p_cantidad;
    END IF;

    -- Si no se recibió un pedido existente, crea la cabecera
    IF p_id_pedido IS NULL THEN
        INSERT INTO pedidos (id_cliente, id_empleado, id_sucursal, estado)
        VALUES (p_id_cliente, p_id_empleado, p_id_sucursal, 'PENDIENTE')
        RETURNING id_pedido INTO p_id_pedido;
    END IF;

    SELECT precio INTO v_precio FROM productos WHERE id_producto = p_id_producto;

    -- Inserta el detalle; el trigger trg_calcular_subtotal calcula el
    -- subtotal y trg_actualizar_stock descuenta el inventario.
    INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad, precio_unitario)
    VALUES (p_id_pedido, p_id_producto, p_cantidad, v_precio);

    COMMIT;
END;
$$;


-- ---------------------------------------------------------------------
-- sp_actualizar_inventario
-- Ajusta manualmente el stock de un producto (entradas de mercancía,
-- correcciones de conteo físico, etc.). Usa un valor positivo para
-- sumar y negativo para restar.
-- ---------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_actualizar_inventario(
    IN p_id_producto INTEGER,
    IN p_ajuste      INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock_actual INTEGER;
BEGIN
    SELECT stock INTO v_stock_actual FROM productos WHERE id_producto = p_id_producto FOR UPDATE;

    IF v_stock_actual IS NULL THEN
        RAISE EXCEPTION 'El producto % no existe', p_id_producto;
    END IF;

    IF v_stock_actual + p_ajuste < 0 THEN
        RAISE EXCEPTION 'El ajuste dejaría el stock en negativo (actual: %, ajuste: %)',
            v_stock_actual, p_ajuste;
    END IF;

    UPDATE productos
       SET stock = stock + p_ajuste
     WHERE id_producto = p_id_producto;

    COMMIT;
END;
$$;


-- ---------------------------------------------------------------------
-- sp_cancelar_pedido
-- Cancela un pedido, devuelve el stock reservado a inventario y marca
-- la entrega asociada (si existe) como fallida.
-- ---------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_cancelar_pedido(IN p_id_pedido INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    r RECORD;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pedidos WHERE id_pedido = p_id_pedido) THEN
        RAISE EXCEPTION 'El pedido % no existe', p_id_pedido;
    END IF;

    -- Devuelve el stock de cada producto del pedido
    FOR r IN SELECT id_producto, cantidad FROM detalle_pedidos WHERE id_pedido = p_id_pedido LOOP
        UPDATE productos SET stock = stock + r.cantidad WHERE id_producto = r.id_producto;
    END LOOP;

    UPDATE pedidos SET estado = 'CANCELADO' WHERE id_pedido = p_id_pedido;

    UPDATE entregas SET estado_entrega = 'FALLIDO' WHERE id_pedido = p_id_pedido;

    COMMIT;
END;
$$;
