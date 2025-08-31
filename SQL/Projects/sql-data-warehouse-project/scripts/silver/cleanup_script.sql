--crm_cust_info
--Check for nulls , duplicates
--1.Get the id list using count(*)
SELECT
  cst_id,
  count(*)
FROM
  bronze.crm_cust_info
GROUP BY
  cst_id
HAVING
  count(*) > 1
  OR cst_id IS NULL;

--2.Get all details for filtered duplicate ids
SELECT
  *
FROM
  bronze.crm_cust_info
WHERE
  cst_id IN (
    SELECT
      cst_id
    FROM
      bronze.crm_cust_info
    GROUP BY
      cst_id
    HAVING
      count(*) > 1
      OR cst_id IS NULL
  )
ORDER BY
  cst_id;

--3. Filter again based on latest record for a particular id
SELECT
  *,
  RANK() OVER (
    PARTITION BY
      cst_id
    ORDER BY
      cst_create_date
  )
FROM
  bronze.crm_cust_info
WHERE
  cst_id = 29433;

SELECT
  *,
  ROW_NUMBER() OVER (
    PARTITION BY
      cst_id
    ORDER BY
      cst_create_date DESC
  ) rankno
FROM
  bronze.crm_cust_info
WHERE
  cst_id IN (
    SELECT
      cst_id
    FROM
      bronze.crm_cust_info
    GROUP BY
      cst_id
    HAVING
      count(*) > 1
      OR cst_id IS NULL
  )
ORDER BY
  cst_id;

--4. Apply the filter to all 
SELECT
  *
FROM
  (
    SELECT
      *,
      ROW_NUMBER() OVER (
        PARTITION BY
          cst_id
        ORDER BY
          cst_create_date DESC
      ) flag_last
    FROM
      bronze.crm_cust_info
  ) q
WHERE
  flag_last = 1;

--Check for whitespaces
SELECT
  TRIM(cst_firstname),
  TRIM(cst_lastname)
FROM
  bronze.crm_cust_info;

--Use fullnames
--Use case when 
--F: Female
--M:Male
-----------------------------------------------------------------------------------------------------------
--crm_prd_info
--Check for nulls , duplicates
SELECT
  prd_id,
  count(*)
FROM
  bronze.crm_prd_info
GROUP BY
  prd_id
HAVING
  count(*) > 1
  OR prd_id IS NULL;

--Split the prd_key into cat_id and prd_key
SELECT
  prd_key,
  REPLACE (SUBSTRING(prd_key, 1, 5), '-', '_') cat_id,
  SUBSTRING(prd_key, 7, LEN (prd_key)) prd_key
FROM
  bronze.crm_prd_info;

--Check for unwanted sapecs in prd_nm
--Check for nulls or zeros in prd_cost
--Check for invalid order dates