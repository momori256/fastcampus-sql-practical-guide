-- Q1. 各カテゴリごとに、最も高価な商品を取得する
SELECT
    i1.*
FROM
    inventory as i1
LEFT JOIN
    inventory as i2
ON
    i1.category = i2.category
    AND i1.price < i2.price
WHERE
    i2.product IS NULL;

-- Q1. 参考: WINDOW 関数を使って最大値を取得する
SELECT
    *,
    MAX(price) OVER (PARTITION BY category) AS max_price
FROM
    inventory;

-- Q2. 各カテゴリごとに、自分よりも高価な商品の個数を取得する
SELECT
    i1.product, COUNT(i2.product)
FROM
    inventory as i1
LEFT JOIN
    inventory as i2
ON
    i1.category = i2.category
    AND i1.price < i2.price
GROUP BY
    i1.product;

-- Q3. 各顧客ごとに、もっとも注文回数の多いカテゴリを取得する
WITH order_count AS (
    SELECT
        c.name,
        i.category,
        COUNT(*) as count
    FROM
        orders as o
    INNER JOIN
        inventory as i
    ON
        o.product = i.product
    INNER JOIN
        customers as c
    ON
        o.customer_id = c.customer_id
    GROUP BY
        o.customer_id, i.category
)
SELECT
    o1.*
FROM
    order_count as o1
LEFT JOIN
    order_count as o2
ON
    o1.name = o2.name
    AND o1.count < o2.count
WHERE
    o2.count IS NULL;

-- Q4. 同じ顧客が複数回同じ商品を注文しているかどうかを取得する
SELECT
    o1.customer_id, o1.product, o1.order_date, o2.order_date
FROM
    orders as o1
INNER JOIN
    orders as o2
ON
    o1.order_id < o2.order_id
    AND o1.product = o2.product
    AND o1.customer_id = o2.customer_id;
