--Find the running total of sales for each month
--In other database we can use CREATE OR REPLACE
IF OBJECT_ID ('Sales.V_Monthly_Summary', 'V') IS NOT NULL
DROP VIEW Sales.V_Monthly_Summary;

GO
CREATE VIEW
  V_Monthly_Summary AS (
    SELECT
      DATETRUNC (month, OrderDate) month,
      SUM(Sales) totalsales,
      COUNT(OrderID) totalorders,
      COUNT(Quantity) totalquantity
    FROM
      SalesDB.Sales.Orders
    GROUP BY
      DATETRUNC (month, OrderDate)
  );

--   --by using view
-- SELECT
--   month,
--   totalsales,
--   SUM(totalsales) OVER (
--     ORDER BY
--       month
--   ) as runningtotal
-- FROM
--   V_Monthly_Summary;
-- --DROP View
-- DROP VIEW V_Monthly_Summary;
--Provide view that combines details from orders,customers and products and employees tables
CREATE VIEW
  V_Order_Details AS (
    SELECT
      o.OrderID,
      o.OrderDate,
      p.Product,
      p.Category,
      COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') CustomerName,
      COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') SalesName,
      e.Department,
      o.Sales,
      o.Quantity
    FROM
      SalesDB.Sales.Orders o
      LEFT JOIN SalesDB.Sales.Products p ON o.ProductID = p.ProductID
      LEFT JOIN SalesDB.Sales.Customers c ON o.CustomerID = c.CustomerID
      LEFT JOIN SalesDB.Sales.Employees e ON o.SalesPersonID = e.EmployeeID
  );