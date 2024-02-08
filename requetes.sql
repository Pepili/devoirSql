-- Requête 1 : Afficher les horaires à l'arrêt Madelaine dans l'ordre chronologique
SELECT *
FROM horaire
JOIN station ON horaire.id_station = station.id_station
WHERE station.nom_station = 'Madeleine'
ORDER BY heure_depart;

-- Requête 2 : Afficher les horaires à l'arrêt République dans l'ordre chronologique
SELECT *
FROM horaire
JOIN station ON horaire.id_station = station.id_station
WHERE station.nom_station = 'République'
ORDER BY heure_depart;

-- Désactiver ONLY_FULL_GROUP_BY
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Afficher le parcours complet de la ligne 2 en direction de Kersec
SELECT station.nom_station
FROM ligne
JOIN desservir ON ligne.id_ligne = desservir.id_ligne
JOIN station ON desservir.id_station = station.id_station
WHERE ligne.nom_ligne = '2 P+R Ouest direction Kersec'
ORDER BY desservir.id_ligne, desservir.id_station;

-- Requête pour afficher le message approprié à l'arrêt Petit Tohannic
SELECT 
    CASE 
        WHEN station.nom_station = 'Petit Tohannic' THEN CONCAT("L'arrêt temporairement non desservi, veuillez vous reporter à l'arrêt ", ant.arret_redirige, '.')
        ELSE CONCAT("Horaires à l'arrêt ", station.nom_station, ' (Lundi)')
    END AS "Horaires à l'arrêt Petit Tohannic (Lundi)"
FROM 
    horaire
JOIN 
    station ON horaire.id_station = station.id_station
JOIN 
    desservir ON horaire.id_station = desservir.id_station
JOIN 
    ligne ON horaire.id_ligne = ligne.id_ligne
LEFT JOIN 
    arretsNonDesservis ant ON station.nom_station = ant.nom_arret
WHERE 
    station.nom_station = 'Petit Tohannic' AND
    ligne.nom_ligne = '2 P+R Ouest direction Kersec'
ORDER BY 
    horaire.heure_depart;

