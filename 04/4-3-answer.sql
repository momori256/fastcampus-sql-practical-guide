-- Q1. カテゴリごとに商品の平均価格を計算する
SELECT category, AVG(price) FROM inventory GROUP BY category;

-- Q2. 価格が 10000 円以上の商品に対して、カテゴリごとに在庫数の合計を計算する
SELECT category, SUM(stock) FROM inventory WHERE price >= 10000 GROUP BY category;

-- Q3. 価格が 10000 円以上の商品に対してカテゴリごとに商品の平均価格を計算し、平均価格が 5000 円以上のカテゴリを抽出する
SELECT category, AVG(price) FROM inventory GROUP BY category HAVING AVG(price) >= 5000;
