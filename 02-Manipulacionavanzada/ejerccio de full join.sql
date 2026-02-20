SELECT *
FROM Products AS p
FULL JOIN Categories AS c
  ON c.CategoryID = p.CategoryID;



  -- crear una tabla a partir de una consulta 

  Select 
  TOP 0
  CategoryID,
  CategoryName 
  INTO categoria
  from Categories

  select *
  from categoria
  
  alter table categoria 
  add constraint pk_categoria
  Primary key (CategoryId);



  INSERT INTO categoria
  values
  ('C1'),
  ('C2'),
  ('C3'),
  ('C4'),
  ('C5');

  select 
  top 0
  ProductID as [numero_producto],
  ProductName as [nombre_producto],
  CategoryID as [Catego_id]
  into Produ
  FROM Products;



  select *
  from categoria;


  alter table produ
  add constraint pk_produ
  primary key (numero_producto);

  alter table produ
  add constraint fk_producto_categoria
  FOREIGN KEY (catego_id)
  REFERENCES categoria (CategoryID)
  ON DELETE CASCADE;

  
  INSERT INTO Produ
  values
  ('P1', 1),
  ('P2' , 1),
  ('P3', 2),
  ('P4', 2),
  ('P5', 3),
  ('P6', null);

  select *
  from Produ

    select *
  from categoria

  drop table categoria


    Select 
  TOP 0
  CategoryID,
  CategoryName 
  INTO categoria
  from Categories


  select *
  from Products

  --crear la tabla products new apartior de products mediante una consulta 
  select 
  top 0 
  ProductID as [product_number],
  ProductName as [product_name],
  UnitPrice as [unit_price], UnitsInStock as [stok],
  (UnitPrice * UnitsInStock) as [total]
  INTO products_new 
  from Products

  select *  from products_new

  select 
  p.ProductID, 
  p.ProductName, 
  p.UnitPrice, 
  p.UnitsInStock,
  (p.UnitPrice * p.UnitsInStock) as [total],pw.*
  from Products as p
  left join products_new as pw
  on p.ProductID = pw.product_name;

  

  ALTER TABLE products_new
  add constraint pk_products_new
  primary key ([product_number]);



    select 
  p.ProductID, 
  p.ProductName, 
  p.UnitPrice, 
  p.UnitsInStock,
  (p.UnitPrice * p.UnitsInStock) as [total]
  from Products as p
  left join products_new as pw
  on p.ProductID = pw.product_name
  where product_number is null;



  --crear la tabla products new apartior de products mediante una consulta 
  select 
  top 0 
  ProductID as [product_number],
  ProductName as [product_name],
  UnitPrice as [unit_price], UnitsInStock as [stok],
  (UnitPrice * UnitsInStock) as [total]
  INTO products_new 
  from Products

  select *  from products_new

  select 
  p.ProductID, 
  p.ProductName, 
  p.UnitPrice, 
  p.UnitsInStock,
  (p.UnitPrice * p.UnitsInStock) as [total],pw.*
  from Products as p
  left join products_new as pw
  on p.ProductID = pw.product_name;

  

  ALTER TABLE products_new
  add constraint pk_products_new
  primary key ([product_number]);


  insert into products_new
    select 
  p.ProductName, 
  p.UnitPrice, 
  p.UnitsInStock,
  (p.UnitPrice * p.UnitsInStock) as [total]
  from Products as p
  left join products_new as pw
  on p.ProductID = pw.product_name
  where product_number is null;




  insert into products_new
    select 
  p.ProductName, 
  p.UnitPrice, 
  p.UnitsInStock,
  (p.UnitPrice * p.UnitsInStock) as [total]
  from Products as p
  left join products_new as pw
  on p.ProductID = pw.product_name
  where  product_number is null;

  select *
  from products_new



  insert into 

