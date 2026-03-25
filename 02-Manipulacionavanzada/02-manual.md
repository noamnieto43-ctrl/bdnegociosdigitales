# 📘 Manual de Consultas SQL (LDD y LMD)
**Autor:** Noam Jesús
**Proyecto:** Documentación de Ejercicios de Base de Datos

Este manual documenta la lógica y los comandos utilizados en las prácticas de SQL Server, cubriendo desde la creación de tablas hasta consultas de agregación y unión de datos.

---

## 1. Lenguaje de Definición de Datos (LDD / DDL)
Se define la estructura de las bases de datos `tienda` y `dborders`.

### A. Creación de Estructuras
* **`CREATE DATABASE`**: Inicializa el contenedor de datos (ej. `CREATE DATABASE tienda;`).
* **`PRIMARY KEY`**: Define el identificador único para evitar duplicados, como `cliente_id`.
* **`IDENTITY(1,1)`**: Genera IDs automáticos que incrementan de uno en uno, aplicado en `clientes_2`.
* **`NOT NULL`**: Asegura que campos críticos como `nombre` o `sexo` no queden vacíos.

### B. Restricciones e Integridad (Constraints)
* **`CHECK`**: Valida que los datos cumplan condiciones específicas (ej. `credit_limit` entre 0 y 50,000).
* **`DEFAULT`**: Asigna valores automáticos, como la fecha del sistema con `GETDATE()`.
* **`UNIQUE`**: Garantiza que no existan nombres duplicados en la tabla de proveedores o productos.



---

## 2. Lenguaje de Manipulación de Datos (LMD / DML)
Gestión y consulta de la información almacenada en las tablas.

### A. Inserción de Datos (`INSERT INTO`)
Se realizaron diversas pruebas de inserción:
* **Inserción Total**: Se agregaron registros completos como el de 'Goku'.
* **Inserción Parcial**: Especificando solo columnas necesarias (ej. `nombre`, `edad`) para que el resto use valores por defecto.

### B. Proyección y Alias
* **`SELECT *`**: Selecciona todas las columnas de una tabla.
* **Alias (`AS`)**: Renombrado de columnas para mejorar la legibilidad (ej. `UnitPrice AS [PRECIO UNITARIO]`).

### C. Campos Calculados
Operaciones matemáticas realizadas sobre la marcha:
* **Costo de Inventario**: `(UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]`.
* **Importe con Descuento**: `(UnitPrice * Quantity) * (1 - Discount)`.

---

## 3. Filtrado y Operadores de Búsqueda
Uso de la cláusula `WHERE` para segmentar datos según criterios específicos.

* **Relacionales**: Filtros de comparación como `UnitPrice > 30`.
* **Lógicos**: Combinación de condiciones con `AND` y `OR` (ej. países 'USA' o 'Canada').
* **Rangos y Listas**:
    * **`BETWEEN`**: Filtra valores dentro de un rango inclusivo (ej. precios entre 20 y 40).
    * **`IN`**: Coincidencia con una lista de valores (ej. categorías 1, 3 o 5).
* **Búsqueda de Patrones (`LIKE`)**:
    * `'an%'`: Nombres que inician con "an".
    * `'[bsp]%'`: Inicia con B, S o P.
    * `'[^a-f]%'`: No inicia con letras entre la A y la F.

---

## 4. Agregación y Agrupamiento
Resumen de datos mediante funciones estadísticas y segmentación.

### A. Funciones de Agregado
* **`COUNT(*)`**: Cuenta el total de registros o registros no nulos.
* **`SUM()`**: Suma total de valores numéricos (fletes, ventas).
* **`AVG()`**: Promedio de precios, redondeado con `ROUND()`.
* **`MAX()` / `MIN()`**: Halla valores extremos (fecha más reciente o precio más bajo).

### B. Lógica de Grupos (`GROUP BY` & `HAVING`)
* **`GROUP BY`**: Agrupa filas que comparten valores en columnas específicas (ej. productos por categoría).
* **`HAVING`**: Filtro exclusivo para grupos, aplicado después de la agregación (ej. clientes con más de 10 pedidos).



---

## 5. Relaciones entre Tablas (`JOINS`)
Cruce de información entre entidades mediante llaves foráneas.

* **`INNER JOIN`**: Devuelve registros que tienen coincidencia en ambas tablas (ej. `Categories` y `Products`).
* **Integridad Referencial**:
    * **`ON DELETE SET NULL`**: Al eliminar un proveedor, sus productos vinculados pasan a tener `NULL` en el ID de proveedor.
    * **`ON UPDATE NO ACTION`**: Impide la actualización si existen registros dependientes.

---

## 6. Funciones de Fecha y Sistema
* **`GETDATE()`**: Obtiene la fecha y hora actual.
* **`DATEPART`**: Extrae partes específicas de una fecha como el año, mes o trimestre (`QUARTER`).
* **`CONCAT()`**: Une cadenas de texto, como el nombre y apellido de un empleado.



1. Llaves Primarias (Primary Keys - PK)
Es el identificador único de cada fila. No puede haber dos iguales y no puede ser nula (NULL). Piensa en ella como el CURP o el DNI de un registro.

Cómo identificarla: Generalmente es un ID numérico. En un diagrama, suele tener un icono de llave dorada.

Identity: Se usa para que SQL Server asigne el número automáticamente (autoincrementable).

SQL
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1), -- Empieza en 1 y aumenta de 1 en 1
    Nombre VARCHAR(50)
);
2. Llaves Foráneas (Foreign Keys - FK)
Es una columna que crea una relación entre dos tablas. Básicamente, apunta a la Primary Key de otra tabla para asegurar que los datos estén conectados correctamente (Integridad Referencial).

Regla de oro: No puedes insertar un valor en la FK si ese valor no existe primero en la tabla principal (PK).

SQL
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    UsuarioID INT FOREIGN KEY REFERENCES Usuarios(UsuarioID) -- Relaciona con la tabla Usuarios
);
3. Consultas y Operadores (Sintaxis)
Aquí tienes el "acordeón" de sintaxis que me pediste:

WHERE, LIKE y BETWEEN
Sirven para filtrar filas.

WHERE: Filtro estándar.

LIKE: Busca patrones (usando % como comodín).

BETWEEN: Filtra dentro de un rango (incluye los límites).

SQL
SELECT * FROM Productos 
WHERE Precio BETWEEN 10 AND 50           -- Precios de 10 a 50
AND Nombre LIKE 'Camisa%';               -- Que empiecen con "Camisa"



Funciones de Agregado y COUNT
Operaciones matemáticas sobre un grupo de datos.

COUNT: Cuenta registros.

SUM, AVG, MAX, MIN: Suma, Promedio, Máximo y Mínimo.

SQL
SELECT COUNT(*) AS TotalProductos, SUM(Precio) AS ValorInventario 
FROM Productos;
GROUP BY y HAVING
GROUP BY: Agrupa filas que tienen los mismos valores.

HAVING: Es como el WHERE, pero solo para filtrar grupos (se usa después del Group By).

SQL
SELECT Categoria, COUNT(*) 
FROM Productos
GROUP BY Categoria
HAVING COUNT(*) > 5; -- Solo muestra categorías con más de 5 productos
ORDER BY
Ordena los resultados de forma ascendente (ASC) o descendente (DESC).

SQL
SELECT * FROM Usuarios 
ORDER BY Nombre ASC; 
UNIQUE
A diferencia de la PK, puedes tener varias columnas UNIQUE. Asegura que no haya datos duplicados (como un correo electrónico), pero sí permite un valor nulo.

SQL
CREATE TABLE Empleados (
    ID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);
Resumen de estructura en una sola consulta
Si quisieras usar casi todo junto, se vería así:

SQL
SELECT Categoria, COUNT(ID) AS Total
FROM Productos
WHERE Estado = 'Activo'          -- 1. Filtra filas
GROUP BY Categoria               -- 2. Agrupa
HAVING COUNT(ID) > 1             -- 3. Filtra grupos
ORDER BY Total DESC;             -- 4. Ordena



![Mi captura](/img/xjd.png)