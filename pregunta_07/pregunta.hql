/*

Pregunta
===========================================================================

Escriba una consulta que retorne para cada valor único de la columna `t0.c2`, 
los valores correspondientes de la columna `t0.c1`. 

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

*/

DROP TABLE IF EXISTS tbl0;
CREATE TABLE tbl0 (
    c1 INT,
    c2 STRING,
    c3 INT,
    c4 DATE,
    c5 ARRAY<CHAR(1)>, 
    c6 MAP<STRING, INT>
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY ':'
MAP KEYS TERMINATED BY '#'
LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data0.csv' INTO TABLE tbl0;


/*
    >>> Escriba su respuesta a partir de este punto <<<
*/

DROP TABLE IF EXISTS result;

CREATE TABLE result AS SELECT c1, c2 FROM tbl0;

INSERT OVERWRITE LOCAL DIRECTORY 'output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY ':'
SELECT c2, collect_set(c1) FROM result GROUP BY c2 ORDER BY c2;