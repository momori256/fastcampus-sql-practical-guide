-- Q1. 誰も配属されていない部署を調べる
-- Q2. 従業員の配属先を調べ、未配属の場合は部署名を「未配属」と表示する
-- Q3. 部署ごとの従業員数を調べる
-- Q4. (CROSS JOIN) 九九の表のすべての数の合計値を求める

-- 従業員テーブルの作成
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY, -- 従業員 ID
    emp_name TEXT NOT NULL, -- 従業員名
    dept_name TEXT -- 部署名 (NULL の場合あり)
);

-- 従業員データ挿入
INSERT INTO employees (emp_id, emp_name, dept_name)
VALUES
    (1, '佐藤 太郎', '人事'),
    (2, '鈴木 次郎', '開発'),
    (3, '高橋 花子', NULL), -- 配属なし
    (4, '田中 一郎', '営業'),
    (5, '渡辺 幸子', '開発'),
    (6, '木村 智子', NULL), -- 配属なし
    (7, '山本 健太', '営業');

-- 部署テーブルの作成
CREATE TABLE departments (
    dept_name TEXT PRIMARY KEY -- 部署名
);

-- 部署データ挿入
INSERT INTO departments (dept_name)
VALUES
    ('人事'),
    ('開発'),
    ('営業'),
    ('広報');
