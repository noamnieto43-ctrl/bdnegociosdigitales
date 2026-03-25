/* ==================================Variables en transac- sql======================================*/

--COMO DECLARAR UNA VARIABLE
-- SIEMPRE CON ARROBA
-- SET PARA QUE SE ASIGNE 
-- para que pueda mostrarte o imprimr tienes que seleccionar todo asta la la de imprimir 

DECLARE @edad INT ;
SET @edad = 21;
PRINT @edad
SELECT @edad as [EDAD];

--formas de imprimir
--PRINT @edad  
--SELECT @edad as [EDAD];

DECLARE @nombre AS varchar(30) = 'San Gallardo';
SELECT @nombre AS [Nombre];
SET @nombre = 'San adonai';
SELECT @nombre AS [Nombre]

/* ==================================Ejercicio 1======================================*/
--declarar una variable que llame @precio y que le asigne el valor , carcular el iva a 16% y quiero que muestre el total
DECLARE @precio as money = 150
DECLARE @IVA decimal (10,2)
DECLARE @total money
SET @IVA = @precio * .16
SET @total = @precio + @IVA
SELECT @precio AS [TOTA];

DECLARE @precioo MONEY = 150;
DECLARE @IVAA DECIMAL(10,2);
DECLARE @totall MONEY;
SET @IVAA = @precioo * 0.16;
SET @totall = @precioo + @IVAA
SELECT @precioo AS [PRECIO], CONCAT('$', @IVAA) AS [IVA(16%)], @totall AS [TOTAL]





/* ================================== IF ======================================*/



DECLARE @edadd INT;
SET @edadd = 18;

if @edadd >= 18
PRINT 'Eres mayor de edad';

ELSE

PRINT 'Eres menor de edad';


--se de una calificacion y si es mayor a 7 es mayor aprobado y si no reprobado


DECLARE @calificacion decimal (10,2) = 7.5;

if @calificacion >= 0 and @calificacion<=10

  if @calificacion >= 7.0
print ('Aprovado')

else
print ('Reprobado')
else
select concat(@calificacion, 'esta fuera del rango') as [Respueesta]

--CALIFICACION SI ES MAYOR DE 70 ES APROBADO SI ES MENOR REPROBADO 

DECLARE @CALI DECIMAL ;
SET @CALI = 11

IF @CALI >=0 AND @CALI <=10
   
   if @CALI > 7
		PRINT 'APROBASTE'
   ELSE
		
		PRINT 'REPROBASTE'
ELSE 
	PRINT 'No se acepta el numero '
GO;

/* ================================== IF ======================================*/


---while (ciclos)

declare @limite int = 5;
DECLARE @i int = 1;

While (@i<=@limite)
begin
print concat('Numeros: ' , @i)
set @i = @i + 1
end

