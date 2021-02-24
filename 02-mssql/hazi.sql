-- 1. Kérdezzük le, hogy melyik termékkategóriában hány darab termék található
SELECT
    pc.[ProductCategoryID]
    ,pc.[Name]
    ,COUNT(*)
FROM [AdventureWorks2017].[Production].[ProductSubcategory] psc
LEFT JOIN [AdventureWorks2017].[Production].[Product] p ON p.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN [AdventureWorks2017].[Production].[ProductCategory] pc ON pc.ProductCategoryID = psc.ProductCategoryID
GROUP BY pc.[ProductCategoryID], pc.[Name]

-- 2. Listázzuk ki dátumok szerint, hogy napokra lebontva hány darab terméket adtunk el.
-- Segítség: SUM() a VARCHAR miatt nem fog működni, így kasztolni kell, amit a CAST() függvénnyel tehetünk meg.
SELECT
    CAST([TransactionDate] as Date)
    ,SUM([Quantity])
FROM [AdventureWorks2017].[Production].[TransactionHistory]
GROUP BY CAST([TransactionDate] as Date)

-- 3. Melyik termékszínből hány darab megrendelés futott be és mennyi volt ezeknek a rendeléseknek az összege (egységár * db szám) ?
-- Segítség: itt INT és FLOAT típusokba kell majd kasztolni a VARCHAR adattípust a lekérdezésben.
SELECT
    [Color]
    ,SUM(CAST(fso.[OrderQty] as INT) * CAST(fso.[UnitPrice] as FLOAT)) OrderPrice
FROM [AdWorkDM].[dbo].[DimProduct] dp
LEFT JOIN [AdWorkDM].[dbo].[FactSalesOrder] fso ON fso.[DimProductID] = dp.[DimProductID]
GROUP BY [Color]

-- 4. Listázzuk ki, hogy melyik vásárló (teljes név) hány darab terméket és mekkora értékben vásárolt havi lebontásban!
-- Segítség: A név összefűzéséhez használjuk a CONCAT() függvényt.
SELECT
    CONCAT(dc.[FirstName], ' ', dc.[LastName]) [FullName]
    ,CONCAT(DATEPART(YEAR, CAST(fso.[OrderDate] as Date)), '-', DATEPART(MONTH, CAST(fso.[OrderDate] as Date))) [Date]
    ,SUM(CAST(fso.[OrderQty] as INT)) [OrderQty]
    ,SUM(CAST(fso.[OrderQty] as INT) * CAST(fso.[UnitPrice] as FLOAT)) [TotalPrice]
    ,SUM(CAST(fso.[UnitPrice] as FLOAT)) [UnitPrice]
FROM [AdWorkDM].[dbo].[DimCustomer] dc
LEFT JOIN [AdWorkDM].[dbo].[FactSalesOrder] fso ON fso.[DimCustomerID] = dc.[DimCustomerID]
GROUP BY CONCAT(dc.[FirstName], ' ', dc.[LastName]), DATEPART(YEAR, CAST(fso.[OrderDate] as Date)), DATEPART(MONTH, CAST(fso.[OrderDate] as Date))

-- vagy

SELECT
    CONCAT(dc.[FirstName], ' ', dc.[LastName]) [FullName]
    ,CONCAT(dd.Year, '-', dd.Month) [Date]
    ,SUM(CAST(fso.[OrderQty] as INT)) [OrderQty]
    ,SUM(CAST(fso.[OrderQty] as INT) * CAST(fso.[UnitPrice] as FLOAT)) [TotalPrice]
    ,SUM(CAST(fso.[UnitPrice] as FLOAT)) [UnitPrice]
FROM [AdWorkDM].[dbo].[DimCustomer] dc
LEFT JOIN [AdWorkDM].[dbo].[FactSalesOrder] fso ON fso.[DimCustomerID] = dc.[DimCustomerID]
LEFT JOIN [AdWorkDM].[dbo].[DimDate] dd ON dd.[DimDateID] = fso.[DimDateID]
GROUP BY CONCAT(dc.[FirstName], ' ', dc.[LastName]), dd.Year, dd.Month

-- 5. Listázzuk ki, hogy melyik termékmodellből mekkora értékű rendelés érkezett be eddig.
SELECT
    dp.[DimProductID]
    ,SUM(CAST(fso.[OrderQty] as INT)) * SUM(CAST(fso.[UnitPrice] as FLOAT)) OrderPrice
FROM [AdWorkDM].[dbo].[DimProduct] dp
LEFT JOIN [AdWorkDM].[dbo].[FactSalesOrder] fso ON fso.[DimProductID] = dp.[DimProductID]
GROUP BY dp.[DimProductID]
