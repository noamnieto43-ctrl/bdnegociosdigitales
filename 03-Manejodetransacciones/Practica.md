### 📘 Documentación de Actividad: Store Procedure de Inserción de Venta
**Proyecto: Gestión de Ventas e Inventario bdpracticas**

*Objetivo: Implementar un proceso transaccional seguro para registrar ventas y actualizar stock.*

*Entregable: Script SQL y Manual Técnico.*

### 1. Creación de la Base de Datos y Tablas (DDL)
Primero, creamos el contenedor y las tablas con sus respectivas llaves primarias y foráneas.

```sql
CREATE DATABASE BDPRACTICAS;
GO

USE BDPRACTICAS;
GO

-- Tabla CatProducto
CREATE TABLE CatProducto (
    Id_Producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre_Producto NVARCHAR(40),
    Existencia INT,
    Precio MONEY
);

-- Tabla CatCliente
CREATE TABLE CatCliente (
    Id_Cliente NVARCHAR(5) PRIMARY KEY,
    nombre_Cliente NVARCHAR(40),
    País NVARCHAR(15),
    Ciudad NVARCHAR(15)
);

-- Tabla TblVenta
CREATE TABLE TblVenta (
    Id_Venta INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE DEFAULT GETDATE(),
    Id_Cliente NVARCHAR(5),
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (Id_Cliente) REFERENCES CatCliente(Id_Cliente)
);

-- Tabla TblDetalleVenta (Llave primaria compuesta)
CREATE TABLE TblDetalleVenta (
    Id_Venta INT,
    Id_Producto INT,
    precio_venta MONEY,
    cantidad_vendida INT,
    PRIMARY KEY (Id_Venta, Id_Producto),
    CONSTRAINT FK_Detalle_Venta FOREIGN KEY (Id_Venta) REFERENCES TblVenta(Id_Venta),
    CONSTRAINT FK_Detalle_Producto FOREIGN KEY (Id_Producto) REFERENCES CatProducto(Id_Producto)
);
GO

```
### 2. Carga de Datos desde Northwind (DML)
Utilizamos INSERT INTO ... SELECT para migrar la información. Asegúrate de que la base de datos NORTHWND esté disponible en tu servidor.

```sql
-- Llenar CatProducto
INSERT INTO CatProducto (nombre_Producto, Existencia, Precio)
SELECT ProductName, UnitsInStock, UnitPrice 
FROM NORTHWND.dbo.Products;

-- Llenar CatCliente
INSERT INTO CatCliente (Id_Cliente, nombre_Cliente, País, Ciudad)
SELECT CustomerID, CompanyName, Country, City 
FROM NORTHWND.dbo.Customers;
GO
```

### 3. Stored Procedure: USP_AGREGAR_VENTA
Este procedimiento utiliza una Transacción para asegurar que si algo falla (falta de stock o IDs inexistentes), no se guarde nada a medias.
```sql
CREATE PROCEDURE USP_AGREGAR_VENTA
    @Id_Cliente NVARCHAR(5),
    @Id_Producto INT,
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Verificar si el cliente existe
        IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE Id_Cliente = @Id_Cliente)
        BEGIN
            PRINT 'Error: El cliente no existe.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 2. Verificar si el producto existe
        IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE Id_Producto = @Id_Producto)
        BEGIN
            PRINT 'Error: El producto no existe.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 3. Verificar si hay stock suficiente
        DECLARE @StockActual INT;
        DECLARE @PrecioProducto MONEY;

        SELECT @StockActual = Existencia, @PrecioProducto = Precio 
        FROM CatProducto WHERE Id_Producto = @Id_Producto;

        IF @StockActual < @Cantidad
        BEGIN
            PRINT 'Error: Existencia insuficiente.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 4. Insertar en TblVenta
        INSERT INTO TblVenta (Id_Cliente, Fecha) 
        VALUES (@Id_Cliente, GETDATE());

        -- Obtener el ID de la venta recién creada
        DECLARE @IdVentaGenerada INT = SCOPE_IDENTITY();

        -- 5. Insertar en TblDetalleVenta
        INSERT INTO TblDetalleVenta (Id_Venta, Id_Producto, precio_venta, cantidad_vendida)
        VALUES (@IdVentaGenerada, @Id_Producto, @PrecioProducto, @Cantidad);

        -- 6. Actualizar existencia en CatProducto
        UPDATE CatProducto 
        SET Existencia = Existencia - @Cantidad
        WHERE Id_Producto = @Id_Producto;

        COMMIT TRANSACTION;
        PRINT 'Venta registrada exitosamente.';

    END TRY
    BEGIN CATCH
        -- En caso de error inesperado, deshacer cambios
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Ocurrió un error: ' + @ErrorMessage;
    END CATCH
END;
GO


---------------------


/* ESTRUCTURA PARA EXAMEN DE BASE DE DATOS
   Proyecto: Gestión de Transacciones (Northwind / BDPracticas)
*/

CREATE OR ALTER PROC USP_NombreDelProceso
    -- 1. DECLARAR PARÁMETROS (Entradas del usuario)
    @parametroID INT,
    @cantidad INT,
    @clienteID NVARCHAR(5) -- Ejemplo para Northwind
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            
            -- 2. VALIDACIÓN DE EXISTENCIA (¿Existe el registro?)
            IF NOT EXISTS (SELECT 1 FROM TablaMaestra WHERE ID = @parametroID)
            BEGIN
                ;THROW 50001, 'Error: El ID proporcionado no existe.', 1;
            END

            -- 3. VALIDACIÓN DE LÓGICA (¿Hay stock o saldo?)
            -- Ejemplo: IF @cantidad > (Subconsulta de stock)
            IF @cantidad > (SELECT Existencia FROM Productos WHERE ID = @parametroID)
            BEGIN
                ;THROW 50002, 'Error: No hay existencias suficientes.', 1;
            END

            -- 4. OPERACIÓN MAESTRA (Insertar en tabla principal)
            INSERT INTO TablaVentas (ClienteID, Fecha) 
            VALUES (@clienteID, GETDATE());
            
            -- 5. CAPTURAR EL ID GENERADO (Solo si la tabla es IDENTITY)
            DECLARE @NuevoID INT = SCOPE_IDENTITY();

            -- 6. OPERACIÓN DETALLE (Insertar con subconsulta de precio)
            INSERT INTO TablaDetalle (VentaID, ProductoID, Precio, Cantidad)
            VALUES (
                @NuevoID, 
                @parametroID, 
                (SELECT Precio FROM Productos WHERE ID = @parametroID), 
                @cantidad
            );

            -- 7. ACTUALIZACIÓN DE ESTADO (Resta de Stock)
            UPDATE Productos 
            SET Existencia = Existencia - @cantidad 
            WHERE ID = @parametroID;

        COMMIT TRANSACTION
        PRINT 'Operación realizada con éxito.';

    END TRY
    BEGIN CATCH
        -- 8. MANEJO DE SEGURIDAD (Deshacer cambios si algo falla)
        IF @@TRANCOUNT > 0 
        BEGIN
            ROLLBACK TRANSACTION;
        END
        
        -- Mostrar el mensaje de error al usuario
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END
GO

