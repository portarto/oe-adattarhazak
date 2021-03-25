
------------
--CREATE DBS
------------

CREATE DATABASE STAGE COLLATE SQL_Latin1_General_CP1_CI_AS
GO

CREATE DATABASE DW COLLATE SQL_Latin1_General_CP1_CI_AS
GO

CREATE DATABASE DM COLLATE SQL_Latin1_General_CP1_CI_AS
GO


-------------
--STAGE LAYER
-------------

USE STAGE
GO

CREATE TABLE STAGE.dbo.STA_Errors
(
    [Message] VARCHAR(2000),
    [Code] VARCHAR(2000)
)

CREATE TABLE STAGE.dbo.STA_Person
(
BusinessEntityID VARCHAR(256),
PersonType VARCHAR(256),
Title VARCHAR(256),
FirstName VARCHAR(256),
LastName VARCHAR(256),
EmailPromotion VARCHAR(256)
)

CREATE TABLE STAGE.dbo.STA_SalesOrderDetail (
SalesOrderID VARCHAR(256),
SalesOrderDetailID VARCHAR(256),
OrderQty VARCHAR(256),
ProductID VARCHAR(256),
SpecialOfferID VARCHAR(256),
UnitPrice VARCHAR(256)
)

CREATE TABLE STAGE.dbo.STA_SalesOrderHeader (
SalesOrderNumber VARCHAR(256),
DueDate VARCHAR(256),
ShipDate VARCHAR(256),
OnlineOrderFlag VARCHAR(256),
CustomerID VARCHAR(256),
SalesPersonID VARCHAR(256),
SubTotal VARCHAR(256),
TaxAmt VARCHAR(256),
Freight VARCHAR(256),
TotalDue VARCHAR(256)
)

CREATE TABLE STAGE.dbo.STA_Products (
ProductID VARCHAR(256),
Name VARCHAR(256),
ProductNumber VARCHAR(256),
Color VARCHAR(256),
ListPrice VARCHAR(256),
ProductSubcategoryID VARCHAR(256),
ProductModelID VARCHAR(256),
SellStartDate VARCHAR(256),
SellEndDate VARCHAR(256)
)

CREATE TABLE STAGE.dbo.STA_ProductModel (
ProductModelID VARCHAR(256),
Name VARCHAR(256)
)

CREATE TABLE STAGE.dbo.STA_ProductCategory (
ProductCategoryID VARCHAR(256),
Name VARCHAR(256)
)

CREATE TABLE STAGE.dbo.STA_ProductSubcategory (
ProductSubcategoryID VARCHAR(256),
ProductCategoryID VARCHAR(256),
Name VARCHAR(256)
)

----------
--DW LAYER
----------

USE DW
GO

CREATE TABLE DW.dbo.DW_Person
(
BusinessKey INT,
PersonType CHAR(2),
Title VARCHAR(5),
FirstName VARCHAR(40),
LastName VARCHAR(40),
EmailPromotion INT,
LoadTimeStamp TIMESTAMP
)

CREATE TABLE DW.dbo.DW_SalesOrderDetail (
SalesOrderID INT,
SalesOrderDetailID INT,
OrderQty INT,
ProductID INT,
SpecialOfferID INT,
UnitPrice MONEY,
LoadTimeStamp TIMESTAMP
)

CREATE TABLE DW.dbo.DW_SalesOrderHeader (
SalesOrderNumber INT,
DueDate DATE,
ShipDate DATE,
OnlineOrderFlag INT,
CustomerID INT,
SalesPersonID INT,
SubTotal MONEY,
TaxAmt MONEY,
Freight MONEY,
TotalDue MONEY,
LoadTimeStamp TIMESTAMP
)

CREATE TABLE DW.dbo.DW_Products (
ProductID INT,
Name VARCHAR(256),
ProductNumber VARCHAR(16),
Color VARCHAR(32),
ListPrice MONEY,
ProductSubcategoryID INT,
ProductModelID INT,
SellStartDate DATE,
SellEndDate DATE,
ValidFrom DATE,
ValidTo DATE,
LoadTimeStamp TIMESTAMP
)

CREATE TABLE DW.dbo.DW_ProductModel (
ProductModelID INT,
Name VARCHAR(256),
LoadTimeStamp TIMESTAMP
)

CREATE TABLE DW.dbo.DW_ProductCategory (
ProductCategoryID INT,
Name VARCHAR(256),
LoadTimeStamp TIMESTAMP
)

CREATE TABLE DW.dbo.DW_ProductSubcategory (
ProductSubcategoryID INT,
ProductCategoryID INT,
Name VARCHAR(256),
LoadTimeStamp TIMESTAMP
)

----------
--DM LAYER
----------

USE DM
GO

CREATE TABLE DM.dbo.FactSalesOrder (
SalesOrderID BIGINT IDENTITY(1,1),
OrderQty INT,
UnitPrice MONEY,
ShipDate INT,
OnlineOrderFlag INT,
DimProductID INT,
DimCustomerID INT,
DimDateID INT,
LoadTimeStamp TIMESTAMP
)

CREATE TABLE DM.dbo.DimCustomer (
DimCustomerID INT IDENTITY(1,1),
BusinessKey INT,
PersonType CHAR(2),
Title VARCHAR(5),
FirstName VARCHAR(40),
LastName VARCHAR(40),
EmailPromotion INT,
LoadTimeStamp TIMESTAMP
)

CREATE TABLE DM.dbo.DimProduct (
DimProductID INT IDENTITY(1,1),
BusinessKey INT,
Name VARCHAR(256),
ProductNumber VARCHAR(16),
Color VARCHAR(32),
ListPrice MONEY,
SellStartDate DATE,
SellEndDate DATE,
ProductModel VARCHAR(256),
ProductCategory VARCHAR(256),
ProductSubcategory VARCHAR(256),
LoadTimeStamp TIMESTAMP
)