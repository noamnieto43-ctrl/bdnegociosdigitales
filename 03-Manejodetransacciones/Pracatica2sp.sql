-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------- Practica 2 -----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------






CREATE TYPE TipoProductoVenta AS TABLE
(
    id_Producto INT,
    Cantidad INT
);
GO


-- 2. Crear 
-- PROCEDURE
CREATE OR ALTER PROCEDURE usp_agregar_venta
    @id_Cliente NVARCHAR(5),
    @Productos TipoProductoVenta READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar cliente
        IF NOT EXISTS (SELECT 1 FROM CatClientes WHERE id_Cliente = @id_Cliente)
        BEGIN
            PRINT 'Cliente no existe';
            ROLLBACK;
            RETURN;
        END

        -- Insertar venta
        INSERT INTO TblVenta (Fecha, id_Cliente)
        VALUES (GETDATE(), @id_Cliente);

        DECLARE @id_Venta INT = SCOPE_IDENTITY();

        -- Validar productos
        IF EXISTS (
            SELECT 1
            FROM @Productos p
            LEFT JOIN CatProducto c ON p.id_Producto = c.id_Producto
            WHERE c.id_Producto IS NULL
        )
        BEGIN
            PRINT 'Uno o más productos no existen';
            ROLLBACK;
            RETURN;
        END

        -- Validar existencia
        IF EXISTS (
            SELECT 1
            FROM @Productos p
            JOIN CatProducto c ON p.id_Producto = c.id_Producto
            WHERE p.Cantidad > c.Existencia
        )
        BEGIN
            PRINT 'No hay suficiente existencia';
            ROLLBACK;
            RETURN;
        END

        -- Insertar detalle
        INSERT INTO tblDetalleVenta (id_Venta, id_Producto, precio_Venta, Cantidad_Vendida)
        SELECT 
            @id_Venta,
            c.id_Producto,
            c.Precio,
            p.Cantidad
        FROM @Productos p
        JOIN CatProducto c ON p.id_Producto = c.id_Producto;

        -- Actualizar stock
        UPDATE c
        SET c.Existencia = c.Existencia - p.Cantidad
        FROM CatProducto c
        JOIN @Productos p ON c.id_Producto = p.id_Producto;

        COMMIT;

        PRINT 'Venta completa realizada';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error en la operación';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


--  EJECUCIÓN CORRECTA (ORDEN IMPORTANTE)

DECLARE @ListaProductos TipoProductoVenta;

INSERT INTO @ListaProductos (id_Producto, Cantidad)
VALUES 
(1, 2),
(2, 3),
(5, 1);

-- Verificar datos antes (opcional)
--SELECT * FROM @ListaProductos;

EXEC usp_agregar_venta 
    @id_Cliente = 'ANATR',
    @Productos = @ListaProductos;


select *
from @ListaProductos;
select *
from TblVenta;


select *
from tblDetalleVenta;

select *
from CatProducto

select *
from CatClientes