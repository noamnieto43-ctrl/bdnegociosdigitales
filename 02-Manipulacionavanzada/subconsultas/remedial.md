D1) Empleados y su jefe (Self-Join)
El truco aquí es usar la misma tabla dos veces con diferentes nombres (alias).

SELECT E.Nombre AS Empleado, J.Nombre AS Jefe, E.Puesto, E.Fecha_Contrato
FROM Representantes AS E
LEFT JOIN Representantes AS J ON E.Jefe = J.Num_Empl
ORDER BY E.Nombre ASC;

-------------------------------------------

D2) Representantes por puesto y ubicación (Join con Oficinas)
Filtramos puestos específicos y aseguramos que tengan oficina.

SELECT R.Nombre, R.Puesto, O.Ciudad, O.Region, R.Cuota, R.Ventas
FROM Representantes AS R
INNER JOIN Oficinas AS O ON R.Oficina_Rep = O.Oficina
WHERE R.Puesto IN ('Representante', 'Jefe Ventas', 'VP Ventas')
ORDER BY O.Region, O.Ciudad, R.Nombre;
----------------------------------------

D3) Clientes con variedad de productos (COUNT DISTINCT)

Aquí usamos la combinación Fab + Producto para contar cosas distintas.
SELECT C.Num_Cli, C.Empresa, COUNT(DISTINCT P.Fab + P.Producto) AS ProductosDistintos
FROM Clientes AS C
INNER JOIN Pedidos AS P ON C.Num_Cli = P.Cliente
GROUP BY C.Num_Cli, C.Empresa
HAVING COUNT(DISTINCT P.Fab + P.Producto) >= 2
ORDER BY ProductosDistintos DESC, C.Empresa ASC;
--------------------------
D4) Productos tipo 'brazo' en rango de precio (WHERE + LIKE)
Consulta simple de filtro de texto y rango numérico.

SELECT Id_fab, Id_producto, Descripcion, Precio, Stock
FROM Productos
WHERE Descripcion LIKE '%brazo%' 
  AND Precio BETWEEN 400 AND 2000
ORDER BY Precio DESC;
------------------------------------

D8) Vista: pedidos por ciudad (Vistas + Agrupación)
Este es un Join triple: Oficinas -> Representantes -> Pedidos.

CREATE VIEW vw_PedidosPorCiudad_D AS
SELECT O.Ciudad, O.Region, 
       COUNT(P.Num_Pedido) AS NumPedidos, 
       SUM(P.Importe) AS TotalImporte
FROM Oficinas AS O
INNER JOIN Representantes AS R ON O.Oficina = R.Oficina_Rep
INNER JOIN Pedidos AS P ON R.Num_Empl = P.Rep
GROUP BY O.Ciudad, O.Region
HAVING COUNT(P.Num_Pedido) >= 2;

### 🔑 Mapeo de Relaciones (Primary Key vs Foreign Key)

| Tabla Origen (PK) | Columna PK | Tabla Destino (FK) | Columna FK | Relación / Propósito |
| :--- | :--- | :--- | :--- | :--- |
| **Oficinas** | `Oficina` | **Representantes** | `Oficina_Rep` | Ubicación física del vendedor |
| **Representantes** | `Num_Empl` | **Clientes** | `Rep_Cli` | Vendedor asignado al cliente |
| **Representantes** | `Num_Empl` | **Pedidos** | `Rep` | Vendedor que realizó la venta |
| **Representantes** | `Num_Empl` | **Representantes** | `Jefe` | **Self-Join**: Jerarquía de mando |
| **Clientes** | `Num_Cli` | **Pedidos** | `Cliente` | Dueño del pedido |
| **Productos** | `Id_fab` | **Pedidos** | `Fab` | **Parte 1** de la llave compuesta |
| **Productos** | `Id_producto` | **Pedidos** | `Producto` | **Parte 2** de la llave compuesta |

---

### ⚠️ Notas Críticas para Consultas SQL

1. **Llave Compuesta (Productos ↔ Pedidos):** Siempre deben ir ambas en el `ON`:
   `ON Productos.Id_fab = Pedidos.Fab AND Productos.Id_producto = Pedidos.Producto`

2. **Diferencia de Nombres:**
   * El número de empleado es `Num_Empl` en su tabla, pero `Rep` en Pedidos y `Rep_Cli` en Clientes.
   * La oficina es `Oficina` en su tabla, pero `Oficina_Rep` en Representantes.

3. **Auto-Referencia (Jefes):**
   Para saber el nombre del jefe de un empleado:
   `FROM Representantes E JOIN Representantes J ON E.Jefe = J.Num_Empl`