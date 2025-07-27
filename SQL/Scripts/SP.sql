-- -- step 1: write a query 
-- -- For US customers find total number of customers and the average score
-- SELECT
--   COUNT(CustomerID) total_customers,
--   AVG(Score) avgscore
-- FROM
--   SalesDB.Sales.customers
-- WHERE
--   Country = 'USA';
-- -- step 2: create a stored procedure
-- CREATE PROCEDURE GetUSCustomerStats AS BEGIN
-- SELECT
--   COUNT(CustomerID) AS total_customers,
--   AVG(Score) AS avgscore
-- FROM
--   SalesDB.Sales.customers
-- WHERE
--   Country = 'USA' END;
-- -- step 3: execute the stored procedure
-- EXEC GetUSCustomerStats;
-- --Parameters can be added to the stored procedure if needed
-- -- Example with parameters
-- CREATE PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50)
-- AS BEGIN
-- SELECT
--   COUNT(CustomerID) AS total_customers,
--   AVG(Score) AS avgscore
-- FROM
--   SalesDB.Sales.customers
-- WHERE
--   Country = @Country END;
-- EXEC GetCustomerStatsByCountry @Country='USA';
-- EXEC GetCustomerStatsByCountry @Country='Germany';

-- -- step 4: add default values to parameters
-- ALTER PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50) = 'USA'
-- AS BEGIN
-- SELECT
--   COUNT(CustomerID) AS total_customers,
--   AVG(Score) AS avgscore
-- FROM
--   SalesDB.Sales.customers
-- WHERE
--   Country = @Country END;

-- EXEC GetCustomerStatsByCountry ;

-- -- step 5: adding multiple queries to the stored procedure
-- ALTER PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50) = 'USA'
-- AS BEGIN
-- SELECT
--   COUNT(CustomerID) AS total_customers,
--   AVG(Score) AS avgscore
-- FROM
--   SalesDB.Sales.customers
-- WHERE
--   Country = @Country ;

-- SELECT COUNT(OrderID) totalorders,
-- SUM(Sales) as totalsales
-- FROM SalesDB.Sales.orders o
-- JOIN SalesDB.Sales.customers c
-- ON o.CustomerID = c.CustomerID
-- WHERE c.Country = @Country
-- END;

-- EXEC GetCustomerStatsByCountry ;

-- --Using variables in stored procedures
-- ALTER PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50) = 'USA'
-- AS BEGIN 
-- DECLARE @TotalCustomers INT;
-- DECLARE @AvgScore FLOAT;
-- SELECT
--   @TotalCustomers = COUNT(CustomerID),
--   @AvgScore = AVG(Score)
-- FROM
--   SalesDB.Sales.customers
-- WHERE
--   Country = @Country ;
-- -- Output the results, PRINT statement can have only string values
-- PRINT 'Total Customers for' + @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR(10));
-- PRINT 'Average score for' + @Country + ': ' + CAST(@AvgScore AS NVARCHAR(10));

-- SELECT COUNT(OrderID) totalorders,
-- SUM(Sales) as totalsales
-- FROM SalesDB.Sales.orders o
-- JOIN SalesDB.Sales.customers c
-- ON o.CustomerID = c.CustomerID
-- WHERE c.Country = @Country
-- END;

-- EXEC GetCustomerStatsByCountry ;
-- EXEC GetCustomerStatsByCountry @Country='Germany';

-- --Control flow in stored procedures
-- ALTER PROCEDURE GetCustomerStatsByCountry @Country NVARCHAR(50) = 'USA'
-- AS BEGIN 
-- --Declaring variables
-- DECLARE @TotalCustomers INT;
-- DECLARE @AvgScore FLOAT;
-- --Data cleanup 
-- IF EXISTS (SELECT 1 FROM SalesDB.Sales.customers WHERE Score IS NULL AND Country =  @Country)
-- BEGIN
--  PRINT('Updating NULL scores to 0 for country: ' + @Country);
--  UPDATE SalesDB.Sales.customers
--  SET Score = 0
--  WHERE Score IS NULL AND Country = @Country;
-- END
-- ELSE
-- BEGIN
--  PRINT('No NULL scores found for country: ' + @Country);
-- END

-- --Calculating total customers and average score
-- SELECT
--   @TotalCustomers = COUNT(CustomerID),
--   @AvgScore = AVG(Score)
-- FROM
--   SalesDB.Sales.customers
-- WHERE
--   Country = @Country ;
-- -- Output the results, PRINT statement can have only string values
-- PRINT 'Total Customers for' + @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR(10));
-- PRINT 'Average score for' + @Country + ': ' + CAST(@AvgScore AS NVARCHAR(10));

-- SELECT COUNT(OrderID) totalorders,
-- SUM(Sales) as totalsales
-- FROM SalesDB.Sales.orders o
-- JOIN SalesDB.Sales.customers c
-- ON o.CustomerID = c.CustomerID
-- WHERE c.Country = @Country
-- END;


------Error handling in stored procedures
ALTER PROCEDURE Getcustomerstatsbycountry @Country NVARCHAR(50) = 'USA'
AS
  BEGIN
      BEGIN try
          --Declaring variables
          DECLARE @TotalCustomers INT;
          DECLARE @AvgScore FLOAT;

          --Data cleanup 
          IF EXISTS (SELECT 1
                     FROM   salesdb.sales.customers
                     WHERE  score IS NULL
                            AND country = @Country)
            BEGIN
                PRINT( 'Updating NULL scores to 0 for country: '
                       + @Country );

                UPDATE salesdb.sales.customers
                SET    score = 0
                WHERE  score IS NULL
                       AND country = @Country;
            END
          ELSE
            BEGIN
                PRINT( 'No NULL scores found for country: '
                       + @Country );
            END

          --Calculating total customers and average score
          SELECT @TotalCustomers = Count(customerid),
                 @AvgScore = Avg(score)
          FROM   salesdb.sales.customers
          WHERE  country = @Country;

          -- Output the results, PRINT statement can have only string values
          PRINT 'Total Customers for' + @Country + ': '
                + Cast(@TotalCustomers AS NVARCHAR(10));

          PRINT 'Average score for' + @Country + ': '
                + Cast(@AvgScore AS NVARCHAR(10));

          SELECT Count(orderid) totalorders,
                 Sum(sales)     AS totalsales,
                 1 / 0
          FROM   salesdb.sales.orders o
                 JOIN salesdb.sales.customers c
                   ON o.customerid = c.customerid
          WHERE  c.country = @Country
      END try

      BEGIN catch
          PRINT( 'An error occurred: ' + Error_message() );
      END catch
  END;


--Triggers
--Special type of stored procedure that automatically executes in response to certain events on a particular table or view
--Use case: To maintain audit log
CREATE TABLE SalesDB.Sales.EmployeeLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    LogMessage NVARCHAR(255),
    LogDate DATE
);

CREATE TRIGGER trg_AfterInsertEmployee ON SalesDB.Sales.Employees
AFTER INSERT
AS
BEGIN
INSERT INTO SalesDB.Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
SELECT EmployeeID, 
       'New employee added with ID: ' + CAST(EmployeeID AS NVARCHAR(10)), 
       GETDATE()
       FROM inserted
END;

-- Example of inserting a new employee to trigger the log
-- INSERT INTO Sales.Employees
-- VALUES
-- (6, 'Maria', 'Doe', 'HR', '1988-01-12', 'F', 80000, 3);

-- SELECT * FROM SalesDB.Sales.EmployeeLogs;