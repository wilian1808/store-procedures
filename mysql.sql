-- MYSQL - SAKILA

-- PRIMER EJERCICIO
-- creamos una consulta que
-- determine el numero de coṕias de determinada pelicula en determinada tienda
-- y agregamos la direccion de la tienda

SELECT 
    COUNT(i.store_id) AS numeros_copias, 
    f.title AS pelicula, 
    i.store_id AS numero_tienda,
    a.address AS direccion_tienda
    FROM inventory AS i INNER JOIN film AS f
    ON f.film_id = i.film_id
    INNER JOIN store AS s
    ON i.store_id = s.store_id
    INNER JOIN address AS a
    on s.address_id = a.address_id
    GROUP BY f.title, i.store_id, a.address;

-- procedimiento almacenado
CREATE OR REPLACE PROCEDURE cantidad_copias ()
BEGIN
    SELECT 
        COUNT(i.store_id) AS numeros_copias, 
        f.title AS pelicula, 
        i.store_id AS numero_tienda,
        a.address AS direccion_tienda
        FROM inventory AS i INNER JOIN film AS f
        ON f.film_id = i.film_id
        INNER JOIN store AS s
        ON i.store_id = s.store_id
        INNER JOIN address AS a
        on s.address_id = a.address_id
        GROUP BY f.title, i.store_id, a.address;
END

-- llamamos al procedimiento almacenado
CALL cantidad_copias;

-- SEGUNDO EJERCICIO
-- creamos una consulta que
-- obtenga el titulo, la duracion, el genero, y las partes extras de cada pelicula

SELECT 
    f.title AS titulo, 
    CONCAT(f.length, " minutos") AS duracion, 
    l.name AS lenguaje,
    c.name AS genero, 
    f.special_features AS extras
    FROM film AS f INNER JOIN language AS l
    ON f.language_id = l.language_id
    INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id
    INNER JOIN category AS c
    ON c.category_id = fc.category_id
    GROUP BY f.title, l.name, c.name, f.special_features;

-- procedimeinto almacenado
CREATE OR REPLACE PROCEDURE datos_peliculas ()
BEGIN 
    SELECT 
        f.title AS titulo, 
        CONCAT(f.length, " minutos") AS duracion, 
        l.name AS lenguaje,
        c.name AS genero, 
        f.special_features AS extras
        FROM film AS f INNER JOIN language AS l
        ON f.language_id = l.language_id
        INNER JOIN film_category AS fc
        ON f.film_id = fc.film_id
        INNER JOIN category AS c
        ON c.category_id = fc.category_id
        GROUP BY f.title, l.name, c.name, f.special_features;
END

-- llamamos al procedimiento almacenado
CALL datos_peliculas;
