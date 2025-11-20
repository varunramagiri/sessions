use sakila;

/* 1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates */
SELECT first_name,last_name,email,COUNT(*) AS duplicate_count FROM customer GROUP BY first_name, last_name, email HAVING COUNT(*) > 1;

/* 2. Number of times letter 'a' is repeated in film descriptions */
SELECT  film_id,title,LENGTH(description) - LENGTH(REPLACE(description, 'a', '')) AS total_a_count FROM film;

/* 3. Number of times each vowel is repeated in film descriptions */
SELECT  film_id,title,LENGTH(description) - LENGTH(REPLACE(description, 'a', '')) AS total_a_count FROM film;
SELECT  film_id,title,LENGTH(description) - LENGTH(REPLACE(description, 'e', '')) AS total_e_count FROM film;
SELECT  film_id,title,LENGTH(description) - LENGTH(REPLACE(description, 'i', '')) AS total_i_count FROM film;
SELECT  film_id,title,LENGTH(description) - LENGTH(REPLACE(description, 'o', '')) AS total_o_count FROM film;
SELECT  film_id,title,LENGTH(description) - LENGTH(REPLACE(description, 'u', '')) AS total_u_count FROM film;

SELECT 
    film_id,
    title,(LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'a', ''))) AS count_a,
    (LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'e', ''))) AS count_e,
    (LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'i', ''))) AS count_i,
    (LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'o', ''))) AS count_o,
    (LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'u', ''))) AS count_u
FROM film;

/* 4. Display the payments made by each customer
        1. Month wise
        2. Year wise
        3. Week wise */
SELECT 
    customer_id,
    YEAR(payment_date) AS payment_year,
    MONTH(payment_date) AS payment_month,
    WEEK(payment_date) AS payment_week
FROM payment
GROUP BY 
    customer_id,
    YEAR(payment_date),
    MONTH(payment_date),
    WEEK(payment_date);
    
/* 5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date */
SELECT 
    '2024-01-01' AS given_date,
    CASE 
        WHEN DAYOFYEAR('2024-12-31') = 366 THEN 'Leap Year'
        ELSE 'Not a Leap Year'
    END AS L_flag;
    
    SELECT 
    NOW() AS given_date,
    CASE 
        WHEN DAYOFYEAR('2025-12-31') = 366 THEN 'Leap Year'
        ELSE 'Not a Leap Year'
    END AS L_Year;
    
/* 6. Display number of days remaining in the current year from today. */
SELECT DATEDIFF('2025-12-31', CURDATE()) AS days_remaining_in_year;

/* 7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table. */
SELECT payment_id,payment_date,CONCAT('Q', QUARTER(payment_date)) AS quarter_number FROM payment; 

/* 8. Display the age in year, months, days based on your date of birth. 
   For example: 21 years, 4 months, 12 days */
SELECT
    TIMESTAMPDIFF(YEAR, '2003-05-10', CURDATE()) AS years,
    TIMESTAMPDIFF(MONTH, '2003-05-10', CURDATE()) % 12 AS months,
    DAY(CURDATE()) - DAY('2003-05-10') AS days;





