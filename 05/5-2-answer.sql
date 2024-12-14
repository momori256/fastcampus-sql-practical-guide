-- Q1. 「ノート」が合計何冊・何円売れたか調べる
SELECT
    inv.product,
    SUM(ord.quantity),
    SUM(inv.price * ord.quantity)
FROM
    inventory AS inv
INNER JOIN
    order_history AS ord
ON
    inv.product = ord.product
WHERE
    inv.product = 'ノート';

-- Q2. カテゴリごとに平均注文数を調べる
SELECT
    inv.category,
    ROUND(AVG(ord.quantity), 2) AS '平均注文数'
FROM
    inventory AS inv
INNER JOIN
    order_history AS ord
ON
    inv.product = ord.product
GROUP BY
    inv.category;

-- Q3. 日付ごとに合計注文金額を調べ、上位 3 日を表示する
SELECT
    ord.order_date,
    SUM(inv.price * ord.quantity) AS total_price
FROM
    inventory AS inv
INNER JOIN
    order_history AS ord
ON
    inv.product = ord.product
GROUP BY
    ord.order_date
ORDER BY
    SUM(inv.price * ord.quantity) DESC
LIMIT 3;

-- Q4. 一日に 4 つ以上注文があった商品を調べる
SELECT
    product,
    order_date,
    SUM(quantity) AS total_quantity
FROM
    order_history
GROUP BY
    product, order_date
HAVING
    SUM(quantity) >= 4;
