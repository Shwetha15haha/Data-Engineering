--data structure that provides quick acess to data, optimized for fast retrieval
--heap structure refers to a type of file organization where records are stored without any specific order.data stored without index,randomly in pages
--clustered index is a type of index that determines the physical order of data in a table, it sorts and stores the data rows in the table based on the clustered index key
--b-tree index is a balanced tree data structure that maintains sorted data and allows for efficient insertion, deletion, and search operations
--non-clustered index is a type of index that creates a separate structure from the data table, allowing for quick lookups without changing the physical order of the data
--Clusterd index use case: unique column, not frequently updated, improve range query performance
--Non-clustered index use case: exact match queries, frequently updated columns,columns used in search operations and  join operations
--CREATE [Clusterd | Non-clusterd] INDEX index_name ON table_name (column_name [ASC | DESC]);
--CREATE CLUSTERED INDEX idx_customer_id ON customers (customer_id ASC);
--CREATE NONCLUSTERED INDEX idx_customer_name ON customers (customer_name ASC);
CREATE NONCLUSTERED INDEX idx_order_date ON SalesDB.Sales.orders (orderDate ASC);

--by default index is created as non-clustered
CREATE INDEX idx_order_date ON SalesDB.Sales.orders (orderDate ASC);

CREATE CLUSTERED INDEX idx_product_ID ON SalesDB.Sales.products (productID ASC);

DROP INDEX IF EXISTS idx_product_ID ON SalesDB.Sales.products;

--composite index is an index that includes multiple columns, allowing for more efficient queries that filter or sort based on those columns
CREATE INDEX idx_order_product ON SalesDB.Sales.orders (orderID, productID);

--same order of columns in index as in query
CREATE INDEX idx_DBCustomers_CountryScore ON SalesDB.Sales.customers (country, score);

--Rowstore index is a type of index that stores data in a row-oriented format, optimizing for queries that access entire rows of data
--Columnstore index is a type of index that stores data in a column-oriented format, optimizing for queries that access specific columns of data, particularly in analytical workloads
--1. Group rows 2. Columns segment 3. Compression 4. Store in Lob : large object storage
--by default rowstore index is created
CREATE INDEX idx_sales_rowstore ON SalesDB.Sales.orders (orderID, orderDate)
--CREATE [Clusterd | Non-clusterd] COLUMNSTORE INDEX idx_sales_columnstore ON SalesDB.Sales.orders (orderID, orderDate, customerID, productID);
--Unique index is an index that ensures all values in the indexed column(s) are unique, preventing duplicate entries
CREATE UNIQUE INDEX idx_unique_customer_email ON SalesDB.Sales.customers (customerID);

--Filtered index is an index that includes only a subset of rows in a table based on a specified filter condition, improving query performance for specific queries
--You cannot create a filtered index on a clustered index
--You cannot create filtered index on a columnstore table
CREATE [UNIQUE] [NONCLUSTERED] INDEX idx_unique_order ON SalesDB.Sales.orders (orderID)
WHERE
  orderStatus = 'Completed';

CREATE INDEX idx_filtered_orders ON SalesDB.Sales.orders (orderDate)
WHERE
  orderDate >= '2023-01-01'
  AND orderDate < '2024-01-01';

--List all specific indexes in a table
USE SalesDB;
sp_helpindex 'Sales.Products';
sp_helpindex 'Sales.Orders';

--Monitoring index usage
--you can join these tables and get info on each table using object_id
SELECT * FROM sys.indexes;
SELECT * FROM sys.tables;
SELECT * FROM sys.dm_db_index_usage_stats;
SELECT * FROM sys.dm_db_missing_index_details;


--Execute plans: To see how query engine executes a query sstep by step,  to see query usage step by step and how indexes are used
--Read notes


--SQL HINTS
--SQL hints are directives that can be used to influence the behavior of the query optimizer, allowing you to specify how a query should be executed
--They can be used to override the default query optimization behavior, providing more control over query execution
SELECT
  *,
  (
    SELECT
      COUNT(*)
    FROM
      SalesDB.Sales.Orders o WITH (FORCESEEK)
    WHERE
      o.CustomerID = c.CustomerID
  ) totalorders
FROM
  SalesDB.Sales.Customers c
  -- OPTION (HASH JOIN);