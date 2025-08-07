--Bulk insert
TRUNCATE TABLE bronze.crm_cust_info;

BULK INSERT bronze.crm_cust_info
FROM
  'C:\Users\moghe\Learnings\Data-Engineering\SQL\Projects\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH
  (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

SELECT
  COUNT(*)
FROM
  bronze.crm_cust_info;

--Bulk insert
TRUNCATE TABLE bronze.crm_prd_info;

BULK INSERT bronze.crm_prd_info
FROM
  'C:\Users\moghe\Learnings\Data-Engineering\SQL\Projects\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH
  (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

SELECT
  COUNT(*)
FROM
  bronze.crm_prd_info;

BULK INSERT bronze.crm_sales_details
FROM
  'C:\Users\moghe\Learnings\Data-Engineering\SQL\Projects\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH
  (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

SELECT
  *
FROM
  bronze.crm_sales_details;