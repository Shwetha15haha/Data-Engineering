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