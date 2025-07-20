-- SELECT [columns]
-- INTO [new_table_name]
-- FROM [source_table]
-- WHERE [optional_conditions];
SELECT DISTINCT
  country INTO SalesDB.Sales.Country
FROM
  SalesDB.Sales.customers;

--Temp tables
-- CREATE TABLE #TempTable (
--     Id INT,
--     Name NVARCHAR(100)
-- );
-- SELECT Id, Name
-- INTO #TempTable
-- FROM SourceTable
-- WHERE Condition;
SELECT
  *
  INTO #Orders
FROM
  SalesDB.Sales.Orders;

SELECT
  *
  FROM #Orders;