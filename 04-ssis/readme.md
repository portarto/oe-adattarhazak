# 4. óra

## SQL parancsok
### AdventureWorks2017Query.sql
```
Use AdventureWorks2017
GO

SELECT [Name]				-- be lesz importálva a céltáblába
      ,[Color]				-- be lesz importálva a céltáblába
      ,[StandardCost] AS Cost		-- be lesz importálva a céltáblába
      ,[ListPrice] AS RetailPrice	-- be lesz importálva a céltáblába
      ,[Size]				-- be lesz importálva a céltáblába
      ,[ItemType] = CASE		-- arra használjuk, hogy a termék ruházati vagy egyéb termék
		WHEN Size IN ('S','M','L','XL') THEN 'Clothing' 
		ELSE 'Product'
		END 
FROM [AdventureWorks2017].[Production].[Product]

-- csak az aktív termékeket szeretném lekérdezni
WHERE SellEndDate IS NULL
```

### MergeDB.sql
```
-- az adatbázis elkészítése
CREATE DATABASE [MergedDB] COLLATE SQL_Latin1_General_CP1_CI_AS; 
GO

USE [MergedDB]
GO

-- készít egy Products táblát, ami a forráshoz hasonló típusokat használ
CREATE TABLE [dbo].[Products](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Color] [nvarchar](20) NULL,
	[Cost] [money] NOT NULL,
	[RetailPrice] [money] NOT NULL,
	[Size] [nvarchar](20) NULL
)
GO

-- készít egy Clothes táblát, ami azonos a Products táblával, de csak ruhák kerülnek bele
CREATE TABLE [dbo].[Clothes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Color] [nvarchar](20) NULL,
	[Cost] [money] NOT NULL,
	[RetailPrice] [money] NOT NULL,
	[Size] [nvarchar](20) NULL
)
GO
```

### WideWorldImportersQuery.sql
```
Use WideWorldImporters
GO

Select [StockItemName] AS [Name]			-- be lesz importálva a céltáblába
      ,[ColorID]					-- be lesz importálva a céltáblába
      ,[Size]						-- be lesz importálva a céltáblába
      ,[TaxRate]					-- nem importáljuk be, de felhasználjuk számításhoz
      ,[UnitPrice]					-- miután hozzáadtuk az adót, be lesz importálva a céltáblába
      ,[RecommendedRetailPrice]				-- be lesz importálva a céltáblába
      ,[ItemType] = CASE				-- arra használjuk, hogy eldöntsük, hogy ruházati vagy egyéb termékről van-e szó
		WHEN Size IN ('S','M','L','3XL','3XS','4XL','5XL','6XL','7XL','XS','XXS','XL','XXL') THEN 'Clothing' 
		ELSE 'Product'
		END 
FROM [WideWorldImporters].[Warehouse].[StockItems]
```

## Hf
**Készítsük el a következő feladatokat SSIS-ben:**
1. Egy Data Flow-on belül kérdezzük le az AdventureWorks2017 adatbázisból a Person tábla tartalmát.
2. A táblából csak a First name és Last name oszlopokat használjuk a Data Flow-ban.
3. A Derived column objektummal készítsünk egy új oszlopot, ahol összefűzzük a keresztnevet és a vezetéknevet "FullName" oszlopként.
4. Rendezzük az adathalmazt a FullName oszlop alapján.
5. Exportáljuk ki kizárólag a FullName oszlop tartalmát egy fullName.csv fájlba a C:\DB mappán belülre.
