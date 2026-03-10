USE SAKILA;

/*Ejercicio 1
selecciona todos los nombres de las peliculas sin que aparezcan duplicados.*/
-- He usado DISTINCT para eliminar registros duplicados 

SELECT DISTINCT title AS nomnbres_de_peliculas
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

SELECT  rating AS Clasificacion,title AS nombres_de_peliculas
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

SELECT customer_id ,first_name,last_name --  Query de comprobacion
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


