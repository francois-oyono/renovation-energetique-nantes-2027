USE btp_renovation_nantes;

-- REQUETE 01 : Repartition des DPE par type de batiment
-- Question metier : quels types de batiments sont
-- les plus representes dans les diagnostics de Nantes ?
-- Technique SQL : COUNT, GROUP BY, ORDER BY

SELECT
    type_batiment,
    COUNT(*) AS nombre_diagnostics
FROM factdpe
GROUP BY type_batiment
ORDER BY nombre_diagnostics DESC;

-- REQUETE 02 : Repartition des maisons par classe DPE
-- Question metier : quelles classes energetiques
-- caracterisent les maisons diagnostiquees a Nantes ?
-- Techniques SQL : WHERE, COUNT, GROUP BY, ORDER BY

SELECT
    etiquette_dpe,
    COUNT(*) AS nombre_diagnostics
FROM factdpe
WHERE type_batiment = 'maison'
GROUP BY etiquette_dpe
ORDER BY etiquette_dpe;


-- REQUETE 03 : Evolution annuelle des DPE des maisons
-- Question metier : comment evoluent les diagnostics
-- des maisons individuelles selon les annees ?
-- Techniques SQL : INNER JOIN, WHERE, GROUP BY, COUNT

SELECT
    d.annee,
    COUNT(*) AS nombre_diagnostics
FROM factdpe AS f
INNER JOIN dim_date AS d
    ON f.date_dpe = d.date_dpe
WHERE f.type_batiment = 'maison'
GROUP BY d.annee
ORDER BY d.annee;


-- REQUETE 04 : Part des maisons classees E, F et G
-- Question metier : quelle proportion des diagnostics
-- de maisons concerne les classes E, F et G ?
-- Techniques SQL : CASE WHEN, SUM, COUNT, ROUND

SELECT
    COUNT(*) AS total_diagnostics_maisons,
    SUM(
        CASE
            WHEN etiquette_dpe IN ('E', 'F', 'G') THEN 1
            ELSE 0
        END
    ) AS diagnostics_efg,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN etiquette_dpe IN ('E', 'F', 'G') THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS pourcentage_efg
FROM factdpe
WHERE type_batiment = 'maison';

-- REQUETE 05 : Maisons E, F et G par periode de construction
-- Question metier : quelles periodes de construction
-- concentrent le plus de diagnostics E, F et G ?
-- Techniques SQL : WHERE, IN, GROUP BY, COUNT, ORDER BY

SELECT
    periode_construction,
    COUNT(*) AS nombre_diagnostics_efg
FROM factdpe
WHERE type_batiment = 'maison'
  AND etiquette_dpe IN ('E', 'F', 'G')
GROUP BY periode_construction
ORDER BY nombre_diagnostics_efg DESC;

-- REQUETE 06 : Chauffage des maisons classees E, F et G
-- Question metier : quelles energies de chauffage
-- sont les plus representees dans ces diagnostics ?
-- Techniques SQL : WHERE, IN, GROUP BY, COUNT, ORDER BY

SELECT
    type_energie_principale_chauffage,
    COUNT(*) AS nombre_diagnostics_efg
FROM factdpe
WHERE type_batiment = 'maison'
  AND etiquette_dpe IN ('E', 'F', 'G')
GROUP BY type_energie_principale_chauffage
ORDER BY nombre_diagnostics_efg DESC;

-- REQUETE 07 : Surface moyenne des maisons par classe DPE
-- Question metier : quelle est la surface moyenne
-- des maisons pour chaque classe energetique A a G ?
-- Techniques SQL : AVG, ROUND, GROUP BY, ORDER BY

SELECT
    etiquette_dpe,
    COUNT(*) AS nombre_diagnostics,
    ROUND(
        AVG(surface_habitable_logement),
        2
    ) AS surface_moyenne_m2
FROM factdpe
WHERE type_batiment = 'maison'
GROUP BY etiquette_dpe
ORDER BY etiquette_dpe;

-- REQUETE 08 : Classement annuel des diagnostics E, F et G
-- Question metier : quelles annees enregistrent
-- le plus de diagnostics de maisons E, F et G ?
-- Techniques SQL : CTE, INNER JOIN, GROUP BY, RANK OVER

WITH diagnostics_annuels AS (
    SELECT
        d.annee,
        COUNT(*) AS nombre_diagnostics_efg
    FROM factdpe AS f
    INNER JOIN dim_date AS d
        ON f.date_dpe = d.date_dpe
    WHERE f.type_batiment = 'maison'
      AND f.etiquette_dpe IN ('E', 'F', 'G')
    GROUP BY d.annee
)
SELECT
    annee,
    nombre_diagnostics_efg,
    RANK() OVER (
        ORDER BY nombre_diagnostics_efg DESC
    ) AS classement
FROM diagnostics_annuels
ORDER BY classement;

-- REQUETE 09 : Classes DPE des maisons
-- ayant plus de diagnostics que la moyenne par classe
-- Question metier : quelles classes comptent davantage
-- de diagnostics de maisons que la moyenne par classe ?
-- Techniques SQL : sous-requete, GROUP BY, HAVING, AVG

SELECT
    etiquette_dpe,
    COUNT(*) AS nombre_diagnostics
FROM factdpe
WHERE type_batiment = 'maison'
GROUP BY etiquette_dpe
HAVING COUNT(*) > (
    SELECT AVG(effectif)
    FROM (
        SELECT
            COUNT(*) AS effectif
        FROM factdpe
        WHERE type_batiment = 'maison'
        GROUP BY etiquette_dpe
    ) AS repartition
)
ORDER BY nombre_diagnostics DESC;

-- REQUETE 10 : Typologie des maisons E, F et G
-- Question metier : quels sont les volumes et les
-- surfaces moyennes des maisons energivores ?
-- Techniques SQL : WHERE, IN, COUNT, AVG, ROUND, GROUP BY

SELECT
    etiquette_dpe,
    COUNT(*) AS nombre_diagnostics,
    ROUND(
        AVG(surface_habitable_logement),
        2
    ) AS surface_moyenne_m2
FROM factdpe
WHERE type_batiment = 'maison'
  AND etiquette_dpe IN ('E', 'F', 'G')
GROUP BY etiquette_dpe
ORDER BY etiquette_dpe;

USE btp_renovation_nantes;

SHOW TABLES LIKE 'dim%';

USE btp_renovation_nantes;

SELECT id_quartier, nom_quartier
FROM dimquartier
ORDER BY id_quartier;

USE btp_renovation_nantes;

CREATE TABLE dpe_quartiers_import (
    numero_dpe VARCHAR(30) PRIMARY KEY,
    id_quartier INT NULL
);

USE btp_renovation_nantes;

LOAD DATA LOCAL INFILE
'C:/Users/OYONO/Documents/COURS DE FORMATION/0000 PROJET FIN DE FORMATION DATA ANALYST IA/PROJET_FINAL_BTP_NANTES/DPE_Quartiers_import.csv'
INTO TABLE dpe_quartiers_import
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(numero_dpe, @id_quartier)
SET id_quartier = NULLIF(@id_quartier, '');

USE btp_renovation_nantes;

SELECT
    COUNT(*) AS total_diagnostics,
    COUNT(id_quartier) AS avec_quartier,
    COUNT(*) - COUNT(id_quartier) AS sans_quartier
FROM dpe_quartiers_import;

USE btp_renovation_nantes;

UPDATE factdpe AS f
INNER JOIN dpe_quartiers_import AS q
    ON f.numero_dpe = q.numero_dpe
SET f.id_quartier = q.id_quartier;

USE btp_renovation_nantes;

SET SQL_SAFE_UPDATES = 0;

UPDATE factdpe AS f
INNER JOIN dpe_quartiers_import AS q
    ON f.numero_dpe = q.numero_dpe
SET f.id_quartier = q.id_quartier;

USE btp_renovation_nantes;

SELECT
    COUNT(*) AS total_diagnostics,
    COUNT(id_quartier) AS avec_quartier,
    COUNT(*) - COUNT(id_quartier) AS sans_quartier
FROM factdpe;

SET SQL_SAFE_UPDATES = 1;

USE btp_renovation_nantes;

SHOW TABLES;

USE btp_renovation_nantes;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'btp_renovation_nantes'
  AND REFERENCED_TABLE_NAME IS NOT NULL;
  
  USE btp_renovation_nantes;

-- Répartition des diagnostics DPE par quartier
SELECT
    q.nom_quartier,
    COUNT(f.numero_dpe) AS nombre_diagnostics
FROM dimquartier AS q
LEFT JOIN factdpe AS f
    ON q.id_quartier = f.id_quartier
GROUP BY q.id_quartier, q.nom_quartier
ORDER BY nombre_diagnostics DESC;










