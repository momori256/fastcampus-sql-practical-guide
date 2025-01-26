-- 協調フィルタリングで 16498 と似た作品を推薦する
-- 1. 16498 を高評価したユーザ一覧
WITH fans AS (
  SELECT r.user_id
  FROM anime AS a
    INNER JOIN rating AS r ON a.anime_id = r.anime_id
  WHERE a.anime_id = 16498
    AND r.rating >= 10
)
-- 2. fans が高評価した他のアニメ一覧
SELECT a.anime_id, a.name, AVG(r.rating), COUNT(*)
FROM anime AS a
  INNER JOIN rating AS r ON a.anime_id = r.anime_id
WHERE a.anime_id <> 16498
AND r.user_id IN (SELECT user_id FROM fans)
AND r.rating >= 9.0
GROUP BY a.anime_id, a.name
HAVING COUNT(*) >= 100
ORDER BY COUNT(*) DESC, AVG(r.rating) DESC;
