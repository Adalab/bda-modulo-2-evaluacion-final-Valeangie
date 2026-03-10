USE SAKILA;

/*Ejercicio 1
selecciona todos los nombres de las peliculas sin que aparezcan duplicados.*/
-- He usado DISTINCT para eliminar registros duplicados 

SELECT DISTINCT title AS nombres_de_peliculas
	FROM film;

/* Ejercicio 2
Muestra los nombres de todas las peliculas que tengan una clasificacion de "PG-13"*/
-- He dado alias con los nombres como lo pide el ejercicio para que sea mas visual para el examinador

SELECT  rating AS Clasificacion,
		title AS nombres_de_peliculas  
	FROM film 
	WHERE rating = "PG-13";

/* Ejercicio 3
Encuentra el titulo y la descripcion de todas las peliculas que contengan la palabra "amazing" en su descripcion */
/*He usaso (%) antes y despues para que no tome en cuenta donde se encuentra la palabra Amazing pero si aparece en el texto la detecte.
He usado like considero que es el operador adecuado.*/
    
SELECT title, description 
	FROM film 
	WHERE description LIKE "%amazing%"; 
    
 /* Ejercicio 4
 Encuentra el titulo de todas las peliculas que tengan una duracion mayor a 120 minutos */
 
 SELECT title AS nombres_de_peliculas, 
		length AS duracion  
	FROM film 
	WHERE length > 120; 

/* Ejercicio 5
Recupera el nombre de todos los actores*/

SELECT first_name AS Nombre,
		last_name AS Apellido
	FROM actor;

/* Ejercicio 6
Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido*/

SELECT first_name AS Nombre,
	   last_name AS Apellido
	FROM actor
    WHERE last_name like "%Gibson%"; 

/* Ejercicio 7
Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20*/
-- Between para decirle entre y AND para que sea (y) , quiero los id entre el 10 y el 20

SELECT actor_id,
	   first_name AS Nombre,
	   last_name AS Apellido
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20; 

/* Ejercicio 8 
Encuentra el titulo de las peliculas en la tabla film que no sean ni r ni pg 13 en cuanto a su clasificacion*/
-- Excluyo con NOT IN

SELECT  rating AS Clasificacion,
		title AS nombres_de_peliculas
	FROM film 
	WHERE rating NOT IN ("PG-13","R" ); 

/*Ejercicio 9
Encuentra la cantnidad total de peliculas en cada clasificacion de la tabla film y muestra la clasificacion junto con el recuento*/
-- Utilizo la función COUNT para contar los titulos segun clasificacion y al tener una funcion hay que usar GROUP BY 

SELECT COUNT(title) AS total_pelis,
		rating AS Clasificación
	FROM film
GROUP BY rating;

/* Ejercicio 10
Encuentra la cantidad total de peliculas alquiladas por cada cliente y muestra el id del cliente, 
su nombre y apellido junto la cantidad de peliculas alquiladas*/
-- Customer y rental se unen por medio de customer_id, saque la informacion de ambas tablas por separado para comprobar que la info que necesito estaba ahi.

SELECT  customer_id,
		first_name,
		last_name --  Query de comprobacion
	FROM customer;
    
SELECT COUNT(rental_id) , -- Query de comprobacion
			customer_id
	FROM rental
    GROUP BY customer_id;

/* Query final.
 Uni las tablas con un INNER JOIN por medio de customer_id y al tener una funcion en este caso COUNT la agrupe en customer_id
 en el SELECT defini las columnas que me pidieron.*/
 
 SELECT  c.customer_id , 
		c.first_name,
		c.last_name,
	COUNT(r.rental_id) AS total_alquiladas
FROM customer AS c
INNER JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name;

/* Ejercicio 11
Encuentra la cantidad total de peliculas alquiladas por categoroia y muestra el nombre de la categoria junto con el recuento de alquileres.*/
/* Primero revise cada tabla por separado que descubri a traves del schema, verifique que fueran las correctas. saque 4 tablas*/
SELECT * 
	FROM category
    LIMIT 5;
    
SELECT * 
	FROM film_category
	LIMIT 5;
	
SELECT * 
	FROM inventory
	LIMIT 5;

SELECT * 
	FROM rental
	LIMIT 5;
 /* Fui uniendo de dos en dos para verificar que los INNER JOIN funcionaban. 
 primero-category – film_category, Segundo film_category -inventory  y por ultimo inventory con rental. */

SELECT 
		c.name AS categoria,
        fc.film_id
	FROM category AS c
INNER JOIN film_category AS fc 
		ON c.category_id = fc.category_id;
        
SELECT 
		fc.category_id,
        fc.film_id,
        i.inventory_id
	FROM film_category AS fc
INNER JOIN inventory AS i
		ON fc.film_id = i.film_id;
        
SELECT 
		r.rental_id,
        r.inventory_id,
        i.inventory_id
	FROM inventory AS i
INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id;
 
	-- QUERY FINAL
/*1.Utilice INNER JOIN para traer solo las filas que coinciden en las 4 tablas (así fui conectando datos).
  2. Recicle los JOIN de mis pruebas anteriores para formar la línea completa.
  3.Use la función COUNT para contar alquileres y GROUP BY para agrupar por categoría, 
ya que las funciones siempre requieren agrupar los resultados. */

 SELECT  c.name AS categoria ,
        COUNT(r.rental_id) AS total_alquiladas
FROM category AS c
INNER JOIN film_category AS fc 
		ON c.category_id = fc.category_id
INNER JOIN inventory AS i
		ON fc.film_id = i.film_id
 INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id 
GROUP BY c.name;

/* Ejercicio 12
Encuentra el promedio de duracion de las peliculas para cada clasificación de la tabla film
 y muestra la clasificacion junto con el promedio de duracion.*/
 
  SELECT rating AS clasificacion, 
		AVG (length) AS promedio_duracion -- sacamos promedio 
	FROM film 
	GROUP BY rating; 
    
/* Ejercicio 13
Encuentra nombre y apellido de los actores que aparecen en la pelicula con title "Indian Love"*/
-- Comprobacion de tablas

SELECT *
	FROM film
	LIMIT 5;
    
SELECT *
	FROM actor
	LIMIT 5;
 
 SELECT *
	FROM film_actor
	LIMIT 5;
    
-- Union sencilla de tablas actor con film_actor y film_actor con film 

SELECT a.actor_id ,
       a.first_name ,
       a.last_name
	FROM actor AS a
INNER JOIN film_actor AS fa 
		ON a.actor_id = fa.actor_id;
    
SELECT 
		fa.actor_id,
        fa.film_id,
        f.title
	FROM film_actor AS fa
    INNER JOIN film AS f
		ON fa.film_id = f.film_id;
/* Query final
Uni las tablas que saque previamente, utilice un lower en el were para que no tome en cuenta como esta escrito indian love 
Utilice  = porque quiero que sea la peli exacta indian love y no que contenga alguna de esas palabras , quiero ese titulo igual */  

SELECT a.first_name,
       a.last_name
	FROM actor AS a
INNER JOIN film_actor AS ac 
		ON a.actor_id = ac.actor_id
INNER JOIN film AS f
		ON ac.film_id = f.film_id
WHERE LOWER(f.title) = "Indian Love";

/* Ejercicio 14 
Muestra el titulo de todas las peliculas que contengan la palabra "dog o "cat" en su descripción

Utilice like porque busco palabras que se encuentren en el texto de la columnna descripcion, 
los simbolos de % son para indicarle que no importa que hay antes o despues pero si hay la palabra dog o cat lo muestre*/

SELECT title, description 
	FROM film 
	WHERE description LIKE "%dog%"
		OR description LIKE "%cat%";
        
/* Ejercicio 15
Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
Realice un LEFT JOIN para mantener la tabla actor , para traer a todos los actores aunque no tengan película, 
le pedí en el WHERE que me mostrara todos los que fueran nuloS, con IS NULL*/

SELECT * 
	FROM actor;
    
SELECT *
	FROM film;

SELECT a.first_name, 
	   a.last_name
	FROM actor AS a 
    LEFT JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	WHERE fa.actor_id IS NULL;
    
/* Ejercicio 16
16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
-- USE BETWEEN  para señalar los años que me piden.

SELECT title AS titulo,
       release_year AS lanzamiento
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;
    
/* Ejercicio 17
Encuentra el título de todas las películas que son de la misma categoría que "Family".
Primero visualice las tablas individuales, despues hice uniones sencillas, con INNER JOIN, ya que solo me interesan los datos con infromacion, no nulos,
define las columnas y una ves que comprobe que mis tabla de uniones sencillas funcionaban las uni a la query final. 
Agregue un WHERE para indicarle que solo queria la categoria "family"*/

-- Tablas individuales 
SELECT category_id,
	   name
	FROM category
    WHERE name = "Family";
    
SELECT film_id,
       title
	FROM film;
    
 SELECT film_id,
       category_id
	FROM film_category;
 
 -- Uniones sencillas

SELECT f.film_id,
       f.title
	FROM film AS f
INNER JOIN film_category AS fc 
		ON f.film_id = fc.film_id;

        
SELECT fc.film_id,
		c.name AS nombre_categoria
	FROM film_category AS fc
INNER JOIN category AS c
		ON fc.category_id =c.category_id;
        
-- Query final

SELECT title
	FROM film AS f
INNER JOIN film_category AS fc 
		ON f.film_id = fc.film_id
INNER JOIN category AS c
		ON fc.category_id =c.category_id
WHERE c.name ="Family";

/* Ejercicio 18
 Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/
-- Visualizacion de tablas  individuales
SELECT first_name,
	   last_name,
       actor_id
	FROM actor;
    
SELECT *
	 FROM film_actor;
 -- Union de tablas INNER JOIN para unir nombres con film_id
 
SELECT a.first_name,
	   a.last_name,
      fa.film_id
	FROM actor AS a
INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id;
-/*Query final use GROUP BY para agrupar los resultados de cada actor  y 
HAVING en lugar de WHERE porque hay GROUP BY, y WHERE no deja agregar funciones, 
en este caso COUNT para contar las pelis de cada grupo*/ 

SELECT a.first_name,
	   a.last_name,
	COUNT(FA.film_id) AS total_peliculas
	FROM actor AS a
INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) > 10;

/* Ejercicio 19
Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
tabla film.*/
/* Use la tabla film que es la que tiene rating , nombre de pelis y duracion, 
le di condicion con WHERE y AND pues me pidieron que se cumplieran las dos condiciones*/

SELECT  rating AS Clasificacion,
        title AS nombres_de_peliculas,
        length AS duracion
	FROM film 
	WHERE rating = "R" 
		AND length > 120;
        
/* Ejercicio 20
. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración.*/
-- Visualizacion de tablas

SELECT *
	FROM category;
   
    
SELECT length,
      film_id,
      title
	FROM film;
    
Select *
	FROM film_category;
    
-- Uniones simples para hacer el puente entre la tabla film_category, verifique que funcionaran bien y arrojaran datos que necesito.
    
SELECT c.category_id,
       c.name
	FROM category AS c
INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id;
   
SELECT fc.film_id,
       f.length,
       f.title
	FROM film_category AS fc
INNER JOIN film AS f
		ON fc.film_id = f.film_id;
 
     /* Query final 
     uni todas las tablas anteriores por medio de INNER JOIN, utilice funcion AVG para sacar promemdio y
     GROUP BY para agrupar por nombre ,HAVING àra dar el ultimo filtro ya que use GROUP BY.*/
     
    
 SELECT c.name AS nombre_categoria,
       AVG(f.length) AS promedio_duracion
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
    GROUP BY c.name 
    HAVING AVG(f.length)> 120;
    
    /*Ejercicio 21
    Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
con la cantidad de películas en las que han actuado.
El ejercicio es igual que el 18 pero se añade = para que incluya 5 o mas peliculas*/

 SELECT first_name,
	   last_name,
       actor_id
	FROM actor;
    
SELECT *
	 FROM film_actor;
 -- Union de tablas INNER JOIN para unir nombres con film_id
 
SELECT a.first_name,
	   a.last_name,
      fa.film_id
	FROM actor AS a
INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id;
-/*Query final use GROUP BY para agrupar los resultados de cada actor  y 
HAVING en lugar de WHERE porque hay GROUP BY, y WHERE no deja agregar funciones, 
en este caso COUNT para contar las pelis de cada grupo*/ 

SELECT a.first_name,
	   a.last_name,
	COUNT(fa.film_id) AS total_peliculas
	FROM actor AS a
INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) >= 5;

/* Ejercicio 22
Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes.

-- Por cuestiones de tiempo he decidido hacerlo con INNER JOIN ,
 me parece un camino mas facil de seguir y codigo mas limpio.*/
-- Visualización de tablas individuales
 SELECT film_id,
        title
	FROM film
    LIMIT 5;
SELECT inventory_id
       film_id
	FROM inventory
    LIMIT 5;
    
SELECT rental_id,
       inventory_id,
       rental_date,
       return_date
	FROM rental
    LIMIT 5;
    
    -- uniones sencillas INNER JOIN dos tablas
  
  SELECT f.title,
         i.inventory_id
		FROM film AS f
	INNER JOIN inventory AS I
			ON f.film_id = i.film_id;

SELECT i.inventory_id,
	   r.rental_date,
       r.return_date
		FROM inventory AS i
	INNER JOIN rental AS r
			ON r.inventory_id = i.inventory_id;


 SELECT DISTINCT f.title
	FROM film AS f
    INNER JOIN inventory AS i
		ON f.film_id = i.film_id
	INNER JOIN RENTAL AS r 
		ON i.inventory_id =r.inventory_id
	WHERE DATEDIFF(r.return_date , r.rental_date) > 5;
    
/*Ejercicio 23
Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
"Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores.*/
-- visualizacion de tablas 
SELECT actor_id,
       first_name,
       last_name 
	FROM actor;
    
 SELECT actor_id,
       film_id
	FROM film_actor;  
    
 SELECT category_id,
       film_id
	FROM film_category; 
  
  SELECT category_id,
		name
	FROM category;  
    
    SELECT title,
           film_id
	FROM film; 
-- INNER JOIN  uniones sencillas para ver que funcionan 
 SELECT a.first_name,
       a.last_name
	FROM actor AS a
INNER JOIN film_actor AS fa 
		ON a.actor_id = fa.actor_id;
        
SELECT fc.film_id,
		c.name AS nombre_categoria
	FROM film_category AS fc
INNER JOIN category AS c
		ON fc.category_id =c.category_id;
        
SELECT f.title, f.film_id
	FROM film AS f
INNER JOIN film_actor AS fa
      ON f.film_id = fa.film_id;

-- Query final
/*Lo de adentro ( subconsulta)busca los id de actores que si han hecho Horror.
El NOT in  los quita y nos da el resto de actores.*/

 
 SELECT first_name AS nombre,
        last_name AS apellido
	FROM actor 
WHERE actor_id NOT IN (
SELECT fa.actor_id
	FROM film_actor as fa
INNER JOIN film_category AS fc 
		ON fa.film_id = fc.film_id
INNER JOIN category AS c
		ON fc.category_id = c.category_id
WHERE c.name = "Horror"
);


/* Ejercicio 24
Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
la tabla film.*/
-- Visualización de tablas

SELECT category_id,
       name
	FROM category;
    
SELECT film_id,
       category_id
	FROM film_category;

-- Union sencilla de tablas (2 tablas)

SELECT c.name,
       fc.film_id
	FROM category AS c
INNER JOIN film_category AS fc
	ON c.category_id = fc.category_id;

/* Query final
INNER JOIN union de tablas, grupo por nombre utilizo la funcion COUNT  para contar total peliculas por categoria*/
SELECT 
       c.name AS nombre_categoria,
       COUNT(fc.film_id) AS total_peliculas
	FROM category AS c
INNER JOIN film_category AS fc 
		ON c.category_id = fc.category_id
	GROUP BY c.name;

        

        



        






































