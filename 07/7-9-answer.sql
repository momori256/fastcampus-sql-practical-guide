-- Q1. (CASE を使わず) 各商品が HML のどのグループに属するかを表示する
SELECT
    *, 'Low' as hml
FROM
    inventory
WHERE
    price < 5000
UNION ALL
SELECT
    *, 'Middle' as hml
FROM
    inventory
WHERE
    5000 <= price AND price < 20000
UNION ALL
SELECT
    *, 'High' as hml
FROM
    inventory
WHERE
    20000 <= price;

-- Q2. 一度も注文されていない商品を表示する
SELECT
    product
FROM
    inventory
EXCEPT
SELECT
    product
FROM
    orders;

-- Q3. 3 回以上注文されたことがあり、かつ在庫数が 10 以下の商品を表示する
SELECT
    product
FROM
    inventory
WHERE
    stock <= 10
INTERSECT
SELECT
    product
FROM
    orders AS o1
WHERE
    3 <= (
        SELECT COUNT(*)
        FROM orders AS o2
        WHERE o1.product = o2.product
    );
