-- Q1. 価格が最大の商品を取得する。同じ価格の商品が複数ある場合は全て取得する
SELECT *
FROM inventory
WHERE price = (
    SELECT MAX(price)
    FROM inventory
);

-- Q2. (IN を使って) 価格が高い順に商品を 3 個取得する
SELECT *
FROM inventory
WHERE id IN (
    SELECT id
    FROM inventory
    ORDER BY price DESC
    LIMIT 3
);

-- Q3. 平均注文金額が 10000 円以下のカテゴリに属する商品を取得する
SELECT
    *
FROM
    inventory
WHERE
    category IN
    (
        SELECT
            i.category
        FROM
            order_history AS o
        INNER JOIN
            inventory AS i ON o.product = i.product
        GROUP BY
            i.category
        HAVING
            AVG(o.quantity * i.price) <= 10000
    );

-- Q4. 平均価格が最大のカテゴリに属する商品を取得する
SELECT
    *
FROM
    inventory
WHERE
    category = (
        SELECT
            category
        FROM
            inventory
        GROUP BY
            category
        ORDER BY
            AVG(price) DESC
        LIMIT 1
    );

-- Q5. 各商品について、カテゴリの平均価格との差を計算する
SELECT
    i.*,
    i.price - tmp.avg_price
FROM
    inventory as i
INNER JOIN
(
    SELECT
        category, AVG(price) as avg_price
    FROM
        inventory
    GROUP BY
        category
) as tmp
ON
    i.category = tmp.category;

-- Q5'. CTE を使ってリファクタリング
WITH category_avg AS (
    SELECT
        category,
        AVG(price) AS avg_price
    FROM
        inventory
    GROUP BY
        category
)
SELECT
    i.*,
    i.price - ca.avg_price
FROM
    inventory AS i
INNER JOIN
    category_avg AS ca
ON
    i.category = ca.category;

-- Q6. 一度も購入されていない商品を取得する
SELECT
    *
FROM
    inventory
WHERE
    product NOT IN (
        SELECT
            product
        FROM
            order_history
    );

-- Q6'. CTE を使ってリファクタリング
WITH ordered_products AS (
    SELECT
        product
    FROM
        order_history
)
SELECT
    *
FROM
    inventory
WHERE
    product NOT IN (SELECT product FROM ordered_products);
