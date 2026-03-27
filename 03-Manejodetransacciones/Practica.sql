CREATE DATABASE bdpracticas
go

use bdpracticas
go
--------------------------------------------TABLA 1 CATPRODUCTO------------------------------------------------------------------
-- CREAR EL DIAGRAMA, UTILIZADO LOS DATOS DE NORWINTD 

create table CatProducto 
(

   Id_Producto INT IDENTITY (1,1) PRIMARY KEY,
   Nombre_Producto NVARCHAR(40),
   Existencia INT,
   Precio MONEY

);
GO

USE NORTHWND
select * from products
GO

-- Llenar la tabla con datos de Northwind CatProducto
INSERT INTO CatProducto (Nombre_Producto, Existencia, Precio)
SELECT 
    ProductName, 
    UnitsInStock, 
    UnitPrice
FROM NORTHWND.dbo.Products
GO

-- Verificar que se llenó correctamente
SELECT * FROM CatProducto;
GO

---------------------------------TABLA 2 CATCLIENTES------------------------------------------------------------------------
CREATE TABLE CatClientes
(

id_Cliente NVARCHAR(5) PRIMARY KEY, 
Nombre_Cliente NVARCHAR(40),
País NVARCHAR(15),
Ciudad NVARCHAR(15)

);
GO
   
   INSERT INTO CatClientes (id_Cliente, Nombre_Cliente, País, Ciudad)
SELECT 
    CustomerID,
    CompanyName, 
    Country, 
    City
FROM NORTHWND.dbo.Customers
GO

use NORTHWND
use bdpracticas
select * from CatClientes
----------------------------------------------TABLA 3 TblVenta-------------------------------------------------------------------------


CREATE TABLE TblVenta (
    Id_Venta INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE DEFAULT GETDATE(), -- Por defecto pone la fecha de hoy
    Id_Cliente NVARCHAR(5),       -- DEBE SER NVARCHAR(5) para coincidir con CatClientes
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (Id_Cliente) REFERENCES CatClientes(id_Cliente)
);
GO
select * from TblVenta

------------------------------------------------------TABLA 4 TblDetalleVenta------------------------------------------------------------------------------------------


CREATE TABLE TblDetalleVenta (
    Id_Venta INT,
    Id_Producto INT,
    precio_venta MONEY,
    cantidad_vendida INT,
    -- Definimos la llave primaria compuesta
    PRIMARY KEY (Id_Venta, Id_Producto),
    -- Definimos las llaves foráneas
    CONSTRAINT FK_Detalle_Venta FOREIGN KEY (Id_Venta) REFERENCES TblVenta(Id_Venta),
    CONSTRAINT FK_Detalle_Producto FOREIGN KEY (Id_Producto) REFERENCES CatProducto(Id_Producto)
);
GO

-----------------------------SP-------------------------------------
CREATE OR ALTER PROC USP_AGREGAR_VENTA
@id_cliente varchar(5),
@id_Producto INT,
@cantidad_vendida int
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION -- Aquí el contador sube a 1
        
        IF EXISTS (SELECT 1 FROM CatClientes WHERE id_Cliente = @id_cliente)
        BEGIN
            IF EXISTS (SELECT 1 FROM CatProducto WHERE Id_Producto = @id_Producto)
            BEGIN
                -- CAMBIO AQUÍ: Validamos que la cantidad NO sea mayor al stock
                IF @cantidad_vendida <= (SELECT Existencia FROM CatProducto WHERE Id_Producto = @id_Producto)
                BEGIN 
                    -- PROCESO DE VENTA
                    INSERT INTO TblVenta (Id_Cliente, Fecha) VALUES (@id_cliente, GETDATE());
                    
                    DECLARE @VentaID INT = SCOPE_IDENTITY();

                    INSERT INTO TblDetalleVenta (Id_Venta, Id_Producto, precio_venta, cantidad_vendida)
                    VALUES (@VentaID, @id_Producto, (SELECT Precio FROM CatProducto WHERE Id_Producto = @id_Producto), @cantidad_vendida);

                    UPDATE CatProducto
                    SET Existencia = Existencia - @cantidad_vendida
                    WHERE Id_Producto = @id_Producto;

                    COMMIT TRANSACTION; -- Aquí el contador vuelve a 0 (Todo bien)
                    PRINT 'Venta realizada con éxito';
                END
                ELSE
                BEGIN
                    -- Si hay error, lanzamos el error para que caiga al CATCH
                    ;THROW 50001, 'No hay stock suficiente', 1;
                END
            END
            ELSE
            BEGIN
                ;THROW 50002, 'El producto no existe', 2;
            END
        END
        ELSE
        BEGIN
            ;THROW 50003, 'El cliente no existe', 3;
        END

    END TRY
    BEGIN CATCH
        -- ESTO ES LO MÁS IMPORTANTE:
        -- Si hubo un error y la transacción sigue abierta, ciérrala (ROLLBACK)
        IF @@TRANCOUNT > 0 
        BEGIN
            ROLLBACK TRANSACTION; 
        END
        
        PRINT 'Error detectado: ' + ERROR_MESSAGE();
    END CATCH
END;




use bdpracticas


EXEC USP_AGREGAR_VENTA 
    @id_cliente = 'ALFKI', 
    @id_Producto = 1, 
    @cantidad_vendida = 1000;

