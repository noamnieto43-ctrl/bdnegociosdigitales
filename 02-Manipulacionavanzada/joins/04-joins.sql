/**

INER JOIN
LEFT JOIN
RIGHT JOIN
FULL JOIN

**/
--siempre lleva un on el iner join

SELECT 
Categories.CategoryID,
Categories.CategoryName,
Products.ProductID,
Products.UnitPrice,
Products.UnitsInStock,
(Products.UnitPrice * Products.UnitsInStock)
as [Precio de inventario]
FROM Categories
INNER JOIN Products
on Categories.CategoryID = Products.CategoryID
where Categories.CategoryID = 9



