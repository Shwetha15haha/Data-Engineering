-- Rules of SET Operators : UNION, INTERSECT, EXCEPT
-- 1. Order by can be used only once  i.e at the end of query
-- 2. Same number of columns selected in queries
-- 3. Data type of columns selected must match
-- 4. Order of columns should be same
-- 5. First query controls aliases
-- Result can be incorrect if you match different columns even if it matches all above rules as it doesn't evaluate content itself
--UNION
--Returns distinct result set from both quries
--Removes duplicates from result set
SELECT
  FirstName,
  LastName
FROM
  Sales.Customers
UNION
SELECT
  FirstName,
  LastName
FROM
  Sales.Employees;

-- Combine data from Orders and OrdersArchive without producing duplicates
SELECT
  'Orders' as Tablename,
  ProductID,
  CustomerID,
  SalesPersonID,
  OrderDate,
  ShipDate,
  OrderStatus,
  ShipAddress,
  BillAddress,
  Quantity,
  Sales,
  CreationTime
FROM
  SalesDB.Sales.Orders
UNION
SELECT
  'OrdersArchive' as Tablename,
  ProductID,
  CustomerID,
  SalesPersonID,
  OrderDate,
  ShipDate,
  OrderStatus,
  ShipAddress,
  BillAddress,
  Quantity,
  Sales,
  CreationTime
FROM
  SalesDB.Sales.OrdersArchive;

--UNION ALL
--Returns all rows including duuplicates
SELECT
  FirstName,
  LastName
FROM
  Sales.Customers
UNION ALL
SELECT
  FirstName,
  LastName
FROM
  Sales.Employees;

--UNION ALL is faster than UNION
--EXCEPT
--Return rows that are not in second query
--Delta catchup
--Data completeness check
SELECT
  FirstName,
  LastName
FROM
  Sales.Customers
EXCEPT
SELECT
  FirstName,
  LastName
FROM
  Sales.Employees;

--INTERSECT
--Return rows that are found in both query sets
SELECT
  FirstName,
  LastName
FROM
  Sales.Customers
INTERSECT
SELECT
  FirstName,
  LastName
FROM
  Sales.Employees;