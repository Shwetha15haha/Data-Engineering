-- step 1: write a query 
-- For US customers find total number of customers and the average score
SELECT
  COUNT(CustomerID) total_customers,
  AVG(Score) avgscore
FROM
  SalesDB.Sales.customers
WHERE
  Country = 'USA';
-- step 2: create a stored procedure
CREATE PROCEDURE GetUSCustomerStats AS BEGIN
SELECT
  COUNT(CustomerID) AS total_customers,
  AVG(Score) AS avgscore
FROM
  SalesDB.Sales.customers
WHERE
  Country = 'USA' END;
-- step 3: execute the stored procedure
EXEC GetUSCustomerStats;
--Parameters can be added to the stored procedure if needed
-- Example with parameters
CREATE PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50)
AS BEGIN
SELECT
  COUNT(CustomerID) AS total_customers,
  AVG(Score) AS avgscore
FROM
  SalesDB.Sales.customers
WHERE
  Country = @Country END;
EXEC GetCustomerStatsByCountry @Country='USA';
EXEC GetCustomerStatsByCountry @Country='Germany';

-- step 4: add default values to parameters
ALTER PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50) = 'USA'
AS BEGIN
SELECT
  COUNT(CustomerID) AS total_customers,
  AVG(Score) AS avgscore
FROM
  SalesDB.Sales.customers
WHERE
  Country = @Country END;

EXEC GetCustomerStatsByCountry ;

-- step 5: adding multiple queries to the stored procedure
ALTER PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50) = 'USA'
AS BEGIN
SELECT
  COUNT(CustomerID) AS total_customers,
  AVG(Score) AS avgscore
FROM
  SalesDB.Sales.customers
WHERE
  Country = @Country ;

SELECT COUNT(OrderID) totalorders,
SUM(Sales) as totalsales
FROM SalesDB.Sales.orders o
JOIN SalesDB.Sales.customers c
ON o.CustomerID = c.CustomerID
WHERE c.Country = @Country
END;

EXEC GetCustomerStatsByCountry ;

--Using variables in stored procedures
ALTER PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50) = 'USA'
AS BEGIN 
DECLARE @TotalCustomers INT;
DECLARE @AvgScore FLOAT;
SELECT
  @TotalCustomers = COUNT(CustomerID),
  @AvgScore = AVG(Score)
FROM
  SalesDB.Sales.customers
WHERE
  Country = @Country ;
-- Output the results, PRINT statement can have only string values
PRINT 'Total Customers for' + @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR(10));
PRINT 'Average score for' + @Country + ': ' + CAST(@AvgScore AS NVARCHAR(10));

SELECT COUNT(OrderID) totalorders,
SUM(Sales) as totalsales
FROM SalesDB.Sales.orders o
JOIN SalesDB.Sales.customers c
ON o.CustomerID = c.CustomerID
WHERE c.Country = @Country
END;

EXEC GetCustomerStatsByCountry ;
EXEC GetCustomerStatsByCountry @Country='Germany';