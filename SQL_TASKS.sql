/*
========================================================
SQL Practice — Real-World Scenarios
Author: Samir Eldarov
Repository: https://github.com/SamirEldarov0/sql-practice-real-scenarios

Description:
This file contains 100+ SQL tasks based on real-world business scenarios.
It covers:
- Table design and relationships
- JOINs (INNER, LEFT)
- GROUP BY and HAVING
- Subqueries
- EXISTS / NOT EXISTS
- Aggregations
- User-defined functions
- Stored procedures
- Views

Database: SQL Server
============================
*/


create table Users(
Id int primary key identity(1,1),
FullName nvarchar(50) not null,
Email nvarchar(50),
Age int,
CreatedDate Date
)

CREATE TABLE UserProfiles (
    UserId INT PRIMARY KEY,
    Address VARCHAR(200),
    BirthDate DATE,
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

CREATE TABLE Orders (
    Id INT PRIMARY KEY identity(1,1),
    UserId INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    CONSTRAINT FK_UserId FOREIGN KEY (UserId) REFERENCES Users(Id)
);

CREATE TABLE Products (
    Id INT PRIMARY KEY identity(1,1),
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE OrderProducts (
    OrderId INT,
    ProductId INT,
    Quantity INT,
    PRIMARY KEY (OrderId, ProductId),
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);


INSERT INTO Users (FullName, Email, CreatedDate) VALUES
('Samir Eldarov',    'samir@mail.com',    '2024-01-10'),
('Ali Hasanov',      'ali@mail.com',      '2024-02-15'),
('Nigar Aliyeva',    'nigar@mail.com',    '2024-03-01'),
('Elvin Mammadov',   'elvin@mail.com',    '2024-03-20'),
('Kamran Huseynov',  'kamran@mail.com',   '2024-03-25'),
('Aysel Karimova',   'aysel@mail.com',    '2024-04-01'),
('Rashad Ibrahimov', 'rashad@mail.com',   '2024-04-05'),
('Lala Ahmadova',    'lala@mail.com',     '2024-04-10'),
('Tural Aliyev',     'tural@mail.com',    '2024-04-12'),
('Gunel Mammadova',  'gunel@mail.com',    '2024-04-15'),
('Emin Abbasov',     'emin@mail.com',     '2024-04-18'),
('Zahra Suleymanli', 'zahra@mail.com',    '2024-04-20'),
('Murad Ismayilov',  'murad@mail.com',    '2024-04-22'),
('Leyla Quliyeva',   'leyla@mail.com',    '2024-04-25'),
('Orkhan Rahimli',   'orkhan@mail.com',   '2024-04-28'),
('Fidan Ahmadli',    'fidan@mail.com',    '2024-05-01'),
('Nurlan Babayev',   'nurlan@mail.com',   '2024-05-03'),
('Amina Taghiyeva',  'amina@mail.com',    '2024-05-05'),
('Javid Qasimov',    'javid@mail.com',    '2024-05-07'),
('Sabina Hajiyeva',  'sabina@mail.com',   '2024-05-10'),
('Rauf Mirzayev',    'rauf@mail.com',     '2024-05-12'),
('Kanan Aliyev',    'kanan@mail.com',    '2024-05-15');

INSERT INTO UserProfiles (UserId, Address, BirthDate) VALUES
(1, 'Baku, Nizami',        '2000-05-10'),
(2, 'Sumqayit',            '1998-11-22'),
(3, 'Ganja',               '2001-01-15'),
(5, 'Baku, Yasamal',       '1999-08-01'),
(7, 'Baku, Narimanov',     '1997-03-18'),
(9, 'Khirdalan',           '2002-12-30'),
(10,'Baku, Sabail',        '1996-06-05'),
(12,'Goychay',             '2000-09-14'),
(14,'Baku, Binagadi',      '1995-04-25'),
(16,'Baku, Khatai',        '2001-02-02');

INSERT INTO Orders (UserId, OrderDate, TotalAmount) VALUES
(1, '2024-04-01', 250.00),
(1, '2024-04-10', 120.00),
(2, '2024-04-05', 500.00),
(3, '2024-04-07', 80.00),
(5, '2024-04-12', 900.00),
(5, '2024-04-20', 150.00),
(7, '2024-04-22', 300.00),
(9, '2024-04-25', 60.00),
(10,'2024-05-01', 700.00),
(12,'2024-05-03', 200.00),
(14,'2024-05-05', 1100.00),
(16,'2024-05-07', 90.00);


INSERT INTO Products (ProductName, Price) VALUES
('Laptop',   1500.00),
('Mouse',     25.00),
('Keyboard',  70.00),
('Monitor',  400.00),
('Headset',  120.00),
('Webcam',    85.00),
('Printer',  350.00),
('Tablet',   600.00);

INSERT INTO OrderProducts (OrderId, ProductId, Quantity) VALUES
(1, 1, 1),  -- Laptop
(1, 2, 2),  -- Mouse
(2, 3, 1),  -- Keyboard
(3, 1, 1),
(3, 4, 1),
(4, 2, 1),
(5, 1, 1),
(5, 4, 1),
(6, 5, 2),
(7, 6, 1),
(8, 2, 1),
(9, 8, 1),
(10,3, 2),
(11,1, 1),
(11,7, 1),
(12,2, 1);

select*from Users
select*from UserProfiles
select*from Products
select*from OrderProducts
select*from Orders
select*from Users

--Users with no orders
select*from Users where Id not in (select UserId from Orders);

select u.FullName, u.Email, o.TotalAmount, o.UserId from Users u
join Orders o
on o.UserId=u.Id

--Users with orders but no profile
select*from Users u where u.Id in (select UserId from Orders) and u.Id in (select UserId from UserProfiles)

select u.Id, u.FullName, u.Email from Users u
join Orders o on u.Id = o.Id
left join UserProfiles uf on u.Id = uf.UserId
where uf.UserId = null

select u.FullName, u.Email, u.Age from Users u
where exists (select 1 from Orders o where u.Id = o.UserId)
and not exists (select 1 from UserProfiles uf where u.Id = uf.UserId)

--Top 3 users by total spending
select*from Users
select*from Orders

select sum(o.TotalAmount) as TotalAmount, u.FullName from Users u
join Orders o on u.Id = o.UserId
group by u.FullName,o.TotalAmount

select top 3 u.Id, u.FullName, sum(o.TotalAmount) TotalSpent from Users u
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName
order by TotalSpent desc

SELECT TOP 3
    u.UserId,
    u.FullName,
    SUM(o.TotalAmount) AS TotalSpent
FROM Users u
JOIN Orders o ON o.UserId = u.UserId
GROUP BY u.UserId, u.FullName
ORDER BY TotalSpent DESC;

--Products never ordered

select * from Products
select*from Orders
select*from OrderProducts

select * from Products p
where not exists (select 1 from OrderProducts op where p.Id = op.ProductId )

select * from Products
where Id not in (select ProductId from OrderProducts)

select * from Products p
left join OrderProducts op on p.Id = op.ProductId
where op.ProductId is null

--Orders with more than 2 products
--Monthly revenue reports

select o.OrderDate, o.TotalAmount, count(*) as productcount from Orders o
join OrderProducts op on o.Id = op.OrderId
group by o.OrderDate, o.TotalAmount having(count(o.Id))

-- Created by GitHub Copilot in SSMS - review carefully before executing
SELECT 
    o.Id AS OrderId,
    COUNT(op.ProductId) AS ProductCount
FROM 
    Orders o
JOIN 
    OrderProducts op ON o.Id = op.OrderId
GROUP BY 
    o.Id
HAVING 
    COUNT(op.ProductId) > 2;


--• Concurrency & Performance: async/await, TAP, Task Parallel Library (TPL), Parallel Programming (Parallel.For/ForEach), Multithreading, Thread-Safety, SynchronizationContext awareness, CancellationToken, Background Services, Performance Optimization

select*from Users
select*from UserProfiles
select*from Products
select*from OrderProducts
select*from Orders


--1?? Users with a profile -- Show UserId, FullName, Address.
select up.UserId,u.FullName,up.Address from Users u
join UserProfiles up
on u.Id=up.UserId

--2?? Users without a profile -- Show UserId, FullName.
select up.UserId,u.FullName from Users u
left join UserProfiles up
on u.Id=up.UserId
where u.Id is null

--3?? Orders with more than one product -- Show OrderId, TotalAmount.

--select op.OrderId, o.TotalAmount from OrderProducts op
--join Orders o on o.Id=op.OrderId
--where op.Quantity>1;

select op.OrderId, o.TotalAmount, count(op.ProductId) as ProductCount from OrderProducts op
join Orders o on o.Id=op.OrderId
group by op.OrderId, o.TotalAmount having count(op.ProductId)>1


--4?? Top 5 users by total spending---Show FullName and total spending.
select*from Users
select*from Orders

select top 5 u.FullName, sum(o.TotalAmount) as TotalSpending from Users u
join Orders o on u.Id=o.UserId
group by u.FullName
order by TotalSpending desc

--5?? Products that were never ordered --- Show ProductName.

select*from Products
select*from OrderProducts
select*from Orders

select p.ProductName from Products p
left join OrderProducts op on p.Id=op.ProductId
where p.Id is null

--6?? Total number of products per order--Show OrderId and ProductCount.

SELECT
    op.OrderId,
    SUM(op.Quantity) AS ProductCount
FROM dbo.OrderProducts op
GROUP BY op.OrderId
ORDER BY op.OrderId; 

--7?? Orders containing both Laptop and Mouse--Show OrderId.

--select o.Id as OrderId from Orders o
--where Id in (select )
--where Id in (select Id from Products where ProductName in ('Laptop','Mouse'))

select op.OrderId from Orders o
join OrderProducts op on o.Id=op.OrderId
where op.ProductId in (select Id from Products where ProductName in ('Laptop','Mouse'))

SELECT op.OrderId
FROM OrderProducts op
JOIN Products p ON p.Id = op.ProductId
WHERE p.ProductName IN ('Laptop', 'Mouse')
GROUP BY op.OrderId
HAVING COUNT(DISTINCT p.ProductName) = 2;

--8?? Users who ordered a Laptop Show UserId, FullName.

select*from Users
select*from Orders

SELECT DISTINCT u.Id, u.FullName
FROM Users u
JOIN Orders o ON o.UserId = u.Id
JOIN OrderProducts op ON op.OrderId = o.Id
JOIN Products p ON p.Id = op.ProductId
WHERE p.ProductName = 'Laptop';

select u.Id, u.FullName from Users u
where exists (
select 1 from Orders o
join OrderProducts op on o.Id=op.OrderId
join Products p on p.Id=op.ProductId
where u.Id=o.UserId and p.ProductName='Laptop')

--9?? Total revenue per user Show UserId, FullName, TotalSpent.
select*from Users
select*from Orders

select u.Id,u.FullName,SUM(o.TotalAmount) from Users u
join Orders o on u.Id=o.UserId
group by u.Id,u.FullName

--20?? Orders with total quantity > 5 (sum of quantities) Show OrderId, TotalQuantity.

select o.Id,sum(op.Quantity) as TotalQuantity from Orders o
join OrderProducts op on o.Id=op.OrderId
group by o.Id having(sum(op.Quantity))>5
select*from Products

--19?? Orders where quantity of any product > 3 Show OrderId, ProductId, Quantity.
select o.Id,p.Id,sum(op.Quantity) from Orders o
join OrderProducts op on o.Id=op.OrderId
join Products p on p.Id=op.ProductId
group by o.Id,p.Id having(sum(op.Quantity))>3

--19?? Products ordered by more than 3 users--Show ProductName.
select*from Users
select top 5*from Orders
select top 5*from OrderProducts
select*from Products

SELECT 
    p.ProductName,
    COUNT(DISTINCT o.UserId) AS UserCount
FROM Products p
JOIN OrderProducts op ON op.ProductId = p.Id
JOIN Orders o ON o.Id = op.OrderId
GROUP BY p.Id, p.ProductName
HAVING COUNT(DISTINCT o.UserId) > 3;

select p.ProductName from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on o.Id = op.OrderId
group by p.ProductName having count(distinct o.UserId)>3

--17?? Orders with only one product Show OrderId.
select*from Users
select *from Orders
select *from OrderProducts
select*from Products

select OrderId from OrderProducts
group by OrderId having sum(Quantity)=

SELECT op.OrderId
FROM OrderProducts op
GROUP BY op.OrderId
HAVING COUNT(DISTINCT op.ProductId) = 1;

--select OrderId from OrderProducts op
--group by OrderId having 

select u.Id,u.FullName from Users u
where exists (select 1 from UserProfiles uf where uf.UserId=u.Id)

select u.Id, u.FullName from Users u
join UserProfiles up on u.Id = up.UserId
left join Orders o on u.Id = o.UserId
where o.Id is null

--2?? Orders with duplicate products

--(same product appearing more than once in the same order)
--Show: OrderId, ProductId, Count

select OrderId,ProductId,count(*) as Count from OrderProducts
group by OrderId, ProductId having count(*)>1

--3?? For each product, show first and last order date

--Show: ProductId, ProductName, FirstOrderDate, LastOrderDate

select p.Id, p.ProductName, Min(o.OrderDate) as FirstOrderDate, Max(o.OrderDate) as LastOrderDate from Products p
join OrderProducts op on op.ProductId=p.Id
join Orders o on o.Id=op.OrderId
group by p.Id, p.ProductName

select*from Orders
select*from OrderProducts
select*from Products

--4?? Users who placed exactly one order

--Show: UserId, FullName

select u.Id, u.FullName from Users u
join Orders o on u.Id=o.UserId
group by u.Id, u.FullName having count(o.UserId)=1


--5?? Orders containing products from at least 2 different price ranges
--(e.g. <100 and ?100)
--Show: OrderId
select o.Id from Orders o
where exists (select 1 from OrderProducts op join Products p on p.Id=op.ProductId where o.Id=op.Quantity and p.Price<100)
and exists (select 1 from OrderProducts op join Products p on p.Id=op.ProductId where o.Id=op.Quantity and p.Price>=100);

--6?? Users whose total spending is greater than the average user spending

--Show: UserId, FullName, TotalSpent

SELECT
    u.Id,
    u.FullName,
    SUM(o.TotalAmount) AS TotalSpent
FROM Users u
JOIN Orders o ON o.UserId = u.Id
GROUP BY u.Id, u.FullName
HAVING SUM(o.TotalAmount) >
(
    SELECT AVG(UserTotal)
    FROM (
        SELECT SUM(o2.TotalAmount) AS UserTotal
        FROM Orders o2
        GROUP BY o2.UserId
    ) t
);


--?? Products ordered by only one user

--Show: ProductId, ProductName

select * from Products
select * from OrderProducts
select * from Orders
select * from Users

select p.Id, p.ProductName from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on o.Id = op.OrderId
group by p.Id, p.ProductName having COUNT(o.UserId)=1


--?? Products cheaper than the average product price

--Show: ProductId, ProductName, Price.
select Id, ProductName, Price from Products where Price < (select avg(Price) from Products)


SELECT p.Id, p.ProductName, p.Price
FROM Products p
JOIN (
    SELECT AVG(Price) AS AvgPrice
    FROM Products
) a ON p.Price < a.AvgPrice;


--9?? Users who have no profile
--Show: UserId, FullName.

select*from Users
select*from UserProfiles

select u.Id, u.FullName from Users u
where u.Id not in (select UserId from UserProfiles);

select u.Id, u.FullName, up.UserId from Users u
left join UserProfiles up on u.Id=up.UserId
where up.UserId is null

select u.Id, u.FullName from Users u
where not exists (select 1 from UserProfiles up where u.Id = up.UserId)

select*from Users
select*from Orders

--7?? Number of orders per user

--Show: UserId, OrderCount.

select UserId,COUNT(*) as OrderCount from Orders
group by UserId

select u.Id, count(o.Id) from Users u
left join Orders o on u.Id = o.UserId
group by u.Id

--8?? Products included in OrderId = 1
--Show: ProductName, Quantity.

select*from Orders
select*from OrderProducts
select*from Products

select p.ProductName,op.Quantity from Products p
join OrderProducts op on p.Id=op.ProductId
where op.OrderId=1

--7?? Number of orders per user
--Show: UserId, OrderCount.

select*from Orders
select*from Users

select UserId, count(*) as OrderCount from Orders
group by UserId

--6?? Orders with their user names

--Show: OrderId, FullName.

select o.Id, u.FullName from Orders o
join Users u on u.Id = o.UserId

select*from Products

--1?? Users who placed at least one order
--Show: UserId, FullName

select*from Users
select*from Orders

SELECT DISTINCT u.Id AS UserId, u.FullName
FROM Users u
JOIN Orders o ON u.Id = o.UserId;

select u.Id, u.FullName from Users u
join Orders o on u.Id = o.UserId

select u.Id, u.FullName from Users u
where exists (select 1 from Orders o where u.Id = o.UserId)

--2?? Users who placed more than one order
--Show: UserId, FullName, OrderCount
select u.Id, u.FullName, count(o.Id) as OrderCount from Users u
join Orders o on u.Id = o.UserId group by u.Id, u.FullName having count(o.Id)>1

select * from Users u where (select count(*) from Orders o where u.Id = o.UserId) > 1

--3?? Orders with more than one product
--Show: OrderId, ProductCount
SELECT
    op.OrderId,
    COUNT(DISTINCT op.ProductId) AS ProductCount
FROM OrderProducts op
GROUP BY op.OrderId
HAVING COUNT(DISTINCT op.ProductId) > 1;

SELECT
    op.OrderId,
    COUNT(op.ProductId) AS ProductCount
FROM OrderProducts op
GROUP BY op.OrderId
HAVING COUNT(op.ProductId) > 1;

select*from Orders
select*from Products
select*from OrderProducts

--4?? Total quantity of products per order
--Show: OrderId, TotalQuantity

select OrderId, sum(Quantity) as TotalQuantity from OrderProducts 
group by OrderId

select o.Id, o.OrderDate, sum(op.Quantity) as TotalQuantity from Orders o
join OrderProducts op on o.Id=op.OrderId
group by o.Id, o.OrderDate

--5?? Users who never ordered a Laptop
--Show: UserId, FullName

select * from Users
select * from Orders

select u.Id, u.FullName from Users u
not exists (
select 1 from Orders o 
join OrderProducts op on o.Id = op.OrderId
join Products p on p.Id = op.ProductId
where u.Id = o.UserId and p.ProductName = 'Laptop')

--6️⃣ Products that appear in at least 2 different orders
--Show: ProductId, ProductName

select*from Products
select*from OrderProducts

select p.Id, p.ProductName from Products p
join OrderProducts op on p.Id = op.ProductId
group by p.Id, p.ProductName having count(p.Id)>=2

SELECT 
    p.Id AS ProductId,
    p.ProductName
FROM Products p
JOIN OrderProducts op 
    ON p.Id = op.ProductId
GROUP BY 
    p.Id, 
    p.ProductName
HAVING COUNT(DISTINCT op.OrderId) >= 2;

--8️⃣ Orders that contain both cheap (<100) and expensive (≥100) products
--Show: OrderId

select * from Products
select*from Orders

select o.Id as OrderId from Orders o
where exists (select 1 from OrderProducts op join Products p on op.ProductId=p.Id where o.Id=op.OrderId and p.Price<100)
and exists (select 1 from OrderProducts op join Products p on op.ProductId = p.Id where o.Id = op.OrderId and p.Price>=100)

--9️⃣ Users who ordered exactly 2 different products (across all orders)
--Show: UserId, FullName
select * from Users
select*from Orders
select * from Products
select*from OrderProducts

select u.Id, u.FullName from Users u 
join Orders o on u.Id = o.UserId
join OrderProducts op on o.Id = op.OrderId
group by u.Id, u.FullName having count(distinct op.OrderId) = 2

--🔟 Products that were ordered by more than one user
--Show: ProductId, ProductName
select p.Id, p.ProductName from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on op.OrderId = o.Id
join Users u on u.Id = o.UserId
group by p.Id, p.ProductName having COUNT(distinct o.UserId) > 1

--1️⃣ Products that appear in at least 2 different orders
--Show: ProductId, ProductName, OrderCount

select p.Id as ProductId, p.ProductName, count(distinct op.OrderId) as OrderCount from Products p
join OrderProducts op on p.Id = op.ProductId
group by p.Id, p.ProductName having COUNT(distinct op.OrderId)>=2

--2️⃣ Users who placed exactly one order
--Show: UserId, FullName
select * from Users
select*from Orders
select * from Products
select*from OrderProducts

select u.Id as UserId, u.FullName from Users u
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName having COUNT(distinct o.Id) = 1

--3️⃣ Orders that contain exactly 2 different products
--Show: OrderId
select*from Orders
select*from OrderProducts
select o.Id as OrderId from Orders o
join OrderProducts op on o.Id = op.OrderId
group by o.Id having count(distinct op.ProductId) = 2

--4️⃣ Users whose first order was placed in May 2024
--Show: UserId, FullName, FirstOrderDate
select * from Users
select * from Orders

select u.Id as UserId, u.FullName from Users u
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName having min(o.OrderDate) >= '2024-05-01' and min(o.OrderDate) < '2024-06-01'

--5️⃣ Orders where all products cost less than 500
--Show: OrderId
select * from Orders
select * from OrderProducts
select * from Products

select o.Id as OrderId from Orders o
join OrderProducts op on o.Id = op.OrderId
join Products p on p.Id = op.ProductId
group by o.Id having SUM(CASE WHEN p.Price >= 500 THEN 1 ELSE 0 END) = 0;
--sum(p.Price) < 500

select o.Id as OrderId from Orders o
where not exists (select 1 from OrderProducts op join Products p on p.Id = op.ProductId where op.OrderId = o.Id and p.Price >= 500)

--6️⃣ Products that were ordered by more than one user
--Show: ProductId, ProductName, UserCount
select*from Orders
select p.Id, p.ProductName, count(distinct u.Id) from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on o.Id = op.OrderId
join Users u on u.Id = o.UserId
group by p.Id, p.ProductName having count(distinct u.Id) > 1

--7️⃣ Users who have a profile and at least one order
--Show: UserId, FullName

select u.Id, u.FullName from Users u
join UserProfiles up on u.Id = up.UserId
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName having count(o.Id) >= 1;

select u.Id, u.FullName from Users u
where exists (select 1 from UserProfiles up where u.Id = up.UserId)
and exists (select 1 from Orders o where o.UserId = u.Id)

--8️⃣ Orders with total quantity greater than the average order quantity
--Show: OrderId, TotalQuantity
select*from OrderProducts
select o.Id, SUM(op.Quantity) as TotalQuantity from Orders o
join OrderProducts op on o.Id = op.OrderId group by o.Id
having SUM(op.Quantity) > (select sum(op.Quantity) from OrderProducts group by OrderId)

select*from Orders

--5️⃣ Orders where all products cost less than 500
--Show: OrderId

select * from Orders
select * from OrderProducts
select * from Products

select o.Id from Orders o
join OrderProducts op on op.OrderId = o.Id
join Products p on op.ProductId = p.Id
group by o.Id having max(p.Price) < 500

select o.Id from Orders o
where not exists
(select 1 from OrderProducts op
 join Products p on op.ProductId = p.Id
 where o.Id = op.OrderId and p.Price>=500)

-- 🔟 Products that were never ordered together with “Laptop”
--Show: ProductId, ProductName

select * from Products
select * from OrderProducts

select p.Id, p.ProductName from Products p
join OrderProducts op on op.ProductId = p.Id
where p.ProductName <> 'Laptop'

select u.Id,u.FullName,u.Age from Users u
where u.CreatedDate > '2024-04-01'

select o.Id, u.FullName from Orders o
join Users u on u.Id = o.UserId

--9️⃣ Users who have at least one order
--Show: UserId, FullName

select u.Id, u.FullName from Users u
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName having COUNT(distinct o.Id) >=1

select u.Id, u.FullName from Users u
where exists (select 1 from Orders o where u.Id = o.Id)

select distinct(u.Id), u.FullName from Users u
join Orders o on u.Id = o.UserId

select u.Id, u.FullName from Users u
join Orders o on u.Id = o.UserId group by u.Id, u.FullName

--in case of users who at least have 2 orders
select u.Id, u.FullName from Users u
where (select count(*) from Orders o where o.UserId = u.Id) >= 2

select u.Id, u.FullName from Users u
join Orders o on u.Id = o.UserId

--🔟 Users who have no orders
--Show: UserId, FullName

select u.Id, u.FullName from Users u
where not exists (select 1 from Orders o where u.Id = o.UserId)

select u.Id, u.FullName from Users u
left join Orders o on o.UserId = u.Id
where o.Id is null

select u.Id, u.FullName from Users u
join Orders o on o.UserId = u.Id
group by u.Id, u.FullName having count(distinct o.Id) = 0

select u.Id, u.FullName from Users u
where u.Id not in (select UserId from Orders)

--11️⃣ Number of orders per user
--Show: UserId, OrderCount

select u.Id, count(o.Id) as OrderCount from Users u
left join Orders o on u.Id = o.UserId
group by u.Id
select*from Users
select*from Orders

--12️⃣ Orders with total amount greater than 200
--Show: OrderId, TotalAmount

select Id as OrderId, TotalAmount from Orders where TotalAmount > 200
select*from OrderProducts

--13️⃣ Products included in a specific order (e.g. OrderId = 1)
--Show: ProductName, Quantity
select*from Products
select*from OrderProducts

select p.ProductName, op.Quantity from Products p
where exists (select 1 from OrderProducts op where p.Id = op.ProductId)

select p.ProductName, op.Quantity from Products p
join OrderProducts op on p.Id = op.ProductId
where op.OrderId = 1

--14️⃣ Users who have a profile
--Show: UserId, FullName
select u.Id, u.FullName from Users u
where u.Id in (select UserId from UserProfiles)

select u.Id, u.FullName from Users u
where exists (select 1 from UserProfiles up where u.Id = up.UserId)

select u.Id, u.FullName from Users u
join UserProfiles up on u.Id = up.UserId

--15️⃣ Users who do NOT have a profile
--Show: UserId, FullName

--var p1 = users.Where(x=>x.UserProfile!=null).ToList();
select u.Id, u.FullName from Users u
where u.Id not in (select UserId from UserProfiles)

select u.Id, u.FullName from Users u where
not exists (select 1 from UserProfiles up where up.UserId = u.Id) 

select u.Id, u.FullName from Users u
left join UserProfiles up on u.Id = up.UserId
where up.UserId is null

--16️⃣ Products that were ordered at least once
--Show: ProductId, ProductName
select * from Products p
select * from OrderProducts op

select p.Id, p.ProductName from Products p
where (select count(*) from OrderProducts op where p.Id = op.ProductId) >= 1

select p.Id, p.ProductName from Products p
join OrderProducts op on p.Id = op.ProductId
group by p.Id, p.ProductName having count(distinct op.OrderId) >= 1

select p.Id, p.ProductName from Products p where
exists (select 1 from OrderProducts op where p.Id = op.ProductId)

--17️⃣ Orders that contain more than one product
--Show: OrderId

select * from Orders o
select * from OrderProducts
select * from Products

select o.Id from Orders o
where (select count(*) from OrderProducts op where o.Id = op.OrderId) > 1

select o.Id from Orders o
join OrderProducts op on o.Id = op.OrderId
group by o.Id having count(op.ProductId) > 1 -- OrderId

--18️⃣ Total quantity of products per order
--Show: OrderId, TotalQuantity

select OrderId, sum(Quantity) as TotalQuantity from OrderProducts
group by OrderId

select o.Id, sum(op.Quantity) as TotalQuantity from Orders o
join OrderProducts op on o.Id = op.OrderId
group by o.Id

--19️⃣ Users who ordered a Laptop
--Show: UserId, FullName
select * from Users
select * from Orders
select u.Id, u.FullName from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on o.Id = op.OrderId
join Products p on op.ProductId = p.Id
where p.ProductName = 'Laptop' group by u.Id, u.FullName

select distinct u.Id, u.FullName from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on o.Id = op.OrderId
join Products p on p.Id = op.ProductId
where p.ProductName = 'Laptop'

select u.Id, u.FullName from Users u
where exists (
select 1 from Orders o
join OrderProducts op on o.Id = op.OrderId
join Products p on p.Id = op.ProductId
where u.Id = o.UserId and p.ProductName = 'Laptop')

--20️⃣ Products that were never ordered
--Show: ProductId, ProductName

select * from Products
select * from OrderProducts
select p.Id, p.ProductName from Products p
left join OrderProducts op on p.Id = op.ProductId
where op.ProductId is null

select p.Id, p.ProductName from Products p
where p.Id not in (select op.ProductId from OrderProducts op)

select p.Id, p.ProductName from Products p where
not exists (select 1 from OrderProducts op where p.Id = op.ProductId)

--1️⃣ Users who placed more than one order
--Show: UserId, FullName, OrderCount
select * from Users
select * from Orders

select u.Id, u.FullName, count(o.Id) as OrderCount from Users u
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName having count(o.Id) > 1;

--2️⃣ Orders with more than one product
--Show: OrderId, ProductCount

select * from Orders
select * from OrderProducts

select o.Id, count(op.ProductId) as ProductCount from Orders o
join OrderProducts op on o.Id = op.OrderId
group by o.Id having count(op.ProductId) > 1

select OrderId, count(ProductId) as ProductCount from OrderProducts group by OrderId having count(ProductId) > 1

--select distinct OrderId, count(ProductId) as ProductCount from OrderProducts where 
--(select count(*) as OC from OrderProducts group by OrderId) > 1

--3️⃣ Products that were ordered by more than one user
--Show: ProductId, ProductName, UserCount

select p.Id, p.ProductName, COUNT(distinct u.Id) as UserCount from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on o.Id = op.OrderId
join Users u on o.UserId = u.Id
group by p.Id, p.ProductName having COUNT(distinct u.Id) > 1

--4️⃣ Users who never ordered a Laptop
--Show: UserId, FullName

select u.Id, u.FullName from Users u where
not exists (select 1 from Orders o
            join OrderProducts op on o.Id = op.OrderId
            join Products p on p.Id = op.ProductId
            where o.UserId = u.Id and p.ProductName = 'Laptop'
                )
select u.Id, u.FullName from Users u
left join Orders o on u.Id = o.UserId
left join OrderProducts op on o.Id = op.OrderId
left join Products p on p.Id = op.ProductId and  p.ProductName = 'Laptop'
where p.Id is null group by u.Id, u.FullName

--5️⃣ Orders that contain both Laptop and Mouse
--Show: OrderId

select op.OrderId from OrderProducts op
join Products p on op.ProductId = p.Id
where p.ProductName in ('Laptop', 'Mouse')
group by op.OrderId having (count(distinct p.ProductName)) = 2

select op.OrderId from OrderProducts op where
exists (select 1 from Products p where p.Id = op.ProductId and p.ProductName = 'Laptop')
and exists (select 1 from Products p where p.Id = op.ProductId and p.ProductName = 'Mouse')

--6️⃣ Total spending per user
--Show: UserId, FullName, TotalSpent

select * from Orders
select * from Users

select u.Id, u.FullName, sum(o.TotalAmount) as TotalSpent from Users u
join Orders o on o.UserId = u.Id
group by u.Id, u.FullName

select u.Id, u.FullName, coalesce(sum(o.TotalAmount), 0) as TotalSpent from Users u
left join Orders o on o.UserId = u.Id
group by u.Id, u.FullName

select 
    u.Id as UserId,
    u.FullName,
    sum(op.Quantity * p.Price) as TotalSpent
from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on op.OrderId = o.Id
join Products p on p.Id = op.ProductId
group by u.Id, u.FullName;

select u.Id, u.FullName, coalesce(sum(p.Price * op.Quantity), 0) as  TotalSpending from Users u
left join Orders o on o.UserId = u.Id
left join OrderProducts op on o.Id = op.OrderId
left join Products p on p.Id = op.ProductId
group by u.Id, u.FullName

--7️⃣ Users whose total spending is greater than the average user spending
--Show: UserId, FullName, TotalSpent

select u.Id, u.FullName, coalesce(sum(p.Price * op.Quantity), 0) as TotalSpent from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on o.Id = op.OrderId
join Products p on p.Id = op.ProductId
group by u.Id, u.FullName having coalesce(sum(p.Price * op.Quantity), 0)=9

--8️⃣ Products that were never ordered
--Show: ProductId, ProductName
select distinct p.Id, p.ProductName from Products p
left join OrderProducts op on p.Id = op.ProductId
where op.ProductId is null

select p.Id, p.ProductName from Products p
where not exists (
    select 1 from OrderProducts op where p.Id = op.ProductId
    )

select p.Id, p.ProductName from Products p
left join OrderProducts op on p.Id = op.ProductId
where op.ProductId is null  group by p.Id, p.ProductName

select p.Id, p.ProductName from Products p
where p.Id not in (select op.ProductId from OrderProducts op)

--9️⃣ Orders with total quantity greater than average order quantity
--Show: OrderId, TotalQuantity

select op.OrderId, sum(op.Quantity) as TotalQuantity from OrderProducts op
group by op.OrderId having sum(op.Quantity) > AVG(op.Quantity) ----------------

--🔟 Users with a profile who never placed an order
--Show: UserId, FullName

select distinct u.Id, u.FullName from Users u
join UserProfiles up on u.Id = up.UserId
left join Orders o on o.UserId = u.Id
where up.UserId is null

select u.Id, u.FullName from Users u
join UserProfiles up on u.Id = up.UserId
where not exists (
    select 1 from Orders o where o.UserId = u.Id)

--11️⃣ Orders where all products cost less than 500
--Show: OrderId
select * from Orders
select * from OrderProducts
select * from Products

select op.OrderId from OrderProducts op
join Products p on op.ProductId = p.Id
group by op.OrderId having max(p.Price) < 500

select op.OrderId from OrderProducts op
where not exists (
    select 1 from Products p where p.Id = op.ProductId and p.Price >= 500
    )
--Example to make it click

--Order #10 has:

--Product A → 100

--Product B → 900

--After where p.Price < 500:

--Product B is removed

--Product A remains

--➡️ Order #10 still appears — wrong for “all products < 500”

--12️⃣ Products ordered in every order
--Show: ProductId, ProductName
select * from Products
select * from OrderProducts

select p.Id, p.ProductName from Products p
join OrderProducts op on p.Id = op.ProductId
group by p.Id, p.ProductName

select p.Id as ProductId, p.ProductName as ProductName
from OrderProducts op
join Products p on op.ProductId = p.Id
group by p.Id, p.ProductName
having count(distinct op.OrderId) = (select count(*) from Orders);

--13️⃣ For each product, show first and last order date
--Show: ProductId, ProductName, FirstOrderDate, LastOrderDate

select p.Id, p.ProductName, min(o.OrderDate) as FirstOrderDate, max(o.OrderDate) as LastOrderDate from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on o.Id = op.OrderId
group by p.Id, p.ProductName

--14️⃣ Users who ordered more than 3 different products
--Show: UserId, FullName, ProductCount

select u.Id, u.FullName, count(distinct op.ProductId) as ProductCount from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on o.Id = op.OrderId
group by u.Id, u.FullName having count(distinct op.ProductId) >= 3

--15️⃣ Orders with exactly 2 different products
--Show: OrderId

select op.OrderId from OrderProducts op
group by op.OrderId having count(distinct op.ProductId) = 2

--16️⃣ Products that were ordered by only one user
--Show: ProductId, ProductName

select p.Id, p.ProductName from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on o.Id = op.OrderId
join Users u on u.Id = o.UserId
group by p.Id, p.ProductName having count(distinct u.Id) = 1

--17️⃣ Orders with duplicate products
--(same product appears more than once in same order)
--Show: OrderId, ProductId, Count

select o.Id, op.ProductId, count(op.ProductId) from Orders o
join OrderProducts op on o.Id = op.OrderId
group by o.Id, op.ProductId having count(op.ProductId) > 1

--18️⃣ Users who placed their first order in April 2024
--Show: UserId, FullName, FirstOrderDate

select u.Id, u.FullName, min(o.OrderDate) as FirstOrderDate from Users u
join Orders o on o.UserId = u.Id
group by u.Id, u.FullName having min(o.OrderDate) between '2024-04-01' and '2024-04-30'

--19️⃣ Products that were never ordered together with Laptop
--Show: ProductId, ProductName
select distinct p.Id, p.ProductName from Products p  -----------sehv
join OrderProducts op on op.ProductId = p.Id
where p.ProductName <> 'Laptop'

--20️⃣ Users who ordered exactly 2 different products (across all orders)
--Show: UserId, FullName

select u.Id, u.FullName from Users u 
join Orders o on u.Id = o.UserId
join OrderProducts op on o.Id = op.OrderId
group by u.Id, u.FullName having count(distinct op.ProductId) = 2

--1️⃣ Users who ordered all products at least once
--Show: UserId, FullName

select u.Id, u.FullName from Users u
join Orders o on u.Id = o.UserId
join OrderProducts op on op.OrderId = o.Id
group by u.Id, u.FullName having count(distinct op.ProductId) = (select count(*) from Products)

--2️⃣ Orders where every product’s quantity ≥ 2
--Show: OrderId

select o.Id from Orders o where
not exists (select 1 from OrderProducts op where op.OrderId = o.Id and op.Quantity < 2)

select op.OrderId from OrderProducts op
group by op.OrderId having min(op.Quantity) >= 2


--1️⃣ Users who placed more than 2 orders
--Show: UserId, FullName, OrderCount

select u.Id, u.FullName, count(o.Id) as OrderCount from Users u
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName having count(o.Id) > 2

select * from UserProfiles
select * from OrderProducts
select * from Orders

--2️⃣ Orders with more than 3 products
--Show: OrderId, ProductCount
select op.OrderId, count(distinct op.ProductId) as ProductCount from OrderProducts op
group by op.OrderId having count(distinct op.ProductId) > 3

--3️⃣ Products ordered by more than 2 different users
--Show: ProductId, ProductName, UserCount

select p.Id, p.ProductName, count(distinct u.Id) as UserCount from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on o.Id = op.OrderId
join Users u on u.Id = o.UserId
group by p.Id, p.ProductName
having count(distinct u.Id) > 2

--4️⃣ Users who never ordered a Mouse
--Show: UserId, FullName
select * from Users u where 
not exists (
    select 1 from Orders o 
    join OrderProducts op on o.Id = op.OrderId
    join Products p on p.Id = op.ProductId
    where u.Id = o.UserId and p.ProductName = 'Mouse'
    )
SELECT u.Id AS UserId, u.FullName
FROM Users u
LEFT JOIN Orders o ON u.Id = o.UserId
LEFT JOIN OrderProducts op ON o.Id = op.OrderId
LEFT JOIN Products p ON p.Id = op.ProductId AND p.ProductName = 'Mouse'
WHERE p.Id IS NULL;

--5️⃣ Orders where total quantity > 5
--Show: OrderId, TotalQuantity
select * from Orders
select * from OrderProducts
select op.OrderId, sum(op.Quantity) as TotalQuantity from OrderProducts op
group by op.OrderId having sum(op.Quantity) > 5

--6️⃣ Users whose total spending > 1000
--Show: UserId, FullName, TotalSpent
select u.Id, u.FullName from Users u
join Orders o on o.UserId = u.Id
group by u.Id, u.FullName having sum(o.TotalAmount) > 1000

--7️⃣ Products that were never ordered
--Show: ProductId, ProductName

select p.Id, p.ProductName from Products p where
not exists (
    select 1 from OrderProducts op where p.Id = op.ProductId
    )

select p.Id, p.ProductName from Products p
left join OrderProducts op on p.Id = op.ProductId
where op.ProductId is null

--8️⃣ Orders containing both Laptop and Headphones
--Show: OrderId

select o.Id from Orders o where exists(
    select 1 from OrderProducts op
    join Products p on p.Id = op.ProductId where o.Id = op.OrderId and p.ProductName = 'Laptop'
) and exists (
    select 1 from OrderProducts op
    join Products p on p.Id = op.ProductId where o.Id = op.OrderId and p.ProductName = 'Headphones'
)

select op.OrderId
from OrderProducts op
join Products p on p.Id = op.ProductId
where p.ProductName in ('Laptop', 'Headphones')
group by op.OrderId
having count(distinct p.ProductName) = 2

--9️⃣ Users who ordered at least 3 different products
--Show: UserId, FullName, ProductCount

select u.Id, u.FullName, COUNT(distinct p.Id) as ProductCount from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on op.OrderId = o.Id
join Products p on p.Id = op.ProductId
group by u.Id, u.FullName having COUNT(distinct p.Id) >= 3

--🔟 Orders with exactly 2 different products
--Show: OrderId

select op.OrderId from OrderProducts op
group by op.OrderId having COUNT(distinct op.ProductId) = 2

SELECT 
    u.Id AS UserId,
    u.FullName,
    COUNT(DISTINCT op.ProductId) AS ProductCount,
    COUNT(DISTINCT o.Id) AS OrderCount
FROM Users u
JOIN Orders o ON o.UserId = u.Id
JOIN OrderProducts op ON op.OrderId = o.Id
GROUP BY u.Id, u.FullName
HAVING 
    COUNT(DISTINCT op.ProductId) >= 3
    AND COUNT(DISTINCT o.Id) >= 2;

--1️⃣ Users who placed at least 2 orders
--Show: UserId, FullName, OrderCount

select u.Id, u.FullName, COUNT(o.Id) as OrderCount from Users u
join Orders o on o.UserId = u.Id
group by u.Id, u.FullName having COUNT(o.Id) >= 2

--2️⃣ Orders that contain more than 1 product
--Show: OrderId, ProductCount

select op.OrderId, COUNT(distinct op.ProductId) as ProductCount from OrderProducts op
group by op.OrderId having COUNT(distinct op.ProductId) > 1

--3️⃣ Products ordered by at least 2 different users
--Show: ProductId, ProductName, UserCount

select p.Id, p.ProductName, COUNT(distinct u.Id) as UserCount from Products p
join OrderProducts op on op.ProductId = p.Id
join Orders o on o.Id = op.OrderId
join Users u on u.Id = o.UserId
group by p.Id, p.ProductName having COUNT(distinct u.Id) >= 2

--7️⃣ Products that were never ordered
--Show: ProductId, ProductName
select p.Id, p.ProductName from Products p
left join OrderProducts op on p.Id = op.ProductId
where op.ProductId is null

select p.Id, p.ProductName from Products p where
not exists(
    select 1 from OrderProducts op where p.Id = op.ProductId
    )
--8️⃣ Orders containing both Mouse and Keyboard
--Show: OrderId

select o.Id from Orders o
where exists(
    select 1 from Products p
    join OrderProducts op on p.Id = op.ProductId
    where o.Id = op.OrderId and p.ProductName = 'Mouse')
and exists(
  select 1 from Products p
    join OrderProducts op on p.Id = op.ProductId
    where o.Id = op.OrderId and p.ProductName = 'Keyboard')

select op.OrderId from OrderProducts op
join Products p on p.Id = op.ProductId
where p.ProductName in ('Mouse', 'Keyboard')
group by op.OrderId having COUNT(distinct p.ProductName) = 2

--9️⃣ Users who ordered at least 3 different products
--Show: UserId, FullName, ProductCount

select u.Id, u.FullName, COUNT(distinct p.Id) as ProductCount from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on o.Id = op.OrderId
join Products p on p.Id = op.ProductId
group by u.Id, u.FullName having COUNT(distinct p.Id) >= 3

--🔟 Orders with exactly 2 different products
--Show: OrderId

select op.OrderId from OrderProducts op
group by op.OrderId having count(distinct op.ProductId) = 2

--1️⃣ Users who ordered more than 5 total items (sum of quantities)
--Show: UserId, FullName, TotalQuantity

select u.Id, u.FullName, SUM(op.Quantity) as TotalQuantity from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on o.Id = op.OrderId
group by u.Id, u.FullName having sum(op.Quantity) > 5

--2️⃣ Orders where any product quantity > 3
--Show: OrderId, ProductId, Quantity

select op.OrderId, op.ProductId, op.Quantity from OrderProducts op where op.Quantity > 3

--3️⃣ Products ordered in at least 3 different orders
--Show: ProductId, ProductName, OrderCount
select p.Id, p.ProductName, COUNT(distinct o.Id) as OrderCount from Products p
join OrderProducts op on op.ProductId = p.Id
join Orders o on o.Id = op.OrderId
group by p.Id, p.ProductName having COUNT(distinct o.Id) >= 3

--4️⃣ Users who ordered more than 2 different product categories
--Show: UserId, FullName, CategoryCount

select u.Id, u.FullName, COUNT(distinct op.ProductId) as CategoryCount from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on o.Id = op.OrderId
group by u.Id, u.FullName having COUNT(distinct op.ProductId) > 2

--5️⃣ Orders whose total value is greater than 1000
--Show: OrderId, TotalValue
select Id, TotalAmount as TotalValue from Orders where TotalAmount > 1000

--6️⃣ Users whose average order value > 500
--Show: UserId, FullName, AvgOrderValue

select u.Id, u.FullName, avg(o.TotalAmount) as AvgOrderValue from Users u
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName having avg(o.TotalAmount) > 500

--🔟 Products that were never ordered together with Mouse
--Show: ProductId, ProductName

select p.Id, p.ProductName from Products p
where exists(
    select 1 from OrderProducts op where p.Id = op.ProductId and p.ProductName <> 'Mouse'
    )

--    9️⃣ Users who ordered the same product more than once
--(across different orders)
--Show: UserId, ProductId, OrderCount

select u.Id, op.ProductId, COUNT(distinct o.Id) as OrderCount from Users u
join Orders o on o.UserId = u.Id
join OrderProducts op on op.OrderId = u.Id
group by u.Id, op.ProductId having count(distinct o.Id) > 1

--8️⃣ Orders where all products cost more than 200
--Show: OrderId
select op.OrderId from OrderProducts op
join Products p on p.Id = op.ProductId
group by op.OrderId having min(p.Price) > 200

--7️⃣ Products that were ordered by exactly one user
--Show: ProductId, ProductName

select p.Id, p.ProductName from Products p
join OrderProducts op on p.Id = op.ProductId
join Orders o on o.Id = op.OrderId
group by p.Id, p.ProductName having count(distinct o.UserId) = 1

--🟠 Task 1 — Orders where ALL product quantities > 3
select op.OrderId from OrderProducts op

--8️⃣ Orders where all products cost more than 200
--Show: OrderId
select o.Id from Orders o
join OrderProducts op on o.Id = op.OrderId
join Products p on p.Id = op.ProductId
group by o.Id having min(p.Price) > 200

--9️⃣ Users who ordered the same product more than once
--(across different orders)
--Show: UserId, ProductId, OrderCount
select o.UserId, op.ProductId, COUNT(distinct o.Id) as OrderCount from Orders o
join OrderProducts op on op.OrderId = o.Id
group by o.UserId, op.ProductId having count(distinct o.Id) > 1

--🔟 Products that were never ordered together with Mouse
--Show: ProductId, ProductName
SELECT p.Id, p.ProductName
FROM Products p
WHERE p.ProductName <> 'Mouse'
AND NOT EXISTS (
    SELECT 1
    FROM OrderProducts op1
    JOIN OrderProducts op2 
        ON op1.OrderId = op2.OrderId
    JOIN Products pm 
        ON pm.Id = op1.ProductId
    WHERE pm.ProductName = 'Mouse'
    AND op2.ProductId = p.Id
);

--11️⃣ Users who placed orders in more than one month
--📌 Return users who have orders in at least 2 different months.
--Show: UserId FullName MonthCount
select u.Id, u.FullName, COUNT(DISTINCT FORMAT(o.OrderDate, 'yyyy-MM')) as MonthCount from Users u
join Orders o on u.Id = o.UserId
group by u.Id, u.FullName having COUNT(DISTINCT FORMAT(o.OrderDate, 'yyyy-MM')) >= 2

--12️⃣ Products with total sold quantity greater than 20 📌 Sum all quantities per product.
--Show: ProductId ProductName TotalSoldQuantity  🧠 Tests: SUM(), grouping
select p.Id, p.ProductName, sum(op.Quantity) as TotalSoldQuantity from Products p
join OrderProducts op on p.Id = op.ProductId
group by p.Id, p.ProductName having sum(op.Quantity) > 20

--13️⃣ Orders whose total value is greater than the average order value

--📌 Calculate order total (Price × Quantity).
--Return orders above global average.
--Show:
--OrderId
--TotalValue
--🧠 Tests: aggregate vs aggregate comparison
