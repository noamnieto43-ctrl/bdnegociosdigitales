/* ==================================Variables en transac- sql======================================*/

--COMO DECLARAR UNA VARIABLE
-- SIEMPRE CON ARROBA
-- SET PARA QUE SE ASIGNE 

DECLARE @edad INT ;
SET @edad = 21;
PRINT @edad

-- FORMAS DE IMPRIMIR EL RESULTADO

PRINT @edad
SELECT @edad as [EDAD];
