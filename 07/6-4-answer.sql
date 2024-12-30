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

-- Q4. 各カテゴリの中の累積在庫を計算する
SELECT
    *,
    SUM(stock) OVER (PARTITION BY category ORDER BY id) AS cumulative_stock
FROM
    inventory;
