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