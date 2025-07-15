-- -- List all tables in the current database
-- SELECT
--   *
-- FROM
--   INFORMATION_SCHEMA.TABLES;
-- -- List all columns in a specific table
-- SELECT
--   *
-- FROM
--   INFORMATION_SCHEMA.COLUMNS
-- WHERE
--   TABLE_NAME = 'YourTableName';
-- -- List all constraints
-- SELECT
--   *
-- FROM
--   INFORMATION_SCHEMA.TABLE_CONSTRAINTS;
--SUBQUERY: A query inside another query
--ROW TYPE 
--Scalar query : Returns single record
SELECT
  AVG(Sales)
FROM
  SalesDB.Sales.Orders;

--Row query : Returns multiple rows
SELECT
  CustomerID
FROM
  SalesDB.Sales.Orders;

--Table query : Returns multiple rows,columns
SELECT
  *
FROM
  SalesDB.Sales.Orders;

--Subquery in FROM clause
--Find the products that have price higher than the average price of all products
SELECT
  * --Main Query
FROM
  (
    SELECT
      ProductID,
      Price,
      AVG(Price) OVER () avgprice --Subquery
    FROM
      SalesDB.Sales.Products
  ) t
WHERE
  Price > avgprice;

--Rank the customers based on their total amount of sales
SELECT
  RANK() OVER (
    ORDER BY
      totalsalesbycustomer DESC
  ) rank,
  *
FROM
  (
    SELECT
      CustomerID,
      SUM(Sales) totalsalesbycustomer
    FROM
      SalesDB.Sales.Orders
    GROUP BY
      CustomerID
  ) t;

--Subquery in SELECT clause
--Show the Product Ids,names,prices and total number of orders
SELECT
  ProductID,
  Product,
  Price,
  (
    SELECT
      COUNT(*)
    FROM
      SalesDB.Sales.Orders --subquery which must be a scalar query
  ) totalorders
FROM
  SalesDB.Sales.Products;

--Subquery in JOIN clause
--Show all the customer details and find total orders of each customer
SELECT
  *
FROM
  SalesDB.Sales.Orders;

SELECT
  c.*,
  o.totalorders
FROM
  SalesDB.Sales.Customers c
  LEFT JOIN (
    SELECT
      CustomerID,
      COUNT(*) totalorders
    FROM
      SalesDB.Sales.Orders
    GROUP BY
      CustomerID
  ) o ON c.CustomerID = o.CustomerID;

--Subquery in WHERE clause
--Find the products that have a price higher than the average price of all products
SELECT
  *
FROM
  SalesDB.Sales.Products
WHERE
  Price > (
    SELECT
      AVG(Price) avgprice --subquery which must be scalar query    
    FROM
      SalesDB.Sales.Products
  );

--Subquery in WHERE Clause IN operator
--Show the orders made by customers in Germany
SELECT
  *
FROM
  SalesDB.Sales.Orders
WHERE
  CustomerID IN (
    SELECT
      CustomerID
    FROM
      SalesDB.Sales.Customers
    WHERE
      Country = 'Germany'
  );

--NOT IN
SELECT
  *
FROM
  SalesDB.Sales.Orders
WHERE
  CustomerID NOT IN (
    SELECT
      CustomerID
    FROM
      SalesDB.Sales.Customers
    WHERE
      Country = 'Germany'
  );

--ALL/ANY
--Find female employees having salary greater than male employees
SELECT
  EmployeeID,
  FirstName Gender,
  Salary
FROM
  SalesDB.Sales.Employees
WHERE
  Gender = 'F'
  AND Salary > ANY (
    SELECT
      Salary
    FROM
      SalesDB.Sales.Employees
    WHERE
      Gender = 'M'
  );

SELECT
  EmployeeID,
  FirstName Gender,
  Salary
FROM
  SalesDB.Sales.Employees
WHERE
  Gender = 'F'
  AND Salary > ALL (
    SELECT
      Salary
    FROM
      SalesDB.Sales.Employees
    WHERE
      Gender = 'M'
  );

--Correlated subquery
--Show all customer details and find the total orders for each customer
SELECT
  *,
  (
    SELECT
      COUNT(*)
    FROM
      SalesDB.Sales.Orders o
    WHERE
      o.CustomerID = c.CustomerID
  ) totalorders
FROM
  SalesDB.Sales.Customers c;

--Subquery using EXISTS:Correlated subquery in WHERE Clause
--Show the orders made by customers in Germany
SELECT
  *
FROM
  SalesDB.Sales.Orders o
WHERE
  EXISTS (
    SELECT
      CustomerID
    FROM
      SalesDB.Sales.Customers c
    WHERE
      Country = 'Germany'
      AND o.CustomerID = c.CustomerID
  );

SELECT
  *
FROM
  SalesDB.Sales.Orders o
WHERE
  NOT EXISTS (
    SELECT
      CustomerID
    FROM
      SalesDB.Sales.Customers c
    WHERE
      Country = 'Germany'
      AND o.CustomerID = c.CustomerID
  );