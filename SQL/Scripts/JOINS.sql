--Combine two tables data through combining their columns
--INNER JOIN
--Returns only matching data from both the tables
SELECT
  *
FROM
  customers c
  INNER JOIN orders o ON c.id = o.customer_id;

SELECT
  id,
  first_name,
  country,
  order_id,
  sales
FROM
  customers c
  INNER JOIN orders o ON c.id = o.customer_id;

SELECT
  c.id,
  c.first_name,
  c.country,
  o.order_id,
  o.sales
FROM
  customers c
  INNER JOIN orders o ON c.id = o.customer_id;

--Duplicates in result possible for below cases
-- - Duplicates in Either Table's Join Column – If the column in the ON clause has repeated values in either table, matching rows will appear multiple times.
-- - Duplicates in Both Tables' Join Columns – If both tables have duplicates in the join column, the result set multiplies even more.
-- - Multiple Columns in the ON Clause – If multiple columns are used in the ON condition and they have duplicate combinations, more matches will be generated.
-- - Unintended Join Multiplication – If the join condition is too broad (e.g., matching based on a general attribute like "region"), it may lead to excessive duplicates.
-- To prevent unintended duplicates:
-- - Use DISTINCT to filter out repeated rows.
-- - Apply aggregation (GROUP BY) to consolidate duplicates.
-- - Ensure unique relationships between the tables.
--LEFT JOIN
--All rows from left table and matching rows from right table
--order of table matters
SELECT
  c.id,
  c.first_name,
  c.country,
  o.order_id,
  o.sales
FROM
  customers c
  LEFT JOIN orders o ON c.id = o.customer_id;

--RIGHT JOIN
SELECT
  c.id,
  c.first_name,
  c.country,
  o.order_id,
  o.sales
FROM
  customers c
  RIGHT JOIN orders o ON c.id = o.customer_id;

--FULL JOIN
SELECT
  c.id,
  c.first_name,
  c.country,
  o.order_id,
  o.sales
FROM
  customers c
  FULL JOIN orders o ON c.id = o.customer_id;