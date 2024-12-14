-- Q1. 誰も配属されていない部署を調べる
SELECT
    dep.dept_name
FROM
    departments AS dep
LEFT OUTER JOIN
    employees AS emp
ON
    dep.dept_name = emp.dept_name
WHERE
    emp.emp_id IS NULL;

-- Q2. 従業員の配属先を調べ、未配属の場合は部署名を「未配属」と表示する
SELECT
    emp.emp_name,
    COALESCE(emp.dept_name, '未配属') AS dept_name
FROM
    employees AS emp
LEFT JOIN
    departments AS dep
ON
    emp.dept_name = dep.dept_name;

-- Q3. 部署ごとの従業員数を調べる
 SELECT
    d.dept_name,
    COUNT(e.emp_id)
 FROM
    departments AS d
    LEFT JOIN employees AS e
        on d.dept_name = e.dept_name
 GROUP BY
    d.dept_name;
