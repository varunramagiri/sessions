use sakila;

/*1. Get all customers whose first name starts with 'J' and who are active.*/

select * from customer where first_name like 'j%' and active = 1;

/*2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'. */

select * from film where title like '%ACTION%' or description like '%WAR%';

/*3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.*/

select * from customer where last_name not like '%SMITH%' and first_name like '%a';

/*4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.*/

select * from film where rental_rate > 3.0 and replacement_cost is NOT NULL;

/*5. Count how many customers exist in each store who have active status = 1.*/

select store_id, count(*) as customer from customer where active = 1 group by store_id;

/*6. Show distinct film ratings available in the film table.*/

select distinct rating from film;

/*7. Find the number of films for each rental duration where the average length is more than 100 minutes.*/

select rental_duration, count(*) as number_of_films from film group by rental_duration having avg(length) > 100;

select avg(length) as lengt from film where rental_duration = 3;

SELECT title, (SELECT AVG(length) FROM film WHERE rental_duration = 3) AS avg_len FROM film WHERE rental_duration = 3;

/*8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.*/

select date(payment_date), sum(amount) as amount, count(*) as no_of_payments from payment group by date(payment_date) having count(*) > 100;

/*9. Find customers whose email address is null or ends with '.org'.*/

SELECT first_name, last_name, email FROM customer WHERE email IS NULL OR email LIKE '%.org';

/*10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.*/

select title as films, rating from film where rating = 'PG' or rating = 'G' order by rental_rate desc;

/*11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.*/

SELECT length, COUNT(*) AS films FROM film WHERE title LIKE 'T%' GROUP BY length HAVING COUNT(*) <= 5;

SELECT length, COUNT(*) AS films FROM film WHERE title LIKE 'T%' GROUP BY length ORDER BY films DESC;

/*12. List all actors who have appeared in more than 10 films.*/

SELECT actor_id, COUNT(film_id) AS total_films FROM film_actor GROUP BY actor_id HAVING COUNT(film_id) > 10;

/*13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.*/

SELECT title, rental_rate, length FROM film ORDER BY rental_rate DESC, length DESC LIMIT 5;

select * from film;

/*14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.*/

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals FROM customer c LEFT JOIN rental r ON c.customer_id = r.customer_id GROUP BY c.customer_id, c.first_name, c.last_name ORDER BY total_rentals DESC;

/* 15. List the film titles that have never been rented. */

SELECT f.film_id, f.title FROM film f LEFT JOIN inventory i ON f.film_id = i.film_id LEFT JOIN rental r ON i.inventory_id = r.inventory_id WHERE r.rental_id IS NULL;


/* 16. Find all staff members along with the total payments they have processed, ordered by total payment amount in descending order. */

SELECT 
    s.staff_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_payments
FROM staff s
LEFT JOIN payment p 
    ON s.staff_id = p.staff_id
GROUP BY 
    s.staff_id,
    s.first_name,
    s.last_name
ORDER BY total_payments DESC;


/* 17. Show the category name along with the total number of films in each category.*/

SELECT 
    c.category_id,
    c.name AS category_name,
    COUNT(fc.film_id) AS total_films
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
GROUP BY 
    c.category_id,
    c.name
ORDER BY total_films DESC;


/* 18. List the top 3 customers who have spent the most money in total.*/

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p 
    ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC
LIMIT 3;


/* 19. Find all films that were rented in the month of May (any year) and have a rental duration greater than 5 days. */

SELECT DISTINCT
    f.film_id,
    f.title,
    f.rental_duration
FROM rental r
JOIN inventory i 
    ON r.inventory_id = i.inventory_id
JOIN film f 
    ON i.film_id = f.film_id
WHERE MONTH(r.rental_date) = 5
  AND f.rental_duration > 5;


/* 20. Get the average rental rate for each film category, but only include categories with more than 50 films.*/

SELECT 
    c.category_id,
    c.name AS category_name,
    AVG(f.rental_rate) AS avg_rental_rate,
    COUNT(f.film_id) AS num_films
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN film f 
    ON fc.film_id = f.film_id
GROUP BY 
    c.category_id,
    c.name
HAVING COUNT(f.film_id) > 50;
