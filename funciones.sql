-- ======================================================
-- Sistema de Control de Pedidos para Colmados
-- Funciones PL/pgSQL
-- ======================================================

-- =====================================
-- FUNCIÓN:
-- Calcular el total de un pedido
-- =====================================

CREATE OR REPLACE FUNCTION calcular_total(
    p_id_pedido INTEGER
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    v_total NUMERIC(10,2);
BEGIN

    SELECT COALESCE(SUM(cantidad * precio),0)
    INTO v_total
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;

    RETURN v_total;

END;
$$;

-- =====================================
-- FUNCIÓN:
-- Aplicar descuento
-- Si el total supera RD$5,000
-- se aplica un 10%
-- =====================================

CREATE OR REPLACE FUNCTION aplicar_descuento(
    p_total NUMERIC
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN

    IF p_total >= 5000 THEN
        RETURN p_total * 0.90;
    ELSE
        RETURN p_total;
    END IF;

END;
$$;

-- =====================================
-- EJEMPLOS DE USO
-- =====================================

SELECT calcular_total(1);

SELECT aplicar_descuento(
    calcular_total(1)
);
