-- Q1. (HML 分析) 価格が 5000 円未満、5000 円以上 20000 円未満、20000 円以上をそれぞれ Low・Middle・High として表示する
SELECT
    *,
    CASE
        WHEN price < 5000 THEN 'Low'
        WHEN price < 20000 THEN 'Middle'
        ELSE 'High'
    END AS HML
FROM
    inventory;

-- Q2. HML それぞれに対して商品の平均価格を計算する
WITH inventory_hml AS (
    SELECT
        *,
        CASE
            WHEN price < 5000 THEN 'Low'
            WHEN price < 20000 THEN 'Middle'
            ELSE 'High'
        END AS hml
    FROM
        inventory
)
SELECT
    hml,
    AVG(price)
FROM
    inventory_hml
GROUP BY
    hml;

-- Q2. 参考: CTE を使わない場合
SELECT
    CASE
        WHEN price < 5000 THEN 'Low'
        WHEN price < 20000 THEN 'Middle'
        ELSE 'High'
    END AS hml,
    AVG(price)
FROM
    inventory
GROUP BY
    CASE
        WHEN price < 5000 THEN 'Low'
        WHEN price < 20000 THEN 'Middle'
        ELSE 'High'
    END;

-- Q3. Q2 の結果を上から順に L, M, H に並べ替える
WITH inventory_hml AS (
    SELECT
        *,
        CASE
            WHEN price < 5000 THEN 'Low'
            WHEN price < 20000 THEN 'Middle'
            ELSE 'High'
        END AS hml
    FROM
        inventory
)
SELECT
    hml,
    AVG(price)
FROM
    inventory_hml
GROUP BY
    hml
ORDER BY
    CASE hml
        WHEN 'Low' THEN 1
        WHEN 'Middle' THEN 2
        ELSE 3
    END;

-- Q4. HML それぞれに対して一度の注文で購入される商品数の平均を計算する
WITH inventory_hml AS (
    SELECT
        *,
        CASE
            WHEN price < 5000 THEN 'Low'
            WHEN price < 20000 THEN 'Middle'
            ELSE 'High'
        END AS hml
    FROM
        inventory
)
SELECT
    hml,
    AVG(quantity)
FROM
    inventory_hml AS i
INNER JOIN
    orders AS o
ON
    i.product = o.product
GROUP BY
    HML;

-- Q5. 休日 (12/1) と平日 (それ以外) に対して、一日の平均売上高を計算する
WITH sales AS (
    SELECT
        order_date,
        SUM(o.quantity * i.price) as avg_sale
    FROM
        orders as o
    INNER JOIN
        inventory as i
    GROUP BY
        order_date
)
SELECT
    CASE
        WHEN order_date = '2024-12-01' THEN 'Holiday'
        ELSE 'Weekday'
    END as day_type,
    AVG(avg_sale)
FROM
    sales
GROUP BY
    CASE
        WHEN order_date = '2024-12-01' THEN 'Holiday'
        ELSE 'Weekday'
    END;
