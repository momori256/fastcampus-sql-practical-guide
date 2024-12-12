-- Q1. 1990 年代に発売された車種の平均価格を計算する
SELECT
    AVG(price)
FROM
    cars
WHERE
    year BETWEEN 1990 AND 1999;

-- Q2. 各年に発売された車種の個数を計算し、個数が 3 個以上の年のデータを年順に並び替えて取得する
SELECT
    year, COUNT(*)
FROM
    Cars
GROUP BY
    year
HAVING
    COUNT(*) >= 3
ORDER BY
    year
LIMIT
    5;

-- Q3. 1980, 1990, 2000, 2010 年代それぞれで車種の最高価格を取得する
SELECT
    year / 10 * 10 AS year,
    MAX(price)
FROM
    Cars
GROUP BY
    year / 10;

-- Q4-1. 車種名の先頭の文字 (イニシャル) と車種名を表示し、イニシャル順に並べる
SELECT
    SUBSTR(name, 1, 1) AS initial,
    name
FROM
    Cars
ORDER BY
    initial;

-- Q4-2. 車種名のイニシャルでグループ分けし、平均価格が 300 万円未満のグループを取得する
SELECT
    SUBSTR(name, 1, 1) AS initial,
    AVG(price)
FROM
    Cars
GROUP BY
    SUBSTR(name, 1, 1)
HAVING
    AVG(price) >= 500;
