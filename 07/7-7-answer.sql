-- Q1. 各商品について、カテゴリの平均価格との差を計算する
SELECT
    i.*,
    AVG(price) OVER (PARTITION BY category) AS avg,
    price - AVG(price) OVER (PARTITION BY category) AS diff
FROM
    inventory as i
ORDER BY
    category, id;

-- Q1. 参考1: GROUP BY + JOIN
SELECT
    i.*,
    tmp.avg_price,
    i.price - tmp.avg_price AS diff
FROM
    inventory as i
INNER JOIN
(
    SELECT
        category, AVG(price) as avg_price
    FROM
        inventory
    GROUP BY
        category
) as tmp
ON
    i.category = tmp.category;

-- Q1. 参考2: スカラサブクエリ
SELECT
    *,
    price - (
        SELECT
            AVG(price)
        FROM
            inventory as i2
        WHERE
            i1.category = i2.category
    ) AS diff
FROM
    inventory as i1;

-- Q2. 各カテゴリの中で、商品の価格の順位を取得する
SELECT
    *,
    RANK() OVER (PARTITION BY category ORDER BY price) AS rank
FROM
    inventory;

-- Q3. 同じカテゴリの商品を価格順に並べたとき、自身より一つ安い商品との価格差を計算する
SELECT
    *,
    price - LAG(price, 1) OVER (PARTITION BY category ORDER BY price) AS diff
FROM
    inventory;

-- Q4. 各カテゴリの商品を id で並び替え、累積在庫を計算する
SELECT
    *,
    SUM(stock) OVER (PARTITION BY category ORDER BY id) AS cumulative_stock
FROM
    inventory;

-- Q5. 各日付ごとの合計購入数の、前後一日を加えた移動平均を計算する
SELECT
    *,
    AVG(total_qty) OVER (ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM
(
    SELECT order_date, SUM(quantity) as total_qty
    FROM orders
    GROUP BY order_date
) as tmp;

-- Q6. 価格が ±10000 の範囲にある商品の平均在庫数との差を計算する
SELECT
    *,
    stock - AVG(stock) OVER (
        ORDER BY price
        RANGE BETWEEN 10000 PRECEDING AND 10000 FOLLOWING
    ) AS diff
FROM
    inventory;
