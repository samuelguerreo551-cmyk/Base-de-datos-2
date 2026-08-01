-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Triggers PL/pgSQL
-- ======================================================

-- =====================================
-- FUNCIÓN DEL TRIGGER
-- Actualizar inventario automáticamente
-- =====================================

CREATE OR REPLACE FUNCTION actualizar_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN

    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;

    RETURN NEW;

END;
$$;

-- =====================================
-- CREAR TRIGGER
-- =====================================

DROP TRIGGER IF EXISTS trg_actualizar_stock
ON detalle_pedido;

CREATE TRIGGER trg_actualizar_stock

AFTER INSERT

ON detalle_pedido

FOR EACH ROW

EXECUTE FUNCTION actualizar_stock();

-- =====================================
-- EJEMPLO
-- Al insertar un detalle de pedido,
-- el inventario disminuirá automáticamente.
-- =====================================

/*
INSERT INTO detalle_pedido
(id_pedido,id_producto,cantidad,precio)

VALUES
(1,1,2,240.00);
*/
