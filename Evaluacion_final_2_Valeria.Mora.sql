USE SAKILA;
/*Ejercicio 1
selecciona todos los nombres de las peliculas sin que aparezcan duplicados.*/
-- He usado DISTINCT para eliminar registros duplicados 

SELECT DISTINCT title AS nomnbres_de_peliculas -- He usado DISTINCT para que no se repitan y asi no tener duplicados
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


