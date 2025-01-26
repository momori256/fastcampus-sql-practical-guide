-- 進撃の巨人
SELECT * FROM anime WHERE name LIKE 'Shingeki no Kyojin%';

-- Anime id=16498 と同じジャンルを持つ作品を評価順に取得する
WITH target_genres AS (
  SELECT g.genre
  FROM anime AS a
    INNER JOIN anime_genres AS g
    ON a.anime_id = g.anime_id
  WHERE a.anime_id = 16498
)
SELECT a.anime_id, a.name, a.rating, COUNT(*) AS common_genres
FROM anime AS a
  INNER JOIN anime_genres AS g
    ON a.anime_id = g.anime_id
WHERE g.genre IN (SELECT genre FROM target_genres) AND a.anime_id <> 16498
GROUP BY a.anime_id, a.name, a.rating
HAVING COUNT(*) >= 4
ORDER BY a.rating DESC;

-- 好みのジャンルから未視聴のものを勧める (user_id = 314)
WITH favorite_genres AS (
  SELECT g.genre, COUNT(*)
  FROM anime AS a
    INNER JOIN anime_genres AS g
      ON a.anime_id = g.anime_id
    INNER JOIN rating AS r
      ON a.anime_id = r.anime_id
  WHERE r.user_id = 314
    AND r.rating >= 9.0
  GROUP BY g.genre
  HAVING COUNT(*) >= 5
)
SELECT a.anime_id, a.name, a.rating, a.members
FROM anime AS a
  INNER JOIN anime_genres AS g
    ON a.anime_id = g.anime_id
WHERE g.genre IN (SELECT genre FROM favorite_genres)
  AND a.anime_id NOT IN (SELECT anime_id FROM rating WHERE user_id = 314)
GROUP BY a.anime_id, a.name, a.rating, a.members
ORDER BY a.rating DESC
LIMIT 20;
