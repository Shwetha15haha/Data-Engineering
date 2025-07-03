SELECT 
OrderDate,
CreationTime,
YEAR(CreationTime),
DAY(CreationTime),
MONTH(CreationTime)
FROM
SalesDB.Sales.Orders;