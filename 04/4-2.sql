-- Q1. 価格が 10000 円と近い順に商品を並べ替える
-- Q2. 売れ筋価格 (15310.573 円) との差の絶対値を少数第二位まで計算する
-- Q3. 商品名を最大 5 文字で表示する
-- Q4. 今日と明日の日付を取得する

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
