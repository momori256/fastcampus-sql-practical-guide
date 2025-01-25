-- ジャンルに着目
SELECT 
    g.genre,
    COUNT(DISTINCT a.anime_id) AS anime_count,
    SUM(a.members) AS total_members,
    AVG(a.rating) AS avg_rating
FROM anime AS a
INNER JOIN anime_genres AS g 
    ON a.anime_id = g.anime_id
GROUP BY g.genre
ORDER BY total_members DESC;

-- タイプに着目
SELECT 
    type,
    COUNT(*) AS anime_count,
    SUM(members) AS total_members,
    AVG(rating) AS avg_rating
FROM anime
WHERE type IS NOT NULL 
GROUP BY type
ORDER BY total_members DESC;

-- エピソード数に着目
SELECT 
    episodes,
    COUNT(*) AS anime_count,
    AVG(rating) AS avg_rating,
    AVG(members) AS avg_members
FROM anime
WHERE episodes <> 'Unknown' AND type = 'TV'
GROUP BY episodes
ORDER BY episodes + 0 ASC;  -- 文字列を数値にキャストして昇順

