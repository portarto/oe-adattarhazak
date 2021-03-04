# Órai SQL scriptek

```
USE AdventureWorks2017;

CREATE TABLE SpaceUsed (
	TableName NVARCHAR(200),
	TotalRows NVARCHAR(200),
	Reserved NVARCHAR(200),
	TableData NVARCHAR(200),
	Index_Size NVARCHAR(200),
	Unused NVARCHAR(200)
);

DECLARE @fullname VARCHAR(200) = (SELECT '[' + SCHEMA_NAME(SCHEMA_ID) + '].[' + NAME + ']' FROM sys.tables WHERE name = 'Department');

INSERT SpaceUsed EXEC sp_spaceused @fullname;

SELECT COUNT(*) AS TotalRowCount FROM SpaceUsed;
```

# Házi
```
USE AdventureWorks2017;

CREATE TABLE ProductsHistory (
	NumberOfProductsWithoutColor NVARCHAR(200)
);

DECLARE @withoutColor VARCHAR(200) = SELECT COUNT(*) FROM [Production].[Product] WHERE [Color] IS NULL;
INSERT SpaceUsed EXEC sp_spaceused @withoutColor;
SELECT COUNT(*) AS TotalRowCount FROM SpaceUsed;
```
