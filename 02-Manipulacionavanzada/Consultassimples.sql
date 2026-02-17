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


SELECT 
    OrderID,
    UnitPrice,
    Quantity,
    Discount,
    (UnitPrice * Quantity) AS Importe,
    (UnitPrice * Quantity) * (1 - Discount) AS [Importe con descuento 1],
    (UnitPrice * Quantity) * (1 - Discount) AS [Importe de descuento 2]
FROM [Order Details]


-- OPERADORES RELACIONALES (<,>,<=,>=,!=O )

--Seleccionar los productos con preso mayor a 30 --
-- seleccionar los productos con strock menor o mayor a 20 
-- seleccionar los pedidos posteriores a 1997 

SELECT *
FROM Products;

SELECT 
ProductID as [Numero de Producto],
ProductName as [Nombre de Producto],
UnitPrice as [Nmero de Producto],
UnitsInStock as stock
FROM Products
where UnitPrice>30
ORDER BY UnitPrice DESC;


SELECT 
ProductID as [Numero de Producto],
ProductName as [Nombre de Producto],
UnitPrice as [Nmero de Producto],
UnitsInStock as stock
FROM Products
where UnitsInStock <= 20;

SELECT *          -- ASTERISCOS ES TODAS LAS CPOLUMNAS 
FROM Categories;

SELECT * 
FROM Products;

SELECT *
FROM Orders;

SELECT *
FROM [Order Details]

SELECT 
OrderID,
OrderDate
FROM Orders
where OrderDate > '1997-12-31';


SET LANGUAGE SPANISH
SELECT OrderID, OrderDate, CustomerID, ShipCountry,
YEAR(OrderDate) AS Año,
MONTH(OrderDate) AS Mes,
DAY(orderdate) AS Día,
DATEPART (YEAR, OrderDate) AS AÑO2,
DATEPART (QUARTER, OrderDate) AS Trimestre,
DATEPART (WEEKDAY, OrderDate) as [Dia semana],
DATEPART (WEEKDAY, OrderDate) AS [Dia semana nombre]
FROM Orders
WHERE DATEPART(YEAR,OrderDate) > 1997;




--- operadores logicos (not, and , or )
--selecionar los productos quer tengan un precio mayor a veinte y menos de 100 unidades en stok

SELECT *
FROM Products
where UnitPrice > 20 and UnitsInStock < 100


SELECT *
FROM Customers
WHERE Country = 'USA' OR Country = 'Canada';

SELECT *
FROM Orders
Where ShipRegion = 

SELECT OrderID, ShipRegion
FROM Orders
WHERE ShipRegion IS NULL;


SELECT OrderID, ShipRegion
FROM Orders
WHERE ShipRegion IS NOT NULL;



SELECT *
FROM Customers
WHERE Country IN ('Germany', 'France', 'UK')
ORDER BY Country DESC;


SELECT *
FROM Products
WHERE CategoryID IN (1, 3, 5);
-------------------
--OPERECION BETWEEN

--Mostrar los profuctos cuyo precio entra entre 20 y 40 


SELECT *
FROM Products
WHERE UnitPrice BETWEEN 20 AND 40
ORDER BY UnitPrice









--OPERECION LIke

-- selccionar todos los clienets customers que empienzen con la letra a 
-- wigdcars o comodines 
SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE 'an%';


SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE City LIKE 'l_nd__%';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE '%s';

-----------------------------
SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERe City LIKE 'M%';

---------------------
----- poner 

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERe NOT CompanyName LIKE 'a%' or CompanyName like 'b%'



SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERe NOT (CompanyName LIKE 'a%' or CompanyName like 'b%');

--SELECCIONAR TODOS LOS CLIENETES QUE COMIENZEN CON B Y TERMINEN CON S 

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERe CompanyName LIKE 'b%';



SELECT CustomerID, CompanyName, city, region, country
from Customers
WHERE CompanyName LIKE 'a__%';


--SELECCIONAR todos los clientes (b,s,o,p)

SELECT CustomerID, CompanyName, city, region, country
from Customers
WHERE CompanyName LIKE '[bsp]%';


--SELECCIONAR TODOS LOS CUSTOMER QUE EMPIENSEN CON A,B,C ,D, E OR F,

SELECT CustomerID, CompanyName, city, region, country
from Customers
WHERE CompanyName LIKE '[a-z]%'
ORDER BY 4 ASC;


SELECT CustomerID, CompanyName, city, region, country
from Customers
WHERE CompanyName LIKE '[^bsp]%';




SELECT 
CustomerID,
CompanyName,
city,
region,
country
from Customers
WHERE CompanyName LIKE '[^a-f]%'
ORDER BY 2 ASC;


---SELECCIONAR TODODS LOS CLIENTES DE ESTADOS UNIDOS O CANADA QUE INICIEN CON B



SELECT *
FROM Customers
WHERE Country = 'USA' OR Country = 'Canada';


SELECT *
FROM Customers
WHERE Country = 'USA' OR Country = 'Canada'
  and CompanyName LIKE 'B%';


  
SELECT *
FROM Customers
WHERE Country = 'USA' OR Country = 'Canada'
  and CompanyName LIKE 'B%';