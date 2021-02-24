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

