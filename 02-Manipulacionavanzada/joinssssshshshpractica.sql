--Necesitamos un listado de todos los pagos realizados,
--pero queremos ver el nombre del cliente que hizo cada pago.

select v.ClienteId, c.Nombre, p.FechaPago, p.Monto
from Clientes as c
inner join Ventas as v on v.ClienteId = c.ClienteId
inner join Pagos as p on v.VentaId = p.VentaId


SELECT v.ClienteId, c.Nombre, p.FechaPago, p.Monto
FROM Clientes AS c
INNER JOIN Ventas AS v ON v.ClienteId = c.ClienteId
INNER JOIN Pagos AS p ON v.VentaId = p.VentaId;



select * from Ventas

