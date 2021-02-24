CREATE DATABASE AdWorkDM COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE AdWorkDM;

INSERT INTO dbo.FactSalesOrder
SELECT 
    ROW_NUMBER() OVER(ORDER BY SOH.salesOrderID) AS SalesOrderID,
    OrderQty,
    UnitPrice,
    OrderDate,
    ShipDate,
    OnlineOrderFlag,
    ROW_NUMBER() OVER(ORDER BY SOH.salesOrderID) DimProductID, 
    ROW_NUMBER() OVER(ORDER BY SOH.salesOrderID) DimCustomerID, 
    YEAR(OrderDate) * 10000 + MONTH(OrderDate) * 100 + DAY(OrderDate) DimDateID
FROM AdventureWorks2017.Sales.SalesOrderDetail SOD INNER JOIN 
AdventureWorks2017.Sales.SalesOrderHeader SOH ON SOD.salesOrderID = SOH.salesOrderID;

INSERT INTO dbo.DimCustomer 
SELECT 
    ROW_NUMBER() OVER(ORDER BY PersonType) DimCustomerID,
    PersonType,
    Title,
    FirstName,
    LastName,
    EmailPromotion
FROM AdventureWorks2017.Person.Person;

INSERT INTO dbo.DimProduct 
SELECT 
    ROW_NUMBER() OVER(ORDER BY PR.ProductID ASC) DimProductID, 
    PR.Name,
    ProductNumber,
    Color,
    ListPrice,
    SellStartDate,
    SellEndDate,
    PM.name ModelName,
    PC.name CategoryName,
    SC.name SubcategoryName
FROM AdventureWorks2017.Production.Product PR 
INNER JOIN AdventureWorks2017.Production.ProductModel PM 
ON PR.ProductModelID = PM.ProductModelID 
INNER JOIN AdventureWorks2017.Production.ProductSubcategory SC 
ON PR.ProductSubcategoryID = SC.ProductSubcategoryID 
INNER JOIN AdventureWorks2017.Production.ProductCategory PC 
ON PC.ProductCategoryID = SC.ProductCategoryID;

-- https://i0.wp.com/improveandrepeat.com/wp-content/uploads/2018/12/AdvWorksOLTPSchemaVisio.png?ssl=1
