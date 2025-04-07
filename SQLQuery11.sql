create database ElectronicsStore



CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY identity(1,1),
    CategoryName VARCHAR(50) NOT NULL 
);

CREATE TABLE Brands (
    BrandID INT PRIMARY KEY identity(1,1),
    BrandName VARCHAR(50) NOT NULL 
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY identity(1,1),
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    BrandID INT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID) ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY identity(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15)
);


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY identity(1,1),
    ProductID INT DEFAULT 1,
    CustomerID INT,
    SaleDate DATE NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO Categories (CategoryName) VALUES 
    ('Смартфони'),
    ('Лаптопи'),
    ('Таблети'),
    ('Монитори'),
    ('Аксесоари');


INSERT INTO Brands (BrandName) VALUES 
    ('Apple'),
    ('Samsung'),
    ('Lenovo'),
    ('Dell'),
    ('Asus');


INSERT INTO Products (ProductName, CategoryID, BrandID, Price, StockQuantity) VALUES 
    ('iPhone 15 Pro', 1, 1, 2499.99, 50),
    ('Galaxy S24 Ultra', 1, 2, 2199.99, 45),
    ('ThinkPad X1', 2, 3, 2599.99, 20),
    ('Dell XPS 15', 2, 4, 2899.99, 15),
    ('ROG Gaming Monitor', 4, 5, 899.99, 30);

INSERT INTO Customers (FirstName, LastName, PhoneNumber) VALUES 
    ('Иван', 'Петров', '0888123456'),
    ('Мария', 'Иванова', '0899234567'),
    ('Георги', 'Димитров', '0877345678'),
    ('Петя', 'Георгиева', '0866456789'),
    ('Николай', 'Стоянов', '0855567890');


INSERT INTO Sales (ProductID, CustomerID, SaleDate, Quantity) VALUES 
    (1, 1, '2025-03-15', 1),
    (2, 2, '2025-03-16', 1),
    (3, 3, '2025-03-17', 1),
    (4, 1, '2025-03-18', 1),
    (5, 4, '2025-03-19', 2);


INSERT INTO Products (ProductID, ProductName, CategoryID, BrandID, Price, StockQuantity) VALUES 
    (1000, 'Изтрит продукт', NULL, NULL, 0.00, 0);


SELECT * FROM Products;


SELECT * FROM Products WHERE Price > 2000;


SELECT p.* 
FROM Products p
JOIN Brands b ON p.BrandID = b.BrandID
WHERE b.BrandName = 'Samsung';


SELECT * FROM Products WHERE Price = (SELECT MAX(Price) FROM Products);

SELECT * FROM Customers ORDER BY LastName ASC;


SELECT c.FirstName, c.LastName, s.SaleDate 
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID;


SELECT SUM(Price * StockQuantity) AS TotalStockValue FROM Products;


SELECT c.* 
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleID IS NULL;

UPDATE Products 
SET Price = Price * 1.1
WHERE BrandID = (SELECT BrandID FROM Brands WHERE BrandName = 'Apple');

DELETE FROM Customers WHERE CustomerID = 5;


DELETE FROM Products 
WHERE ProductID = 1 AND BrandID = (SELECT BrandID FROM Brands WHERE BrandName = 'Apple');

DELETE FROM Products WHERE ProductID = 3;




