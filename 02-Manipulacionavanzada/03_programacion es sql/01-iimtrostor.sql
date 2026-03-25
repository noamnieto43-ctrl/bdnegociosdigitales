Stored procedures, (procedimientos almacenados) en transac (sql server)---


1. Fundamentos 

que es un stored procedure

Un **stored procedure (SP)**  es un bloque de codigo sql guardado dentro de la base de datos que puede ejecutarce cunado se necesite. es decir es un objeto de la base de datos (es algo similar a una funcion o metodo en programacion)


1. resutilizar el codigo 
2. mejor rendimiento 
3. mayor seguridad 
4. centralizacion de logica de negocios
5. menos trafico entre aplicaciones y servidores

**Sintaxix**
![SintaxisSQL](/img/sp_sintaxis.png)


-- Instrucciones sql

end;

***Nomenclatura Recomendada ***

spu_<Entidad>_<Accion>



create database bdstore
use bdstore

CREATE PROCEDURE usp_Mensaje_Saludar


as 

BEGIN 
   PRINT 'Hola mundo transac';
 end;
 go

 --Ejecutar store--

 EXECUTE usp_Mensaje_Saludar;

 --los store no se pueden llamar igual este tiene un 2 y abreviciones 

 CREATE PROC usp_Mensaje_Saludar2
as 

BEGIN 
   PRINT 'Hola mundo transac';
 end;
 go
  EXEC usp_Mensaje_Saludar2;

  -----------------------------

   CREATE or alter PROC usp_Mensaje_Saludar3
as 

BEGIN 
   PRINT 'Hola mundo Entornos virtuales y redes digitales';
 end;
 go

  EXEC usp_Mensaje_Saludar3;

  --- eliminar un sp

  drop procedure usp_Mensaje_Saludar3;
  -------------------------------

 CREATE or alter PROC usp_Servidor_Fechactual
as 

BEGIN 
SELECT cast(getdate()as date) as [ Fecha del sistema ]
  
 end;
 go

  EXEC usp_Servidor_Fechactual;

  --Crear un sp que muestre el nombre de la base de datso usando (DB_NAME())

  CREATE or alter PROC usp_Basedatos_Nombre
as 

BEGIN 
select
host_name() as [Machine],
SUSER_SNAME () as [Sqluser],
SYSTEM_USER as [Systemuser],
DB_NAME() as [ Nombre de la base de datos],
app_name() as [Aplicatoin];
  
 end;
 go
 ------
  EXEC usp_Basedatos_Nombre;


  ----------------------
  CREATE or alter PROC usp_persona_saludar
  @nombre varchar(50)                               --parametro de entreda
  as 

BEGIN 
print 'hola' + @nombre;
end;
go
 EXEC usp_persona_saludar 'Isrrael';
  EXEC usp_persona_saludar 'Artemio';
   EXEC usp_persona_saludar 'Irais';
    EXEC usp_persona_saludar @nombre = 'Brayan';

    Declare @name varchar(50);
    set @name = 'Yael';

    EXEC usp_persona_saludar @name 



    select CustomerID,  CompanyName
    into Customers
    from NORTHWND.dbo.Customers;
    
    select *
    from Customers;
    
    ---crear un sp que busque un cliente en espesifico
    create or alter proc spu_Customer_buscar
    @id nchar(10)
    as 
    begin 
    set @id = trim(@id);
      
        if not len(@id)<=0 and len(@id)>5
    begin 
         print ('el rango debe de estar de 1 a 5 de tamaño')
           return;
           end

           if NOT EXISTS(select 1 from Customers where CustomerID = @id)
           begin
           print 'El cliente no existe en la bese de datos';
           return;
           end

    select CustomerID as [Numero], CompanyName as [Cliente]
    from Customers
    where CustomerID = @id;
    end;
    go
    
    select *
    from Customers
    where CustomerID = '';


    GO
    execute spu_Customer_buscar 'A nton';
    GO

    select *
    from NORTHWND.dbo.Categories
    where not exists(
    select 1
    from Customers
    where CustomerID = 'Antoni');
    GO
   
   ------------todo: Parametros de salidad crear un sp 
   --que resiva un numero y que verifique que no sea negativo si es negativo 
   --imprimir valor no valido y si no multiplicarlo por 5 y mostrarlo , para mostrar usar un select

   ---crear un sp


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
   GO
   execute usp_numero_multiplicar -34;
   go



   CREATE OR ALTER PROC usp_nombre_mayusculas
   @name varchar(15)
   as
   begin 
    select upper(@name) as [name]
    end;
    GO

    execute usp_nombre_mayusculas 'Monico'
    GO

    CREATE OR ALTER PROC usp_numeros_sumar2
    @a int, 
    @b int,
    @Resultado int OUTPUT
    AS
    BEGIN
    SET @Resultado = @a + @b
    END;
    go

    declare @Res int
    execute usp_numeros_sumar2 5,7,@Res output;
    SELECT @Res as [Resultado]
    go
    ---crear un sp 

    CREATE OR ALTER PROC usp_area_circulo
    @radio decimal (10,2),
    @area decimal (10,2)OUTPUT
    as 
    begin

          --set @area = pi() * @radio * @radio
         set @area = pi() * POWER (@radio,2);
    end;
    go

    declare @r Decimal (10,2)
    execute usp_area_circulo 2.4,@r output;
    select @r as [Area del circulo];
    go



    --- crear un sp que resiva un id del cliente y debuelva el nombre 
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


CREATE OR ALTER PROC spu_Evaluar_Calificacion
@cali int
as 
begin
 select 
  case 
  when @cali >= 90 then 'exelente'
  when @cali >= 70 then 'Aprobado'
  when @cali >= 60 then 'Regular'
  else 'no acredito'
  end as [resultado];
  end;

  exec spu_Evaluar_Calificacion 100;

  use bdstore
  go
  --- CAS dentro de un select caso real
  use NORTHWND

  SELECT * FROM NORTHWND.dbo.Products;

  CREATE TABLE bdstore.dbo.Productos
  (
  nombre Varchar(50),
  precio money
  
  );

  --- insetar los datos basados en la consulta (Select)

  INSERT INTO bdstore.dbo.Productos
  select 
  ProductName,
  UnitPrice
  from NORTHWND.dbo.Products

  --- ejercicio con case

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



    ---- Try ...cash

    ------------ Manejo de errores o excepciones en tiempo de ejecucion y manejar lo que sucede cuando ocurren 



    /*=========================================Manejo de errores con try ... catch======================================================*/

    select 10/0;

   ---con try -- catch
   
   begin try
   select 10/0;
   end try
   begin catch
   print 'Ocurrio un error'
   end catch;
   GO


   BEGIN TRY 
   SELECT 10/0;
   END TRY
   
   BEGIN CATCH
   Print 'Mensajes:' + ERROR_MESSAGE();
   Print 'Numero de Error:' + CAST(ERROR_NUMBER() as Varchar);
   PRINT 'Linea del error:' + CAST(ERROR_LINE() as varchar);
   print 'Procedimiento:' + ERROR_PROCEDURE()
   print 'Estado del error:' + cast(ERROR_STATE() AS VARCHAR);
   END CATCH;




   select * 
   from clientes

   use bdstore

   create table clientes(
   id INT PRIMARY KEY,
   nombre VARCHAR(35)
   );
   INSERT INTO CLIENTES
   VALUES(1,'raquel');

   begin try

     INSERT INTO clientes
   VALUES(1,'raquel');

   end try
   begin catch
   print 'error al insertar' + ERROR_MESSAGE();
   PRINT 'ERROR EN LA LINEA:' + CAST(ERROR_LINE() AS VARCHAR );
   end catch;


   begin transaction;
      INSERT INTO CLIENTES
   VALUES(2,'goku');
   select * from clientes
   commit;
   rollback;