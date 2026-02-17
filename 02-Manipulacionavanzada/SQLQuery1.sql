-- CONSUSLTAS SIMPLES CON SQL-LMD 

SELECT *          -- ASTERISCOS ES TODAS LAS CPOLUMNAS 
FROM Categories;

SELECT * 
FROM Products;

SELECT *
FROM Orders;

SELECT *
FROM [Order Details]

--PROYECCION  DE ALGUNOS CAMPOS se quita el asterisco y se ponen solo las que se quieren ver EJEMPLO

SELECT 
ProductID,
ProductName,
UnitPrice,
UnitsInStock
FROM Products;



-- alias de columnas EJEMPLOS
SELECT 
ProductID AS  [NUMERO DE PRODUCTOS],
ProductName 'NOMBRE DE PRODUDUCTO',
UnitPrice AS [PRECIO UNITARIO],
UnitsInStock AS STOCK
FROM Products;



SELECT CompanyName AS CLIENTE,
City AS CIUDAD,
Country as PAIS
FROM Customers;

-- CAMPOS CALCULADOS ES AQUEL QUE NO FORMA PARTE DE LA TABLA 


--SELCCIONAR LOS PRODUCTOS Y CALCULAR EL VALOSR DEL INVENTARIO 


SELECT * ,(UnitPrice * UnitsInStock ) AS [COSTO INVENTARIO]
FROM Products;



SELECT 
ProductID,
ProductName,
UnitPrice,
UnitsInStock,
(UnitPrice * UnitsInStock ) AS [COSTO INVENTARIO]
FROM Products;

-- CALCULAR IMPORTE DE VENTA

SELECT *
FROM [Order Details]

SELECT OrderID,
ProductID,
UnitPrice,
Quantity,
(UnitPrice * Quantity) AS SUBTOTAL
From [Order Details]

--- IMporte sin descuanto y con descuanto


