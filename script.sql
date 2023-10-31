CREATE DATABASE viveros;
\c viveros;

CREATE TYPE Num_telf AS (
  init_code VARCHAR(5),
  local_code VARCHAR(10),
  num VARCHAR(10)
);

CREATE TYPE Coordenadas AS (
  latitud VARCHAR(50),
  longitud VARCHAR(50)
);

CREATE TABLE Vivero (
  nombreVivero VARCHAR(15),
  georef Coordenadas UNIQUE NOT NULL,
  PRIMARY KEY(nombreVivero)
);

CREATE TABLE Zona (
  nombreVivero VARCHAR(15),
  nombreZona VARCHAR(15),
  PRIMARY KEY(nombreVivero, nombreZona),
  FOREIGN KEY (nombreVivero) REFERENCES Vivero (nombreVivero) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Empleado(
  dni CHAR(9),
  nombre VARCHAR(15) NOT NULL,
  telefono Num_telf UNIQUE NOT NULL,
  PRIMARY KEY(dni)
);

CREATE TABLE Cliente (
  idCliente bigserial,
  nombre VARCHAR(15) NOT NULL DEFAULT 'anonimo',
  telefono Num_telf,
  email VARCHAR(30),
  PRIMARY KEY(idCliente)
);

CREATE TABLE ClientePlus (
  idCliente bigint,
  volumenCompras integer NOT NULL DEFAULT 0 CHECK (volumenCompras >= 0),
  PRIMARY KEY (idCliente),
  FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Producto (
  idProducto serial,
  nombreP VARCHAR(20) NOT NULL UNIQUE,
  fabricante VARCHAR(20) NOT NULL,
  precio integer NOT NULL CHECK (precio > 0),
  PRIMARY KEY (idProducto)
);

CREATE TABLE Contiene (
  nombreVivero VARCHAR(15),
  nombreZona VARCHAR(15),
  idProducto integer,
  stock integer NOT NULL CHECK (stock >= 0),
  PRIMARY KEY (nombreVivero, nombreZona, idProducto),
  FOREIGN KEY (nombreVivero, nombreZona) REFERENCES Zona (nombreVivero, nombreZona) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idProducto) REFERENCES Producto (idProducto) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Trabaja (
  dni CHAR(9),
  nombreVivero VARCHAR(15),
  nombreZona VARCHAR(15),
  fechaInicio date NOT NULL CHECK (fechaInicio < fechaFinal),
  fechaFinal date NOT NULL,
  PRIMARY KEY (dni, nombreVivero, nombreZona, fechaInicio),
  FOREIGN KEY (nombreVivero, nombreZona) REFERENCES Zona (nombreVivero, nombreZona) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (dni) REFERENCES Empleado (dni) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Venta (
  dni CHAR(9),
  idCliente bigint,
  idProducto integer,
  cantidadP integer NOT NULL CHECK (cantidadP >= 0),
  precioProduc integer,
  precioCompra integer GENERATED ALWAYS AS (cantidadP * precioProduc) STORED,
  fechaCompra timestamp NOT NULL,
  PRIMARY KEY (dni, idCliente, idProducto),
  FOREIGN KEY (dni) REFERENCES Empleado (dni) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (idProducto) REFERENCES Producto (idProducto) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO Vivero (nombreVivero, georef) VALUES (
  'Vivero1',
  (
    '28°28`10.5"N',
    '16°19`18.4"W'
  )
);

INSERT INTO Vivero (nombreVivero, georef) VALUES (
  'Vivero2',
  (
    '28°28`10.5"N',
    '16°19`18.4"W'
  )
);

INSERT INTO Vivero (nombreVivero, georef) VALUES (
  'Vivero3',
  NULL
);

INSERT INTO Vivero (nombreVivero, georef) VALUES (
  'Vivero4',
  (
    '28°28`13.1"N',
    NULL
  )
);

INSERT INTO Vivero (nombreVivero, georef) VALUES (
  'Vivero5',
  (
    '28°28`14.5"N',
    '16°19`21.3"W'
  )
);

INSERT INTO Vivero (nombreVivero, georef) VALUES (
  'Vivero6',
  (
    '28°28`15.9"N',
    '16°19`22.7"W'
  )
);


INSERT INTO Zona (nombreVivero, nombreZona) VALUES ('Vivero1', 'ZonaA1');
INSERT INTO Zona (nombreVivero, nombreZona) VALUES ('Vivero6', 'ZonaA1');
INSERT INTO Zona (nombreVivero, nombreZona) VALUES ('Vivero6', 'ZonaB1');
INSERT INTO Zona (nombreVivero, nombreZona) VALUES ('Vivero5', 'ZonaB2');
INSERT INTO Zona (nombreVivero, nombreZona) VALUES ('Vivero5', 'ZonaC1');
INSERT INTO Zona (nombreVivero, nombreZona) VALUES ('Vivero8', 'ZonaC2');


INSERT INTO Empleado (dni, nombre, telefono) VALUES 
('A12345678', 'Juan', ('+34', '912', '456789'));

INSERT INTO Empleado (dni, nombre, telefono) VALUES 
('B23456789', 'Maria', ('+34', '913', '567890'));

INSERT INTO Empleado (dni, nombre, telefono) VALUES 
('C34567890', 'Carlos', ('+34', '914', '678901'));

INSERT INTO Empleado (dni, nombre, telefono) VALUES 
('D45678901', 'Ana', ('+34', '915', '789012'));

INSERT INTO Empleado (dni, nombre, telefono) VALUES 
('E56789012', NULL, ('+34', '916', '890123'));

INSERT INTO Empleado (dni, nombre, telefono) VALUES 
('F67890123', 'Isabel', ('+34', '915', '789012'));


INSERT INTO Cliente (nombre, telefono, email) VALUES 
('Roberto', ('+34', '918', '112233'), 'roberto@example.com');

INSERT INTO Cliente (nombre, telefono, email) VALUES 
('Elena', ('+34', '919', '223344'), 'elena@example.com');

INSERT INTO Cliente (telefono, email) VALUES 
(('+34', '920', '334455'), 'anonimo1@example.com');

INSERT INTO Cliente (nombre, telefono, email) VALUES 
('Manuel', ('+34', '921', '445566'), 'manuel@example.com');

INSERT INTO Cliente (nombre, telefono) VALUES 
('Teresa', ('+34', '922', '556677'));

INSERT INTO Cliente (nombre, email) VALUES 
('Sofia', 'sofia@example.com');


INSERT INTO Producto (nombreP, fabricante, precio) VALUES 
('ProdA', 'Fabricante1', 100);

INSERT INTO Producto (nombreP, fabricante, precio) VALUES 
('ProdB', 'Fabricante2', 200);

INSERT INTO Producto (nombreP, fabricante, precio) VALUES 
('ProdC', 'Fabricante1', 300);

INSERT INTO Producto (nombreP, fabricante, precio) VALUES 
('ProdD', 'Fabricante3', 400);

INSERT INTO Producto (nombreP, fabricante, precio) VALUES 
('ProdE', 'Fabricante2', 150);

INSERT INTO Producto (nombreP, fabricante, precio) VALUES 
('ProdF', 'Fabricante4', 250);


INSERT INTO ClientePlus (idCliente, volumenCompras) VALUES (1, 1000);

INSERT INTO ClientePlus (idCliente, volumenCompras) VALUES (2, 5000);

INSERT INTO ClientePlus (idCliente, volumenCompras) VALUES (3, 7500);

INSERT INTO ClientePlus (idCliente) VALUES (4);

INSERT INTO ClientePlus (idCliente, volumenCompras) VALUES (5, 3000);

INSERT INTO ClientePlus (idCliente, volumenCompras) VALUES (6, 9500);


INSERT INTO Contiene (nombreVivero, nombreZona, idProducto, stock) VALUES 
('Vivero1', 'ZonaA1', 1, 100);

INSERT INTO Contiene (nombreVivero, nombreZona, idProducto, stock) VALUES 
('Vivero1', 'ZonaA2', 2, 150);

INSERT INTO Contiene (nombreVivero, nombreZona, idProducto, stock) VALUES 
('Vivero6', 'ZonaB1', 3, 50);

INSERT INTO Contiene (nombreVivero, nombreZona, idProducto, stock) VALUES 
('Vivero6', 'ZonaB1', 4, 75);

INSERT INTO Contiene (nombreVivero, nombreZona, idProducto, stock) VALUES 
('Vivero5', 'ZonaC1', 5, 60);

INSERT INTO Contiene (nombreVivero, nombreZona, idProducto, stock) VALUES 
('Vivero5', 'ZonaC1', 6, 90);


INSERT INTO Venta (dni, idCliente, idProducto, cantidadP, precioProduc, fechaCompra) VALUES 
('A12345678', 1, 1, 5, 100, '2023-11-01 10:00:00');

INSERT INTO Venta (dni, idCliente, idProducto, cantidadP, precioProduc, fechaCompra) VALUES 
('B23456789', 2, 2, 3, 200, '2023-11-01 11:00:00');

INSERT INTO Venta (dni, idCliente, idProducto, cantidadP, precioProduc, fechaCompra) VALUES 
('C34567890', 3, 3, 4, 300, '2023-11-02 14:00:00');

INSERT INTO Venta (dni, idCliente, idProducto, cantidadP, precioProduc, fechaCompra) VALUES 
('D45678901', 4, 4, 2, 400, '2023-11-02 15:30:00');

INSERT INTO Venta (dni, idCliente, idProducto, cantidadP, precioProduc, fechaCompra) VALUES 
('B23456789', 5, 5, 7, 150, '2023-11-03 09:00:00');

INSERT INTO Venta (dni, idCliente, idProducto, cantidadP, precioProduc, fechaCompra) VALUES 
('D45678901', 6, 6, 6, 250, '2023-11-03 10:30:00');


INSERT INTO Trabaja (dni, nombreVivero, nombreZona, fechaInicio, fechaFinal) VALUES 
('A12345678', 'Vivero1', 'ZonaA1', '2023-01-01', '2023-12-31');

INSERT INTO Trabaja (dni, nombreVivero, nombreZona, fechaInicio, fechaFinal) VALUES 
('B23456789', 'Vivero1', 'ZonaA1', '2023-02-01', '2023-11-30');

INSERT INTO Trabaja (dni, nombreVivero, nombreZona, fechaInicio, fechaFinal) VALUES 
('C34567890', 'Vivero6', 'ZonaB1', '2023-03-01', '2023-10-31');

INSERT INTO Trabaja (dni, nombreVivero, nombreZona, fechaInicio, fechaFinal) VALUES 
('D45678901', 'Vivero6', 'ZonaB1', '2023-05-01', '2023-08-31');

INSERT INTO Trabaja (dni, nombreVivero, nombreZona, fechaInicio, fechaFinal) VALUES 
('D45678901', 'Vivero5', 'ZonaC1', '2024-04-01', '2024-09-30');

INSERT INTO Trabaja (dni, nombreVivero, nombreZona, fechaInicio, fechaFinal) VALUES 
('C34567890', 'Vivero5', 'ZonaC1', '2024-06-01', '2024-12-15');

DELETE FROM zona where nombreVivero = 'Vivero1';

DELETE FROM empleado where dni = 'A12345678';

DELETE FROM cliente WHERE idcliente = 1;

SELECT * FROM vivero;

SELECT * FROM zona;
 
SELECT * FROM empleado;

SELECT * FROM cliente;

SELECT * FROM clienteplus;

SELECT * FROM producto;

SELECT * FROM contiene;

SELECT * FROM trabaja;
