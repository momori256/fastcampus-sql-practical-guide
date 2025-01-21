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
