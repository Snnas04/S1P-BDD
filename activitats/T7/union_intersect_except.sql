CREATE DATABASE unionTest;

create table t1 (
    id INT
);

create Table t2 (
    id INT
);

INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
INSERT INTO t1 VALUES (3);

INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (3);
INSERT INTO t2 VALUES (4);

-- 

SELECT id from `unionTest`.t1
UNION
SELECT id from `unionTest`.t2;

SELECT id from `unionTest`.t1
UNION DISTINCT
SELECT id from `unionTest`.t2;

SELECT id from `unionTest`.t1
UNION ALL
SELECT id from `unionTest`.t2;


-- 
USE empresa;

SELECT nom, 'client' as tipo from empresa.`CLIENT`
UNION
SELECT cognom, 'empleat' FROM empresa.`EMP`
ORDER BY nom;

select id from `unionTest`.t1
INTERSECT
select id from `unionTest`.t2;

-- si tenim la vercio del mysql 8.0.30 o anterior INTERSECT no funcion, es pot fer amb uns subquery o un join

SELECT id FROM `unionTest`.t1
WHERE id in (SELECT id FROM `unionTest`.t2);

SELECT id FROM `unionTest`.t1
JOIN `unionTest`.t2 USING(id);

select id from `unionTest`.t2
EXCEPT
select id from `unionTest`.t1;

(select id from `unionTest`.t1
EXCEPT
select id from `unionTest`.t2)
UNION
(select id from `unionTest`.t2
EXCEPT
select id from `unionTest`.t1);

-- emular amb subquery i join
SELECT id FROM `unionTest`.t1
WHERE id not in (SELECT id FROM `unionTest`.t2);

SELECT t1.id as t1, t2.id as t2 FROM `unionTest`.t1
LEFT JOIN `unionTest`.t2 ON t1.id = t2.id
WHERE t2.id is NULL;

SELECT t1.id as t1, t2.id as t2 FROM `unionTest`.t1
RIGHT JOIN `unionTest`.t2 ON t1.id = t2.id
WHERE t1.id is NULL;
