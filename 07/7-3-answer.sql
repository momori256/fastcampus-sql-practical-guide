-- Q1. カテゴリごとの平均価格よりも高価な商品を取得する
SELECT *
FROM inventory AS i1
WHERE i1.price > (SELECT AVG(price)
                  FROM inventory AS i2
                  WHERE i2.category = i1.category);

-- Q2. 在庫数が注文数よりも少ない商品を取得する
SELECT
    *
FROM
    inventory as i
WHERE
    i.stock < (
        SELECT SUM(o.quantity)
        FROM orders AS o
        WHERE o.product = i.product
    );

-- Q2. 別解
SELECT
    i.*, SUM(o.quantity)
FROM
    inventory AS i
    INNER JOIN
        orders AS o
        ON i.product = o.product
GROUP BY
    i.product
HAVING
    i.stock < SUM(o.quantity);

-- Q3. 最後に注文された商品の在庫数を取得する
SELECT
    *
FROM
    inventory AS i
WHERE
    product = (
        SELECT product
        FROM orders
        ORDER BY order_datetime DESC
        LIMIT 1
    );

-- Q3. 別解
SELECT
    *
FROM
    inventory AS i
    INNER JOIN (
        SELECT product
        FROM orders
        ORDER BY order_datetime DESC
        LIMIT 1
    ) as tmp
        ON i.product = tmp.product;

-- Q4. 各カテゴリの中で、価格が最大である商品を取得する
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
    (category, price) IN (SELECT * from category_highest);

-- Q5. 各カテゴリの中で、価格が最大ではない商品を取得する
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
