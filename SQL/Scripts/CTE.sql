--Standalone CTE
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

--Find the total sales per customer
WITH
  cte_total_sales AS (
    SELECT
      CustomerID,
      SUM(Sales) totalsales
    FROM
      SalesDB.Sales.Orders
    GROUP BY
      CustomerID
      -- ORDER BY
      --   totalsales can't use 
  ),
  --Find the last order date per customer
  cte_last_order_date AS (
    SELECT
      CustomerID,
      MAX(OrderDate) lastorder
    FROM
      SalesDB.Sales.Orders
    GROUP BY
      CustomerID
  ),
  --Nested CTE: CTE inside another CTE
  --Can't be run independently
  --Rank customers based on Total sales per customer
  cte_rank_customers AS (
    SELECT
      *,
      RANK() OVER (
        ORDER BY
          totalsales DESC
      ) rn
    FROM
      cte_total_sales
  ),
  --Segment the customers based on their total sales
  cte_customer_segment AS (
    SELECT
      *,
      CASE
        WHEN totalsales > 100 THEN 'High'
        WHEN totalsales > 80 THEN 'Medium'
        ELSE 'Low'
      END segment
    FROM
      cte_total_sales
  )
SELECT
  crc.rn,
  c.CustomerID,
  c.FirstName,
  c.LastName,
  cts.totalsales,
  clod.lastorder,
  ccs.segment
FROM
  SalesDB.Sales.Customers c
  LEFT JOIN cte_total_sales cts ON c.CustomerID = cts.CustomerID
  LEFT JOIN cte_last_order_date clod ON c.CustomerID = clod.CustomerID
  LEFT JOIN cte_rank_customers crc ON c.CustomerID = crc.CustomerID
  LEFT JOIN cte_customer_segment ccs ON c.CustomerID = ccs.CustomerID
ORDER BY
  cts.totalsales DESC;

--Recursive query
--Looping or iterating until it meets condition
--Anchor query, Recursive query
;

--Generate a sequence of numbers from 1 to 20
WITH
  number_sequence AS (
    --Anchor query
    SELECT
      1 cnst
    UNION ALL
    --Recursive query
    SELECT
      cnst + 1
    FROM
      number_sequence
    WHERE
      cnst < 30000
  )
SELECT
  *
FROM
  number_sequence OPTION (MAXRECURSION 32767);

--Generate a sequence of numbers from 100 to 1
WITH
  number_sequence AS (
    --Anchor query
    SELECT
      100 cnst
    UNION ALL
    --Recursive query
    SELECT
      cnst - 1
    FROM
      number_sequence
    WHERE
      cnst > 1
  )
SELECT
  *
FROM
  number_sequence;

--Show the employees heirarchy by dispalying each employee's level with the organization
WITH
  heirarchy AS (
    --Anchor query
    SELECT
      EmployeeID,
      FirstName,
      ManagerID,
      1 AS LEVEL
    FROM
      SalesDB.Sales.Employees
    WHERE
      ManagerID IS NULL
    UNION ALL
    --Recursive query
    SELECT
      e.EmployeeID,
      e.FirstName,
      e.ManagerID,
      LEVEL + 1
    FROM
      SalesDB.Sales.Employees e
      INNER JOIN heirarchy h ON e.ManagerID = h.EmployeeID
  )
SELECT
  *
FROM
  heirarchy;