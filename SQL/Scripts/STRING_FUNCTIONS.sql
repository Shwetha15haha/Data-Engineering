--CONCAT
--To combine two columnsvalue into one
SELECT
  first_name,
  country,
  CONCAT (first_name, ' ', country)
FROM
  customers;

--UPPER,LOWER
--To change case of string values
SELECT
  first_name,
  country,
  UPPER(first_name) as uppername,
  LOWER(first_name) as lowername
FROM
  customers;

--LEN
--To check character length
SELECT
  first_name,
  LEN (first_name)
FROM
  customers;

--TRIM
--To remove whitespaces in string value 
SELECT
  first_name,
  LEN (first_name)
FROM
  customers;

SELECT
  first_name,
  LEN (first_name) as originallen,
  TRIM(first_name) as trimmedname,
  LEN (TRIM(first_name)) as trimmedlen
FROM
  customers
WHERE
  first_name != TRIM(first_name)
  and LEN ((first_name)) != LEN (TRIM(first_name));

SELECT
  first_name
FROM
  customers
WHERE
  first_name != TRIM(first_name);

--REPLACE
--Replace characters with new one or remove characters
SELECT
  '123-356-789' as stringvalue,
  REPLACE ('123-356-789', '-', '/') AS replcedvalue;

SELECT
  '123-356-789' as stringvalue,
  REPLACE ('123-356-789', '-', '') AS replcedvalue;

SELECT
  'report.txt',
  REPLACE ('report.txt', 'txt', 'csv') as replaced;

--LEFT/RIGHT
--To extract charcters from right or left side
SELECT
  first_name,
  LEFT (TRIM(first_name), 2) as leftchar,
  RIGHT (TRIM(first_name), 2) as rightchar
FROM
  customers;

--SUBSTRING
--To extract characters from anywhere in the string
SELECT
  first_name,
  SUBSTRING(TRIM(first_name), 2, LEN (first_name))
from
  customers;