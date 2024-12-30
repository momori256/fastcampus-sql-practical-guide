-- Q1. 注文履歴に顧客名を加えて表示する
SELECT
    o.*,
    c.name
FROM
    orders AS o
INNER JOIN
    customers AS c
ON
    o.customer_id = c.customer_id;

-- Q2. 顧客ごとに購入合計金額を表示する。購入履歴がない顧客は除外する
SELECT
    c.name,
    SUM(i.price * o.quantity) AS total_price
FROM
    customers AS c
INNER JOIN
    orders AS o
ON
    c.customer_id = o.customer_id
INNER JOIN
    inventory AS i
ON
    o.product = i.product
GROUP BY
    c.name;

-- Q3. 顧客ごとに購入合計金額を表示する。もし購入履歴がなければ 0 と表示する
SELECT
    c.name,
    COALESCE(SUM(i.price * o.quantity), 0) AS total_price
FROM
    customers AS c
LEFT JOIN
    orders AS o
ON
    c.customer_id = o.customer_id
LEFT JOIN
    inventory AS i
ON
    o.product = i.product
GROUP BY
    c.name;

-- Q4. 一度も購入されていない商品を表示する
SELECT
    i.product
FROM
    inventory AS i
LEFT JOIN
    orders AS o
ON
    i.product = o.product
WHERE
    o.product IS NULL;

-- Q5. 最も多くの個数の文房具を購入した顧客を表示する
SELECT
    c.name,
    SUM(o.quantity) AS total_quantity
FROM
    customers AS c
INNER JOIN
    orders AS o
ON
    c.customer_id = o.customer_id
INNER JOIN
    inventory AS i
ON
    o.product = i.product
WHERE
    i.category = '文房具'
GROUP BY
    c.name
ORDER BY
    total_quantity DESC
LIMIT 1;

-- Q6. 各カテゴリ・顧客ごとに注文数を取得する
SELECT
    i.category,
    c.name,
    SUM(o.quantity) AS total_quantity
FROM
    inventory AS i
INNER JOIN
    orders AS o
ON
    i.product = o.product
INNER JOIN
    customers AS c
ON
    o.customer_id = c.customer_id
GROUP BY
    i.category, c.name
ORDER BY
    i.category, total_quantity DESC;

-- Q7. 文房具を 2000 円以上購入した顧客を表示する
SELECT
    c.name,
    SUM(i.price * o.quantity) AS total_price
FROM
    customers AS c
INNER JOIN
    orders AS o
ON
    c.customer_id = o.customer_id
INNER JOIN
    inventory AS i
ON
    o.product = i.product
WHERE
    i.category = '文房具'
GROUP BY
    c.name
HAVING
    SUM(i.price * o.quantity) >= 2000;
