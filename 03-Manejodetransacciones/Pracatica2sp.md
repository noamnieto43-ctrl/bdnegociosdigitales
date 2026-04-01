
 ###  TIPO DE TABLA: TipoProductoVenta
 * DESCRIPCIÓN: Define la estructura del 'carrito de compras' para ser procesado masivamente.
 

```sql
CREATE TYPE TipoProductoVenta AS TABLE
(
    id_Producto INT,
    Cantidad INT
);
GO
```


 ### * PROCEDIMIENTO: usp_agregar_venta
 * DESCRIPCIÓN: Registra una venta, valida stock, inserta detalles y actualiza existencias.
 * PARÁMETROS:
 * - @id_Cliente (NVARCHAR): Código del cliente.
 * - @Productos (READONLY): Listado de productos (Tipo: TipoProductoVenta).
 */ ###

 ```sql
CREATE OR ALTER PROCEDURE usp_agregar_venta
    @id_Cliente NVARCHAR(5),
    @Productos TipoProductoVenta READONLY
AS
BEGIN
    SET NOCOUNT ON; -- Optimiza el rendimiento evitando mensajes de filas afectadas

    BEGIN TRY
        BEGIN TRANSACTION;

        -- ==========================================================
        -- 1. VALIDACIÓN DEL CLIENTE
        -- ==========================================================
        IF NOT EXISTS (SELECT 1 FROM CatClientes WHERE id_Cliente = @id_Cliente)
        BEGIN
            PRINT 'Error: El cliente no existe.';
            ROLLBACK;
            RETURN;
        END

        -- ==========================================================
        -- 2. REGISTRO DE CABECERA DE VENTA
        -- ==========================================================
        INSERT INTO TblVenta (Fecha, id_Cliente)
        VALUES (GETDATE(), @id_Cliente);

        -- Recuperamos el ID de la venta recién creada
        DECLARE @id_Venta INT = SCOPE_IDENTITY();

        -- ==========================================================
        -- 3. VALIDACIÓN DE EXISTENCIA DE PRODUCTOS
        -- ==========================================================
        IF EXISTS (
            SELECT 1
            FROM @Productos p
            LEFT JOIN CatProducto c ON p.id_Producto = c.id_Producto
            WHERE c.id_Producto IS NULL
        )
        BEGIN
            PRINT 'Error: Uno o más productos enviados no existen en el catálogo.';
            ROLLBACK;
            RETURN;
        END

        -- ==========================================================
        -- 4. VALIDACIÓN DE STOCK (EXISTENCIAS)
        -- ==========================================================
        IF EXISTS (
            SELECT 1
            FROM @Productos p
            JOIN CatProducto c ON p.id_Producto = c.id_Producto
            WHERE p.Cantidad > c.Existencia
        )
        BEGIN
            PRINT 'Error: No hay suficiente existencia para completar la orden.';
            ROLLBACK;
            RETURN;
        END

        -- ==========================================================
        -- 5. REGISTRO DEL DETALLE DE VENTA
        -- ==========================================================
        INSERT INTO tblDetalleVenta (id_Venta, id_Producto, precio_Venta, Cantidad_Vendida)
        SELECT 
            @id_Venta,
            c.id_Producto,
            c.Precio,
            p.Cantidad
        FROM @Productos p
        JOIN CatProducto c ON p.id_Producto = c.id_Producto;

        -- ==========================================================
        -- 6. ACTUALIZACIÓN AUTOMÁTICA DE STOCK
        -- ==========================================================
        UPDATE c
        SET c.Existencia = c.Existencia - p.Cantidad
        FROM CatProducto c
        JOIN @Productos p ON c.id_Producto = p.id_Producto;

        -- Si todo salió bien, confirmamos los cambios
        COMMIT;
        PRINT 'Operación Exitosa: Venta registrada y stock actualizado.';

    END TRY
    BEGIN CATCH
        -- En caso de error inesperado, revertimos cualquier cambio
        IF @@TRANCOUNT > 0 ROLLBACK;

        PRINT 'Error Crítico en la Operación:';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


 -- 1. Declarar la variable de tipo tabla (simula el carrito)
DECLARE @ListaProductos TipoProductoVenta;

-- 2. Cargar los productos a vender
INSERT INTO @ListaProductos (id_Producto, Cantidad)
VALUES 
(1, 2), -- 2 unidades del producto 1
(2, 3), -- 3 unidades del producto 2
(5, 1); -- 1 unidad del producto 5

-- 3. Ejecutar el procedimiento
EXEC usp_agregar_venta 
    @id_Cliente = 'ANATR',
    @Productos = @ListaProductos;

-- 4. Verificación de resultados
SELECT 'Ventas Realizadas' AS Info, * FROM TblVenta;
SELECT 'Detalles de Venta' AS Info, * FROM tblDetalleVenta;
SELECT 'Stock Actualizado' AS Info, * FROM CatProducto;

