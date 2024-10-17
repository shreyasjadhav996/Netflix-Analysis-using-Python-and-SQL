-- Handeling Foreign Characters

SELECT * FROM netflix_raw 
WHERE show_id = 's5023';

-- Remove Duplicates

SELECT show_id, COUNT(*)
FROM netflix_raw
GROUP BY show_id
HAVING COUNT(*)>1;


SELECT * 
FROM netflix_raw
WHERE concat(upper(title),type) IN (
    SELECT concat(upper(title),type)
    FROM netflix_raw
    GROUP BY concat(upper(title),type)
    HAVING COUNT(*) > 1
)
ORDER BY title;

WITH cte as (
SELECT * 
, ROW_NUMBER() over(partition by title, type order by show_id) as rn
FROM netflix_raw
)
SELECT show_id, type, title, cast(date_added as date) as date_added, release_year, rating, duration, description
FROM cte
WHERE rn = 1;

-- New Table for listed_in, directors, country and cast

SELECT show_id, TRIM(value) as director
into netflix_directors
FROM netflix_raw
cross apply string_split(director,',')

SELECT show_id, TRIM(value) as genre
into netflix_genre
FROM netflix_raw
cross apply string_split(listed_in,',')


SELECT show_id, TRIM(value) as country
into netflix_country
FROM netflix_raw
cross apply string_split(country,',')


SELECT show_id, TRIM(value) as cast
into netflix_cast
FROM netflix_raw
cross apply string_split(cast,',')


SELECT * FROM netflix_country;


-- Populate missing values in country, duration columns

INSERT INTO netflix_country
SELECT show_id, m.country
FROM netflix_raw nr
INNER JOIN (
SELECT director, country 
FROM netflix_country nc
INNER JOIN netflix_directors nd on nc.show_id = nd.show_id
GROUP BY director, country
) m on nr.director = m.director
WHERE nr.country IS NULL;

SELECT * FROM netflix_raw WHERE director = 'Ahishor Solomon';

SELECT director, country 
FROM netflix_country nc
INNER JOIN netflix_directors nd on nc.show_id = nd.show_id
GROUP BY director, country;

-----------------------------
SELECT * FROM netflix_raw WHERE duration IS NULL;

WITH cte as (
SELECT * 
, ROW_NUMBER() over(partition by title, type order by show_id) as rn
FROM netflix_raw
)
SELECT show_id, type, title, cast(date_added as date) as date_added, release_year, rating, case when duration is null 
then rating else duration end as duration, description
FROM cte;

-- Netflix Data Analysis

/* 1. For each Director Count the no. of movies and Tv Shows created by them in seperate columns for directors who have created 
tv shows and movies both */

SELECT nd.director
, COUNT(DISTINCT case when n.type = 'Movie' then n.show_id end) as no_of_movies
, COUNT(DISTINCT case when n.type = 'TV Show' then n.show_id end) as no_of_tvshow
FROM netflix n
INNER JOIN netflix_directors nd on n.show_id = nd.show_id
GROUP BY nd.director
HAVING COUNT(DISTINCT n.type) > 1;


/* 2. Which Country has higher no. of Comedy Movies */

SELECT TOP 1 nc.country, COUNT(DISTINCT ng.show_id) AS no_of_movies
FROM netflix_genre ng
INNER JOIN netflix_country nc ON ng.show_id = nc.show_id
INNER JOIN netflix n ON ng.show_id = nc.show_id
WHERE ng.genre = 'Comedies' AND n.type = 'Movie' 
GROUP BY nc.country
ORDER BY no_of_movies DESC;

/* 3. For each year (as per date added to netflix), which director has the maximum number of movies released */

WITH cte AS(
SELECT nd.director, YEAR(date_added) as date_year, COUNT (DISTINCT n.show_id) AS no_of_movies
FROM netflix n
INNER JOIN netflix_directors nd ON n.show_id = nd.show_id
WHERE type = 'Movie'
GROUP BY nd.director, YEAR(date_added) 
)
, cte2 as ( 
SELECT * 
, ROW_NUMBER() OVER(PARTITION BY date_year ORDER BY no_of_movies DESC, director) AS rn
FROM cte
--ORDER BY date_year, no_of_movies DESC
)
SELECT * FROM cte2 WHERE rn = 1;

/* 4.What is the avverage duration of movies in each genre */

SELECT ng.genre, AVG(CAST(REPLACE(duration,'min','') AS int)) AS avg_duration
FROM netflix n
INNER JOIN netflix_genre ng ON n.show_id = ng.show_id
WHERE type = 'Movie'
GROUP BY ng.genre;


/* 5. Find the list of directors who have created horror and comedy movies both
Display director names along with number of comedy and horror movies directed by them */

SELECT nd.director
, COUNT(DISTINCT CASE WHEN ng.genre = 'Comedies' THEN n.show_id END) AS no_of_comedy
, COUNT(DISTINCT CASE WHEN ng.genre = 'Horror Movies' THEN n.show_id END) AS no_of_horror
FROM netflix n
INNER JOIN netflix_genre ng ON n.show_id = ng.show_id
INNER JOIN netflix_directors nd ON n.show_id = nd.show_id
WHERE type = 'Movie' AND ng.genre in ('Comedies','Horror Movies')
GROUP BY nd.director
HAVING COUNT(DISTINCT ng.genre) = 2	;