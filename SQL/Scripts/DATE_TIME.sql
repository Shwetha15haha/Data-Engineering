SELECT
  OrderDate,
  CreationTime,
  YEAR (CreationTime) Year,
  DAY (CreationTime) Day,
  MONTH (CreationTime) Month
FROM
  SalesDB.Sales.Orders;