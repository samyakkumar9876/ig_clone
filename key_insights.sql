-- Finding 5 oldest users

SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;


-- Two Most Popular Registration Date

SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;


-- Identify Inactive users(users with no photos)

SELECT
  username,
  users.id
FROM users
LEFT JOIN photos
  ON users.id = photos.user_id
WHERE photos.id IS NULL;


-- Most liked photo

SELECT 
    username,
    photos.image_url,
    COUNT(*) AS total_no_of_likes
FROM photos
JOIN likes
    ON likes.photo_id = photos.id
JOIN users 
  ON users.id = photos.user_id	
GROUP BY photo_id
ORDER BY total_no_of_likes DESC 
LIMIT 1;


-- Calculate average number of photos per user

SELECT
  COUNT(*) / (SELECT COUNT(*) FROM users)
  AS avg_no_of_posts
FROM photos;


-- Find the five most popular hashtags

SELECT
  tag_name,
  COUNT(*) AS tag_count
FROM tags
JOIN photo_tags
  ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY tag_count DESC
LIMIT 5;


-- Search for bots(users who has liked every single photo)

SELECT 
	username,
    COUNT(*) as num_likes
FROM users
JOIN likes
	ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);