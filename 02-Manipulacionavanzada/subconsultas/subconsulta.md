# Que es una subconsulta?

Una subconsulta es un select dentro de otro select, puede devolver:

1. Un solo valor (escalar)
1. Una lista de valores (una columna, varias filas)
1. Una tabla (Varias columnas y/o varia filas)
1. Segun lo que devuelva, se elige el operador correcto (*,in,exisis, etc),

una subconsulta es una consulta anidada dentro de otra consulta que permite resolver problemas en varios niveles de informacion 

------

 Dependiendo de donde se coloque y que retorne cambia su comportamiento

------

5 grades formas de usarlas 

1. Subconsultas escolares 
2. Subconsultas en in, any, all 
3. subconsultas corelacionadas 
4. subconsultas en select 
5. subconsultas en from (Tablas derivadas).


1. escalares : devuelve un unico valor por eso se pueden utilzar con oprdarores = , <, >,  relacionales 


2. Subconsultas en in, any, all

devuelve varios valores con una sola columna (in)
