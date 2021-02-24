CREATE TABLE AdWorkDM.dbo.FactSalesOrder (
	SalesOrderID VARCHAR(256),
	OrderQty VARCHAR(256),
	UnitPrice VARCHAR(256),
	OrderDate VARCHAR(256),
	ShipDate VARCHAR(256),
	OnlineOrderFlag VARCHAR(256),
	DimProductID VARCHAR(256),
	DimCustomerID VARCHAR(256),
	DimDateID VARCHAR(256)
);


CREATE TABLE AdWorkDM.dbo.DimCustomer (
	DimCustomerID VARCHAR(256),
	PersonType VARCHAR(256),
	Title VARCHAR(256),
	FirstName VARCHAR(256),
	LastName VARCHAR(256),
	EmailPromotion VARCHAR(256)
);


CREATE TABLE AdWorkDM.dbo.DimProduct (
	DimProductID VARCHAR(256),
	Name VARCHAR(256),
	ProductNumber VARCHAR(256),
	Color VARCHAR(256),
	ListPrice VARCHAR(256),
	SellStartDate VARCHAR(256),
	SellEndDate VARCHAR(256),
	ProductModel VARCHAR(256),
	ProductCategory VARCHAR(256),
	ProductSubcategory VARCHAR(256)
);
