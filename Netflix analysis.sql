-- NETFLIX project

DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix(
	show_id VARCHAR(10) PRIMARY KEY,
	type	VARCHAR(7),	
	title	VARCHAR(150),	
	director VARCHAR(207),	
	casts VARCHAR(1000),
	country VARCHAR(150),	
	date_added VARCHAR(50),	
	release_year INT,	
	rating VARCHAR(8),	
	duration VARCHAR(10),	
	listed_in VARCHAR(79),	
	description VARCHAR(250)	
);

ALTER TABLE netflix
ALTER COLUMN director
TYPE VARCHAR(250);


-- Business Problems and Solutions


-- 1. Count the Number of Movies vs TV Shows

SELECT type,
	   COUNT(type) AS no_of_shows
FROM netflix
GROUP BY 1;

-- 2. Find the Most Common Rating for Movies and TV Shows

SELECT
	type,
	rating,
	ranks
FROM(
SELECT
	type,
	rating,
	COUNT(*) AS No_of_ranks,
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranks
FROM netflix
GROUP BY 1,2) as T1
WHERE ranks=1;

-- 3. List All Movies Released in a Specific Year (e.g., 2020)
SELECT*
FROM netflix
WHERE 
	type='Movie'
	AND
	release_year=2020;

-- 4. Find the Top 5 Countries with the Most Content on Netflix
SELECT
	UNNEST(STRING_TO_ARRAY(country,',')),
	COUNT(*) AS total_content
FROM netflix
GROUP BY 1
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 5. Identify the Longest Movie

SELECT *
FROM netflix
WHERE
	type='Movie'
	AND
	duration= (SELECT MAX(duration) FROM netflix)

-- 6. Find Content Added in the Last 5 Years
SELECT *
FROM netflix
WHERE 
	TO_DATE(date_added,'Month,DD,YYYY') >= CURRENT_DATE - INTERVAL '5 years'

SELECT CURRENT_DATE - INTERVAL '5 Years'
SELECT TO_DATE(date_added,'Month,DD,YYYY') FROM netflix;

-- 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

SELECT *,
	d
FROM (
SELECT *,
		UNNEST(STRING_TO_ARRAY(director,',')) AS d
FROM netflix)
WHERE d = 'Rajiv Chilaka';

	OR

SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%'

-- 8. List All TV Shows with More Than 5 Seasons

SELECT *
FROM netflix
WHERE type ='TV Show' 
AND
SPLIT_PART(duration,' ',1)::NUMERIC>5;

-- 9. Count the Number of Content Items in Each Genre

SELECT COUNT(*),
	UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre
FROM netflix
GROUP BY 2;

-- 10.Find each year and the average numbers of content release in India on netflix.


SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as DATE,
	COUNT (*),
	ROUND(COUNT (*)::NUMERIC/(SELECT COUNT(*) FROM netflix WHERE COUNTRY='India')*100::NUMERIC,2) as avg_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1;

-- 11. List All Movies that are Documentaries

SELECT
	*
FROM(SELECT
	*,
	UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre
FROM netflix)
WHERE genre='Documentaries';

	OR

SELECT
	*
FROM netflix
WHERE listed_in ILIKE '%Documentaries%'

-- 12. Find All Content Without a Director

SELECT
	*
FROM netflix
WHERE director IS NULL;

-- 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

SELECT
	*
FROM netflix
WHERE casts ILIKE '%Salman Khan%'
AND
release_year> EXTRACT(YEAR FROM current_date) - 10;

-- 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

SELECT
	-- show_id,
	-- casts,
	UNNEST(STRING_TO_ARRAY(casts,',')) AS actors,
	COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY total_content DESC
LIMIT 10;

-- 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

SELECT *
FROM netflix
WHERE description ILIKE '%kill%'
		OR
	  description ILIKE '%Violence%;
























SELECT director
FROM netflix;

SELECT UNNEST(STRING_TO_ARRAY(director,','))
FROM netflix;



SELECT *
FROM netflix;
















