
-- Proyecto: Azure SQL Database Security
-- Script 01: Creación de tablas
-- Base de datos: sqldb-security-dev

CREATE TABLE dbo.Departamentos (
    DepartamentoID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Empleados (
    EmpleadoID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    DepartamentoID INT NOT NULL,
    Salario DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (DepartamentoID)
        REFERENCES dbo.Departamentos(DepartamentoID)
);

CREATE TABLE dbo.RegistroAccesos (
    AccesoID INT PRIMARY KEY,
    EmpleadoID INT NOT NULL,
    Fecha DATETIME2 NOT NULL,
    Accion NVARCHAR(100) NOT NULL,

    FOREIGN KEY (EmpleadoID)
        REFERENCES dbo.Empleados(EmpleadoID)
);
