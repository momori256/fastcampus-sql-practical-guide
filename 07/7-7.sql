-- Q1. 各商品について、カテゴリの平均価格との差を計算する
-- Q2. 各カテゴリの中で、商品の価格の順位を取得する
-- Q3. 同じカテゴリの商品を価格順に並べたとき、自身より一つ安い商品との価格差を計算する
-- Q4. 各カテゴリの商品を id で並び替え、累積在庫を計算する
-- Q5. 各日付ごとの合計購入数の、前後一日を加えた移動平均を計算する
-- Q6. 価格が ±10000 の範囲にある商品の平均在庫数との差を計算する

-- 商品在庫テーブルの作成
CREATE TABLE inventory (
    id INTEGER PRIMARY KEY, -- 商品 ID
    product TEXT NOT NULL, -- 商品名
    stock INTEGER NOT NULL, -- 在庫数
    price INTEGER NOT NULL, -- 価格
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
    (6, 'プリンター', 10, 12000, 'オフィス用品'),
    (7, 'ノートパソコン', 30, 80000, '電子機器'),
    (8, 'スマートフォン', 100, 35000, '電子機器'),
    (9, 'ヘッドフォン', 20, 5000, '電子機器'),
    (10, 'デスク', 25, 80000, '家具');

-- 注文履歴データ挿入
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY, -- 注文 ID
    product_id INTEGER NOT NULL, -- 商品 ID
    quantity INTEGER NOT NULL, -- 注文数
    order_date TEXT NOT NULL -- 注文日
);

INSERT INTO orders (order_id, product_id, quantity, order_date)
VALUES
    -- 文房具
    (1, 1, 2, '2024-12-01'), -- ノートを 2 冊購入
    (2, 2, 5, '2024-12-01'),
    (3, 3, 1, '2024-12-02'),
    (4, 4, 3, '2024-12-03'),
    (5, 1, 4, '2024-12-03'),
    (6, 1, 4, '2024-12-01'),

    -- オフィス用品
    (7, 5, 1, '2024-12-04'),
    (8, 6, 2, '2024-12-05'),
    (9, 5, 3, '2024-12-02'),
    (10, 6, 1, '2024-12-03'),
    (11, 6, 1, '2024-12-04'),
    (12, 5, 2, '2024-12-05'),

    -- 電子機器
    (13, 7, 1, '2024-12-04'),
    (14, 7, 1, '2024-12-02'),
    (15, 8, 2, '2024-12-04'),
    (16, 8, 1, '2024-12-01'),
    (17, 7, 2, '2024-12-02'),

    -- 家具
    (18, 10, 2, '2024-12-02'),
    (19, 10, 1, '2024-12-03'),
    (20, 10, 3, '2024-12-04');
