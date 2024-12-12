-- Q1. 商品在庫の合計・平均値を計算する
SELECT SUM(stock), AVG(price) FROM inventory;

-- Q2. 商品の最高・最低価格を取得する
SELECT MAX(price), MIN(price) FROM inventory;

-- Q3. 「文房具」カテゴリの商品数を取得する
SELECT COUNT(*) FROM inventory WHERE category = '文房具';
