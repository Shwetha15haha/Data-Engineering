--Combine two tables data through combining their columns
--INNER JOIN
--Returns only matching data from both the tables
SELECT
  *
FROM
  customers c
  INNER JOIN orders o ON c.id = o.customer_id;

SELECT
  id,
  first_name,
  country,
  order_id,
  sales
FROM
  customers c
  INNER JOIN orders o ON c.id = o.customer_id;

SELECT
  c.id,
  c.first_name,
  c.country,
  o.order_id,
  o.sales
FROM
  customers c
  INNER JOIN orders o ON c.id = o.customer_id;

--Duplicates in result possible for below cases
-- - Duplicates in Either Table's Join Column – If the column in the ON clause has repeated values in either table, matching rows will appear multiple times.
-- - Duplicates in Both Tables' Join Columns – If both tables have duplicates in the join column, the result set multiplies even more.
-- - Multiple Columns in the ON Clause – If multiple columns are used in the ON condition and they have duplicate combinations, more matches will be generated.
-- - Unintended Join Multiplication – If the join condition is too broad (e.g., matching based on a general attribute like "region"), it may lead to excessive duplicates.
-- To prevent unintended duplicates:
-- - Use DISTINCT to filter out repeated rows.
-- - Apply aggregation (GROUP BY) to consolidate duplicates.
-- - Ensure unique relationships between the tables.
--LEFT JOIN
--All rows from left table and matching rows from right table
--order of table matters
SELECT
  c.id,
  c.first_name,
  c.country,
  o.order_id,
  o.sales
FROM
  customers c
  LEFT JOIN orders o ON c.id = o.customer_id;

--RIGHT JOIN
SELECT
  c.id,
  c.first_name,
  c.country,
  o.order_id,
  o.sales
FROM
  customers c
  RIGHT JOIN orders o ON c.id = o.customer_id;

--FULL JOIN
SELECT
  c.id,
  c.first_name,
  c.country,
  o.order_id,
  o.sales
FROM
  customers c
  FULL JOIN orders o ON c.id = o.customer_id;

--LEFT ANTI JOIN
--Returns rows from left table that has no match in right table
--Use case: Fetch list of customers who didn't order
SELECT
  *
FROM
  MyDatabase.dbo.customers c
  LEFT JOIN MyDatabase.dbo.orders o ON c.id = o.customer_id
WHERE
  o.customer_id IS NULL;

--RIGHT ANTI JOIN
--Returns rows from right table that has no match in left table
--Use case: get orders without matching customers
SELECT
  *
FROM
  MyDatabase.dbo.customers c
  RIGHT JOIN MyDatabase.dbo.orders o ON c.id = o.customer_id
WHERE
  c.id IS NULL;

--OR
SELECT
  *
FROM
  MyDatabase.dbo.orders o
  LEFT JOIN MyDatabase.dbo.customers c ON c.id = o.customer_id
WHERE
  c.id IS NULL;

--FULL ANTI JOIN
--Opposite of inner join
--Returns data thet doen't match in either tables
--Use case : Find customers without orders and orders without customers
SELECT
  *
FROM
  MyDatabase.dbo.customers c
  FULL JOIN MyDatabase.dbo.orders o ON c.id = o.customer_id
WHERE
  c.id IS NULL
  OR o.customer_id IS NULL;

--Get all customers along with orders , but only for customers who have order Without using Inner join
SELECT
  *
FROM
  MyDatabase.dbo.customers c
  FULL JOIN MyDatabase.dbo.orders o ON c.id = o.customer_id
WHERE
  o.customer_id IS NOT NULL;

SELECT
  *
FROM
  MyDatabase.dbo.customers c
  LEFT JOIN MyDatabase.dbo.orders o ON c.id = o.customer_id
WHERE
  o.customer_id IS NOT NULL;

SELECT
  *
FROM
  MyDatabase.dbo.customers c
  CROSS JOIN MyDatabase.dbo.orders o;

--CROSS JOIN
--Each row from right table combines with each row in left table
--2 rows in A, 3 rows in B produces 6 rows output. Here it doesn't matter whether it is matching or not. There is no matching column to specifiy.
-- Imagine students in a school and sports they play.
-- - FULL JOIN: Matches students with their sports. If a student doesn’t play a sport, their name appears with NULL. If a sport has no players, it still appears with NULL.
-- - CROSS JOIN: Pairs every student with every sport, even if they don’t actually play that sport—just listing all possible combinations!
-- CROSS JOIN = One - to - Many (All Pairings)
-- FULL JOIN = One - to - One
-- or One - to - None (
--   Matching
--   where
--     possible,
--     NULLs
--   where
--     missing
-- )
--MULTIPLE  TABLE JOINS
SELECT
  o.OrderID,
  o.Sales,
  c.FirstName CustomerFirstName,
  c.LastName CustomerLastName,
  p.Product as ProductName,
  p.Price,
  e.FirstName EmployeeFirstName,
  e.LastName EmployeeLastName
FROM
  Sales.Orders o
  LEFT JOIN Sales.Customers c ON o.CustomerID = c.CustomerID
  LEFT JOIN Sales.Products p ON o.ProductID = p.ProductID
  LEFT JOIN Sales.Employees e ON o.SalesPersonID = e.EmployeeID;