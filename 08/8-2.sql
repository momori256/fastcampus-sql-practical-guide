-- データの一部を確認
SELECT * FROM WA_MarketingCampaign LIMIT 10;

-- プロモーションごとの基本情報
SELECT Promotion, COUNT(*), SUM(SalesInThousands),  ROUND(AVG(SalesInThousands), 1)
FROM WA_MarketingCampaign
GROUP BY Promotion;

-- 市場規模ごとの売上
SELECT MarketSize, COUNT(*), ROUND(AVG(SalesInThousands), 1)
FROM WA_MarketingCampaign
GROUP BY MarketSize;

-- プロモーションごとに各市場規模が占める割合
SELECT
    Promotion,
    MarketSize,
    ROUND(100 * CAST(COUNT(*) AS REAL) / (SELECT COUNT(*) FROM WA_MarketingCampaign WHERE Promotion = c.Promotion), 1)
      AS Percentage
FROM WA_MarketingCampaign as c
GROUP BY Promotion, MarketSize;

-- 各店舗でのプロモーションの実施回数
SELECT
    LocationID,
    COUNT(CASE WHEN Promotion = 1 THEN 1 ELSE NULL END) AS P1,
    COUNT(CASE WHEN Promotion = 2 THEN 1 ELSE NULL END) AS P2,
    COUNT(CASE WHEN Promotion = 3 THEN 1 ELSE NULL END) AS P3
FROM WA_MarketingCampaign
GROUP BY LocationID;

-- プロモーションごとの市場規模別の平均売上
SELECT
    Promotion,
    ROUND(AVG((CASE MarketSize WHEN 'Large' Then SalesInThousands ELSE NULL END)), 1) AS Large,
    ROUND(AVG((CASE MarketSize WHEN 'Medium' Then SalesInThousands ELSE NULL END)), 1) AS Medium,
    ROUND(AVG((CASE MarketSize WHEN 'Small' Then SalesInThousands ELSE NULL END)), 1) AS Small
FROM WA_MarketingCampaign
GROUP BY Promotion;

-- プロモーションごとの市場規模別の平均売上（市場規模の売上を市場規模の売上の平均で調整）
SELECT promotion, ROUND(avg(AdjustedSales), 2)
FROM
(
    SELECT c.*, SalesInThousands / MarketSales.Sales as AdjustedSales
    FROM WA_MarketingCampaign as c
    INNER JOIN
    (
        SELECT MarketSize, AVG(SalesInThousands) as Sales
        FROM WA_MarketingCampaign
        GROUP BY MarketSize
    ) as MarketSales
    ON c.MarketSize = MarketSales.MarketSize
) as tmp
GROUP BY promotion;

-- t-検定のためのデータを取得する
WITH SalesWithIds AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY Promotion ORDER BY SalesInThousands) AS RowId
    FROM
        WA_MarketingCampaign
)
SELECT
    RowId,
    MAX(CASE WHEN promotion = 1 THEN SalesInThousands END) AS P1,
    MAX(CASE WHEN promotion = 2 THEN SalesInThousands END) AS P2,
    MAX(CASE WHEN promotion = 3 THEN SalesInThousands END) AS P3
FROM
    SalesWithIds
GROUP BY
    RowId
ORDER BY
    RowId;
