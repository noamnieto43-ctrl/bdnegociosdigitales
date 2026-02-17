/* Funciones de Agragado son 
1. sum()
2. max()
3. min()
4. avg()
5. count(*)
6. count(campo)

*/


SELECT  DISTINCT Country
FROM Customers


---seleccionar los paises de donde son los clientes 



SELECT  DISTINCT Country
FROM Customers


-- SGREGACION COUNT(*) cuenta el nueme de registros que tiene una tabla 


SELECT  COUNT(*) as [TOTAL DE ORDENES]
FROM Orders;

--SELECCIONAR EL TOTAL DE ORDENES QUE FUERON ENVIADAS A ALEMANIA 

SELECT COUNT(*) as [Numero de ordenes a alemania]
FROM Orders
where ShipCountry  = 'Germany'

select *
from Orders

SELECT *
FROM Customers

SELECT count(CustomerID)
FROM Customers 

SELECT count(Region)
FROM Customers 
--count con asterisco cuenta todo de un campo 
-- y bsin asterisco cuenta todos menos los nulos 



--selecciona de cuantas ciudades son las ciudades de los ciudades  



SELECT city
FROM Customers
Order by city Asc;

SELECT count(city)
FROM Customers

SELECT COUNT (DISTINCT city) AS [CIUDADES CLIENETES]
FROM Customers


-- SELECCIONA EL PRECIO MAXIMO DE LOS PRODUCTOS 

SELECT *
FROM Products
ORDER BY UnitPrice DESC;



SELECT MAX(UnitPrice) as [Precio mas alto]
FROM Products


SELECT MAX(OrderDate) as [fecha mas reciente]
FROM orders


select *
from orders 


SELECT YEAR(MAX(OrderDate)) as [fecha mas reciente]
FROM orders



SELECT (MIN(OrderDate)) as [Primera fecha]
FROM orders



SELECT MAX(DATEPART(YEAR,OrderDate))
FROM Orders

SELECT DATEPART(YEAR, MAX(OrderDate)) AS [AÑO]
FROM Orders



SELECT (MIN(Quantity)) as [Primera fecha]
FROM [Order Details]


SELECT (MIN(UnitPrice)) as [Precio minimo de vente]
FROM [Order Details]


SELECT min(UnitPrice * Quantity * (1-Discount)) AS [IMPORTE]
FROM [Order Details]


SELECT (UnitPrice * Quantity * (1-Discount)) AS [IMPORTE]
FROM [Order Details]
ORDER BY [IMPORTE] ASC

SELECT (UnitPrice * Quantity * (1-Discount)) AS [IMPORTE]
FROM [Order Details]
ORDER BY (UnitPrice * Quantity * (1-Discount)) ASC


select *
from [Order Details]
--- TOTAL DE LOS PRECIOS DE LOS PRODUCTOS

select sum(UnitPrice) as [Total de suma del valor de todos los producto]
from [Order Details]





select *
from Products

select sum(UnitPrice) as [Total de suma del valor de todos los producto]
from Products



SELECT 
sum((Quantity * UnitPrice * (1-Discount))) as [Producto 1, 10 y 12]
FROM [Order Details]
Where ProductID IN (4, 10, 20)






SELECT SUM(Freight) AS Total_Segundo_Trimestre_1995
FROM Orders
WHERE OrderDate BETWEEN '1995-04-01' AND '1995-06-30';





select *
from Customers


--seleccionar el numero de clientes que comienzan con  a o que comienzan con b

SELECT SUM(Freight) AS Total_Segundo_Trimestre_1995
FROM Orders
WHERE OrderDate BETWEEN '1997-04-01' AND '1998-06-30';


SELECT COUNT(*) AS Total_Clientes_AB
FROM Customers
WHERE CompanyName LIKE 'A%' OR CompanyName LIKE 'B%';


 




select *
from Customers
where CompanyName = 'Chop-suey Chinese'


select COUNT(*) AS [Numero de ordenes]
from Orders
where CustomerID = 'CHOPS' AND YEAR(OrderDate) = 1996;


/*

GROUP BY Y HAVING
*/
SELECT c.CompanyName, 
       COUNT(o.OrderID) AS [Numero de ordenes]
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
ORDER BY [Numero de ordenes] DESC;


-- seleccionar el numero de productos por categoria mostrr categoriaid,total de los prodroductos, ordenarlos de mayor a menor por el tataldeproductos

SELECT CategoryID, 
       COUNT(ProductID) AS [Total de productos]
FROM Products
GROUP BY CategoryID
ORDER BY [Total de productos] DESC;

seleccionar el precio promedio por probedor de los productos 
redondear a dos decimales el resultado
ordenar de forma decendente por el precio promedio 



SELECT SupplierID, 
       CAST(SUM(UnitPrice) / COUNT(ProductID) AS DECIMAL(10,2)) AS [Precio Promedio]
FROM Products
GROUP BY SupplierID
ORDER BY [Precio Promedio] DESC;


SELECT SupplierID, 
       ROUND(AVG(UnitPrice), 2) AS [Precio Promedio]
FROM Products
GROUP BY SupplierID
ORDER BY [Precio Promedio] DESC;

SELECT *
FROM Customers


--- selecionaer los clienetes por pais y ordenarlos por pais alfaveticamente 

SELECT Country as [Pais de origen], ContactName
as [Nombre de cliente]
FROM Customers
Group by Country, ContactName


---obtener la cantidad totl vendidad agrupada por producto y por pedido

select sum(UnitPrice * Quantity) as [Total de venta]
from [Order Details]




select ProductID,OrderID, sum(UnitPrice * Quantity) as [Total de venta]
from [Order Details]
group by ProductID, OrderID
order by ProductID

select ProductID,OrderID, sum(UnitPrice * Quantity) as [Total de venta]
from [Order Details]
group by ProductID, OrderID
order by ProductID, [Total de venta] desc



select * ,
(UnitPrice * Quantity) as [Total de venta]
from [Order Details]
where OrderID = 1047
AND ProductID = 1



--seleccionar la cantidad maxima vendida en cada producto de cada pedido 


select OrderID, UnitPrice  as [cantidad maxima de producto]
from [Order Details]
order by ProductID


SELECT  ProductID,OrderID,
       MAX(Quantity) AS [Cantidad Maxima]
FROM [Order Details] Products
GROUP BY ProductID, OrderID
Order By ProductID, OrderID





select *
from Products





--flujo logico sql 1 from 2 join 3 where 4 grup bay  5 having 6 select 7 distin 8 order bay 



--Having(Filtro de grupos)
--selecciar los clienetes que allan realizado mas de 10 pedidos 




SELECT customerid, count(*) AS [Numero de ordenes]
FROM Orders
GROUP BY CustomerID
Having COUNT(*) > 10
ORDER BY 2 DESC;




SELECT customerid, count(*) AS [Numero de ordenes]
FROM Orders
where ShipCountry IN ('Germany','France', 'Brazil')
GROUP BY CustomerID
Having COUNT(*) > 10
ORDER BY 2 DESC;


SELECT Customerid, count(*) AS [Numero de ordenes]
FROM Orders
where ShipCountry IN ('Germany','France', 'Brazil')
GROUP BY CustomerID, ShipCountry
Having COUNT(*) > 10
ORDER BY 2 DESC;



SELECT c.CompanyName, count(*) AS [Numero de ordenes]
FROM Orders as o 
inner join
Customers AS c
on o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
Having COUNT(*) > 10
ORDER BY 2 DESC;


-- SELECCIONAR LOS EMPLEADOS QUE ALLAN GESTIONADO PEDIDOS CON UN TOTAL SUPERIOR a 50000 en ventas que muestre el nombre del noambre y id de empleado y total de compras 



SELECT *
FROM Employees as e 
inner join Orders AS o
ON e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
ON o.OrderID = od.OrderID




SELECT 

CONCAT(e.FirstName,'  ', e.LastName) as [Nombre Copleto],

(od.Quantity * od.UnitPrice * (1 - od.Discount)) as [Importe]

FROM Employees as e 
inner join Orders AS o
ON e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
ON o.OrderID = od.OrderID
Order by e.FirstName 



 
SELECT 

CONCAT(e.FirstName,'  ', e.LastName) as [Nombre Completo],

SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) as [Importe]

FROM Employees as e 
inner join Orders AS o
ON e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
ON o.OrderID = od.OrderID
GROUP BY e.FirstName, e.LastName
HAVING SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) > 100000
Order by [Importe] desc;


-- SELECCIONAR EL NUMERO DE PRODUCTOS VENDIDOS EN MAS DE 20 PEDIDOS DISTINTOS 
-- MORTAR ID DEL PRODUCTO, EL NOMBRE DEL PRODUCTO Y EL NUMERO DE ORDENES 


SELECT p.ProductID, p.ProductName, COUNT(o.OrderID) as [Numero de pedidos]
FROM Products as p
inner join [Order Details] as od
on p.ProductID = od.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
GROUP BY p.ProductID, p.ProductName
HAVING COUNT(o.OrderID)>20;


--seleccionar los productos no descontinuados 
--calcular el precio promedio vendido y mostror solo aquellos que se allan vendido en menos de 15 pedidos distintos 
--

SELECT p.ProductName, avg(od.UnitPrice) as [Precio Promedio]
FROM Products as p
inner join [Order Details] as od
on p.UnitPrice = od.ProductID
where p.Discontinued = 0 
GROUP BY p.ProductName
HAVING COUNT(OrderID) < 15;

--seleccionar el precio maximo de productos por
--categoria pero solo si la suma de unidades es menosr a 200 y ademas que no esten descontinuados 



select 
c.CategoryID,
c.CategoryName,
p.ProductName, max(p.UnitPrice) as [Precio maximo]
from Categories as c
inner join Products as p 
on c.CategoryID = p.CategoryID
where p.Discontinued = 0
group by c.CategoryID, c.CategoryName, p.ProductName
having sum(p.UnitsInStock ) < 200
order by CategoryName, p.ProductName desc;






select *
from [Order Details]
