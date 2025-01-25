DROP VIEW IF EXISTS valid_sales;

CREATE VIEW IF NOT EXISTS valid_sales AS
SELECT *
FROM Online_Retail_Processed
WHERE 
    InvoiceNo NOT LIKE 'C%'        -- 'C'から始まる=返金Invoiceを除外
    AND Quantity > 0               -- 返品行（負数数量）を除外
    AND UnitPrice > 0.0            -- 単価が正のもののみ
    AND CustomerID IS NOT NULL;    -- 顧客IDがあるもののみ

-- Q1. 月ごとに新規顧客数を調査
WITH first_purchase AS ( -- 1. 顧客ごとの初回購入日を求める
    SELECT
        CustomerID,
        MIN(DATE(InvoiceDate)) AS first_date
    FROM valid_sales
    GROUP BY CustomerID
)
SELECT -- 2. 初回購入日を月単位にまとめて新規顧客数をカウント
    strftime('%Y-%m', first_date) AS year_month,
    COUNT(*) AS new_customers
FROM first_purchase
GROUP BY year_month
ORDER BY year_month;


-- Q2. 曜日・時間帯ごとに注文数を調査
SELECT
    strftime('%w', InvoiceDate) AS weekday,
    strftime('%H', InvoiceDate) AS hour,
    COUNT(DISTINCT InvoiceNo) AS orders
FROM valid_sales
GROUP BY weekday, hour
ORDER BY weekday, hour;

-- Q3. 月ごとの RFM 値を調査
DROP TABLE IF EXISTS months;
CREATE TABLE months (
    year_month TEXT PRIMARY KEY,
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL
);

INSERT INTO months VALUES
    ('2010-12', '2010-12-31'),
    ('2011-01', '2011-01-31'),
    ('2011-02', '2011-02-28'),
    ('2011-03', '2011-03-31'),
    ('2011-04', '2011-04-30'),
    ('2011-05', '2011-05-31'),
    ('2011-06', '2011-06-30'),
    ('2011-07', '2011-07-31'),
    ('2011-08', '2011-08-31'),
    ('2011-09', '2011-09-30'),
    ('2011-10', '2011-10-31'),
    ('2011-11', '2011-11-30'),
    ('2011-12', '2011-12-31');

WITH rfm AS (
    WITH customer_ids AS (
        SELECT DISTINCT CustomerID
        FROM valid_sales
    )
    SELECT
        m.year_month,
        c.CustomerID,
        COALESCE(CAST(
            julianday(m.end_date) 
            - julianday(MAX(s.InvoiceDate))
            AS INT
        ), 9999) AS recency,
        COUNT(DISTINCT s.InvoiceNo) AS frequency,
        COALESCE(SUM(s.Quantity * s.UnitPrice), 0) AS monetary
    FROM months m
    CROSS JOIN customer_ids c
    LEFT JOIN valid_sales s
        ON s.CustomerID = c.CustomerID
        AND DATE(s.InvoiceDate) 
            BETWEEN DATE(m.end_date, '-3 months') AND m.end_date
    GROUP BY
        m.year_month,
        c.CustomerID
    ORDER BY
        m.year_month,
        c.CustomerID
)
SELECT
    *,
    CASE
        WHEN recency <= 20 THEN 5
        WHEN recency <= 40 THEN 4
        WHEN recency <= 60 THEN 3
        WHEN recency <= 80 THEN 2
	    ELSE 1
    END as r_score,
    NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary DESC) AS m_score
FROM rfm
ORDER BY
    year_month, CustomerID;

-- Q2. おまけ: 月ごとにリセットして RFM 値を計算
WITH rfm AS (
    WITH customer_ids AS (
        SELECT DISTINCT CustomerID
        FROM valid_sales
    )
    SELECT
        m.year_month,
        c.CustomerID,
        CAST(
            julianday(m.end_date) - julianday(MAX(s.InvoiceDate))
            AS INT
        ) AS recency,
        COUNT(DISTINCT s.InvoiceNo) AS frequency,
        SUM(s.Quantity * s.UnitPrice) AS monetary
    FROM months m
    CROSS JOIN customer_ids c
    INNER JOIN valid_sales s
        ON c.CustomerID = s.CustomerID
        AND DATE(s.InvoiceDate) BETWEEN m.start_date AND m.end_date
    GROUP BY
        m.year_month, c.CustomerID
    ORDER BY
        m.year_month, c.CustomerID
)
SELECT
    *,
    6 - NTILE(5) OVER (ORDER BY recency) AS r_score,
    NTILE(5) OVER (ORDER BY frequency) AS f_score,
    NTILE(5) OVER (ORDER BY monetary) AS m_score
FROM rfm;

-- Q2. おまけ: R はこれまでの累計で計算
WITH last_purchase AS ( -- 1. その月末日時点の「最終購入日」を求める
    SELECT
        m.year_month,
        s.CustomerID,
        MAX(s.InvoiceDate) AS last_invoice_date
    FROM months m
    INNER JOIN valid_sales s
        ON DATE(s.InvoiceDate) <= m.end_date
    GROUP BY
        m.year_month,
        s.CustomerID
),
fm AS ( -- 2. その月における Frequency / Monetary を集計
    SELECT
        m.year_month,
        s.CustomerID,
        COUNT(DISTINCT s.InvoiceNo) AS frequency,
        SUM(s.Quantity * s.UnitPrice) AS monetary
    FROM months m
    INNER JOIN valid_sales s
        ON DATE(s.InvoiceDate) BETWEEN m.start_date AND m.end_date
    GROUP BY
        m.year_month,
        s.CustomerID
),
rfm AS ( -- 3. 二つのテーブルを結合して RFM を計算
    SELECT
        fm.year_month,
        fm.CustomerID,
        CAST(
            julianday(m.end_date) - julianday(lp.last_invoice_date)
            AS INT
        ) AS recency,
        fm.frequency,
        fm.monetary
    FROM fm fm
    INNER JOIN last_purchase lp
        ON fm.year_month = lp.year_month
        AND fm.CustomerID = lp.CustomerID
    INNER JOIN months m
        ON fm.year_month = m.year_month
)
SELECT
    *,
    6 - NTILE(5) OVER (PARTITION BY year_month ORDER BY recency) AS r_score,
    NTILE(5) OVER (PARTITION BY year_month ORDER BY frequency DESC) AS f_score,
    NTILE(5) OVER (PARTITION BY year_month ORDER BY monetary DESC) AS m_score
FROM rfm
ORDER BY year_month, CustomerID;
