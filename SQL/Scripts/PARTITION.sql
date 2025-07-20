--define partition 
--Create partition function
CREATE PARTITION FUNCTION Partitionbyyear (DATE) AS RANGE LEFT FOR
VALUES
  ('2023-12-31', '2024-12-31', '2025-12-31');

--Query lists all existing Partition function
SELECT
  name,
  function_id,
  type,
  type_desc,
  boundary_value_on_right
FROM
  sys.partition_functions;

--Filegroups
ALTER DATABASE SalesDB ADD FILEGROUP FG_2023;

ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2023;

SELECT
  *
FROM
  sys.filegroups;

--Data Files
ALTER DATABASE SalesDB ADD FILE (NAME = P_2023, FILENAME = 'file_path') TO FILEGROUP FG_2023;

--Create partion schema
CREATE PARTITION SCHEMA Schemapartitionbyyear AS PARTITION Partitionbyyear TO (FG_2023);

--Create partitioned table
CREATE TABLE
  SalesDB.Sales.Order_Partition (OrderID INT, OrderDate DATE, Sales FLOAT) ON Schemapartitionbyyear (OrderDate);

INSERT INTO
  SalesDB.Sales.Order_Partition
VALUES
  (1, '2023-05-13', 100);