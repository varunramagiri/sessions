USE sakila;

-- 1) Days each film was rented
SELECT 
    rental_id,
    rental_date,
    return_date,
    DATEDIFF(return_date, rental_date) AS days_rented
FROM rental;

-- 2) Extract month number and month name from rental_date
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    MONTHNAME(rental_date) AS rental_month_name
FROM rental
LIMIT 20;

-- 3) Extract year from rental_date
SELECT 
    rental_id,
    rental_date,
    YEAR(rental_date) AS rental_year
FROM rental
LIMIT 20;

-- 4) Group payments by date (strip time using DATE())
SELECT 
    DATE(payment_date) AS pay_date,
    SUM(amount) AS total_amount
FROM payment
GROUP BY DATE(payment_date)
ORDER BY pay_date;

-- 5) "Last 1 day" of payments based on latest date in Sakila
SELECT 
    customer_id,
    amount,
    payment_date
FROM payment
WHERE payment_date >= (
    SELECT DATE_SUB(MAX(payment_date), INTERVAL 1 DAY)
    FROM payment
)
ORDER BY payment_date;

-- 6) Current date/time functions (conceptual – real-time systems)
SELECT 
    NOW()      AS current_datetime,  -- date + time
    CURDATE()  AS current_date,      -- date only
    CURTIME()  AS current_time;      -- time only

-- 7) Actors who acted in at least 10 films (subquery in WHERE)
SELECT 
    actor_id,
    first_name,
    last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(*) >= 10
)
ORDER BY actor_id;

-- 8) Payments where the amount is greater than the overall average payment
SELECT 
    payment_id,
    customer_id,
    amount,
    payment_date
FROM payment
WHERE amount > (
    SELECT AVG(amount)
    FROM payment
)
ORDER BY amount DESC;

-- 9) Actor with film count using subquery in SELECT
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    (
        SELECT COUNT(*)
        FROM film_actor fa
        WHERE fa.actor_id = a.actor_id
    ) AS film_count
FROM actor a
ORDER BY film_count DESC;

-- 10) Same film_count logic but using a derived table + JOIN
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    f.film_count
FROM actor a
JOIN (
    SELECT 
        actor_id,
        COUNT(*) AS film_count
    FROM film_actor
    GROUP BY actor_id
) f
    ON f.actor_id = a.actor_id
ORDER BY f.film_count DESC;

-- 11) Top 10 customers by total amount spent (derived table)
SELECT 
    t.customer_id,
    t.total_spent
FROM (
    SELECT 
        customer_id,
        SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
    ORDER BY total_spent DESC
    LIMIT 10
) AS t
ORDER BY t.total_spent DESC;

-- 12) For each film, count how many actors acted in it (correlated subquery)
SELECT 
    f.film_id,
    f.title,
    (
        SELECT COUNT(*)
        FROM film_actor fa
        WHERE fa.film_id = f.film_id
    ) AS actor_count
FROM film f
ORDER BY actor_count DESC, f.title
LIMIT 20;

-- 13) Payments greater than that customer's average payment (correlated subquery)
SELECT 
    p1.payment_id,
    p1.customer_id,
    p1.amount,
    p1.payment_date
FROM payment p1
WHERE p1.amount > (
    SELECT AVG(p2.amount)
    FROM payment p2
    WHERE p2.customer_id = p1.customer_id
)
ORDER BY p1.customer_id, p1.amount DESC;
