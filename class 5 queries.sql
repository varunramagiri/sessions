use sakila;
-- LPAD & RPAD
SELECT LPAD(title, 20, '*') FROM film;
SELECT RPAD(title, 25, '*') FROM film;

-- SUBSTRING
SELECT SUBSTRING(title, 3, 9) FROM film;

-- CONCAT
SELECT CONCAT(first_name, '@', last_name) AS email FROM customer;

-- REVERSE
SELECT REVERSE(title) FROM film;

-- LENGTH
SELECT title, LENGTH(title) FROM film WHERE LENGTH(title) = 15;

-- LOCATE + SUBSTRING
SELECT email, SUBSTRING(email, LOCATE('@', email) + 1) AS domain FROM customer;
SELECT SUBSTRING(email, 1, LOCATE('@', email) - 1) FROM customer;

-- SUBSTRING_INDEX
SELECT SUBSTRING_INDEX(email, '.', 1) FROM customer;
SELECT SUBSTRING_INDEX(email, '.', -1) FROM customer;

-- REGEXP
SELECT last_name FROM customer WHERE last_name REGEXP '[aeiou]$';
SELECT title FROM film WHERE title REGEXP 'e$';

-- Mathematical Functions
SELECT rental_rate, POWER(rental_rate, 2) FROM film;
SELECT length, MOD(length, 60) FROM film;
SELECT ROUND(replacement_cost / rental_rate, 2) FROM film;

-- Random Value
SELECT FLOOR(RAND() * 100) AS random_value;

-- Add Column & Update Column
ALTER TABLE film ADD COLUMN cost_efficiency DECIMAL(6,2);
UPDATE film SET cost_efficiency = replacement_cost / length WHERE length IS NOT NULL;

-- CASE WHEN
SELECT last_name,
       CASE 
         WHEN LEFT(last_name, 1) BETWEEN 'A' AND 'M' THEN 'Group 1'
         WHEN LEFT(last_name, 1) BETWEEN 'N' AND 'Z' THEN 'Group 2'
         ELSE 'Other'
       END AS group_name
FROM customer;
