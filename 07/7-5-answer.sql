-- Q1. 在庫数が同じものが存在する商品を取得するクエリを二通り書いて実行時間を比較する
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

-- Q2. カテゴリの中で在庫数が最大の商品のリストを取得するクエリを二通り書いて実行時間を比較する
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
