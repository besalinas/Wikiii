CREATE DATABASE GranjaHidroponica;
GO
USE GranjaHidroponica;
GO

CREATE TABLE Cultivo (
    id_cultivo INT PRIMARY KEY IDENTITY(1,1),
    tipo_planta NVARCHAR(50) NOT NULL,
    fecha_siembra DATE,
    estado_crecimiento NVARCHAR(50),
    rendimiento_esperado DECIMAL(10, 2)
);

CREATE TABLE Insumo (
    id_insumo INT PRIMARY KEY IDENTITY(1,1),
    tipo_insumo NVARCHAR(50) NOT NULL,
    cantidad_disponible DECIMAL(10, 2),
    fecha_caducidad DATE
);

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100),
    correo NVARCHAR(100),
    telefono NVARCHAR(15)
);

CREATE TABLE Venta (
    id_venta INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT,
    fecha_venta DATETIME,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Detalle_Venta (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    venta_id INT,
    cultivo_id INT,
    cantidad DECIMAL(10, 2),
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (venta_id) REFERENCES Venta(id_venta),
    FOREIGN KEY (cultivo_id) REFERENCES Cultivo(id_cultivo)
);

SELECT * FROM Cultivo;
SELECT * FROM Insumo;
SELECT * FROM Cliente;
SELECT * FROM Venta;
SELECT * FROM Detalle_Venta;

SELECT 
    C.tipo_planta AS TipoDePlanta,
    SUM(DV.cantidad) AS TotalVendido,
    SUM(DV.subtotal) AS Ingresos
FROM 
    Venta V
JOIN 
    Detalle_Venta DV ON V.id_venta = DV.venta_id
JOIN 
    Cultivo C ON DV.cultivo_id = C.id_cultivo
WHERE 
    V.fecha_venta BETWEEN '2024-01-01' AND '2024-12-31'  -- Cambia estas fechas seg�n el rango que necesites
GROUP BY 
    C.tipo_planta;