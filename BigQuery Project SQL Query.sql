 
 
/*  (A)   All Year Data Analysis (1948-2023) */
 
 
 -- Count Total Number of Countries in the Dataset

SELECT COUNT(DISTINCT ReporterCountry) AS Total_Countries
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`;

 --  Countries Name in the Dataset

SELECT DISTINCT ReporterCountry AS Countries
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`;


-- how many Year's Data Available

SELECT  DISTINCT Year AS Year_data
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
order by Year_data asc;


-- Merchandise Product info 

SELECT DISTINCT Product AS Product
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`;


-- Total Trade Value by Year (Million USD) (1948-2023)

SELECT Year, SUM(Value_MillionUSD) AS Total_Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
where Product="Total merchandise"
GROUP BY Year
ORDER BY Year;

-- Top-10 World Trade Year (1948-2023)

SELECT Year, SUM(Value_MillionUSD) AS Total_Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
where Product="Total merchandise"
GROUP BY Year
ORDER BY Total_Trade_Value desc limit 10;

--  Top 10 Trading Countries by Total Trade Value (Year 1948-2023)

SELECT ReporterCountry, SUM(Value_MillionUSD) AS Total_Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
where Product="Total merchandise"
GROUP BY ReporterCountry
ORDER BY Total_Trade_Value DESC
LIMIT 10;

 -- Most Traded Products Globally (Yaer 1948-2023)

SELECT Product, SUM(Value_MillionUSD) AS Total_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
where Product !="Total merchandise"
GROUP BY Product
ORDER BY Total_Value DESC
LIMIT 10;


-- Yearly Growth of Trade Value  (1948-2023)

WITH YearlyTrade AS (
    SELECT 
        Year, 
        SUM(Value_MillionUSD) AS Trade_Value
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product="Total merchandise"
    GROUP BY Year
)
SELECT 
    Year, 
    Trade_Value, 
    LAG(Trade_Value) OVER (ORDER BY Year) AS Prev_Year_Trade_Value,
    ROUND(((Trade_Value - LAG(Trade_Value) OVER (ORDER BY Year)) / LAG(Trade_Value) OVER (ORDER BY Year)) * 100, 2) AS Growth_Percentage
FROM YearlyTrade
order by Year;

--Most Traded Product by Country (Get the most traded product for each country) (1948-2023)

WITH ProductTrade AS (
    SELECT 
        ReporterCountry, 
        Product, 
        SUM(Value_MillionUSD) AS Trade_Value,
        RANK() OVER (PARTITION BY ReporterCountry ORDER BY SUM(Value_MillionUSD) DESC) AS rnk
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product !="Total merchandise"
    GROUP BY ReporterCountry, Product
)
SELECT ReporterCountry, Product, Trade_Value
FROM ProductTrade
WHERE rnk = 1
order by ReporterCountry ;

-- Trade Volume Distribution Across Product Categories (1948-2023)

SELECT 
    ProductCode, 
    Product, 
    SUM(Value_MillionUSD) AS Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
where Product !="Total merchandise"
GROUP BY ProductCode, Product
ORDER BY Trade_Value DESC;

-- Countries with the Largest Trade Surplus (1948-2023)

 WITH TradeSurplus AS (
    SELECT 
        ReporterCountry, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where  Product ="Total merchandise"
    GROUP BY ReporterCountry
)
SELECT 
    ReporterCountry, 
    Total_Exports, 
    Total_Imports, 
    (Total_Exports - Total_Imports) AS Trade_Surplus
FROM TradeSurplus
WHERE Total_Exports > Total_Imports
ORDER BY Trade_Surplus DESC
LIMIT 10;

-- Countries with the Largest Trade Deficit (1948-2023)

WITH TradeDeficit AS (
    SELECT 
        ReporterCountry, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where  Product ="Total merchandise"
    GROUP BY ReporterCountry
)
SELECT 
    ReporterCountry, 
    Total_Exports, 
    Total_Imports, 
    (Total_Imports - Total_Exports) AS Trade_Deficit
FROM TradeDeficit
WHERE Total_Imports > Total_Exports
ORDER BY Trade_Deficit DESC
LIMIT 10;


-- Yearly Global Trade Balance  (1948-2023)

WITH TradeBalance AS (
    SELECT 
        Year, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    GROUP BY Year
)
SELECT 
    Year, 
    Global_Exports, 
    Global_Imports, 
    (Global_Exports - Global_Imports) AS Global_Trade_Balance
FROM TradeBalance
ORDER BY Year;




/*  (B)  Year Specific Data Analysis */



-- Get the total trade value for a particular year 2023

SELECT 
    Year, 
    SUM(Value_MillionUSD) AS Total_Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
WHERE Year = 2023 AND Product ="Total merchandise" 
GROUP BY Year;

-- Top 10 Trading Countries in a Year 2023

SELECT 
    ReporterCountry, 
    SUM(Value_MillionUSD) AS Total_Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
WHERE Year = 2023 AND Product ="Total merchandise" 
GROUP BY ReporterCountry
ORDER BY Total_Trade_Value DESC
LIMIT 10;


-- Most Traded Product in 2023

SELECT Product, SUM(Value_MillionUSD) AS Total_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
where Product !="Total merchandise" and Year=2023
GROUP BY Product
ORDER BY Total_Value DESC
LIMIT 10;


-- Top 10 Exporting Countries in 2023


SELECT ReporterCountry, SUM(Value_MillionUSD) AS Total_Export
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
WHERE Year = 2023 AND Indicator = 'exports'AND Product="Total merchandise"
GROUP BY ReporterCountry
ORDER BY Total_Export DESC
LIMIT 10;

-- Top 10 Importing Countries in 2023

SELECT ReporterCountry, SUM(Value_MillionUSD) AS Total_Import
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
WHERE Year = 2023 AND Indicator = 'imports'AND Product="Total merchandise"
GROUP BY ReporterCountry
ORDER BY Total_Import DESC
LIMIT 10;

-- Countries with the Largest Trade Surplus (2023)

 WITH TradeSurplus AS (
    SELECT 
        ReporterCountry, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where  Product ="Total merchandise" and Year=2023
    GROUP BY ReporterCountry
)
SELECT 
    ReporterCountry, 
    Total_Exports, 
    Total_Imports, 
    (Total_Exports - Total_Imports) AS Trade_Surplus
FROM TradeSurplus
WHERE Total_Exports > Total_Imports
ORDER BY Trade_Surplus DESC
LIMIT 10;


-- Countries with the Largest Trade Deficit (2023)

WITH TradeDeficit AS (
    SELECT 
        ReporterCountry, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where  Product ="Total merchandise" AND Year=2023
    GROUP BY ReporterCountry
)
SELECT 
    ReporterCountry, 
    Total_Exports, 
    Total_Imports, 
    (Total_Imports - Total_Exports) AS Trade_Deficit
FROM TradeDeficit
WHERE Total_Imports > Total_Exports
ORDER BY Trade_Deficit DESC
LIMIT 10;


--  Global Trade Balance (2023)

WITH TradeBalance AS (
    SELECT 
        Year, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise" And Year=2023
    GROUP BY Year
)
SELECT 
    Year, 
    Global_Exports, 
    Global_Imports, 
    (Global_Exports - Global_Imports) AS Global_Trade_Balance
FROM TradeBalance
ORDER BY Year;


-- yaer 2023 overall  import And Export %

WITH TradeTotals AS (
    SELECT 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Year = 2023 and Product ="Total merchandise"
)
SELECT 
    Total_Exports,
    Total_Imports,
    (Total_Exports + Total_Imports) AS Total_Trade,
    ROUND((Total_Exports / NULLIF((Total_Exports + Total_Imports), 0)) * 100, 2) AS Export_Percentage,
    ROUND((Total_Imports / NULLIF((Total_Exports + Total_Imports), 0)) * 100, 2) AS Import_Percentage
FROM TradeTotals;



-- country wise import and export in 2023 data in % also

WITH CountryTrade AS (
    SELECT 
        ReporterCountry, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Year = 2023 and Product ="Total merchandise"
    GROUP BY ReporterCountry
)
SELECT 
    ReporterCountry, 
    Total_Exports,
    Total_Imports,
    (Total_Exports + Total_Imports) AS Total_Trade,
    ROUND((Total_Exports / NULLIF((Total_Exports + Total_Imports), 0)) * 100, 2) AS Export_Percentage,
    ROUND((Total_Imports / NULLIF((Total_Exports + Total_Imports), 0)) * 100, 2) AS Import_Percentage
FROM CountryTrade
ORDER BY Total_Trade DESC;

-- each country's share in total world trade (exports + imports) in 2023

WITH CountryTrade AS (
    SELECT 
        ReporterCountry, 
        SUM(Value_MillionUSD) AS Country_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Year = 2023 and Product ="Total merchandise"
    GROUP BY ReporterCountry
), 
WorldTrade AS (
    SELECT SUM(Country_Total_Trade) AS Global_Trade
    FROM CountryTrade
)
SELECT 
    c.ReporterCountry, 
    c.Country_Total_Trade, 
    w.Global_Trade,
    ROUND((c.Country_Total_Trade / NULLIF(w.Global_Trade, 0)) * 100, 2) AS Trade_Percentage
FROM CountryTrade c, WorldTrade w
ORDER BY Trade_Percentage DESC;

-- each country's share in total world trade, exports, and imports separately in 2023

WITH CountryTrade AS (
    SELECT 
        ReporterCountry, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Country_Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Country_Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Year = 2023 and Product ="Total merchandise"
    GROUP BY ReporterCountry
), 
WorldTrade AS (
    SELECT 
        SUM(Country_Total_Exports) AS Global_Exports,
        SUM(Country_Total_Imports) AS Global_Imports
    FROM CountryTrade
)
SELECT 
    c.ReporterCountry, 
    c.Country_Total_Exports, 
    w.Global_Exports,
    ROUND((c.Country_Total_Exports / NULLIF(w.Global_Exports, 0)) * 100, 2) AS Export_Percentage,
    c.Country_Total_Imports, 
    w.Global_Imports,
    ROUND((c.Country_Total_Imports / NULLIF(w.Global_Imports, 0)) * 100, 2) AS Import_Percentage,
    (c.Country_Total_Exports + c.Country_Total_Imports) AS Country_Total_Trade,
    (w.Global_Exports + w.Global_Imports) AS Global_Trade,
    ROUND(((c.Country_Total_Exports + c.Country_Total_Imports) / NULLIF((w.Global_Exports + w.Global_Imports), 0)) * 100, 2) AS Trade_Percentage
FROM CountryTrade c, WorldTrade w
ORDER BY Trade_Percentage DESC;



-- To rank countries separately by total exports and total imports in 2023


WITH CountryTrade AS (
    SELECT 
        ReporterCountry, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Country_Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Country_Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Year = 2023 and Product ="Total merchandise"
    GROUP BY ReporterCountry
)

SELECT 
    ReporterCountry,
    Country_Total_Exports,
    RANK() OVER (ORDER BY Country_Total_Exports DESC) AS Export_Rank,
    Country_Total_Imports,
    RANK() OVER (ORDER BY Country_Total_Imports DESC) AS Import_Rank
FROM CountryTrade
ORDER BY Export_Rank;



-- To rank countries by trade deficit (highest to lowest) in 2023

WITH CountryTrade AS (
    SELECT 
        ReporterCountry, 
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Country_Total_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Country_Total_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Year = 2023 and Product ="Total merchandise"
    GROUP BY ReporterCountry
)

SELECT 
    ReporterCountry,
    Country_Total_Exports,
    Country_Total_Imports,
    (Country_Total_Imports - Country_Total_Exports) AS Trade_Deficit,
    RANK() OVER (ORDER BY (Country_Total_Imports - Country_Total_Exports) DESC) AS Deficit_Rank
FROM CountryTrade
WHERE (Country_Total_Imports - Country_Total_Exports) > 0  -- Ensures only countries with a deficit are ranked
ORDER BY Trade_Deficit DESC;


/*  (C) Specific Data Analysis For India */




-- the total trade value (exports + imports) for India across all years (1948-2023)

SELECT 
    Year, 
    SUM(Value_MillionUSD) AS Total_Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
WHERE ReporterCountry = 'India' and Product ="Total merchandise"
GROUP BY Year
ORDER BY Year;


--  India's role in global trade (import + export) year-wise in percentage (1948-2023)

WITH IndiaTrade AS (
    SELECT Year, 
           SUM(Value_MillionUSD) AS India_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'India' and  Product ="Total merchandise"
    GROUP BY Year
),
GlobalTrade AS (
    SELECT Year, 
           SUM(Value_MillionUSD) AS Global_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    GROUP BY Year
)
SELECT i.Year, 
       i.India_Total_Trade, 
       g.Global_Total_Trade, 
       ROUND((i.India_Total_Trade / g.Global_Total_Trade) * 100, 2) AS India_Trade_Percentage
FROM IndiaTrade i
JOIN GlobalTrade g ON i.Year = g.Year
ORDER BY i.Year DESC;

-- India's Global Trade (import + export) Rank (Year-Wise)


WITH CountryTrade AS (
    SELECT 
        Year, 
        ReporterCountry, 
        SUM(Value_MillionUSD) AS Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    GROUP BY Year, ReporterCountry
),
RankedTrade AS (
    SELECT 
        Year, 
        ReporterCountry, 
        Total_Trade, 
        RANK() OVER (PARTITION BY Year ORDER BY Total_Trade DESC) AS Trade_Rank
    FROM CountryTrade
)
SELECT Year, ReporterCountry, Total_Trade, Trade_Rank
FROM RankedTrade
WHERE ReporterCountry = 'India'
ORDER BY Year DESC;


--  India’s year-wise export & import percentage globally and its global rank


WITH IndiaTrade AS (
    SELECT 
        Year, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS India_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS India_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'India' and Product ="Total merchandise"
    GROUP BY Year
),
GlobalTrade AS (
    SELECT 
        Year, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    GROUP BY Year
),
CountryRank AS (
    SELECT 
        Year, 
        ReporterCountry, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Export_Rank,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Import_Rank
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    GROUP BY Year, ReporterCountry
)
SELECT 
    i.Year, 
    i.India_Exports, 
    g.Global_Exports, 
    ROUND((i.India_Exports / g.Global_Exports) * 100, 2) AS India_Export_Percentage,
    c.Export_Rank,
    i.India_Imports, 
    g.Global_Imports, 
    ROUND((i.India_Imports / g.Global_Imports) * 100, 2) AS India_Import_Percentage,
    c.Import_Rank
FROM IndiaTrade i
JOIN GlobalTrade g ON i.Year = g.Year
JOIN CountryRank c ON i.Year = c.Year AND c.ReporterCountry = 'India'
ORDER BY i.Year DESC;



-- calculate India's trade deficit for all years (1948-2023)

WITH IndiaTrade AS (
    SELECT 
        Year,
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS India_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS India_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'India' and Product ="Total merchandise"
    GROUP BY Year
)
SELECT 
    Year,
    India_Exports,
    India_Imports,
    (India_Imports - India_Exports) AS Trade_Deficit,
    CASE 
        WHEN (India_Imports - India_Exports) > 0 THEN 'Trade Deficit'
        ELSE 'Trade Surplus'
    END AS Trade_Status
FROM IndiaTrade
ORDER BY Year;


-- To analyze India's year-wise trade growth (or decline) in exports, imports, and trade balance


WITH IndiaTrade AS (
    SELECT 
        Year,
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS India_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS India_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'India' and Product ="Total merchandise"
    GROUP BY Year
),
IndiaTradeGrowth AS (
    SELECT 
        Year,
        India_Exports,
        India_Imports,
        (India_Exports - India_Imports) AS Trade_Balance,

        -- Percentage Growth in Exports
        LAG(India_Exports) OVER (ORDER BY Year) AS Prev_Exports,
        ROUND(((India_Exports - LAG(India_Exports) OVER (ORDER BY Year)) / NULLIF(LAG(India_Exports) OVER (ORDER BY Year), 0)) * 100, 2) AS Export_Growth_Percentage,

        -- Percentage Growth in Imports
        LAG(India_Imports) OVER (ORDER BY Year) AS Prev_Imports,
        ROUND(((India_Imports - LAG(India_Imports) OVER (ORDER BY Year)) / NULLIF(LAG(India_Imports) OVER (ORDER BY Year), 0)) * 100, 2) AS Import_Growth_Percentage,

        -- Percentage Growth in Trade Balance
        LAG(India_Exports - India_Imports) OVER (ORDER BY Year) AS Prev_Trade_Balance,
        ROUND((((India_Exports - India_Imports) - LAG(India_Exports - India_Imports) OVER (ORDER BY Year)) / NULLIF(LAG(India_Exports - India_Imports) OVER (ORDER BY Year), 0)) * 100, 2) AS Trade_Balance_Growth_Percentage
    FROM IndiaTrade
)
SELECT 
    Year,
    India_Exports,
    Export_Growth_Percentage,
    India_Imports,
    Import_Growth_Percentage,
    Trade_Balance,
    Trade_Balance_Growth_Percentage,
    CASE 
        WHEN Export_Growth_Percentage > 0 THEN 'Export Growth'
        ELSE 'Export Decline'
    END AS Export_Status,
    CASE 
        WHEN Import_Growth_Percentage > 0 THEN 'Import Growth'
        ELSE 'Import Decline'
    END AS Import_Status,
    CASE 
        WHEN Trade_Balance_Growth_Percentage > 0 THEN 'Trade Balance Improvement'
        ELSE 'Trade Balance Worsened'
    END AS Trade_Balance_Status
FROM IndiaTradeGrowth
ORDER BY Year;


--  India's Top Export Product (Year-wise) (1948-2023)


WITH IndiaExports AS (
    SELECT 
        Year,
        Product,
        SUM(Value_MillionUSD) AS Total_Export_Value
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE LOWER(ReporterCountry) = 'india'  
        AND LOWER(Product) != 'total merchandise'  
        AND LOWER(Indicator) = 'exports'  
    GROUP BY Year, Product
),
RankedExports AS (
    SELECT 
        Year,
        Product AS Top_Export_Product,
        Total_Export_Value,
        RANK() OVER (PARTITION BY Year ORDER BY Total_Export_Value DESC) AS Export_Rank
    FROM IndiaExports
)
SELECT 
    Year,
    Top_Export_Product,
    Total_Export_Value AS Export_Value_MillionUSD
FROM RankedExports
WHERE Export_Rank = 1
ORDER BY Year;

--  India's Top Import Product (Year-wise) (1948-2023)

WITH IndiaImports AS (
    SELECT 
        Year,
        Product,
        SUM(Value_MillionUSD) AS Total_Import_Value
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE LOWER(ReporterCountry) = 'india'  
        AND LOWER(Product) != 'total merchandise'  
        AND LOWER(Indicator) = 'imports'  
    GROUP BY Year, Product
),
RankedImports AS (
    SELECT 
        Year,
        Product AS Top_Import_Product,
        Total_Import_Value,
        RANK() OVER (PARTITION BY Year ORDER BY Total_Import_Value DESC) AS Import_Rank
    FROM IndiaImports
)
SELECT 
    Year,
    Top_Import_Product,
    Total_Import_Value AS Import_Value_MillionUSD
FROM RankedImports
WHERE Import_Rank = 1
ORDER BY Year;

-- India's Export Product-Wise Percentage (2023)

WITH IndiaExports AS (
    SELECT 
        Product,
        SUM(Value_MillionUSD) AS Total_Export_Value
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE LOWER(ReporterCountry) = 'india'  
        AND LOWER(Product) != 'total merchandise'  
        AND LOWER(Indicator) = 'exports'  
        AND Year = 2023
    GROUP BY Product
),
TotalExports AS (
    SELECT SUM(Total_Export_Value) AS Grand_Total_Exports FROM IndiaExports
)
SELECT 
    e.Product,
    e.Total_Export_Value,
    ROUND((e.Total_Export_Value / t.Grand_Total_Exports) * 100, 2) AS Export_Percentage
FROM IndiaExports e, TotalExports t
ORDER BY Export_Percentage DESC;



-- India's Import Product-Wise Percentage (2023)

WITH IndiaImports AS (
    SELECT 
        Product,
        SUM(Value_MillionUSD) AS Total_Import_Value
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE LOWER(ReporterCountry) = 'india'  
        AND LOWER(Product) != 'total merchandise'  
        AND LOWER(Indicator) = 'imports'  
        AND Year = 2023
    GROUP BY Product
),
TotalImports AS (
    SELECT SUM(Total_Import_Value) AS Grand_Total_Imports FROM IndiaImports
)
SELECT 
    i.Product,
    i.Total_Import_Value,
    ROUND((i.Total_Import_Value / t.Grand_Total_Imports) * 100, 2) AS Import_Percentage
FROM IndiaImports i, TotalImports t
ORDER BY Import_Percentage DESC;



--  case Study : China :  China’s year-wise import, export, total trade, global percentage, and rank and Trade Deficit also

WITH ChinaTrade AS (
    SELECT 
        Year, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS China_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS China_Imports,
        SUM(Value_MillionUSD) AS China_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'China' and Product ="Total merchandise"
    GROUP BY Year
),
GlobalTrade AS (
    SELECT 
        Year, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports,
        SUM(Value_MillionUSD) AS Global_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    GROUP BY Year
),
CountryRank AS (
    SELECT 
        Year, 
        ReporterCountry, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports,
        SUM(Value_MillionUSD) AS Total_Trade,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Export_Rank,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Import_Rank,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(Value_MillionUSD) DESC) AS Trade_Rank
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    GROUP BY Year, ReporterCountry
)
SELECT 
    c.Year, 
    c.China_Exports, 
    g.Global_Exports, 
    ROUND((c.China_Exports / g.Global_Exports) * 100, 2) AS China_Export_Percentage,
    r.Export_Rank,
    c.China_Imports, 
    g.Global_Imports, 
    ROUND((c.China_Imports / g.Global_Imports) * 100, 2) AS China_Import_Percentage,
    r.Import_Rank,
    c.China_Total_Trade, 
    g.Global_Total_Trade, 
    ROUND((c.China_Total_Trade / g.Global_Total_Trade) * 100, 2) AS China_Total_Trade_Percentage,
    r.Trade_Rank,
    (c.China_Imports - c.China_Exports) AS Trade_Deficit
FROM ChinaTrade c
JOIN GlobalTrade g ON c.Year = g.Year
JOIN CountryRank r ON c.Year = r.Year AND r.ReporterCountry = 'China'
ORDER BY c.Year DESC;


--  case Study : USA : USA's Global Trade Performance with Trade Deficit


WITH USATrade AS (
    SELECT 
        Year, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS USA_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS USA_Imports,
        SUM(Value_MillionUSD) AS USA_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'United States of America'AND Product ="Total merchandise"
    GROUP BY Year
),
GlobalTrade AS (
    SELECT 
        Year, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports,
        SUM(Value_MillionUSD) AS Global_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    
    GROUP BY Year
),
CountryRank AS (
    SELECT 
        Year, 
        ReporterCountry, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports,
        SUM(Value_MillionUSD) AS Total_Trade,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Export_Rank,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Import_Rank,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(Value_MillionUSD) DESC) AS Trade_Rank
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    
    GROUP BY Year, ReporterCountry
)
SELECT 
    u.Year, 
    u.USA_Exports, 
    g.Global_Exports, 
    ROUND((u.USA_Exports / g.Global_Exports) * 100, 2) AS USA_Export_Percentage,
    r.Export_Rank,
    u.USA_Imports, 
    g.Global_Imports, 
    ROUND((u.USA_Imports / g.Global_Imports) * 100, 2) AS USA_Import_Percentage,
    r.Import_Rank,
    u.USA_Total_Trade, 
    g.Global_Total_Trade, 
    ROUND((u.USA_Total_Trade / g.Global_Total_Trade) * 100, 2) AS USA_Total_Trade_Percentage,
    r.Trade_Rank,
    (u.USA_Imports - u.USA_Exports) AS Trade_Deficit
FROM USATrade u
JOIN GlobalTrade g ON u.Year = g.Year
JOIN CountryRank r ON u.Year = r.Year AND r.ReporterCountry = 'United States of America'
ORDER BY u.Year DESC;



--  India's Global Trade Case Study (1948-2023) (All info in Single Table)

WITH IndiaTrade AS (
    SELECT 
        Year, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS India_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS India_Imports,
        SUM(Value_MillionUSD) AS India_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'India' and Product ="Total merchandise"
    GROUP BY Year
),
GlobalTrade AS (
    SELECT 
        Year, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports,
        SUM(Value_MillionUSD) AS Global_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    GROUP BY Year
),
CountryRank AS (
    SELECT 
        Year, 
        ReporterCountry, 
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports,
        SUM(Value_MillionUSD) AS Total_Trade,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Export_Rank,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Import_Rank,
        RANK() OVER (PARTITION BY Year ORDER BY SUM(Value_MillionUSD) DESC) AS Trade_Rank
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product ="Total merchandise"
    GROUP BY Year, ReporterCountry
),
FinalData AS (
    SELECT 
        i.Year, 
        i.India_Exports, 
        g.Global_Exports, 
        ROUND((i.India_Exports / g.Global_Exports) * 100, 2) AS India_Export_Percentage,
        r.Export_Rank,
        LAG(i.India_Exports) OVER (ORDER BY i.Year) AS Prev_Exports,
        ROUND(((i.India_Exports - LAG(i.India_Exports) OVER (ORDER BY i.Year)) / NULLIF(LAG(i.India_Exports) OVER (ORDER BY i.Year), 0)) * 100, 2) AS Export_Growth_Percentage,

        i.India_Imports, 
        g.Global_Imports, 
        ROUND((i.India_Imports / g.Global_Imports) * 100, 2) AS India_Import_Percentage,
        r.Import_Rank,
        LAG(i.India_Imports) OVER (ORDER BY i.Year) AS Prev_Imports,
        ROUND(((i.India_Imports - LAG(i.India_Imports) OVER (ORDER BY i.Year)) / NULLIF(LAG(i.India_Imports) OVER (ORDER BY i.Year), 0)) * 100, 2) AS Import_Growth_Percentage,

        i.India_Total_Trade, 
        g.Global_Total_Trade, 
        ROUND((i.India_Total_Trade / g.Global_Total_Trade) * 100, 2) AS India_Total_Trade_Percentage,
        r.Trade_Rank,
        LAG(i.India_Total_Trade) OVER (ORDER BY i.Year) AS Prev_Total_Trade,
        ROUND(((i.India_Total_Trade - LAG(i.India_Total_Trade) OVER (ORDER BY i.Year)) / NULLIF(LAG(i.India_Total_Trade) OVER (ORDER BY i.Year), 0)) * 100, 2) AS Total_Trade_Growth_Percentage,

        (i.India_Imports - i.India_Exports) AS Trade_Deficit,
        LAG(i.India_Imports - i.India_Exports) OVER (ORDER BY i.Year) AS Prev_Trade_Deficit,
        ROUND((((i.India_Imports - i.India_Exports) - LAG(i.India_Imports - i.India_Exports) OVER (ORDER BY i.Year)) / NULLIF(LAG(i.India_Imports - i.India_Exports) OVER (ORDER BY i.Year), 0)) * 100, 2) AS Trade_Deficit_Growth_Percentage
    FROM IndiaTrade i
    JOIN GlobalTrade g ON i.Year = g.Year
    JOIN CountryRank r ON i.Year = r.Year AND r.ReporterCountry = 'India'
)
SELECT * FROM FinalData
ORDER BY Year DESC;


-- India's product-wise trade performance across all years (1948-2023)


WITH IndiaProductTrade AS (
    SELECT 
        Year, 
        Product,
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS India_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS India_Imports,
        SUM(Value_MillionUSD) AS India_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'India' AND Product != 'Total merchandise'
    GROUP BY Year, Product
),
GlobalProductTrade AS (
    SELECT 
        Year, 
        Product,
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports,
        SUM(Value_MillionUSD) AS Global_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Product != 'Total merchandise'
    GROUP BY Year, Product
),
ProductRank AS (
    SELECT 
        Year, 
        Product,
        ReporterCountry,
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Total_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Total_Imports,
        SUM(Value_MillionUSD) AS Total_Trade,
        RANK() OVER (PARTITION BY Year, Product ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Export_Rank,
        RANK() OVER (PARTITION BY Year, Product ORDER BY SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) DESC) AS Import_Rank,
        RANK() OVER (PARTITION BY Year, Product ORDER BY SUM(Value_MillionUSD) DESC) AS Trade_Rank
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Product != 'Total merchandise'
    GROUP BY Year, Product, ReporterCountry
),
FinalProductData AS (
    SELECT 
        i.Year, 
        i.Product, 
        i.India_Exports, 
        g.Global_Exports, 
        ROUND((i.India_Exports / g.Global_Exports) * 100, 2) AS India_Export_Percentage,
        r.Export_Rank,
        LAG(i.India_Exports) OVER (PARTITION BY i.Product ORDER BY i.Year) AS Prev_Exports,
        ROUND(((i.India_Exports - LAG(i.India_Exports) OVER (PARTITION BY i.Product ORDER BY i.Year)) / NULLIF(LAG(i.India_Exports) OVER (PARTITION BY i.Product ORDER BY i.Year), 0)) * 100, 2) AS Export_Growth_Percentage,

        i.India_Imports, 
        g.Global_Imports, 
        ROUND((i.India_Imports / g.Global_Imports) * 100, 2) AS India_Import_Percentage,
        r.Import_Rank,
        LAG(i.India_Imports) OVER (PARTITION BY i.Product ORDER BY i.Year) AS Prev_Imports,
        ROUND(((i.India_Imports - LAG(i.India_Imports) OVER (PARTITION BY i.Product ORDER BY i.Year)) / NULLIF(LAG(i.India_Imports) OVER (PARTITION BY i.Product ORDER BY i.Year), 0)) * 100, 2) AS Import_Growth_Percentage,

        i.India_Total_Trade, 
        g.Global_Total_Trade, 
        ROUND((i.India_Total_Trade / g.Global_Total_Trade) * 100, 2) AS India_Total_Trade_Percentage,
        r.Trade_Rank,
        LAG(i.India_Total_Trade) OVER (PARTITION BY i.Product ORDER BY i.Year) AS Prev_Total_Trade,
        ROUND(((i.India_Total_Trade - LAG(i.India_Total_Trade) OVER (PARTITION BY i.Product ORDER BY i.Year)) / NULLIF(LAG(i.India_Total_Trade) OVER (PARTITION BY i.Product ORDER BY i.Year), 0)) * 100, 2) AS Total_Trade_Growth_Percentage,

        (i.India_Imports - i.India_Exports) AS Trade_Deficit,
        LAG(i.India_Imports - i.India_Exports) OVER (PARTITION BY i.Product ORDER BY i.Year) AS Prev_Trade_Deficit,
        ROUND((((i.India_Imports - i.India_Exports) - LAG(i.India_Imports - i.India_Exports) OVER (PARTITION BY i.Product ORDER BY i.Year)) / NULLIF(LAG(i.India_Imports - i.India_Exports) OVER (PARTITION BY i.Product ORDER BY i.Year), 0)) * 100, 2) AS Trade_Deficit_Growth_Percentage
    FROM IndiaProductTrade i
    JOIN GlobalProductTrade g ON i.Year = g.Year AND i.Product = g.Product
    JOIN ProductRank r ON i.Year = r.Year AND i.Product = r.Product AND r.ReporterCountry = 'India'
)
SELECT * FROM FinalProductData
ORDER BY Year DESC, Product;


-- Global Trade Rankings  (1948-2023): Country-Wise Export, Import, and Trade Deficit Analysis


WITH CountryTrade AS (
    SELECT 
        Year, 
        ReporterCountry AS Country,
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Imports,
        SUM(Value_MillionUSD) AS Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product = 'Total merchandise'
    GROUP BY Year, ReporterCountry
),
GlobalTrade AS (
    SELECT 
        Year,
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports,
        SUM(Value_MillionUSD) AS Global_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    where Product = 'Total merchandise'
    GROUP BY Year
)
SELECT 
    c.Year, 
    c.Country, 
    c.Exports, 
    ROUND((c.Exports / g.Global_Exports) * 100, 2) AS Export_Percentage_Global, 
    RANK() OVER (PARTITION BY c.Year ORDER BY c.Exports DESC) AS Export_Rank,
    
    c.Imports, 
    ROUND((c.Imports / g.Global_Imports) * 100, 2) AS Import_Percentage_Global, 
    RANK() OVER (PARTITION BY c.Year ORDER BY c.Imports DESC) AS Import_Rank,
    
    c.Total_Trade, 
    ROUND((c.Total_Trade / g.Global_Total_Trade) * 100, 2) AS Total_Trade_Percentage_Global, 
    RANK() OVER (PARTITION BY c.Year ORDER BY c.Total_Trade DESC) AS Trade_Rank,
    
    (c.Imports - c.Exports) AS Trade_Deficit,
    LAG(c.Imports - c.Exports) OVER (PARTITION BY c.Country ORDER BY c.Year) AS Prev_Trade_Deficit,
    ROUND(((c.Imports - c.Exports) - LAG(c.Imports - c.Exports) OVER (PARTITION BY c.Country ORDER BY c.Year)) / 
    NULLIF(LAG(c.Imports - c.Exports) OVER (PARTITION BY c.Country ORDER BY c.Year), 0) * 100, 2) AS Trade_Deficit_Growth_Percentage
FROM CountryTrade c
JOIN GlobalTrade g ON c.Year = g.Year
ORDER BY c.Year DESC, Trade_Rank;



-- Global Trade Rankings (2023): Country-Wise Export, Import, and Trade Deficit Analysis



WITH CountryTrade AS (
    SELECT 
        Year, 
        ReporterCountry AS Country,
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Imports,
        SUM(Value_MillionUSD) AS Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Year = 2023 and Product = 'Total merchandise'
    GROUP BY Year, ReporterCountry
),
GlobalTrade AS (
    SELECT 
        Year,
        SUM(CASE WHEN LOWER(Indicator) = 'exports' THEN Value_MillionUSD ELSE 0 END) AS Global_Exports,
        SUM(CASE WHEN LOWER(Indicator) = 'imports' THEN Value_MillionUSD ELSE 0 END) AS Global_Imports,
        SUM(Value_MillionUSD) AS Global_Total_Trade
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Year = 2023 and Product = 'Total merchandise'
    GROUP BY Year
)
SELECT 
    c.Year, 
    c.Country, 
    c.Exports, 
    ROUND((c.Exports / g.Global_Exports) * 100, 2) AS Export_Percentage_Global, 
    RANK() OVER (ORDER BY c.Exports DESC) AS Export_Rank,
    
    c.Imports, 
    ROUND((c.Imports / g.Global_Imports) * 100, 2) AS Import_Percentage_Global, 
    RANK() OVER (ORDER BY c.Imports DESC) AS Import_Rank,
    
    c.Total_Trade, 
    ROUND((c.Total_Trade / g.Global_Total_Trade) * 100, 2) AS Total_Trade_Percentage_Global, 
    RANK() OVER (ORDER BY c.Total_Trade DESC) AS Trade_Rank,
    
    (c.Imports - c.Exports) AS Trade_Deficit
FROM CountryTrade c
JOIN GlobalTrade g ON c.Year = g.Year
ORDER BY Trade_Rank;













