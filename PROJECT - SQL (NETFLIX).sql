
 DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550));
select * from netflix_titles;
desc netflix_titles;
use abc;
-- 1. Count the Number of Movies vs TV Shows 
SELECT 
    type,
    COUNT(*)
FROM netflix_titles
GROUP BY 1;

-- 2.Find the Most Common Rating for Movies and TV Shows
WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix_titles
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;

-- 3.List All Movies Released in a Specific Year (e.g., 2020)
SELECT * 
FROM netflix_titles
WHERE release_year = 2020;

-- 4.Find the Top 5 Countries with the Most Content on Netflix
SELECT * 
FROM
(
    SELECT 
        UNNEST(STRING_TO_ARRAY(country, ',')) AS country,
        COUNT(*) AS total_content
    FROM netflix_titles
    GROUP BY 1
) AS t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;

-- 5.Identify the Longest Movie
SELECT 
    *
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;

-- 6.Find Content Added in the Last 5 Years
SELECT *
FROM netflix_titles
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

-- 7.Find All Movies/TV Shows by Director 'Rajiv Chilaka'
SELECT *
FROM (
    SELECT 
        *,
        UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM netflix_titles
) AS t
WHERE director_name = 'Rajiv Chilaka';

-- 8.List All TV Shows with More Than 5 Seasons
SELECT *
FROM netflix_titles
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;
  
--   9.Count the Number of Content Items in Each Genre
SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
    COUNT(*) AS total_content
FROM netflix_titles
GROUP BY 1;

-- 10.List All Movies that are Documentaries
SELECT * 
FROM netflix_titles
WHERE listed_in LIKE '%Documentaries';

-- 11.Find All Content Without a Director
SELECT * 
FROM netflix_titles
WHERE director IS NULL;

-- 12.Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
SELECT * 
FROM netflix_titles
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
  
--   13. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India
SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM netflix_ttiles
WHERE country = 'India'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;

-- FINDING AND CONCLUSION-- 
-- Content Distribution: The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
-- Common Ratings: Insights into the most common ratings provide an understanding of the content's target audience.
-- Geographical Insights: The top countries and the average content releases by India highlight regional content distribution.
-- Content Categorization: Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

