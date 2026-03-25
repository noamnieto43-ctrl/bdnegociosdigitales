Stored procedures, (procedimientos almacenados) en transac (sql server)


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
'''
| Parte   | Significado                     | Ejemplo |
|--------|---------------------------------|--------|
| spu    | Stored Procedure User           | spu_   |
| Entidad| Tabla o concepto del negocio    | Cliente|
| Acción | Lo que hace                     | Insert |

- Acciones Estándar

Estas son las **Acciones más usadas** en sistemas empresariales


| Acción     | Significado          | Ejemplo                |
| ---------- | -------------------- | ---------------------- |
| Insert     | Insertar registro    | spu_Cliente_Insert     |
| Update     | Actualizar           | spu_Cliente_Update     |
| Delete     | Eliminar             | spu_Cliente_Delete     |
| Get        | Obtener uno          | spu_Cliente_Get        |
| List       | Obtener varios       | spu_Cliente_List       |
| Search     | Búsqueda con filtros | spu_Cliente_Search     |
| Exists     | Validar si existe    | spu_Cliente_Exists     |
| Activate   | Activar registro     | spu_Cliente_Activate   |
| Deactivate | Desactivar           | spu_Cliente_Deactivate |


Ejemplo completo 
Suponer que tenemos una tabla cliente 
----------
Insertar cliente 

spu_Cliente_insert
-------------
Actualizar cliente 

spu_Cliente_update
----------
Insertar optener cliente por id 

spu_Cliente_get

----------
Listar todos los clienetes

spu_Cliente_List

----------
Buscar cliente

spu_Cliente_Search


2222222

'''sql
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
  '''
***Parametros en los store procedures***

Los parametros permiten emviar datos alprocedimiento almacenado

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


    ***Ejemplo con consulta***

    --Vamos a crear una tabla de clientes de clientes basada en la tabla de norwin

      ------ crear un store procedure que inserte un cliente, con las validaciones nesesarias

  CREATE OR ALTER PROC usp_insertar_cliente
  @id int,
  @nombre varchar(35)
  as 
  begin 
   begin try 
   begin transaction
  insert into clientes
  values (@id, @nombre);
  commit;
  print 'cliente insertado'
  end try
   
    begin catch
   if @@TRANCOUNT > 1
   begin
   rollback;
   end
   print 'error:' + ERROR_MeSSAGE();
   end catch
  end;













  select * from clientes;

  UPDATE clientes 
  SET nombre = 'AMERICO AZULL' WHERE ID = 1;
  IF @@ROWCOUNT < 1
  BEGIN 
  PRINT @@ROWCOUNT;
  PRINT 'NO EXIXTE EL CLIENTE'
  END
  ELSE
  PRINT 'CLIENTE ACTUALIZADO'

  create table teams 
  (
  id int not null identity primary key,
  nombre nvarchar(15)
  

  
  );
  --FORMA DE OBTENER UN IDENTITY INSERTADO FORMA 1

  insert into teams (nombre)
  values ('Cruz Azul')
  DECLARE @id_insertado int
  set @id_insertado = @@identity
  print 'ID INSERTADO:' + cast(@id_insertado as varchar);
  select @id_insertado = @@IDENTITY
  print 'ID INSERTADO FORMA 2' + cast(@id_insertado as varchar)

  select * from teams
     insert into teams (nombre)
  values ('Agilas')
    --FORMA DE OBTENER UN IDENTITY INSERTADO FORMA 2

  insert into teams (nombre)
  values ('Cruz Azul')
  DECLARE @id_insertado2 int
  set @id_insertado2 = SCOPE_IDENTITY();
  print 'ID INSERTADO:' + cast(@id_insertado2 as varchar);
  select @id_insertado2 = SCOPE_IDENTITY();
  print 'ID INSERTADO FORMA 2' + cast(@id_insertado2 as varchar)
