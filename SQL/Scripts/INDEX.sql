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

CREATE CLUSTERED INDEX idx_product_ID ON SalesDB.Sales.products (productID ASC);

DROP INDEX IF EXISTS idx_product_ID ON SalesDB.Sales.products;