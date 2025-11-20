-- 1. INNER JOIN: customers with their payments
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    p.payment_id,
    p.amount,
    p.payment_date
FROM customer AS c
INNER JOIN payment AS p
    ON c.customer_id = p.customer_id;

-- 2. LEFT JOIN: all customers, payments if they exist
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    p.payment_id,
    p.amount,
    p.payment_date
FROM customer AS c
LEFT JOIN payment AS p
    ON c.customer_id = p.customer_id;

-- 3. RIGHT JOIN: all payments, customers if they exist
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    p.payment_id,
    p.amount,
    p.payment_date
FROM customer AS c
RIGHT JOIN payment AS p
    ON c.customer_id = p.customer_id;

-- 4. FULL OUTER JOIN (simulated with LEFT + RIGHT + UNION)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    p.payment_id,
    p.amount,
    p.payment_date
FROM customer AS c
LEFT JOIN payment AS p
    ON c.customer_id = p.customer_id
UNION
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    p.payment_id,
    p.amount,
    p.payment_date
FROM customer AS c
RIGHT JOIN payment AS p
    ON c.customer_id = p.customer_id;

-- 5. SELF JOIN: pairs of films that have the same length
SELECT
    f1.film_id  AS film1_id,
    f1.title    AS film1_title,
    f2.film_id  AS film2_id,
    f2.title    AS film2_title,
    f1.length
FROM film AS f1
JOIN film AS f2
    ON f1.length = f2.length
   AND f1.film_id < f2.film_id;

-- 6. SELF JOIN: customers who live at the same address
SELECT
    c1.customer_id AS customer1_id,
    c1.first_name  AS customer1_first_name,
    c1.last_name   AS customer1_last_name,
    c2.customer_id AS customer2_id,
    c2.first_name  AS customer2_first_name,
    c2.last_name   AS customer2_last_name,
    c1.address_id
FROM customer AS c1
JOIN customer AS c2
    ON c1.address_id = c2.address_id
   AND c1.customer_id < c2.customer_id;

-- 7. CROSS JOIN: all combinations of stores and categories
SELECT
    s.store_id,
    c.category_id,
    c.name AS category_name
FROM store AS s
CROSS JOIN category AS c;
