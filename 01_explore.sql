-- Этап 1. Разведка и базовый анализ 
-- Проект: Анализ каталога Netflix
-- Автор: Владимир 

-- Запрос 1. Сколько фильмов и сериалов? Проверяю, что преобладает в каталоге.

select type, count(*) as titles_count from netflix
group by type
order by titles_count DESC;

-- Запрос 2. Проверяю данные на количество пропусков, где есть null, для того, чтобы учесть это в анализе.

SELECT COUNT(*) AS total_rows,
COUNT(director) AS filled_director,
COUNT(country) AS filled_country,
COUNT(date_added) AS filled_date_added
FROM netflix;

-- Запрос 3. Диапазон годов выпуска контента. Узнаю, за какой период есть данные в каталоге.

SELECT
MIN(release_year) AS first_year,
MAX(release_year) AS last_year,
COUNT(DISTINCT release_year) AS unique_years
FROM netflix;

-- Запрос 4. Распределение контента по рейтингам. Понимаю, на какую аудиторию ориентирован Netflix.
SELECT rating, COUNT(*) AS titles_count
FROM netflix
GROUP BY rating
ORDER BY titles_count DESC;

-- Запрос 5. Топ-10 стран по количеству контента. Смотрю, какие страны производят больше всего контента.
SELECT country, COUNT(*) AS titles_count
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY titles_count DESC limit 10;

-- Запрос 6. Топ 10 жанров по количеству контента. Разбиваю жанры на отдельные и считаю топ.

SELECT TRIM(genre) AS single_genre, COUNT(*) AS titles_count
FROM netflix, unnest(string_to_array(listed_in, ',')) AS genre
WHERE genre IS NOT NULL
GROUP BY single_genre
ORDER BY titles_count DESC
LIMIT 10;

-- Запрос 7. Топ-10 годов по количеству выпущенного контента. Смотрю, в какие годы Netflix выпускал больше всего контента.
SELECT release_year, COUNT(*) AS titles_count
FROM netflix
GROUP BY release_year
ORDER BY titles_count DESC
LIMIT 10;

