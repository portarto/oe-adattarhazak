# Hf

## *Oldjátok meg a következő feladatokat a laboron használt csillagsémán keresztül:*

![https://raw.githubusercontent.com/portarto/oe-adattarhazak/main/02-mssql/star-schema.png](https://raw.githubusercontent.com/portarto/oe-adattarhazak/main/02-mssql/star-schema.png)

## 1. Kérdezzük le, hogy melyik termékkategóriában hány darab termék található
```
SELECT
    [ProductCategory]
    ,COUNT(*) NumberOfProducts
FROM [AdWorkDM].[dbo].[DimProduct]
GROUP BY [ProductCategory]
```

## 2. Listázzuk ki dátumok szerint, hogy napokra lebontva hány darab terméket adtunk el.
Segítség: SUM() a VARCHAR miatt nem fog működni, így kasztolni kell, amit a CAST() függvénnyel tehetünk meg.
```
SELECT
    CAST([OrderDate] as Date)
    ,SUM(CAST([OrderQty] as INT))
FROM [AdWorkDM].[dbo].[FactSalesOrder]
GROUP BY CAST([OrderDate] as Date)
```

## 3. Melyik termékszínből hány darab megrendelés futott be és mennyi volt ezeknek a rendeléseknek az összege (egységár * db szám) ?
Segítség: itt INT és FLOAT típusokba kell majd kasztolni a VARCHAR adattípust a lekérdezésben.
```
SELECT
    [Color]
    ,SUM(CAST(fso.[OrderQty] as INT) * CAST(fso.[UnitPrice] as FLOAT)) OrderPrice
FROM [AdWorkDM].[dbo].[DimProduct] dp
LEFT JOIN [AdWorkDM].[dbo].[FactSalesOrder] fso ON fso.[DimProductID] = dp.[DimProductID]
GROUP BY [Color]
```

## 4. Listázzuk ki, hogy melyik vásárló (teljes név) hány darab terméket és mekkora értékben vásárolt havi lebontásban!
Segítség: A név összefűzéséhez használjuk a CONCAT() függvényt.
```
SELECT
    CONCAT(MIN(dc.[FirstName]), ' ', MIN(dc.[LastName])) [FullName]
    ,CONCAT(DATEPART(YEAR, CAST(fso.[OrderDate] as Date)), '-', DATEPART(MONTH, CAST(fso.[OrderDate] as Date))) [Date]
    ,SUM(CAST(fso.[OrderQty] as INT)) [OrderQty]
    ,SUM(CAST(fso.[OrderQty] as INT) * CAST(fso.[UnitPrice] as FLOAT)) [TotalPrice]
    ,SUM(CAST(fso.[UnitPrice] as FLOAT)) [UnitPrice]
FROM [AdWorkDM].[dbo].[DimCustomer] dc
LEFT JOIN [AdWorkDM].[dbo].[FactSalesOrder] fso ON fso.[DimCustomerID] = dc.[DimCustomerID]
GROUP BY dc.[DimCustomerID], DATEPART(YEAR, CAST(fso.[OrderDate] as Date)), DATEPART(MONTH, CAST(fso.[OrderDate] as Date))
```

### vagy

```
SELECT
    CONCAT(MIN(dc.[FirstName]), ' ', MIN(dc.[LastName])) [FullName]
    ,CONCAT(dd.Year, '-', dd.Month) [Date]
    ,SUM(CAST(fso.[OrderQty] as INT)) [OrderQty]
    ,SUM(CAST(fso.[OrderQty] as INT) * CAST(fso.[UnitPrice] as FLOAT)) [TotalPrice]
    ,SUM(CAST(fso.[UnitPrice] as FLOAT)) [UnitPrice]
FROM [AdWorkDM].[dbo].[DimCustomer] dc
LEFT JOIN [AdWorkDM].[dbo].[FactSalesOrder] fso ON fso.[DimCustomerID] = dc.[DimCustomerID]
LEFT JOIN [AdWorkDM].[dbo].[DimDate] dd ON dd.[DimDateID] = fso.[DimDateID]
GROUP BY dc.[DimCustomerID], dd.Year, dd.Month
```

## 5. Listázzuk ki, hogy melyik termékmodellből mekkora értékű rendelés érkezett be eddig.
```
SELECT
    dp.[DimProductID]
    ,SUM(CAST(fso.[OrderQty] as INT)) * SUM(CAST(fso.[UnitPrice] as FLOAT)) OrderPrice
FROM [AdWorkDM].[dbo].[DimProduct] dp
LEFT JOIN [AdWorkDM].[dbo].[FactSalesOrder] fso ON fso.[DimProductID] = dp.[DimProductID]
GROUP BY dp.[DimProductID]
```
