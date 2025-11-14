use sakila;
-- SELECT (all rows from film table)
SELECT * FROM film;

-- SELECT (specific columns from actor table)
SELECT first_name, last_name FROM actor;

-- DISTINCT (unique ratings in film table)
SELECT DISTINCT rating FROM film;

-- WHERE (filter films longer than 120 minutes)
SELECT title, length FROM film
WHERE length > 120;

-- AND / OR (find customers from specific cities)
SELECT * FROM customer
WHERE active = 1 AND store_id = 1;

SELECT * FROM customer
WHERE active = 0 OR store_id = 2;

-- NOT (films not rated 'R')
SELECT title FROM film
WHERE NOT rating = 'R';

-- IN (films with specific ratings)
SELECT title, rating FROM film
WHERE rating IN ('PG', 'PG-13');

-- BETWEEN (films with rental duration 3–6 days)
SELECT title, rental_duration FROM film
WHERE rental_duration BETWEEN 3 AND 6;

-- IS NULL / IS NOT NULL (customers without email)
SELECT * FROM customer
WHERE email IS NULL;

SELECT * FROM customer
WHERE email IS NOT NULL;

-- ORDER BY (sort films by length)
SELECT title, length FROM film
ORDER BY length DESC;

-- LIMIT (first 10 customers)
SELECT * FROM customer
LIMIT 10;

-- LIKE (film titles using patterns)
SELECT title FROM film WHERE title LIKE 'A%';      -- starts with A
SELECT title FROM film WHERE title LIKE '%man';    -- ends with man
SELECT title FROM film WHERE title LIKE '%love%';  -- contains 'love'
SELECT title FROM film WHERE title LIKE 'A_n';     -- A?n pattern

-- Aggregations
SELECT COUNT(*) AS total_films FROM film;
SELECT SUM(amount) AS total_revenue FROM payment;
SELECT AVG(length) AS avg_length FROM film;
SELECT MAX(replacement_cost), MIN(replacement_cost) FROM film;

-- GROUP BY (total amount paid by each customer)
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;

-- HAVING (customers who paid more than $100)
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

-- SQL Execution Order Reminder (comment only)
-- 1. FROM
-- 2. WHERE
-- 3. GROUP BY
-- 4. HAVING
-- 5. SELECT
-- 6. ORDER BY
-- 7. LIMIT
