SELECT *
FROM data_analyst_jobs;

-- 1.	How many rows are in the data_analyst_jobs table?
SELECT COUNT (*) AS number_of_rows
FROM data_analyst_jobs;

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
--ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
-- PART A
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location= 'TN';

-- PART B
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location IN('TN','KY');

-- 4.	How many postings in Tennessee have a star rating above 4?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE star_rating >4 AND location = 'TN';

-- 5.	How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- 6.	Show the average star rating for companies in each state. The output should show the state 
-- as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE location IS NOT NULL AND star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;
--Nebraska

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?
--PART A
SELECT DISTINCT title
FROM data_analyst_jobs;

--PART B
SELECT COUNT (DISTINCT title) AS distinct_job_titles
FROM data_analyst_jobs;

-- 8.	How many unique job titles are there for California companies?
SELECT COUNT (DISTINCT title) AS unique_job_titles
FROM data_analyst_jobs
WHERE location = 'CA';

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews 
-- across all locations. How many companies are there with more that 5000 reviews across all locations?
--PART A
SELECT company, AVG(star_rating)AS avg_star_rating
FROM data_analyst_jobs
WHERE (review_count)>5000 AND company IS NOT NULL
GROUP BY company;

--PART B
SELECT COUNT (DISTINCT company)
FROM data_analyst_jobs
WHERE (review_count)>5000 AND company IS NOT NULL;

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 
-- 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
--Part A
SELECT company, AVG(star_rating)AS avg_star_rating
FROM data_analyst_jobs
WHERE (review_count)>5000 AND company IS NOT NULL
GROUP BY company
ORDER BY avg_star_rating DESC;

--Part B
SELECT company, AVG(star_rating)AS avg_star_rating
FROM data_analyst_jobs
WHERE (review_count)>5000 AND company IS NOT NULL
GROUP BY company
ORDER BY avg_star_rating DESC
LIMIT 1;

--Part C 4.3 avg_star_rating

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 
--Part A
SELECT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--Part B
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
-- What word do these positions have in common?
--Part A
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%';

--Part B - Tableau
SELECT *
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%';

-- BONUS
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry 
-- (domain) that require SQL and have been posted longer than 3 weeks. 
--  - Disregard any postings where the domain is NULL. 
--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
--   - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks 
--   for each of the top 4?
--Part A
SELECT domain, COUNT(title) AS number_of_hard_to_fill_jobs_by_industry
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%' AND domain IS NOT NULL AND days_since_posting >21 
GROUP BY domain
ORDER BY number_of_hard_to_fill_jobs_by_industry DESC;

--Part B
SELECT domain AS industry, COUNT(title) AS number_of_hard_to_fill_jobs_by_industry
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%' AND domain IS NOT NULL AND days_since_posting >21 
GROUP BY domain
ORDER BY number_of_hard_to_fill_jobs_by_industry DESC
LIMIT 4;

