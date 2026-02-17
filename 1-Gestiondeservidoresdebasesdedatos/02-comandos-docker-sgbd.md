# Documentacion de comoandos de contenedores docker para SGBD

## Contenedor sin volumen 

```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssword" \
   -p 1435:1433 --name servidorsqlserver \
   -d \
   mcr.microsoft.com/mssql/server:2019-latest
   ```

## Comando para contenedor de sql sever con volumen 
/var/opt/mssql/data

```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssword" \
   -p 1435:1433 --name servidorsqlserver \
   -v volume-mssql:/var/opt/mssql \
      -d \
   mcr.microsoft.com/mssql/server:2019-latest
   ```





   CREATE DATABASE bdevnd;
GO

USE bdevnd;
GO 

CREATE TABLE tbl1(
id int not null identity(1,1),
nombre NVARCHAR(20) not null,
CONSTRAINT pk_tbl1
PRIMARY KEY (id)

);
GO

INSERT INTO tbl1
VALUES ('Docker'),
        ('Git'),
        ('Github'),
        ('Postgres');
        GO

        SELECT * 
        FROM tbl1;

          SELECT * 
        FROM tbl1;

