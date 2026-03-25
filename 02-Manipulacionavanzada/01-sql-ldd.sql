--crea una base--
CREATE DATABASE tienda;
GO
USE tienda;

--create tabla--
CREATE TABLE cliente (
id int not null, 
nombre nvarchar(30) not null,
apaterno nvarchar (10) not null,
amaterno nvarchar (10) null,
sexo nchar(1) not null,
edad int not null,
direccion nvarchar(20) not null,
rfc nvarchar(20) not null, 
limitecredito money not null default 500.0

);
GO


--restricciones--

CREATE TABLE clientes (
cliente_id INT NOT NULL PRIMARY KEY,
nombre nvarchar(30) not null, 
apellido_paterno nvarchar(20) NOT NULL, 
apellido_materno nvarchar(20),
edad int NOT NULL, 
fecha_nacimiento DATE NOT NULL,
limite_credito MONEY NOT NULL,
);

GO 

INSERT INTO clientes 
values (1, 'Goku', 'LINTERNA','SUPERMAN', 450, '1575-01-17', 100); 

INSERT INTO clientes 
values (2, 'Goku', 'LINTERNA','SUPERMAN', 450, '1575-01-17', 100); 

INSERT INTO clientes (nombre, cliente_id, limite_credito, fecha_nacimiento,apellido_paterno, edad )
values ('Arcadia', 3, 4500, '2000-01-22', 'Ramirez',20 ); 

SELECT GETDATE();

select *
From clientes 


INSERT INTO clientes 
values 
(4, 'Vanesa', 'LINTERNA','SUPERMAN', 42, '1583-01-17', 78955);


INSERT INTO clientes
values 
(5, 'Sonia', 'La cruz','del corral', 450, '1575-01-17', 100), 
(6, 'Laila', 'San luis','gante', 450, '1575-01-17', 100),
(7, 'Beto', 'Villa','SUPERMAN', 450, '1575-01-17', 100),
(8, 'Pedro', 'paris','SUPERMAN', 450, '1575-01-17', 100); 

Select cliente_id, nombre, edad, limite_credito
From clientes
select getdate()-- fecha del sistema--


--Tabla restricciones--

create table clientes_2(

cliente_id INT NOT NULL identity (1,1),
nombre nvarchar(50) not null, 
edad int NOT NULL, 
fecha_registro DATE default GETDATE(),
limite_credito MONEY NOT NULL,
CONSTRAINT pk_clientes_2
PRIMARY KEY (cliente_id),
);

select * 
FROM clientes_2



INSERT INTO clientes_2 
values ('Slenderman', 78,DEFAULt,4500);


INSERT INTO clientes_2 
values ('Batman', 45,DEFAULt,899500); 

INSERT INTO clientes_2 (nombre,edad,limite_credito)
values ('eltona', 45,899500);


INSERT INTO clientes_2 
values ('robin', 10,'2005-03-19',89.23);


INSERT INTO clientes_2 (limite_credito,edad,nombre,fecha_registro)
values (89.33, 24,'flasreverso','2004-03-21');


CREATE TABLE suppliers (

supplier_id  int not null,
[name] nvarchar(30) not null,
date_register date not null DEFAULT GETDATE(),
tipo char(1) not null, 
credit_limit money not null,
CONSTRAINT pk_suppliers
PRIMARY KEY ( supplier_id ),
CONSTRAINT unique_name 
UNIQUE ([name]),
CONSTRAINT chk_credit_limit
CHECK (credit_limit > 0.0 and credit_limit < 50000),
CHECK (tipo IN ('A','B','C'))
);

insert into suppliers
values ('Noam',DEFAULT,'A', 45000 );

insert into suppliers
values (UPPER('tia rosa'),'2026-01-23',UPPER('a'), 49999.99 );

select * 
FROM suppliers

insert into suppliers ([name], tipo, credit_limit)
values (UPPER('tia mensa'),UPPER('a'), 49999.99 )




--base de datos dbordes--

CREATE DATABASE dborders;
go 

use dborders;
go

CREATE TABLE customers(
customers_id int not null IDENTITY (1,1),
firs_name NVARCHAR (20) not null, 
last_name NVARCHAR (30),
[address] NVARCHAR (80) not null, 
number int,
CONSTRAINT pk_customers
PRIMARY KEY (customers_id)
);

CREATE TABLE products(
customers_id int not null IDENTITY (1,1),
firs_name NVARCHAR (20) not null, 
last_name NVARCHAR (30),
[address] NVARCHAR (80) not null, 
number int,
CONSTRAINT pk_customers
PRIMARY KEY (customers_id)
);





CREATE TABLE products (
   product_id INT NOT NULL IDENTITY (1,1),
   [name] NVARCHAR (40) NOT NULL,
   quantity int NOT NULL,
   unit_price MONEY NOT NULL,
   supplier_id INT ,
   CONSTRAINT pk_products
   PRIMARY KEY (product_id),
   CONSTRAINT unique_name_products
   UNIQUE ([name]),
   CONSTRAINT chk_quantity
   CHECK (quantity between 1 and 100),
   CONSTRAINT chk_unitprice
   CHECK ( unit_price > 0 and unit_price <= 10000),
   CONSTRAINT fk_products_suppliers
   FOREIGN KEY (supplier_id)
   REFERENCES suppliers (supplier_id)
   ON DELETE set null
   ON UPDATE set null 

);
GO


DROP TABLE products;
drop table suppliers



insert into suppliers
values (1,UPPER('chinoo'),'2026-01-23',UPPER('a'), 49999.99 );
insert into suppliers
values (2,UPPER('xd'),'2026-01-27',UPPER('b'), 499 );
insert into suppliers
values (3,UPPER('pp'),'2026-01-24',UPPER('c'), 100 );

INSERT INTO suppliers (supplier_id,[name],tipo,credit_limit)


select * 
FROM suppliers




INSERT INTO products
VALUES('Papas', 10, 5.3, 1);

INSERT INTO products
VALUES('Papas', 10, 5.3, 1);

--para cambiar de null a un valor de 2 
UPDATE products
set supplier_id = 2
where product_id in (6,7);
UPDATE products
set supplier_id = 3
where product_id in (8);
-------------

--comprobacion de un delete no accion

--ELIMINAR HIJOS 
DELETE FROM products
WHERE supplier_id = 1;

--eliminar padre
DELETE FROM suppliers
WHERE supplier_id = 1;


--comprobar el update no accion 
--permite cambiar la estructura de uan tabla 
alter table products
alter column supplier_id int null;
--para ver si ya deja poner nulos 
INSERT INTO products
VALUES('Azulito', 100, 15.3, null);

ALTER TABLE suppliers
DROP CONSTRAINT pk_suppliers;

update suppliers
set supplier_id = 10 
where supplier_id = 2;

ALTER TABLE products
DROP CONSTRAINT fk_products_suppliers;

drop table suppliers



select * 
FROM products;


select * 
FROM suppliers



INSERT INTO products
VALUES('rollos conjunto primavera', 20, 100, 10);




INSERT INTO products
VALUES('chanclas pata de gallo', 50, 20, 10);


INSERT INTO products
VALUES('chanclas buenas', 30, 56.7, 10);


INSERT INTO products
VALUES('ramita chiquita', 78.23, 23, 10);

use dborders;
go



delete from products
where supplier_id = 1;


-- chancas el 2 , y rama se queda igual 



select * 
FROM products;


select * 
FROM suppliers

--camiar a xd de 3 por 10 xd
UPDATE suppliers
set supplier_id = 10
where supplier_id in (2);


UPDATE products
set supplier_id = 20
where supplier_id is null;

update products 
set supplier_id = null 
where supplier_id = 2;

update products 
set supplier_id = 2
where products_id in (3,4);

--- comprobar on delete set null 

delete suppliers 
where supplier_id = 10

-------------------------------------------------------------------------
CREATE TABLE products (
   product_id INT NOT NULL IDENTITY (1,1),
   [name] NVARCHAR (40) NOT NULL,
   quantity int NOT NULL,
   unit_price MONEY NOT NULL,
   supplier_id INT ,
   CONSTRAINT pk_products
   PRIMARY KEY (product_id),
   CONSTRAINT unique_name_products
   UNIQUE ([name]),
   CONSTRAINT chk_quantity
   CHECK (quantity between 1 and 100),
   CONSTRAINT chk_unitprice
   CHECK ( unit_price > 0 and unit_price <= 10000),
   CONSTRAINT fk_products_suppliers
   FOREIGN KEY (supplier_id)
   REFERENCES suppliers (supplier_id)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION 

);
GO

select * 
FROM products;


select * 
FROM suppliers

--- comprobar un delete set null 

UPDATE suppliers
set supplier_id = 20
where supplier_id = 1;