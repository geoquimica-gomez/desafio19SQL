--Para entrar al terminal Escribir
--$env:Path += ";C:\Program Files\PostgreSQL\16\bin"
psql -U postgres

CREATE DATABASE desafio_19_sql;

\c desafio_19_sql

CREATE TABLE
    INSCRITOS(cantidad INT, fecha DATE, fuente VARCHAR);

INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '2021-01-01', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '2021-01-01', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '2021-01-02', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '2021-01-02', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '2021-01-03', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '2021-01-03', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '2021-01-04', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '2021-01-04', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '2021-01-05', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '2021-01-05', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '2021-01-06', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '2021-01-06', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '2021-01-07', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '2021-01-07', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '2021-01-08', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '2021-01-08', 'Página' );

-- Requerimiento 1: ¿Cuántos registros hay?
SELECT
    COUNT(*) AS total_registros
FROM
    INSCRITOS;

-- Requerimiento 2: ¿Cuántos inscritos hay en total?
SELECT
    SUM(cantidad) AS total_inscritos
FROM
    INSCRITOS;

-- Requerimiento 3: ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT
    *
FROM
    INSCRITOS
WHERE
    fecha = (
        SELECT
        MIN(fecha)
        FROM
        INSCRITOS
    );

-- Requerimiento 4: ¿Cuántos inscritos hay por día? (Indistintamente de la fuente de inscripción)
SELECT
    fecha,
    sum(cantidad) AS inscritos_por_dia
FROM
    INSCRITOS
GROUP by
    fecha
ORDER BY
    fecha ASC;

-- adicional orden las fechas.

-- Requerimiento 5: ¿Cuántos inscritos hay por fuente?
SELECT
    fuente,
    SUM(cantidad) AS incritos_por_fuente
FROM
    INSCRITOS
GROUP BY
    fuente
ORDER BY
    fuente DESC;

-- Requerimiento 6: ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se inscribieron en ese día?
SELECT
    fecha,
    cantidad
FROM
    INSCRITOS
WHERE
    cantidad = (
        SELECT
        MAX(cantidad)
        FROM
        INSCRITOS
    );

-- Requerimiento 7: ¿Qué día se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron? (si hay más de un registro con el máximo de personas, considera solo el primero)

SELECT
    fecha,
    fuente,
    MAX(cantidad) AS cantidad_maxima
FROM
    INSCRITOS
WHERE
    fuente = 'Blog'
GROUP BY
    fecha, fuente
ORDER BY
    cantidad_maxima DESC
LIMIT 1;

-- Requerimiento 8: ¿Cuál es el promedio de personas inscritas por día? Toma en consideración que la base de datos tiene un registro de 8 días, es decir, se obtendrán 8 promedios.
SELECT
    fecha,
    AVG(cantidad) AS inscritos_por_dia
FROM
    INSCRITOS
GROUP BY
    fecha
ORDER BY
    fecha ASC;

-- Requerimiento 9: ¿Qué días se inscribieron más de 50 personas?
SELECT
    fecha,
    cantidad AS mas_50_inscritos
FROM
    INSCRITOS
WHERE
    cantidad > 50
GROUP BY
    fecha, cantidad
ORDER BY
    fecha ASC;

-- Requerimiento 10: ¿Cuál es el promedio por día de personas inscritas? Considerando sólo calcular desde el tercer día.
SELECT
    fecha,
    AVG(cantidad) AS promedio_diario
FROM
    INSCRITOS
GROUP BY
    fecha
HAVING
    fecha >= (
        SELECT MIN(fecha) + INTERVAL '2 day'
        FROM INSCRITOS
    )
ORDER BY
    fecha ASC;
