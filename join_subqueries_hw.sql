-- 1. List all customers who live in Texas (use JOINs)
SELECT c.first_name, c.last_name, a.district 
FROM address a
JOIN customer c
ON c.address_id = a.address_id
WHERE district LIKE 'Texas';

-- ANSWER:  first_name|last_name|district|
			----------+---------+--------+
			Jennifer  |Davis    |Texas   |
			Kim       |Cruz     |Texas   |
			Richard   |Mccrary  |Texas   |
			Bryan     |Hardison |Texas   |
			Ian       |Still    |Texas   |



-- 2. List all payments of more than $7.00 with the customer’s first and last name
SELECT c.first_name, c.last_name, p.amount
FROM customer c
JOIN payment p 
ON c.customer_id = p.customer_id 
WHERE amount > 7.00;

-- ANSWER:  first_name|last_name  |amount|
			----------+-----------+------+
			Peter     |Menard     |  7.99|
			Peter     |Menard     |  7.99|
			Peter     |Menard     |  7.99|
			Douglas   |Graf       |  8.99|
			Ryan      |Salisbury  |  8.99|
			Ryan      |Salisbury  |  8.99|
			Ryan      |Salisbury  |  7.99|
			Roger     |Quintanilla|  8.99|
			Joe       |Gilliland  |  8.99|
			Jonathan  |Scarborough|  7.99|
			Harry     |Arce       |  9.99|



-- 3. Show all customer names who have made over $175 in payments (use subqueries)
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id 
	HAVING sum(amount) > 175.00
);

-- ANSWER:

customer_id|store_id|first_name|last_name|email                            |address_id|activebool|create_date|last_update            |activ
-----------+--------+----------+---------+---------------------------------+----------+----------+-----------+-----------------------+-----
        137|       2|Rhonda    |Kennedy  |rhonda.kennedy@sakilacustomer.org|       141|true      | 2006-02-14|2013-05-26 14:49:45.738|     
        144|       1|Clara     |Shaw     |clara.shaw@sakilacustomer.org    |       148|true      | 2006-02-14|2013-05-26 14:49:45.738|     
        148|       1|Eleanor   |Hunt     |eleanor.hunt@sakilacustomer.org  |       152|true      | 2006-02-14|2013-05-26 14:49:45.738|     
        178|       2|Marion    |Snyder   |marion.snyder@sakilacustomer.org |       182|true      | 2006-02-14|2013-05-26 14:49:45.738|     
        459|       1|Tommy     |Collazo  |tommy.collazo@sakilacustomer.org |       464|true      | 2006-02-14|2013-05-26 14:49:45.738|     
        526|       2|Karl      |Seal     |karl.seal@sakilacustomer.org     |       532|true      | 2006-02-14|2013-05-26 14:49:45.738|     



-- 4. List all customers that live in Argentina (use the city table)

SELECT c.first_name, c.last_name, a.district, ct.city, co.country
FROM customer c
JOIN address a 
ON c.address_id = a.address_id
JOIN city ct 
ON a.city_id = ct.city_id 
JOIN country co 
ON ct.country_id = co.country_id 
WHERE co.country = 'Argentina';

-- Answer:

		first_name|last_name|district    |city                |country  |
		----------+---------+------------+--------------------+---------+
		Willie    |Markham  |Buenos Aires|Almirante Brown     |Argentina|
		Jordan    |Archuleta|Buenos Aires|Avellaneda          |Argentina|
		Jason     |Morrissey|Buenos Aires|Baha Blanca         |Argentina|
		Kimberly  |Lee      |Crdoba      |Crdoba              |Argentina|
		Micheal   |Forman   |Buenos Aires|Escobar             |Argentina|
		Darryl    |Ashcraft |Buenos Aires|Ezeiza              |Argentina|
		Julia     |Flores   |Buenos Aires|La Plata            |Argentina|
		Florence  |Woods    |Buenos Aires|Merlo               |Argentina|
		Perry     |Swafford |Buenos Aires|Quilmes             |Argentina|
		Lydia     |Burke    |Tucumn      |San Miguel de Tucumn|Argentina|
		Eric      |Robert   |Santa F     |Santa F             |Argentina|
		Leonard   |Schofield|Buenos Aires|Tandil              |Argentina|
		Willie    |Howell   |Buenos Aires|Vicente Lpez        |Argentina|


-- 5. Show all the film categories with their count in descending order

SELECT c.category_id, c.name, count(*) AS num_movies_in_cat 
FROM category c
JOIN film_category fc 
ON fc.category_id = c.category_id 
GROUP BY c.category_id 
ORDER BY num_movies_in_cat DESC;


-- ANSWER:

--		category_id|name       |num_movies_in_cat|
--		-----------+-----------+-----------------+
--		         15|Sports     |               74|
--		          9|Foreign    |               73|
--		          8|Family     |               69|
--		          6|Documentary|               68|
--		          2|Animation  |               66|
--		          1|Action     |               64|
--		         13|New        |               63|
--		          7|Drama      |               62|
--		         14|Sci-Fi     |               61|
--		         10|Games      |               61|
--		          3|Children   |               60|
--		          5|Comedy     |               58|
--		          4|Classics   |               57|
--		         16|Travel     |               57|
--		         11|Horror     |               56|
--		         12|Music      |               51|



-- 6. What film had the most actors in it (show film info)?

SELECT f.film_id, f.title, count(*) AS num_actors 
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.film_id
ORDER BY num_actors DESC
LIMIT 1;

-- Answer:

		film_id|title           |num_actors|
		-------+----------------+----------+
		    508|Lambs Cincinatti|        15|


-- 7. Which actor has been in the least movies?

SELECT a.actor_id, a.first_name, a.last_name, count(*) AS num_films 
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
GROUP BY a.actor_id
ORDER BY num_films
LIMIT 1;

-- Answer:

		actor_id|first_name|last_name|num_films|
		--------+----------+---------+---------+
		     148|Emily     |Dee      |       14|

-- 8. Which country has the most cities?
SELECT c.country_id, c.country, count(*) AS num_cities 
FROM country c
JOIN city ci
ON c.country_id = ci.country_id
GROUP BY c.country_id
ORDER BY num_cities DESC
LIMIT 3;

-- Answer:

		country_id|country      |num_cities|
		----------+-------------+----------+
		        44|India        |        60|
		        23|China        |        53|
		       103|United States|        35|

		       
-- 9. List the actors who have been in between 20 and 25 films.

SELECT a.actor_id, a.first_name, a.last_name, count(*)
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
GROUP BY a.actor_id
HAVING count(*) BETWEEN 20 AND 25;




		       
		       
