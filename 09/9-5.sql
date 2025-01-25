-- 無効なデータを除外して VIEW を作成
CREATE VIEW valid_sales AS
SELECT *
FROM Online_Retail_Processed
WHERE 
   InvoiceNo NOT LIKE 'C%'        -- 'C'から始まる=返金Invoiceを除外
   AND Quantity > 0               -- 返品行（負数数量）を除外
   AND UnitPrice > 0.0            -- 単価が正のもののみ
   AND CustomerID IS NOT NULL;    -- 顧客IDがあるもののみ

-- 日次の売上トレンドを確認
SELECT 
    DATE(InvoiceDate) AS order_date,
    SUM(Quantity * UnitPrice) AS daily_sales,
    COUNT(DISTINCT InvoiceNo) AS daily_orders
FROM valid_sales
GROUP BY order_date
ORDER BY order_date;

-- 日次の売上トレンドを確認（移動平均）
WITH daily_aggr AS (
    SELECT 
        DATE(InvoiceDate) AS order_date,
        SUM(Quantity * UnitPrice) AS daily_sales,
        COUNT(DISTINCT InvoiceNo) AS daily_orders
    FROM valid_sales
    GROUP BY order_date
)
SELECT
    order_date,
    daily_sales,
    daily_orders,

    -- 7日間移動平均（売上）
    AVG(daily_sales) OVER (
        ORDER BY order_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS sales_7d,

    -- 7日間移動平均（注文数）
    AVG(daily_orders) OVER (
        ORDER BY order_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS orders_7d

FROM daily_aggr
ORDER BY order_date;


-- 月次の売上トレンドを確認
SELECT
    strftime('%Y-%m', InvoiceDate) AS year_month,
    SUM(Quantity * UnitPrice) AS monthly_sales,
    COUNT(DISTINCT InvoiceNo) AS monthly_orders
FROM valid_sales
GROUP BY year_month
ORDER BY year_month;

-- 時間帯別の売上トレンドを確認
SELECT
    CAST(strftime('%H', InvoiceDate) AS INT) AS hour_of_day,
    SUM(Quantity * UnitPrice) AS hourly_sales,
    COUNT(DISTINCT InvoiceNo) AS hourly_orders
FROM valid_sales
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- 商品別の売上ランキング
SELECT
    StockCode,
    Description,
    SUM(Quantity * UnitPrice) AS total_sales,
    COUNT(DISTINCT InvoiceNo) AS order_count
FROM valid_sales
GROUP BY
    StockCode,
    Description
ORDER BY
    total_sales DESC
LIMIT 10;
