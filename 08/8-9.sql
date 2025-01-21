-- 標本標準偏差（sample）を計算
SELECT
    SQRT(
        (
            SUM(SalesInThousands * SalesInThousands)
            - 1.0 * SUM(SalesInThousands) * SUM(SalesInThousands) / COUNT(*)
        ) 
        / (COUNT(*) - 1)
    ) AS stdev
FROM WA_MarketingCampaign;
