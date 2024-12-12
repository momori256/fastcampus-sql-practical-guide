-- Q1. 商品在庫の合計・平均値を計算する
-- Q2. 商品の最高・最低価格を取得する
-- Q3. 「文房具」カテゴリの商品の個数を取得する

-- 商品在庫テーブルの作成
CREATE TABLE inventory (
    id INTEGER PRIMARY KEY, -- 商品 ID
    product TEXT NOT NULL, -- 商品名
    stock INTEGER NOT NULL, -- 在庫数
    price REAL NOT NULL, -- 価格
    category TEXT NOT NULL -- カテゴリ
);

-- データ挿入
INSERT INTO inventory (id, product, stock, price, category)
VALUES
    (1, 'ノート', 50, 350, '文房具'),
    (2, 'ペン', 200, 120, '文房具'),
    (3, '消しゴム', 10, 80, '文房具'),
    (4, 'マーカー', 5, 150, '文房具'),
    (5, 'ホッチキス', 15, 400, 'オフィス用品'),
    (6, 'ノートパソコン', 30, 80000, '電子機器'),
    (7, 'スマートフォン', 100, 35000, '電子機器'),
    (8, 'ヘッドフォン', 20, 5000, '電子機器'),
    (9, 'プリンター', 10, 12000, 'オフィス用品'),
    (10, 'デスク', 25, 20000, '家具');
