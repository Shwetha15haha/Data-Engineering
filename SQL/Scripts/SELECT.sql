-- Use sales database
USE SalesDB;

-- Select all data from Customers table
SELECT
  *
FROM
  Sales.Customers;

SELECT
  *
FROM
  SalesDB.Sales.Customers;

-- Select all data from Orders table
SELECT
  *
FROM
  Sales.Orders;

SELECT
  *
FROM
  SalesDB.Sales.Orders;

--Select All columns
SELECT
  CustomerId,
  FirstName,
  LastName,
  Country,
  Score
FROM
  Sales.Customers;

--Select few columns
SELECT
  FirstName,
  LastName,
  Country
FROM
  Sales.Customers;

--Retrieve all data from customers table in Mydatabase 
SELECT
  *
FROM
  customers;

SELECT
  *
FROM
  MyDatabase.dbo.customers;

--Retrieve few columns
SELECT
  first_name,
  country,
  score
FROM
  customers;

SELECT
  MyDatabase.dbo.customers.first_name,
  MyDatabase.dbo.customers.country,
  MyDatabase.dbo.customers.score
FROM
  customers;

--Retrieve data for specific condition using WHERE clause
SELECT
  *
FROM
  customers
WHERE
  score <> 0;

SELECT
  *
FROM
  customers
WHERE
  score != 0;

SELECT
  *
FROM
  customers
WHERE
  score = 0;

SELECT
  *
FROM
  customers
WHERE
  score > 0;

SELECT
  *
FROM
  customers
WHERE
  score < 0;

SELECT
  *
FROM
  customers
WHERE
  country = 'Germany';

--Sort your data using ORDER BY clause
SELECT
  *
FROM
  customers
ORDER BY
  score DESC;

--When tehere is a repeating value for first column in order by clause , it is good to add another column to sort properly
SELECT
  *
FROM
  customers
ORDER BY
  country,
  score DESC;

--GROUP BY clause
--Aggregate the column values by using another column, combines rows with the same value
--If you're using a column either it should be a part of group by clause or the column for which aggregation is done.
SELECT
  country,
  SUM(score) total_score
FROM
  customers
GROUP BY
  country;

SELECT
  country,
  SUM(score) total_score,
  COUNT(id) total_customers
FROM
  customers
GROUP BY
  country;

SELECT
  country,
  SUM(score) total_score
FROM
  customers
GROUP BY
  country
ORDER BY
  2 DESC;

SELECT
  country,
  SUM(score) total_score
FROM
  customers
GROUP BY
  country
ORDER BY
  total_score DESC;

--HAVING clause
--Can be used only with GROUP BY clause
--Used for filtering aggregated data
SELECT
  country,
  SUM(score) total_score
FROM
  customers
GROUP BY
  country
HAVING
  SUM(score) > 800;

SELECT
  country,
  SUM(score) total_score
FROM
  customers
WHERE
  score != 0
GROUP BY
  country
HAVING
  SUM(score) > 800;

SELECT
  country,
  AVG(score) agv_score
FROM
  customers
WHERE
  score != 0
GROUP BY
  country
HAVING
  AVG(score) > 430;

-- Why we can't use alias in WHERE or HAVING clause?
-- SQL processes statements in the following order:
-- - FROM – Defines the source table(s).
-- - WHERE – Filters rows before aggregation.
-- - GROUP BY – Groups data for aggregation.
-- - HAVING – Applies conditions on aggregated data.
-- - SELECT – Evaluates expressions and assigns aliases.
-- - ORDER BY – Sorts the final result set.
-- Since HAVING comes before SELECT, it doesn’t recognize column aliases, but ORDER BY does because it’s executed after SELECT.
-- Any clause that executes before SELECT cannot use column aliases because those aliases haven’t been assigned yet.
--DISTINCT : for removing duplicates
SELECT
  DISTINCT country
FROM
  customers;