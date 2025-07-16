--Find the total sales per customer along with productID details
WITH
  cte_total_sales AS (
    SELECT
      CustomerID,
      ProductID,
      SUM(Sales) OVER (
        PARTITION BY
          CustomerID
      ) AS totalsalesbycustomer
    FROM
      SalesDB.Sales.Orders
  )
SELECT
  c.CustomerID,
  p.ProductID,
  c.FirstName,
  c.LastName,
  cts.totalsalesbycustomer
FROM
  SalesDB.Sales.Customers c
  LEFT JOIN cte_total_sales cts ON c.CustomerID = cts.CustomerID
  LEFT JOIN SalesDB.Sales.Products p ON p.ProductID = cts.ProductID
WHERE
  cts.totalsalesbycustomer > 200;

--Subquery for comparison
SELECT
  c.CustomerID,
  c.FirstName,
  c.LastName,
  t.totalsalesbycustomer
FROM
  SalesDB.Sales.Customers c
  LEFT JOIN (
    SELECT
      CustomerID,
      ProductID,
      SUM(Sales) OVER (
        PARTITION BY
          CustomerID
      ) AS totalsalesbycustomer
    FROM
      SalesDB.Sales.Orders
  ) t ON c.CustomerID = t.CustomerID
  LEFT JOIN SalesDB.Sales.Products p ON p.ProductID = t.ProductID
WHERE
  t.totalsalesbycustomer > 200;