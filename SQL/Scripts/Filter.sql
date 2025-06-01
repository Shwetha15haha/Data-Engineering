--Comparison Operators
SELECT
  *
FROM
  customers
WHERE
  country = 'Germany';

SELECT
  *
FROM
  customers
WHERE
  country != 'Germany';

SELECT
  *
FROM
  customers
WHERE
  score > 500;

SELECT
  *
FROM
  customers
WHERE
  score >= 500;

SELECT
  *
FROM
  customers
WHERE
  score < 500;

SELECT
  *
FROM
  customers
WHERE
  score <= 500;

--Logical Operators
--AND
SELECT
  *
FROM
  customers
WHERE
  country = 'USA'
  AND score > 500;

--OR
SELECT
  *
FROM
  customers
WHERE
  country = 'USA'
  OR score > 500;