--Extract parts from date
SELECT
  OrderDate,
  CreationTime,
  YEAR (CreationTime) Year,
  DAY (CreationTime) Day,
  MONTH (CreationTime) Month
FROM
  SalesDB.Sales.Orders;

--DATEPART
--To extract more informations like week, quarter etc
--Datatype of output is integer
SELECT
  OrderDate,
  CreationTime,
  DATEPART (YEAR, CreationTime) Year,
  DATEPART (DAY, CreationTime) Day,
  DATEPART (MONTH, CreationTime) Month,
  DATEPART (HOUR, CreationTime) Hour,
  DATEPART (QUARTER, CreationTime) Quarter,
  DATEPART (WEEK, CreationTime) Week
FROM
  SalesDB.Sales.Orders;

--DATENAME
--Get name of the parts
--Datatype of output is string type
SELECT
  OrderDate,
  CreationTime,
  DATENAME (YEAR, CreationTime) Year,
  DATENAME (WEEKDAY, CreationTime) Weekday,
  DATENAME (MONTH, CreationTime) Month,
  DATENAME (HOUR, CreationTime) Hour,
  DATENAME (QUARTER, CreationTime) Quarter,
  DATENAME (WEEK, CreationTime) Week
FROM
  SalesDB.Sales.Orders;

--DATETRUNC
--To reset a time part to 00 and to reset date part to 01
SELECT
  OrderID,
  CreationTime,
  DATETRUNC (YEAR, CreationTime) Year,
  DATETRUNC (MONTH, CreationTime) Month,
  DATETRUNC (Day, CreationTime) Day,
  DATETRUNC (HOUR, CreationTime) Hour,
  DATETRUNC (MINUTE, CreationTime) Minute,
  DATETRUNC (SECOND, CreationTime) Second
FROM
  SalesDB.Sales.Orders;

--Use case: based on granularity, you can aggregate data
--Check below example how aggregation is more valuable when we decrease the granularity
SELECT
  CreationTime,
  COUNT(*)
FROM
  SalesDB.Sales.Orders
GROUP BY
  CreationTime;

SELECT
  DATETRUNC (YEAR, CreationTime),
  COUNT(*)
FROM
  SalesDB.Sales.Orders
GROUP BY
  DATETRUNC (YEAR, CreationTime);