-- Q1. 価格が 10000 円と近い順に商品を並べ替える
SELECT product, price, ABS(price - 10000) FROM inventory ORDER BY ABS(price - 10000);

-- Q2. 売れ筋価格 (15310.573 円) との差の絶対値を少数第二位まで計算する
SELECT product, price, ABS(ROUND(price - 15310.573, 2)) FROM inventory;

-- Q3. 商品名を最大 5 文字で表示する
SELECT SUBSTR(product, 1, 5) FROM inventory;

-- Q4. 今日と明日の日付を取得する
SELECT DATE('now'), DATE('now', '+1 day');
