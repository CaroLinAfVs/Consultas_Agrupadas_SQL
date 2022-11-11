
-- 1 ●¿cuantos registros hay?
SELECT COUNT(*) inscritos;

/* COUNT sirve para poder contar, en este caso contamos todos los registros */

-- RESPUESTA: hay 16 registros

-- 2 ● ¿Cuántos inscritos hay en total?
SELECT SUM (cantidad) FROM inscritos;

/* para sumar ocupamos SUM, ya que calcula la suma de un conjunto de valores */ 

-- RESPUESTA: 774 inscritos en total

--3 ● ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT * FROM Inscritos WHERE fecha = (SELECT MIN(FECHA) FROM Inscritos);
 
 /* colocamos las condicion donde la fecha se seleccione al minimo */

 -- RESPUESTA: los registros mas antiguos serian los 2 registros de enero 
 -- (44, 2021-01-01, 'Blog')  (56 ,2021-01-01 , 'Página')


-- 4 ● ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)
SELECT fecha, SUM(cantidad)FROM Inscritos GROUP BY fecha ;

/* seleccionamos la columna de fechas y sumamos sus cantidades para luego agrupar el conjunto de resultados */
   /*  RESPUESTA: fecha    | sum
               ------------+-----
                2021-02-01 | 120
                2021-08-01 | 182
                2021-05-01 |  88
                2021-04-01 |  93
                2021-06-01 |  30
                2021-07-01 |  58
                2021-03-01 | 103
                2021-01-01 | 100
   */

-- 5 ● ¿Cuántos inscritos hay por fuente?
SELECT fuente, SUM(cantidad) FROM inscritos GROUP BY fuente;

/* Seleccionamos la columna fuentes donde sumamos sus cantidades y las agrupamos por el conjunto de relsultados de fuentes */
 
/* RESPUESTA :    fuente| sum
                --------+-----
                 Página | 441
                 Blog   | 333
*/ 

-- 6 ● ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?
SELECT fecha, SUM(cantidad) FROM inscritos GROUP BY fecha ORDER BY MAX(cantidad) DESC LIMIT 1;

/* seleccionamos la columna fecha, sumamos la cantidades y las agrupamos por fecha, y ordenamos por el maximo, de forma desecendente
con un limite de 1 registro */
-- RESPUESTA:      fecha    | sum
                ------------+-----
                 2021-08-01 | 182


-- 7 ● ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas personas fueron?
SELECT fecha,fuente, SUM(cantidad) FROM inscritos  WHERE fuente = 'Blog' GROUP BY fecha,fuente ORDER BY SUM(cantidad) DESC LIMIT 1;

/* seleccionamos la columnas fecha y fuente, sumamos sus cantidades, y la condicion es que fuente sea igual a blog, y se agrupan por 
fecha y fuente , tambien por la suma total de sus cantidades de manera decendente con un limite de 1 regristro */

/* RESPUESTA:    fecha    | fuente | sum
              ------------+--------+-----
               2021-08-01 | Blog   |  83
*/

-- 8 ● ¿Cuántas personas en promedio se inscriben en un día?
SELECT AVG(cantidad) FROM (SELECT SUM(cantidad) AS total FROM inscritos GROUP BY fecha ) AS quantity_days; 

/* seleccionamos el promedio de cantidad (AVG devuelve el valor promedio de una columna numérica), from contiene , la seleccion
de la suma total de las cantidades y saldran como total (AS se usa para cambiar el nombre de una columna o tabla con un alias)
y vendran agrupados por fecha, y eso tendra el alias de quantity_days. */

-- RESPUESTA: Su promedio seria de 97 personas

-- 9 ● ¿Qué días se inscribieron más de 50 personas?
SELECT fecha, SUM(cantidad)  FROM inscritos GROUP BY fecha HAVING SUM(cantidad) > 50;

/* seleccionamos la columna fecha, sumamos cantidades, y agrupamos por fecha. Filtramos los resultados obtenidos de la suma de cantidades
mayores a 50. (having permite filtrar por el resultado de funciones de agregado) */

/* RESPUESTA:       fecha    | sum
                 ------------+-----
                  2021-02-01 | 120
                  2021-08-01 | 182
                  2021-05-01 |  88
                  2021-04-01 |  93
                  2021-07-01 |  58
                  2021-03-01 | 103
                  2021-01-01 | 100
*/

-- 10 ● ¿Cuántas personas se registraron en promedio cada día a partir del tercer día?
SELECT AVG(cantidad) FROM (SELECT SUM(cantidad) AS cantidad FROM inscritos WHERE fecha >= '2021-03-01' GROUP BY fecha) AS third_day;  

/* Seleccionamos el promedio de cantidad, de la seleccion de la suma de cantidad, donde fecha debe ser mayor o igual a 2021-03-01 y
 los agrupamos por fecha. */

-- RESPUESTA: se registraron 92 personas en promedio
