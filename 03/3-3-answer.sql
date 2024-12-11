-- Q1. 2000 年移行に発売された車種を安い順に 10 個取得する
SELECT
    *
FROM
    Cars
WHERE
    year >= 2000
ORDER BY
    price
LIMIT
    10;

-- Q2. 最も価格が高い車種を取得し、値段を「最大値」として表示する
SELECT
    name,
    MAX(price) AS '最大値'
FROM
    Cars
ORDER BY
    price DESC
LIMIT
    1;

-- Q3. 1980 年代または 2000 年代に発売された車種の中で、価格が 200 万円以下のものを取得する
SELECT
    *
FROM
    Cars
WHERE
    ((year BETWEEN 1990 AND 1999) OR (year BETWEEN 2000 AND 2009))
    AND price <= 200;

-- Q4. 発売年順に 5 個の車種を取得し、発売年が同じ場合は名前順に並べ、発売年と名前を表示する
SELECT
    year, name
FROM
    Cars
ORDER BY
    year, name;

-- Q5. 一つの単語からなる車種名、つまり空白を含まない車種名を取得する
SELECT
    name
FROM
    Cars
WHERE
    name NOT LIKE '% %';
