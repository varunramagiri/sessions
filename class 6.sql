use sakila;
-- Returns current date and time
SELECT NOW();

-- Returns today's date only
SELECT CURDATE();

-- Returns current time only
SELECT CURTIME();

-- Adds 7 days to a date
SELECT DATE_ADD('2024-01-01', INTERVAL 7 DAY);

-- Subtracts 30 days from a date
SELECT DATE_SUB('2024-01-01', INTERVAL 30 DAY);

-- Number of days between two dates
SELECT DATEDIFF('2024-12-31', '2024-01-01');

-- Extract year from date
SELECT YEAR('2024-10-15');

-- Extract month from date
SELECT MONTH('2024-10-15');

-- Extract day from date
SELECT DAY('2024-10-15');

-- Returns weekday name
SELECT DAYNAME('2024-10-15');

-------------------------------------------------------
-- CONDITIONAL FUNCTIONS
-------------------------------------------------------

-- Returns Adult/Minor based on condition
SELECT name, age, IF(age > 18, 'Adult', 'Minor') AS age_group FROM students;


/* Subquery in WHERE clause (Filtering) */
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);

/* Subquery in SELECT clause (Derived Column) */
SELECT 
    customer_id,
    first_name,
    (SELECT SUM(amount) 
     FROM payment 
     WHERE payment.customer_id = customer.customer_id
    ) AS total_payment
FROM customer;

/* C. Subquery as a Derived Table (FROM clause) */
SELECT customer_id, total_payments
FROM (
    SELECT customer_id, COUNT(*) AS total_payments
    FROM payment
    GROUP BY customer_id
) AS temp_table;

/* 4. Correlated Subquery */
SELECT f1.title, f1.rental_rate, f1.rating
FROM film f1
WHERE f1.rental_rate > (
    SELECT AVG(f2.rental_rate)
    FROM film f2
    WHERE f2.rating = f1.rating
);




