-- Q1. 商品名、価格、カテゴリーを持つ products テーブルを作成する
CREATE TABLE products (
    product TEXT PRIMARY KEY,
    price INTEGER NOT NULL,
    category TEXT NOT NULL
);

-- Q2. products テーブルにデータを挿入する
INSERT INTO products (product, price, category)
VALUES
    ('ノート', 350, '文房具'),
    ('ペン', 120, '文房具'),
    ('消しゴム', 80, '文房具'),
    ('マーカー', 150, '文房具'),
    ('ホッチキス', 400, 'オフィス用品'),
    ('プリンター', 12000, 'オフィス用品'),
    ('ノートパソコン', 80000, '電子機器'),
    ('スマートフォン', 35000, '電子機器'),
    ('ヘッドフォン', 5000, '電子機器'),
    ('デスク', 20000, '家具');
    
-- Q3. 最も値段が高い商品の価格を 10% 割引する
UPDATE products
SET price = ROUND(price * 0.9, 0)
WHERE price = 80000;

-- Q4. 最も値段が安い商品を削除する
DELETE FROM products
WHERE price = 80;
