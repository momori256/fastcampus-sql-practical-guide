-- Q1. 各カテゴリの中で、価格が最大である商品を取得する
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

-- Q3. 購入されたことがある商品の中で、在庫数が 20 個未満の商品を取得する
SELECT
    *
FROM
    inventory AS i
WHERE
    EXISTS (
        SELECT
            *
        FROM
            orders AS o
        WHERE
            i.product = o.product
    )
    AND i.stock < 20;

-- Q4. すべての商品が 20000 円以下であるカテゴリを取得する
SELECT DISTINCT
    category
FROM
    inventory AS i1
WHERE
    NOT EXISTS (
        SELECT 1
        FROM inventory AS i2
        WHERE i2.category = i1.category
        AND i2.price > 20000
    );

-- Q5. すべてのオフィス用品よりも高額な商品を取得する
SELECT
    *
FROM
    inventory
WHERE
    price > ALL (SELECT price FROM inventory WHERE category = 'オフィス用品');

-- Q5. 別解
SELECT
    *
FROM
    inventory as i1
WHERE
    NOT EXISTS (
        SELECT 1
        FROM inventory as i2
        WHERE i2.category = 'オフィス用品'
        AND i2.price >= i1.price
    );
