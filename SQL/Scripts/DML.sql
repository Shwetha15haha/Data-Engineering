--INSERT
INSERT INTO
  customers (id, first_name, country, score)
VALUES
  (6, 'Anna', 'USA', NULL);

INSERT INTO
  MyDatabase.dbo.customers (id, first_name, country, score)
VALUES
  (7, 'Peter', 'India', 250);

INSERT INTO
  MyDatabase.dbo.customers (7, 'Peter', 'India', 250);

--Nullable columns can be ignored if no data is available
INSERT INTO
  MyDatabase.dbo.customers (id, first_name)
VALUES
  (8, 'Priya')
  --Insert data from customers table to person table
  --Here only two columns are matching, for other two columns add default value
INSERT INTO
  MyDatabase.dbo.persons (id, person_name, birth_date, phone)
SELECT
  id,
  first_name,
  NULL,
  'NA'
FROM
  MyDatabase.dbo.customers;

--UPDATE
SELECT
  *
FROM
  MyDatabase.dbo.customers
WHERE
  id = 6;

UPDATE MyDatabase.dbo.customers
SET
  score = 0
WHERE
  id = 6;

UPDATE MyDatabase.dbo.customers
SET
  score = 0,
  country = 'India'
WHERE
  id = 8;

UPDATE MyDatabase.dbo.customers
SET
  score = 0
WHERE
  score IS NULL;

--DELETE
DELETE FROM MyDatabase.dbo.customers
WHERE
  id > 5;

DELETE FROM MyDatabase.dbo.persons;

TRUNCATE TABLE MyDatabase.dbo.persons;