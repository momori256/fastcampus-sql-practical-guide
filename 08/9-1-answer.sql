-- Q1. 各プロモーションごとにレコード数、合計売上額、平均売上額を求める
SELECT 
    Promotion,
    COUNT(*) AS Records,
    SUM(SalesInThousands) AS TotalSales,
    AVG(SalesInThousands) AS AvgSales
FROM WA_MarketingCampaign
GROUP BY Promotion
ORDER BY Promotion;

-- Q2. プロモーションごとに週次平均売上額を求める
SELECT 
    Promotion,
    week,
    AVG(SalesInThousands) AS AvgWeeklySales
FROM WA_MarketingCampaign
GROUP BY Promotion, week
ORDER BY Promotion, week;

-- Q3. プロモーションごとに四分位数を求める
SELECT 
    'Promotion' || Promotion as Promotion,
    MIN(SalesInThousands) as Min,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY SalesInThousands) AS Q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY SalesInThousands) AS Q2,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY SalesInThousands) AS Q3,
    MAX(SalesInThousands) AS Max
FROM WA_MarketingCampaign
GROUP BY Promotion;

-- Q4. 市場規模 (Small/Medium/Large) ごとに平均売上額を求める
SELECT
    MarketSize,
    AVG(SalesInThousands) AS TotalSales,
    STDDEV(SalesInThousands) / AVG(SalesInThousands) AS CV
FROM WA_MarketingCampaign
GROUP BY MarketSize
ORDER BY MarketSize;

-- Q5. 店舗 (LocationID) ごとに各プロモーションが何度実施されたかを求める
SELECT
    LocationID,
    COUNT(CASE WHEN Promotion = 1 THEN 1 END) AS Promotion1,
    COUNT(CASE WHEN Promotion = 2 THEN 1 END) AS Promotion2,
    COUNT(CASE WHEN Promotion = 3 THEN 1 END) AS Promotion3
FROM
    WA_MarketingCampaign
GROUP BY
    LocationID
ORDER BY
    LocationID;

-- Q6. 各プロモーションに対して、プロモーションが実施された市場規模の割合を求める
SELECT
    Promotion,
    CAST(COUNT(CASE WHEN MarketSize = 'Small' THEN 1 END) AS REAL)
        / (SELECT COUNT(*) FROM WA_MarketingCampaign t WHERE t.Promotion = WA_MarketingCampaign.Promotion) AS Small,
    CAST(COUNT(CASE WHEN MarketSize = 'Medium' THEN 1 END) AS REAL)
        / (SELECT COUNT(*) FROM WA_MarketingCampaign t WHERE t.Promotion = WA_MarketingCampaign.Promotion) AS Medium,
    CAST(COUNT(CASE WHEN MarketSize = 'Large' THEN 1 END) AS REAL)
        / (SELECT COUNT(*) FROM WA_MarketingCampaign t WHERE t.Promotion = WA_MarketingCampaign.Promotion) AS Large
FROM
    WA_MarketingCampaign
GROUP BY
    Promotion;

WITH PromotionCounts AS (
    SELECT
        Promotion,
        COUNT(*) AS TotalCount
    FROM
        WA_MarketingCampaign
    GROUP BY
        Promotion
)
SELECT
    w.Promotion,
    ROUND(
        CAST(COUNT(CASE WHEN w.MarketSize = 'Small' THEN 1 END) AS REAL)
        / p.TotalCount,
        2
    ) AS Small,
    ROUND(
        CAST(COUNT(CASE WHEN w.MarketSize = 'Medium' THEN 1 END) AS REAL)
        / p.TotalCount,
        2
    ) AS Medium,
    ROUND(
        CAST(COUNT(CASE WHEN w.MarketSize = 'Large' THEN 1 END) AS REAL)
        / p.TotalCount,
        2
    ) AS Large
FROM
    WA_MarketingCampaign w
JOIN
    PromotionCounts p
ON
    w.Promotion = p.Promotion
GROUP BY
    w.Promotion, p.TotalCount;

-- Q7. t-検定のためのデータを取得する
WITH SalesWithIds AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY promotion ORDER BY SalesInThousands) AS RowId
    FROM 
        WA_MarketingCampaign
)
SELECT
    RowId,
    MAX(CASE WHEN promotion = 1 THEN SalesInThousands END) AS promotion1,
    MAX(CASE WHEN promotion = 2 THEN SalesInThousands END) AS promotion2,
    MAX(CASE WHEN promotion = 3 THEN SalesInThousands END) AS promotion3
FROM
    SalesWithIds
GROUP BY
    RowId
ORDER BY
    RowId;
