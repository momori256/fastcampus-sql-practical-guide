-- Q1. (在庫補充) 在庫数が 20 個未満の商品をリストアップし、在庫数が少ない順に並べ替える
SELECT * FROM inventory WHERE stock < 10 ORDER BY stock;

-- Q2. (高額な電子機器) 「電子機器」カテゴリの商品で、価格が 10000 円以上の商品の名前を取得する
SELECT product FROM inventory WHERE category = '電子機器' AND price >= 10000;

-- Q3. (中間在庫の商品) 在庫数が 10 個以上 50 個以下の商品のリストを取得する
SELECT * FROM inventory WHERE stock BETWEEN 10 AND 50;

-- Q4. (キーワード検索) 「ノート」から始まる商品の名前を取得する
SELECT product FROM inventory WHERE product LIKE 'ノート%';

-- Q5. 3 文字の商品名を取得する
SELECT product FROM inventory WHERE product LIKE '___';

-- Q6. (価格と在庫の需要) 文房具カテゴリで在庫数が 50 個以上、または価格が 100 円以上の商品を取得する
SELECT * FROM inventory WHERE category = '文房具' AND (stock >= 50 OR price >= 100);

-- Q7. (税込価格の計算) 商品の価格に 10% の消費税を加えた価格を計算する
SELECT product, price, price + price / 10 AS '税込価格' FROM inventory;

-- Q8. (特定カテゴリの抽出) 文房具ではない商品を取得する
SELECT * FROM inventory WHERE category != '文房具';
