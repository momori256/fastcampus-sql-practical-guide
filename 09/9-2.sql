-- 無効なデータを除外して VIEW を作成
CREATE VIEW valid_sales AS
SELECT *
FROM Online_Retail_Processed
WHERE 
   InvoiceNo NOT LIKE 'C%'        -- 'C'から始まる=返金Invoiceを除外
   AND Quantity > 0               -- 返品行（負数数量）を除外
   AND UnitPrice > 0.0            -- 単価が正のもののみ
   AND CustomerID IS NOT NULL;    -- 顧客IDがあるもののみ

-- Recency 計算の基準となる最新購入日を取得
SELECT MAX(InvoiceDate)
FROM valid_sales;

--- 顧客ごとの RFM を計算
SELECT
    CustomerID,
    CAST(
      julianday(DATETIME((SELECT MAX(InvoiceDate) FROM valid_sales), '+1 day'))
      - julianday(MAX(InvoiceDate)) AS INT) as recency,
    COUNT(DISTINCT InvoiceNo) AS frequency,
    SUM(Quantity * UnitPrice) AS monetary
FROM valid_sales
GROUP BY CustomerID;

-- RFM にスコアを付与
WITH rfm AS (
    SELECT
        CustomerID,
        CAST(
          julianday(DATETIME((SELECT MAX(InvoiceDate) FROM valid_sales), '+1 day'))
          - julianday(MAX(InvoiceDate)) AS INT) as recency,
        COUNT(DISTINCT InvoiceNo) AS frequency,
        SUM(Quantity * UnitPrice) AS monetary
    FROM valid_sales
    GROUP BY CustomerID
)
SELECT
    *,
    6 - NTILE(5) OVER (ORDER BY recency ASC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary DESC) AS m_score
FROM rfm;
