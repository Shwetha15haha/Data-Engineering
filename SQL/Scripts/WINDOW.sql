--Aggregating without losing level of details(Row level calculations
--Returns result for each row
--Find the total sales across all orders
SELECT
  SUM(Sales) total_sales
FROM
  SalesDB.Sales.Orders;

--Find the total sales for each product
SELECT
  ProductID,
  SUM(Sales) total_sales
FROM
  SalesDB.Sales.Orders
GROUP BY
  ProductID;

--Find the total sales across all orders , along with orderid and orderdate
SELECT
  OrderID,
  OrderDate,
  SUM(Sales) OVER () TotalsSales
FROM
  SalesDB.Sales.Orders;

--Find the total sales for each product , along with orderid and orderdate
SELECT
  OrderID,
  OrderDate,
  ProductID,
  SUM(Sales) OVER (
    PARTITION BY
      ProductID
  ) Totalsalesbyproduct
FROM
  SalesDB.Sales.Orders;

SELECT
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  SUM(Sales) OVER () TotalsSales,
  SUM(Sales) OVER (
    PARTITION BY
      ProductID
  ) Totalsalesbyproduct,
  SUM(Sales) OVER (
    PARTITION BY
      ProductID,
      OrderStatus
  ) SalesbyProdudctAndStatus
FROM
  SalesDB.Sales.Orders;

--Ranking
SELECT
  OrderID,
  Sales,
  ProductID,
  RANK() OVER (
    ORDER BY
      Sales desc
  ) RankbyHighestSales,
  RANK() OVER (
    PARTITION BY
      ProductID
    ORDER BY
      Sales desc
  ) RankbyProduct
FROM
  SalesDB.Sales.Orders;

SELECT
  OrderID,
  OrderDate,
  OrderStatus,
  Sales,
  SUM(Sales) OVER (
    PARTITION BY
      OrderStatus
    ORDER BY
      OrderDate ROWS BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW
  ) Totalsales
FROM
  SalesDB.Sales.Orders;

--Rank the customers based on their total sales
SELECT
  CustomerID,
  SUM(Sales) Totalsales,
  RANK() Over (
    ORDER BY
      SUM(Sales) DESC
  ) rankbytotalsales
FROM
  SalesDB.Sales.Orders
GROUP BY
  CustomerID;

--COUNT in window functions
SELECT
  OrderID,
  COUNT(*) OVER (
    ORDER BY
      OrderID
  ) total_orders,
  ProductID,
  OrderStatus,
  COUNT(*) OVER (
    PARTITION BY
      ProductID
  ) totalordersbyproduct
FROM
  SalesDB.Sales.Orders;

--Find the total number of customers
--Find the total number of scores for the customers
--Additionally provide all customer details
SELECT
  *,
  COUNT(*) OVER () totalcustomers,
  COUNT(Score) OVER () totalnoscore
FROM
  SalesDB.Sales.Customers;

--Check whether the table 'Orders' contains any duplicate
SELECT
  OrderID,
  COUNT(*) OVER (
    PARTITION BY
      OrderID
  )
FROM
  SalesDB.Sales.Orders;

SELECT
  *
FROM
  (
    SELECT
      OrderID,
      COUNT(*) OVER (
        PARTITION BY
          OrderID
      ) duplicatecount
    FROM
      SalesDB.Sales.OrdersArchive
  ) t
WHERE
  duplicatecount > 1;

--Find total sales across all orders
--Find total sales for each product
--Additionally provide details like orderid, orderdate
SELECT
  OrderID,
  OrderDate,
  SUM(Sales) OVER () Totalsales,
  ProductID,
  SUM(Sales) OVER (
    PARTITION BY
      ProductID
  ) salesbyproduct
FROM
  SalesDB.Sales.Orders;

--Part to whole analysis: compare current sales with total sales
--Find the percentage contribution of each product's sales to the total sales
SELECT
  OrderId,
  ProductID,
  Sales,
  SUM(Sales) OVER () totalsales,
  ROUND(
    ((CAST(Sales AS Float) / SUM(Sales) OVER ()) * 100),
    2
  ) percentage
FROM
  SalesDB.Sales.Orders;

--Find AVG sales across all orders
--Find AVG sales for each product
--Additionally provide details like orderid, orderdate
SELECT
  OrderID,
  OrderDate,
  AVG(Sales) OVER () avgsales,
  ProductID,
  AVG(COALESCE(Sales, 0)) OVER (
    PARTITION BY
      ProductID
  ) avgsalesbyproduct
FROM
  SalesDB.Sales.Orders;

--For customer table
SELECT
  *,
  avg(coalesce(Score, 0)) OVER () totalnoscore
FROM
  SalesDB.Sales.Customers;

--Find all the orders where sales are higher than the avg sales across all orders
SELECT
  *
FROM
  (
    SELECT
      OrderID,
      Sales,
      AVG(COALESCE(Sales, 0)) OVER () avgsales
    FROM
      SalesDB.Sales.Orders
  ) t
WHERE
  Sales > avgsales;

--Find highest and lowest sales across all orders
--Find highest and lowest sales for each product
--Additionally provide orderid, orderdate details
SELECT
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  MAX(Sales) OVER () maxsale,
  MIN(Sales) OVER () minsale,
  MAX(Sales) OVER (
    PARTITION BY
      ProductID
  ) highsalebyproduct,
  MIN(Sales) OVER (
    PARTITION BY
      ProductID
  ) lowsalebyproduct
FROM
  SalesDB.Sales.Orders;

--show the employee who has the highest salary
SELECT
  *
FROM
  (
    SELECT
      *,
      MAX(Salary) OVER () highestsalary
    FROM
      SalesDB.Sales.Employees
  ) t
WHERE
  Salary = highestsalary;

--Find the deviation of each sales from minimum and maximum sales amount
SELECT
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  MAX(Sales) OVER () maxsale,
  MIN(Sales) OVER () minsale,
  Sales - MIN(Sales) OVER (),
  Sales - MAX(Sales) OVER ()
FROM
  SalesDB.Sales.Orders;

--Running total
-- SUM(Sales) OVER (
--   Order by
--     Month
-- ) 
--Default
--ROWS BETWEEN UNBOUNDED PRECEDING
-- AND CURRENT ROW
--Rolling total
-- SUM(Sales) OVER (
--   Order by
--     MONTH
-- ROWS BETWEEN PRECEDING 2
-- AND CURRENT ROW )
;

--Calculate moving average of sales for each product over time
SELECT
  OrderId,
  ProductID,
  OrderDate,
  Sales,
  AVG(Sales) OVER (
    PARTITION BY
      ProductID
  ) AvgSalesProduct,
  AVG(Sales) OVER (
    PARTITION BY
      ProductID
    ORDER BY
      OrderDate
  ) movingavg,
  AVG(Sales) OVER (
    PARTITION BY
      ProductID
    ORDER BY
      OrderDate ROWS BETWEEN CURRENT ROW
      AND 1 FOLLOWING
  ) rollingavg
FROM
  SalesDB.Sales.Orders;

--Rank the orders based on their sales from highest to lowest
SELECT
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  ROW_NUMBER() OVER (
    ORDER BY
      Sales DESC
  ) Salesrow_no,
  RANK() OVER (
    ORDER BY
      Sales DESC
  ) Salesrank_no,
  DENSE_RANK() OVER (
    ORDER BY
      Sales DESC
  ) Salesdenserank
FROM
  SalesDB.Sales.Orders;

--Find the top highest sales for each product
--Which function to use for top sale that is repeating, like 2 products have same highest sales?
SELECT
  *
FROM
  (
    SELECT
      OrderID,
      OrderDate,
      ProductID,
      Sales,
      ROW_NUMBER() OVER (
        PARTITION BY
          ProductID
        ORDER BY
          Sales DESC
      ) Salesrow_no
    FROM
      SalesDB.Sales.Orders
  ) t
WHERE
  Salesrow_no = 1;

--Find the bottom 2 customers based on their total sales
SELECT
  *
FROM
  (
    SELECT
      CustomerID,
      SUM(Sales) total_sales,
      ROW_NUMBER() OVER (
        ORDER BY
          SUM(Sales) ASC
      ) salesrank
    FROM
      SalesDB.Sales.Orders
    GROUP BY
      CustomerID
  ) t
WHERE
  salesrank <= 2;

--Assign new unique Ids
SELECT
  ROW_NUMBER() OVER (
    ORDER BY
      OrderID
  ) unique_id,
  *
FROM
  SalesDB.Sales.OrdersArchive;

--Identify duplicate rows
SELECT
  *
FROM
  (
    SELECT
      ROW_NUMBER() OVER (
        PARTITION BY
          OrderID
        ORDER BY
          CreationTime DESC
      ) rn,
      *
    FROM
      SalesDB.Sales.OrdersArchive
  ) t
WHERE
  rn = 1;

--Find the products that fall within the highest 40% of the prices
SELECT
  *
FROM
  (
    SELECT
      Product,
      Price,
      CUME_DIST() OVER (
        ORDER BY
          Price DESC
      ) DistRank
    FROM
      SalesDB.Sales.Products
  ) t
WHERE
  DistRank <= 0.4;

SELECT
  *
FROM
  (
    SELECT
      Product,
      Price,
      PERCENT_RANK() OVER (
        ORDER BY
          Price DESC
      ) DistRank
    FROM
      SalesDB.Sales.Products
  ) t
WHERE
  DistRank <= 0.4;

--NTILE
SELECT
  OrderID,
  Sales,
  NTILE (3) OVER (
    Order by
      Sales DESC
  ) buckets
FROM
  SalesDB.Sales.Orders;

--Segment all orders into 3 categories:high,medium, and low
SELECT
  *,
  CASE
    WHEN buckets = 1 THEN 'High'
    WHEN buckets = 2 THEN 'Medium'
    WHEN buckets = 3 THEN 'Low'
  END sgments
FROM
  (
    SELECT
      Sales,
      NTILE (3) OVER (
        ORDER BY
          Sales DESC
      ) buckets
    FROM
      SalesDB.Sales.Orders
  ) t;

--LOAD balancing in ETL
SELECT
  NTILE (2) OVER (
    ORDER BY
      OrderId
  ) buckets,
  *
FROM
  SalesDB.Sales.Orders;