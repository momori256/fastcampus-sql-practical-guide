-- 隠れた名作を探す
SELECT *
FROM anime
WHERE rating >= 8.0
  AND members < 20000
ORDER BY rating DESC;

-- 名作指標の計算
WITH stats AS (
    SELECT 
        AVG(rating) AS avg_rating,
        STDDEV(rating) AS stddev_rating,
        MAX(members) AS max_members
    FROM anime
),
normalized AS (
    SELECT
        anime_id,
        name,
        -- 評価スコアの標準化
        (rating - (SELECT avg_rating FROM stats)) / (SELECT stddev_rating FROM stats) AS normalized_rating,
        -- members の補正 (例: 最大値との差分)
        ((SELECT max_members FROM stats) - members) / (SELECT max_members FROM stats) AS adjusted_members
    FROM anime
)
SELECT
    anime_id,
    name,
    -- 加重平均でスコアを計算 (例: 評価70%、視聴者数30%)
    0.7 * normalized_rating + 0.3 * adjusted_members AS promotion_score
FROM normalized
WHERE 0.7 * normalized_rating + 0.3 * adjusted_members IS NOT NULL
ORDER BY promotion_score DESC
LIMIT 50;  -- 上位50作品を表示

