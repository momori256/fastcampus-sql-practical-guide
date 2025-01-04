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
    order_history;

-- Q3. 注文されたことがある商品を表示する
SELECT
    product
FROM
    inventory
INTERSECT
SELECT
    product
FROM
    order_history;
