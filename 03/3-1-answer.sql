-- Q1. 全従業員の ID, 名前, 部署を取得する
SELECT * FROM employees;

-- Q2. 全従業員の名前を取得し、カラム名を「従業員名」とする
SELECT name AS "従業員名" FROM employees;

-- Q3. 全従業員の名前と部署を取得し、部署名順に並べる
SELECT name, department FROM employees ORDER BY department;

-- Q4. 全従業員の名前と部署を取得し、名前の逆順・部署名順に並べ、最初の 3 名を取得する
SELECT name, department FROM employees ORDER BY name DESC, department LIMIT 3;

-- Q5. 全部署名を重複なく取得する
SELECT DISTINCT department FROM employees;

