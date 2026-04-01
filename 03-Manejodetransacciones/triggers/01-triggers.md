# Triggers en sql Server 


## 1. Que es un triggers?

Un trigger (Disparador en español) es un bloque de codigo sql que se ejecuta automaticamente cuando ocurre un evento en una tabla. 

Eventos principales 
-INSERT
--DELETE
---UPDATE

NOTA: No se ejectan manualmente, se activan solos 

 ## Para que sirven ##

 -VALIDACIONES
 -AUDOTORIA (GUARDAR HISTORIAL)
 -REGLAS DE NEGOCIOS
 -AUTOMATIZACION 

  ## Tipo de triggers en sql server ##

  - ALFTER TRIGGER
  se ejecuta despues del evento

  -INTEAD OF TRIGGER

  REMPLAZA LA OPERACION ORIGINAL

   ## 4 sintaxis ##

   CREATE OR ALTER TRIGGER nombre_trigger
   on nombre _tabla
   after insert 
   as 
   begin
   end;


    ## 5. tablas especiales ##

| Título Columna A | Título Columna B |
| :--- | :--- |
| Dato 1 | Información relacionada |
| Dato 2 | Información relacionada |