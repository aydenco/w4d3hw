-- 1. List all customers who live in Texas (use
-- JOINs)

SELECT *
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full
-- Name

SELECT first_name, last_name
FROM customer
WHERE customer_id in (
    SELECT DISTINCT customer_id
    FROM payment
    WHERE amount > 6.99
);
-- This doesn't seem completely correct, but I don't know what to do.

-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id in (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175.00
    ORDER BY SUM(amount)
);

-- 4. List all customers that live in Nepal (use the city
-- table)

SELECT customer_id, first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Nepal';

-- 5. Which staff member had the most
-- transactions?


SELECT staff.staff_id, first_name, last_name
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(rental_id) DESC;



-- 6. How many movies of each rating are
-- there?

SELECT DISTINCT rating, COUNT(rating)
FROM film
GROUP BY rating;


-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id in (
    SELECT DISTINCT customer_id
    FROM payment
    WHERE amount > 6.99
);

-- 8. How many free rentals did our stores give away?

SELECT COUNT(rental_id)
FROM rental
WHERE rental_id in (
    SELECT rental_id
    FROM payment
    WHERE amount = 0.00
);