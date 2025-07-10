--Basic aggregation functions
SELECT
  CustomerID,
  COUNT(*) total_no_orders,
  SUM(Sales) total_sales,
  AVG(Sales) avg_sales,
  MAX(Sales) highest_sales,
  MIN(Sales) lowest_sales
FROM
  SalesDB.Sales.Orders
GROUP BY
  CustomerID;