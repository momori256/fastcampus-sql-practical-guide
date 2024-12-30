-- Q1. 各顧客の最新の注文商品を取得する
WITH latest_orders AS (
SELECT
    customer_id,
    movie_id,
    MAX(order_date) AS latest_date
FROM
    orders
GROUP BY
    customer_id
)
SELECT
    c.*, m.title, l.latest_date
FROM
    customers as c
INNER JOIN
    latest_orders as l
ON
    c.customer_id = l.customer_id
INNER JOIN 
    movies as m
ON
    l.movie_id = m.movie_id;

-- Q2. 各顧客の平均注文間隔日数を少数点以下四捨五入して取得する
SELECT
    customer_id,
    ROUND(AVG(diff), 0) as avg_diff
FROM
(
    SELECT
        customer_id,
        julianday(order_date) - julianday(LAG(order_date, 1) OVER (PARTITION BY customer_id ORDER BY order_date)) AS diff
    FROM
        orders
) as tmp
WHERE
    diff IS NOT NULL
GROUP BY
    customer_id;

-- Q3. 地域別 (アジア、北アメリカ、ヨーロッパ) に最も注文数の多い映画を取得する
WITH region_orders AS (
SELECT
    CASE
        WHEN c.country IN ('Indonesia', 'China', 'Japan', 'Malaysia', 'Philippines') THEN 'Asia'
        WHEN c.country IN ('United States', 'Canada') THEN 'North America'
        ELSE 'Europe'
    END as region,
    m.movie_id,
    m.title,
    COUNT(*) as count
FROM
    orders as o
INNER JOIN
    movies as m
ON
    o.movie_id = m.movie_id
INNER JOIN
    customers as c
ON
    o.customer_id = c.customer_id
GROUP BY
    CASE
        WHEN c.country IN ('Indonesia', 'China', 'Japan', 'Malaysia', 'Philippines') THEN 'Asia'
        WHEN c.country IN ('United States', 'Canada') THEN 'North America'
        ELSE 'Europe'
    END,
    m.movie_id
)
SELECT
    r1.*
FROM
    region_orders as r1
LEFT JOIN
    region_orders as r2
ON
    r1.region = r2.region
    AND r1.count < r2.count
WHERE
    r2.count IS NULL;

-- Q4. 同一顧客から複数回購入されている映画の一覧を取得する
SELECT DISTINCT
    m.*
FROM
    orders as o1
INNER JOIN
    movies as m
ON
    o1.movie_id = m.movie_id
WHERE
    EXISTS (
        SELECT
            1
        FROM
            orders as o2
        WHERE
            o1.order_id != o2.order_id
            AND o1.movie_id = o2.movie_id
            AND o1.customer_id = o2.customer_id
    );

-- Q5. 複数回同じ映画を購入したことがある顧客の一覧を取得する
SELECT DISTINCT
    c.*
FROM (
    SELECT
        *,
        COUNT(*) OVER (PARTITION BY customer_id, movie_id) as count
    FROM
        orders
) as tmp
INNER JOIN
    customers as c
ON
    tmp.customer_id = c.customer_id
WHERE
    tmp.count > 1;

-- Q6. Robin (customer_id=2) が購入していない映画一覧を取得する
SELECT
    *
FROM
    movies
EXCEPT
SELECT
    m.*
FROM
    orders as o
INNER JOIN
    customers as c
ON
    o.customer_id = c.customer_id
INNER JOIN
    movies as m
ON
    o.movie_id = m.movie_id
WHERE
    c.name = 'Robyn';
