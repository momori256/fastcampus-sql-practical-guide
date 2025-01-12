-- Q1. 各顧客の最新の注文商品を取得する
-- Q2. 各顧客の平均注文間隔日数を少数点以下四捨五入して取得する
-- Q3. 地域別 (アジア、北アメリカ、ヨーロッパ) に最も注文数の多い映画を取得する (アジア: ('Indonesia', 'China', 'Japan', 'Malaysia', 'Philippines'), 北アメリカ: ('United States', 'Canada'))
-- Q4. 同一顧客から複数回購入されている映画の一覧を取得する
-- Q5. 複数回同じ映画を購入したことがある顧客の一覧を取得する
-- Q6. Robin (customer_id=2) が購入していない映画一覧を取得する

-- 映画テーブル
CREATE TABLE movies (
    movie_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    price INTEGER NOT NULL
);

-- 顧客テーブル
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT NOT NULL
);

-- 注文テーブル
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date TEXT NOT NULL,
    movie_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL
);

INSERT INTO movies (movie_id, title, price) VALUES
    (1, 'Dead Pit, The', 1494),
    (2, '71 Fragments of a Chronology of Chance', 1652),
    (3, 'American Pie Presents: The Book of Love', 3069),
    (4, 'Sounder', 2056),
    (5, 'No Place to Hide', 1928),
    (6, 'Seven Little Foys, The', 3572),
    (7, 'Fame', 2368),
    (8, 'Dinner with Friends', 1828),
    (9, 'Just Friends?', 2862),
    (10, 'Charlie Chan''s Courage', 3475);

INSERT INTO customers (customer_id, name, country) VALUES
    (1, 'Morse', 'Sweden'),
    (2, 'Robyn', 'Germany'),
    (3, 'Hardy', 'Indonesia'),
    (4, 'Stephannie', 'United States'),
    (5, 'Johnathon', 'Canada'),
    (6, 'Gothart', 'United States'),
    (7, 'Rodger', 'China'),
    (8, 'Sigvard', 'Malaysia'),
    (9, 'Peta', 'Japan'),
    (10, 'Rycca', 'Philippines');

INSERT INTO orders (order_id, order_date, movie_id, customer_id) VALUES
    (1, '2024-04-03', 4, 3),
    (2, '2024-08-18', 9, 8),
    (3, '2024-09-15', 4, 1),
    (4, '2024-01-23', 9, 5),
    (5, '2024-02-07', 8, 6),
    (6, '2024-12-30', 9, 10),
    (7, '2024-10-13', 1, 1),
    (8, '2024-09-11', 5, 9),
    (9, '2024-07-21', 10, 6),
    (10, '2024-04-03', 10, 6),
    (11, '2024-11-23', 4, 6),
    (12, '2024-03-16', 5, 2),
    (13, '2024-01-12', 7, 8),
    (14, '2024-07-11', 2, 2),
    (15, '2024-02-05', 5, 10),
    (16, '2024-02-17', 9, 4),
    (17, '2024-02-14', 2, 6),
    (18, '2024-11-01', 3, 9),
    (19, '2024-05-19', 3, 1),
    (20, '2024-05-10', 6, 1),
    (21, '2024-04-16', 6, 5),
    (22, '2024-10-11', 5, 2),
    (23, '2024-04-29', 4, 10),
    (24, '2024-02-08', 5, 10),
    (25, '2024-05-27', 7, 4),
    (26, '2024-09-05', 6, 2),
    (27, '2024-12-22', 3, 10),
    (28, '2024-08-04', 10, 8),
    (29, '2024-09-26', 9, 1),
    (30, '2024-12-23', 4, 3),
    (31, '2024-11-18', 3, 8),
    (32, '2024-11-19', 9, 8),
    (33, '2024-05-07', 8, 6),
    (34, '2024-03-07', 10, 6),
    (35, '2024-12-13', 8, 1),
    (36, '2024-06-14', 1, 10),
    (37, '2024-09-01', 7, 9),
    (38, '2024-01-21', 3, 3),
    (39, '2024-01-26', 9, 10),
    (40, '2024-08-12', 5, 4),
    (41, '2024-03-14', 10, 8),
    (42, '2024-11-09', 8, 2),
    (43, '2024-09-18', 1, 5),
    (44, '2024-11-01', 4, 2),
    (45, '2024-12-10', 5, 3),
    (46, '2024-12-24', 1, 7),
    (47, '2024-03-05', 7, 8),
    (48, '2024-06-10', 8, 8),
    (49, '2024-08-19', 3, 10),
    (50, '2024-04-30', 8, 3);

