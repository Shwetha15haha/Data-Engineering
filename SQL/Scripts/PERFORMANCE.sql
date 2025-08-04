--Read notes for complete details
-----------SQL Performances TIPS for fetching data-----------
--Select only required columns
--avoid using SELECT *
SELECT
  p.product_id,
  p.product_name,
  p.price
FROM
  products p;

--Avoid unnecessary distinct and order by clauses
--Use DISTINCT only when necessary
--Avoid ORDER BY unless required for the result set
--Use LIMIT to restrict the number of rows returned while exploring data
;

-----------SQL Performances TIPS for filtering data-----------
--create non clustered index on frequently filtered columns 
--avoid using functions in WHERE clause as they prevent index usage
SELECT
  *
FROM
  Customers
WHERE
  LOWER(country) = 'USA'
  AND state = 'California';

-- Avoid providing leading wildcard in LIKE clause as they prevent index usage
SELECT
  *
FROM
  Customers
WHERE
  country LIKE 'USA%'
  AND state = 'California';

--Use IN instead of OR for better performance
SELECT
  *
FROM
  Customers
WHERE
  country IN ('USA', 'Canada')
  AND state = 'California';

-----------SQL Performances TIPS for joining-----------
--Use implicit joins instead of subqueries for better performance
--Use indexed columns for joining
--better to filter data before joining
--aggregate data before joining for big tables
--avoid using OR in ON clause instead use UNION
--check for nested loops in joins and use sql hints to optimize
--if duplicates are allowed then use union all  and distinct instead of union
;

-----------SQL Performances TIPS for aggregation-----------
--use columnstore index on fact tables
--pre aggregate data and store in seperate table for reporting