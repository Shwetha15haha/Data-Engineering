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