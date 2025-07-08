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
--Output data type is DATETIME
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

--EOMONTH
--Last day of month
--Output datatype is DATE
SELECT
  OrderID,
  CreationTime,
  EOMONTH (CreationTime)
FROM
  SalesDB.Sales.Orders;

--First day of month
SELECT
  OrderID,
  CreationTime,
  DATETRUNC (MONTH, CreationTime) Month
FROM
  SalesDB.Sales.Orders;

--Use case
--How many orders placed each year?
SELECT
  YEAR (OrderDate) Year,
  COUNT(*)
FROM
  SalesDB.Sales.Orders
GROUP BY
  YEAR (OrderDate);

--How many orders placed each month?
SELECT
  MONTH (OrderDate) Month,
  COUNT(*)
FROM
  SalesDB.Sales.Orders
GROUP BY
  MONTH (OrderDate);

SELECT
  DATENAME (MONTH, OrderDate) Month,
  COUNT(*)
FROM
  SalesDB.Sales.Orders
GROUP BY
  DATENAME (MONTH, OrderDate);

--hOw many orders placed in Febraury month?
--Here use integer for filtering using MONTH function, avoid using DATENAME which gives string type output
--for easy search by query analyser
SELECT
  *
FROM
  SalesDB.Sales.Orders
WHERE
  MONTH (OrderDate) = 2;

--FORMAT
SELECT
  OrderID,
  CreationTime,
  FORMAT (CreationTime, 'MM-dd-yyyy'),
  FORMAT (CreationTime, 'dd-MM-yyyy'),
  FORMAT (CreationTime, 'dd'),
  FORMAT (CreationTime, 'ddd'),
  FORMAT (CreationTime, 'dddd'),
  FORMAT (CreationTime, 'MM'),
  FORMAT (CreationTime, 'MMM'),
  FORMAT (CreationTime, 'MMMM')
FROM
  SalesDB.Sales.Orders;

--show creationtime using this format: Day Wed Jan Q1 2025 12:34:56 PM
SELECT
  CreationTime,
  'Day ' + FORMAT (CreationTime, 'ddd MMM ') + 'Q' + DATENAME (QUARTER, CreationTime) + ' ' + FORMAT (CreationTime, 'yyyy') + ' ' + FORMAT (CreationTime, 'hh:mm:ss tt')
FROM
  SalesDB.Sales.Orders;

--CONVERT
--one data type to another data type, formatting-styling
SELECT
  CONVERT(INT, '123'),
  CONVERT(DATE, '2025-07-05'),
  CONVERT(DATE, CreationTime),
  CONVERT(VARCHAR, CreationTime, 32),
  CONVERT(VARCHAR, CreationTime, 34)
FROM
  SalesDB.Sales.Orders;

--CAST
SELECT
  CAST('123' AS INT),
  CAST('123' AS VARCHAR),
  CAST('2025-07-05' AS DATE),
  CAST('2025-07-05' AS DATETIME);

--DATEADD
--Add dates,subtract dates
SELECT
  OrderDate,
  DATEADD (YEAR, 2, OrderDate),
  DATEADD (DAY, 2, OrderDate),
  DATEADD (DAY, -12, OrderDate)
FROM
  SalesDB.Sales.Orders;

--DATEDIFF
SELECT
  OrderDate,
  ShipDate,
  DATEDIFF (DAY, OrderDate, ShipDate)
FROM
  SalesDB.Sales.Orders;

SELECT
  EmployeeID,
  Birthdate,
  DATEDIFF (Year, Birthdate, GETDATE ())
FROM
  SalesDB.Sales.Employees;

--Find average shipping durations in days for each month
SELECT
  DATENAME (MONTH, OrderDate) month_name,
  AVG(DATEDIFF (DAY, OrderDate, ShipDate)) ship_durations
FROM
  SalesDB.Sales.Orders
GROUP BY
  DATENAME (MONTH, OrderDate);

--Find the number of days between each order and the previous order
SELECT
  OrderID,
  OrderDate current_orderdate,
  LAG (OrderDate) OVER (
    Order by
      OrderID
  ) previous_orderdate,
  DATEDIFF (
    DAY,
    (
      LAG (OrderDate) OVER (
        Order by
          OrderID
      )
    ),
    OrderDate
  ) gap
FROM
  SalesDB.Sales.Orders;

--ISDATE
--To check value is date or not
--Returns if string value is valid date
SELECT
  ISDATE ('123') Datecheck1;

SELECT
  ISDATE ('2025-07-08') Datecheck2;

SELECT
  ISDATE ('2025-20-08') Datecheck3;

SELECT
  ISDATE ('08-07-2025') Datecheck4;

SELECT
  ISDATE ('2025') Datecheck5;

SELECT
  ISDATE ('2025-08') Datecheck6;

SELECT
  ISDATE ('08') Datecheck7;

--Use case when casting if there is any string is not in correct dateformat then instaed of getting error, we flag and cast string that are in date format
SELECT
  OrderDate,
  ISDATE (OrderDate),
  CASE
    WHEN ISDATE (OrderDate) = 1 THEN CAST(OrderDate as DATE)
  END Newdate
FROM
  (
    SELECT
      '2025-08-07' AS OrderDate
    UNION
    SELECT
      '2025-08' --not in date format and hence casting will fail
    UNION
    SELECT
      '2025-08-20'
  ) t