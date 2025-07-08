--ISNUL/COALESCE
--Replace a null value to specific value or default value
--Coalesce can check multiple column values
--Use case: Handling nulls before Data aggregation : Suppose 3 vlaues likes 1,2 and NULL then avg of this will ignore NULL.But if we replace null as zero, then avg value will be accurate.
SELECT
  *
FROM
  SalesDB.Sales.Customers;

--when NULL is present
SELECT
  AVG(Score) as avg_score
FROM
  SalesDB.Sales.Customers;

--when NULL is replaced
SELECT
  AVG(ISNULL (Score, 0)) as avg_score
FROM
  SalesDB.Sales.Customers;

--Use case: Mathematical operations
--Dispaly customer's full name and add bonus 10 to their score
SELECT
  FirstName,
  LastName,
  CONCAT (FirstName, ' ', ISNULL (LastName, '')) fullname,
  Score,
  10 + ISNULL (Score, 0) new_scores
FROM
  SalesDB.Sales.Customers;

--Use case: Hnadle Nulls before doing Joins
--Even though logically both the tables have matching values(NULL), it will be skipped and won't be considered in output and hence it is important convert NULL values as empty string before joining
-- SELECT
--   a.year,
--   a.type,
--   a.order,
--   b.sales
-- FROM
--   orders a
--   JOIN sales b ON a.year = b.year
--   and ISNULL (a.type, '') = ISNULL (b.type, '')
;

--IS NULL
--Use case: Handle nulls before sorting data
SELECT
  CustomerID,
  Score
FROM
  SalesDB.Sales.Customers
ORDER BY
  CASE
    WHEN Score IS NULL THEN 1
    ELSE 0
  END,
  Score;

;

--NULLIF
--Compares two values and if they are equal gives NULL, if not it returns first value
--Use case: Preventing erroor from dividing by 0
SELECT
  OrderID,
  Sales,
  Quantity,
  Sales / NULLIF(Quantity, 0) Price
FROM
  SalesDB.Sales.Orders;

--IS NULL/IS NOT NULL
--Use case : Searching for missing informations
SELECT
  *
FROM
  SalesDB.Sales.Customers
WHERE
  Score IS NULL;

SELECT
  *
FROM
  SalesDB.Sales.Customers
WHERE
  Score IS NOT NULL;

--Use case : left anti join(LEFT JOIN + IS NULL) and right anti join(RIGHT JOIN + IS NULL)
--LEFT ANTI JOIN
--Returns rows from left table that has no match in right table
--Use case: Fetch list of customers who didn't order
SELECT
  c.*,
  OrderID
FROM
  SalesDB.Sales.Customers c
  LEFT JOIN SalesDB.Sales.Orders o ON c.CustomerID = o.CustomerID
WHERE
  o.CustomerID IS NULL;

--NULL vs Empty string vs Blank
--NULL is nothing, unknown
--Empty string is 0 characters, known but 0 length
--Blank is spaces that is counted as characters, length is 1 or more
--Data policies
--TRIM is used to remove spaces for cleaning data
--Use NULLIF to convert empty strings to NULL : for inserting data 
--Use default values instead of null,empty string, blanks : for reporting purpose