-- Q1. 各カテゴリの中で、自分より価格が高い商品が存在する商品を取得する
SELECT
    *
FROM
    inventory AS i1
WHERE
    EXISTS (
        SELECT
            *
        FROM
            inventory AS i2
        WHERE
            i1.category = i2.category
            AND i1.price < i2.price
    );

-- Q1. 別解 1
WITH category_highest AS (
    SELECT
        category,
        MAX(price) AS price
    FROM
        inventory
    GROUP BY
        category
)
SELECT
    *
FROM
    inventory
WHERE
    (category, price) NOT IN (SELECT * from category_highest);

-- Q1. 別解 2
SELECT
    *
FROM
    inventory AS i1
LEFT JOIN
    inventory AS i2
ON
    i1.category = i2.category
    AND i1.price < i2.price
WHERE
    i2.id IS NOT NULL;

-- Q2. 各カテゴリの中で、価格が最大でも最小でもない商品を取得する
SELECT
    *
FROM
    inventory AS i1
WHERE
    EXISTS (
        SELECT
            *
        FROM
            inventory AS i2
        WHERE
            i1.category = i2.category
            AND i1.price < i2.price
    )
    AND
    EXISTS (
        SELECT
            *
        FROM
            inventory AS i3
        WHERE
            i1.category = i3.category
            AND i1.price > i3.price
    );

-- Q3. 各カテゴリの中で、価格が最大である商品を取得する
SELECT
    *
FROM
    inventory AS i1
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            inventory AS i2
        WHERE
            i1.category = i2.category
            AND i1.price < i2.price
    );

-- Q4. 購入されたことがある商品の中で、在庫数が 20 個未満の商品を取得する
SELECT
    *
FROM
    inventory AS i
WHERE
    EXISTS (
        SELECT
            *
        FROM
            order_history AS o
        WHERE
            i.product = o.product
    )
    AND i.stock < 20;
