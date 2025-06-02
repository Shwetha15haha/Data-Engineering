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

--NOT
SELECT
  *
FROM
  customers
WHERE
  NOT score >= 500;

SELECT
  *
FROM
  customers
WHERE
  score IS NOT NULL;

--BETWEEN
SELECT
  *
FROM
  customers
WHERE
  score BETWEEN 100 AND 500;

--IN
SELECT
  *
FROM
  customers
WHERE
  country IN ('USA', 'Germany');

SELECT
  *
FROM
  customers
WHERE
  country NOT IN ('USA', 'Germany');

--LIKE
SELECT
  *
FROM
  customers
WHERE
  first_name LIKE 'M%';

SELECT
  *
FROM
  customers
WHERE
  first_name LIKE '%r%';

SELECT
  *
FROM
  customers
WHERE
  first_name LIKE '__r%';