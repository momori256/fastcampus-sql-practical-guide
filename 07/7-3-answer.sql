-- Q1. 各カテゴリの中で、価格が最大である商品を取得する
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

-- Q2. 各カテゴリの中で、価格が最大ではない商品を取得する
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

-- Q6. 在庫数が同じ商品を取得するクエリを二通り書いて実行時間を比較する
-- 相関サブクエリ
SELECT *
FROM inventory2 AS i1
WHERE EXISTS (
    SELECT 1
    FROM inventory2 AS i2
    WHERE i1.stock = i2.stock AND i1.product <> i2.product
);

-- テーブル結合
SELECT DISTINCT *
FROM inventory2 AS i1
INNER JOIN inventory2 AS i2
ON i1.stock = i2.stock AND i1.product <> i2.product;

-- Q7. カテゴリの中で在庫数が最大の商品のリストを取得するクエリを二通り書いて実行時間を比較する
-- 相関サブクエリ
SELECT i1.product, i1.stock
FROM inventory2 AS i1
WHERE i1.stock = (
    SELECT MAX(i2.stock)
    FROM inventory2 AS i2
    WHERE i2.category = i1.category
);

-- IN
SELECT product, stock
FROM inventory2
WHERE (category, stock) IN (
    SELECT category, MAX(stock)
    FROM inventory2
    GROUP BY category
);
