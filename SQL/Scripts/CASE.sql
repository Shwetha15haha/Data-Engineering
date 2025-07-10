--Evaluate the conditions and when the condition is met then return the result for that.
-- CASE
--   WHEN condition1 THEN result1
--   WHEN condition1 THEN result1
--   ELSE result
-- END
--Data type of result for each conditions should be same
--Use case: Data transformation: Creating new columns, creating categories for analytics
SELECT
  Category,
  SUM(Sales) TotalSales
FROM
  (
    SELECT
      OrderID,
      Sales,
      CASE
        WHEN Sales > 50 THEN 'High'
        WHEN Sales > 20 THEN 'Medium'
        ELSE 'Low'
      END Category
    FROM
      SalesDB.Sales.Orders
  ) t
GROUP BY
  Category
Order by
  TotalSales desc,
  Category;

--Use case: Mapping : Transform the value from one form to another
--Retrieve employee details where gender displayed as full text
SELECT
  *,
  CASE
    WHEN Gender = 'M' THEN 'Male'
    WHEN Gender = 'F' THEN 'Female'
    ELSE 'Not Available'
  END GenderFullText
FROM
  SalesDB.Sales.Employees;

--Retrieve customer details with abbreviated country code
SELECT
  *,
  CASE
    WHEN Country = 'Germany' THEN 'Ger'
    WHEN Country = 'USA' THEN 'US'
    ELSE 'Not Available'
  END CountryCode
FROM
  SalesDB.Sales.Customers;

--Second format
SELECT
  *,
  CASE Country
    WHEN 'Germany' THEN 'Ger'
    WHEN 'USA' THEN 'US'
    ELSE 'Not Available'
  END CountryCode
FROM
  SalesDB.Sales.Customers;

--Use case: Handling nulls
--Over is used when you want to get aggregation on row level details
SELECT
  CustomerID,
  LastName,
  AVG(
    CASE
      WHEN Score IS NULL THEN 0
      ELSE Score
    END
  ) OVER () Avgscoreclean
FROM
  SalesDB.Sales.Customers;

--Count how many times each customer has made an order with sales greater than 30.
SELECT
  CustomerID,
  SUM(
    CASE
      WHEN Sales > 30 THEN 1
      ELSE 0
    END
  ) Totalordershighsales,
  COUNT(*) Totalorders
FROM
  SalesDB.Sales.Orders
GROUP BY
  CustomerID;

--Notice the difference between two statements
SELECT
  CustomerID,
  Count(*)
FROM
  SalesDB.Sales.Orders
WHERE
  Sales > 30
GROUP BY
  CustomerID
ORDER BY
  CustomerID