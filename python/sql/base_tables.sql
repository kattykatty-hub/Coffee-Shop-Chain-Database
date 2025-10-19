-- Employee Table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Store_ID INT
);

INSERT INTO Employee VALUES
(1,'Alice Johnson','Barista',1),
(2,'Bob Smith','Manager',1),
(3,'Clara Lee','Cashier',2),
(4,'Daniel Green','Barista',2),
(5,'Eva Brown','Shift Supervisor',3);

-- Store Table
CREATE TABLE Store (
    Store_ID INT PRIMARY KEY,
    Address VARCHAR(255),
    City VARCHAR(50),
    Capacity INT
);

INSERT INTO Store VALUES
(1,'123 Main St','New York',50),
(2,'456 Broadway Ave','Los Angeles',40),
(3,'789 Market St','Chicago',60);

-- Product Table
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(5,2),
    Description VARCHAR(255)
);

INSERT INTO Product VALUES
(1,'Espresso','Beverage',2.50,'Strong black coffee shot'),
(2,'Cappuccino','Beverage',3.50,'Espresso with steamed milk foam'),
(3,'Latte','Beverage',4.00,'Espresso with milk'),
(4,'Blueberry Muffin','Bakery',2.00,'Freshly baked muffin'),
(5,'Croissant','Bakery',2.20,'Buttery flaky pastry');

-- Inventory Table
CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    Product_ID INT,
    Store_ID INT,
    Quantity INT,
    LastUpdated DATE
);

INSERT INTO Inventory VALUES
(1,1,1,200,'2023-11-01'),
(2,2,1,150,'2023-11-01'),
(3,3,2,180,'2023-11-01'),
(4,4,2,75,'2023-11-01'),
(5,5,3,90,'2023-11-01');

-- Sale Table
CREATE TABLE Sale (
    Sale_ID INT PRIMARY KEY,
    Date DATE,
    Store_ID INT,
    Employee_ID INT
);

INSERT INTO Sale VALUES
(1,'2023-11-01',1,1),
(2,'2023-11-01',2,3),
(3,'2023-11-02',1,2),
(4,'2023-11-03',3,5);

-- Sale_Item Table
CREATE TABLE Sale_Item (
    Sale_Item_ID INT PRIMARY KEY,
    Sale_ID INT,
    Product_ID INT,
    Quantity INT,
    TotalPrice DECIMAL(6,2)
);

INSERT INTO Sale_Item VALUES
(1,1,1,2,5.00),
(2,1,4,1,2.00),
(3,2,2,1,3.50),
(4,3,3,2,8.00),
(5,4,5,3,6.60);

-- Supplier Table
CREATE TABLE Supplier (
    Supplier_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact_Info VARCHAR(255)
);

INSERT INTO Supplier VALUES
(1,'Coffee Beans Co.','beans@supplier.com | 555-1111'),
(2,'Dairy Fresh Ltd.','milk@supplier.com | 555-2222'),
(3,'Sweet Syrups Inc.','syrups@supplier.com | 555-3333');

-- Supply_Order Table
CREATE TABLE Supply_Order (
    Order_ID INT PRIMARY KEY,
    Supplier_ID INT,
    Product_ID INT,
    Quantity INT,
    OrderDate DATE
);

INSERT INTO Supply_Order VALUES
(1,1,1,500,'2023-10-25'),
(2,2,3,200,'2023-10-26'),
(3,3,4,100,'2023-10-27'),
(4,1,1,500,'2023-10-25'),
(5,2,3,200,'2023-10-26'),
(6,3,4,100,'2023-10-27');

-- Promotion Table
CREATE TABLE Promotion (
    Promotion_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    DiscountRate DECIMAL(5,2)
);

INSERT INTO Promotion VALUES
(1,'Happy Hour Espresso','2023-11-01','2023-11-07',20.00),
(2,'Latte Lovers Week','2023-11-10','2023-11-17',15.00),
(3,'Bakery Bundle','2023-11-15','2023-11-30',10.00);
