-- Q1. 全従業員の ID, 名前, 部署を取得する
-- Q2. 全従業員の名前を取得し、カラム名を「従業員名」とする
-- Q3. 全従業員の名前と部署を取得し、部署名順に並べる
-- Q4. 全従業員の名前と部署を取得し、名前の逆順・部署名順に並べ、最初の 3 名を取得する
-- Q5. 全部署名を重複なく取得する

-- 従業員テーブルの作成
CREATE TABLE employees (
    id INTEGER PRIMARY KEY, -- 従業員 ID
    name TEXT NOT NULL, -- 名前
    department TEXT NOT NULL -- 部署
);

-- データ挿入
INSERT INTO employees (id, name, department)
VALUES
    (1, 'Alice', 'Sales'),
    (2, 'Bob', 'HR'),
    (3, 'Charlie', 'IT'),
    (4, 'Daisy', 'Marketing'),
    (5, 'Eve', 'Sales'),
    (6, 'Frank', 'Finance'),
    (7, 'Grace', 'IT'),
    (8, 'Grace', 'HR'),
    (9, 'Ivy', 'Marketing');
