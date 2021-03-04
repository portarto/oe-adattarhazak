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