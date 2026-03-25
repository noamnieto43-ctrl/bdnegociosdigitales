#Lenguaje Transact SQL (Microsof sql server)

##👽    fundamentos programables 

## Que es la parte programable de transact t-sql?

Es todo lo que permite:

- usar variables
- controlar el flujo (if/else/while)
- crear procedimintos almacenados (stor procidius)
- Disparadores (Triggers)
- crear funciones
- usar transacciones

Es convertir sql en un lenguaje casi c/Java pero dentro del motor de base de datos 

variables 
------------------------

/* ==================================Ejercicio 1======================================*/
--declarar una variable que llame @precio y que le asigne el valor , carcular el iva a 16% y quiero que muestre el 

DECLARE @precioo MONEY = 150;
DECLARE @IVAA DECIMAL(10,2);
DECLARE @totall MONEY;
SET @IVAA = @precioo * 0.16;
SET @totall = @precioo + @IVAA
SELECT @precioo AS [PRECIO], CONCAT('$', @IVAA) AS [IVA(16%)], @totall AS [TOTAL]
-----------------

IF/ELSE

Definicion permiyte ejecutar codigo de un segun condicion 

-------------------------------------------------------------

DECLARE @calificacion decimal (10,2) = 7.5;

if @calificacion >= 0 and @calificacion<=10

  if @calificacion >= 7.0
print ('Aprovado')

else
print ('Reprobado')
else
select concat(@calificacion, 'esta fuera del rango') as [Respueesta]

--------------------

while (ciclos)


declare @limite int = 5;
DECLARE @i int = 1;

While (@i<=@limite)
begin
print concat('Numeros: ' , @i)
set @i = @i + 1
end




------------------
   CREATE or ALTER PROC usp_numero_multiplicar
   @num int
   as 
   begin 
   if @num<=0
   print 'el numero no puede ser negativo ni cero'
   return;
     end
      select (@num * 5) as [operacion]
   end;
   
   execute usp_numero_multiplicar -34;
   go



   CREATE OR ALTER PROC usp_nombre_mayusculas
   @name varchar(15)
   as
   begin 
    select upper(@name) as [name]
    end;

    execute usp_nombre_mayusculas 'Monico'


**Parametros de salida**

Los parametros OUTPUT devuelven valores al usuario

CREATE OR ALTER PROC spu_cliente_obtener
 @id NCHAR(10),
 @name NVARCHAR(40) OUTPUT
AS
BEGIN
    IF LEN(@id) > 5
    BEGIN
     IF EXISTS (SELECT 1 FROM CUSTOMERS WHERE CustomerID = @id)
     BEGIN
        SELECT @name = CompanyName
        FROM Customers
        WHERE CustomerID = @id;
        RETURN;
     END
     PRINT 'El Customer no existe';
     RETURN;
    END
     PRINT 'El ID debe ser de tamaño 5';
END;
GO

DECLARE @name NVARCHAR(40)
EXEC spu_cliente_obtener 'ANTON', @name OUTPUT
SELECT @name AS [Nombre del cliente];
GO


***case**
SIRVE PARA EVAluar condiciones como un swich multiple

  select 
  nombre, 
  precio,
  case
 when precio >= 200 then 'Caro'
 when precio >= 100 then 'Medio'
 else 'Barato'
 end as [Categoria]
  from bdstore.dbo.Productos

  go
  --- selecciona los clientes, con su nombre pais , ciudad y region (los valores nulos 
  --   visualizalos con la leyenda sin region y quiero que todod este en mayusculas )
  use NORTHWND
  go


  Create or ALTER VIEW vw_buena
  as
  select 
  upper(c.CompanyName) as [CompanyName],
  upper(c.Country) as [Country],
  upper(c.City) as [City],
  upper(isnull (c.Region, 'Sin region')) as [RegionLimpia],
  LTRIM(upper(CONCAT (e.FirstName, '  ', e.LastName))) as [FullName],
  ROUND(SUM (od.Quantity * od.UnitPrice), 2) as [Total],
  case 
  when SUM (od.Quantity * od.UnitPrice) >= 30000 and SUM(od.Quantity * od.UnitPrice) <= 60000 then 'gold'
  when SUM (od.Quantity * od.UnitPrice) >= 10000 and SUM(od.Quantity * od.UnitPrice) <= 30000 then 'silver'
  else 'Bronce'
  end as [Medallon]
  from NORTHWND.dbo.Customers as c
  inner join 
  NORTHWND.dbo.Orders as o
  on c.CustomerID = o.CustomerID
  inner join [order Details] as od
  on o.OrderID = od.OrderID
  INNER JOIN Employees as e
  on e.EmployeeID = o.EmployeeID
   
  Group by c.CompanyName,c.Country,c.City , c.Region,CONCAT (e.FirstName, '  ', e.LastName)
  
  go




  select 
  upper(c.CompanyName) as [CompanyName],
  upper(c.Country) as [Country],
  upper(c.City) as [City],
  upper(isnull (c.Region, 'Sin region')) as [RegionLimpia],
  LTRIM(upper(CONCAT (e.FirstName, '  ', e.LastName))) as [FullName],
  ROUND(SUM (od.Quantity * od.UnitPrice), 2) as [Total],
  case 
  when SUM (od.Quantity * od.UnitPrice) >= 30000 and SUM(od.Quantity * od.UnitPrice) <= 60000 then 'gold'
  when SUM (od.Quantity * od.UnitPrice) >= 10000 and SUM(od.Quantity * od.UnitPrice) <= 30000 then 'silver'
  else 'Bronce'
  end as [Medallon]
  from NORTHWND.dbo.Customers as c
  inner join 
  NORTHWND.dbo.Orders as o
  on c.CustomerID = o.CustomerID
  inner join [order Details] as od
  on o.OrderID = od.OrderID
  INNER JOIN Employees as e
  on e.EmployeeID = o.EmployeeID
    where UPPER(CONCAT(e.FirstName, '  ', e.LastName)) = UPPER('ANDREW  FULLER')
  and upper(isnull (c.Region, 'Sin region')) = UPPER('Sin region')
  Group by c.CompanyName,c.Country,c.City , c.Region,CONCAT (e.FirstName, '  ', e.LastName)

  order by [Total] desc



  CREATE OR ALTER PROC spu_informe_Clientes_empleados
  @nombre varchar(50),
  @region varchar(50)
  as 
  begin 
    select *
    from vw_buena
    where FullName = @nombre
    and RegionLimpia = @region
    end;

    exec spu_informe_Clientes_empleados 'ANDREW  FULLER', 'sin region';

 ***Try ...cash***

  ***Manejo de errores o excepciones en tiempo de ejecucion y manejar lo que sucede cuando ocurren***


sintaxis 
'''sql 
BEGIN TRY

--- CODIGO QUE PUEDE GENERAR UN ERROR 
END TRY
BEGIN CATCH
-- CODIGO QUE SE EJECUTA SI OCURRE UN ERROR
END CATCH
---


COMO FUNCIONA 

1. SQL ejecuta todo lo que dentro del try
2. sSI OCURRE UN ERROR :
- SE DETIENE LA EJECUCION DE TRY
-SALTA AUTOMATICAMENTE AL CATCH

3. EN EL CATCH SE PUDE:
-MOSTRAR MENSAJES
-REVERTIR TRANSACCIONES 
-REGITRAR ERRORES 



| FUNCION | Descripcion  |
| :--- | :--- |
| ERROR_MESSAGE() | MESAJE DE ERROR |
| ERROR_NUMBER() | Numero de Error |
| ERROR_LINE() | Linea donde ocurrio|
| ERROR_PROCEDURE() | Procedimiento |
| ERROR_SEVERITY() | Nivel de gravedad |
| ERROR_STATE() | Estado del error|
|





obtener infomacion del error


EJEMPLO DE USO DE FUNCIONES PARA OBTENER INFORMCION DE UN ERROR