
### Escenario 1: Agregar Producto a Pedido Existente
Se usa cuando ya hay una orden creada y solo quieres añadir una partida más al detalle.###
```sql
CREATE OR ALTER PROC USP_AgregarDetallePedido
    @OrderID INT,
    @ProductID INT,
    @Quantity SMALLINT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            
            -- 1. Validar que la Orden exista
            IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
                ;THROW 50001, 'La Orden no existe.', 1;

            -- 2. Validar que el Producto exista
            IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
                ;THROW 50002, 'El Producto no existe.', 1;

            -- 3. Validar Stock suficiente
            IF @Quantity > (SELECT UnitsInStock FROM Products WHERE ProductID = @ProductID)
                ;THROW 50003, 'No hay stock suficiente.', 1;

            -- 4. Insertar en Detalle (Obteniendo precio del catálogo)
            INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
            VALUES (
                @OrderID, 
                @ProductID, 
                (SELECT UnitPrice FROM Products WHERE ProductID = @ProductID), 
                @Quantity, 
                0
            );

            -- 5. Restar Stock
            UPDATE Products 
            SET UnitsInStock = UnitsInStock - @Quantity 
            WHERE ProductID = @ProductID;

        COMMIT TRANSACTION
        PRINT 'Producto agregado con éxito.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END
GO
```

### Escenario 2: Registrar Venta Completa (Nueva Orden)
Se usa cuando debes crear la orden desde cero para un cliente y luego su primer producto. ###

```sql
CREATE OR ALTER PROC USP_NuevaVentaCompleta
    @CustomerID NVARCHAR(5),
    @EmployeeID INT,
    @ProductID INT,
    @Quantity SMALLINT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            
            -- 1. Validar Cliente y Producto
            IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
                ;THROW 50001, 'Cliente no válido.', 1;
            
            IF @Quantity > (SELECT UnitsInStock FROM Products WHERE ProductID = @ProductID)
                ;THROW 50002, 'Stock insuficiente.', 1;

            -- 2. Insertar Cabecera (Orders)
            INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)
            VALUES (@CustomerID, @EmployeeID, GETDATE());

            -- 3. Capturar el ID de la nueva Orden
            DECLARE @NuevoOrderID INT = SCOPE_IDENTITY();

            -- 4. Insertar Detalle
            INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
            VALUES (
                @NuevoOrderID, 
                @ProductID, 
                (SELECT UnitPrice FROM Products WHERE ProductID = @ProductID), 
                @Quantity, 
                0
            );

            -- 5. Actualizar Stock
            UPDATE Products 
            SET UnitsInStock = UnitsInStock - @Quantity 
            WHERE ProductID = @ProductID;

        COMMIT TRANSACTION
        PRINT 'Venta registrada con éxito.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END
GO
```

### Escenario 3: Cancelación de Partida (Devolución)
Se usa cuando un cliente regresa un producto y debes borrar el detalle y devolver el stock.

```sql
CREATE OR ALTER PROC USP_CancelarProductoPedido
    @OrderID INT,
    @ProductID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            
            -- 1. Validar que la partida exista en el detalle
            IF NOT EXISTS (SELECT 1 FROM [Order Details] WHERE OrderID = @OrderID AND ProductID = @ProductID)
                ;THROW 50001, 'No se encontró el registro de esa venta.', 1;

            -- 2. Obtener la cantidad que se había vendido para regresarla al stock
            DECLARE @CantidadDevuelta INT;
            SELECT @CantidadDevuelta = Quantity FROM [Order Details] 
            WHERE OrderID = @OrderID AND ProductID = @ProductID;

            -- 3. Eliminar el registro del detalle
            DELETE FROM [Order Details] 
            WHERE OrderID = @OrderID AND ProductID = @ProductID;

            -- 4. SUMAR el stock de vuelta al catálogo
            UPDATE Products 
            SET UnitsInStock = UnitsInStock + @CantidadDevuelta 
            WHERE ProductID = @ProductID;

        COMMIT TRANSACTION
        PRINT 'Devolución procesada correctamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END
GO
```
