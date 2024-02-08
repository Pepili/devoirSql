START TRANSACTION;

-- Supprimer les anciennes données
TRUNCATE TABLE desservir;
TRUNCATE TABLE horaire;
TRUNCATE TABLE ligne;
TRUNCATE TABLE jour;
TRUNCATE TABLE station;

-- Insérer les stations
INSERT INTO station (nom_station) VALUES
('P+R Ouest'),
('Fourchêne 1'),
('Madeleine'),
('République'),
('PIBS 2'),
('Petit Tohannic'),
('Delestraint'),
('Kersec');

-- Insérer les jours (uniquement lundi)
INSERT INTO jour (nom_jour) VALUES ('Lundi');

-- Insérer la ligne
INSERT INTO ligne (nom_ligne) VALUES ('2 P+R Ouest direction Kersec');

-- Insérer les horaires
INSERT INTO horaire (heure_depart, id_station, id_jour, id_ligne) VALUES
-- P+R Ouest
('6:32', 1, 1, 1),
('6:42', 1, 1, 1),
('6:52', 1, 1, 1),
('7:00', 1, 1, 1),
('7:10', 1, 1, 1),
-- Fourchêne 1
('6:34', 2, 1, 1),
('6:44', 2, 1, 1),
('6:54', 2, 1, 1),
('7:02', 2, 1, 1),
('7:12', 2, 1, 1),
-- Madeleine
('6:37', 3, 1, 1),
('6:47', 3, 1, 1),
('6:57', 3, 1, 1),
('7:06', 3, 1, 1),
('7:16', 3, 1, 1),
-- République
('6:42', 4, 1, 1),
('6:52', 4, 1, 1),
('7:02', 4, 1, 1),
('7:12', 4, 1, 1),
('7:22', 4, 1, 1),
-- PIBS 2
('6:46', 5, 1, 1),
('6:56', 5, 1, 1),
('7:07', 5, 1, 1),
('7:17', 5, 1, 1),
('7:27', 5, 1, 1),
-- Petit Tohannic (supposé)
('6:50', 6, 1, 1),
('7:00', 6, 1, 1),
('7:11', 6, 1, 1),
('7:21', 6, 1, 1),
('7:31', 6, 1, 1),
-- Delestraint (supposé)
('6:51', 7, 1, 1),
('7:01', 7, 1, 1),
('7:12', 7, 1, 1),
('7:22', 7, 1, 1),
('7:32', 7, 1, 1),
-- Kersec
('6:55', 8, 1, 1),
('7:05', 8, 1, 1),
('7:16', 8, 1, 1),
('7:26', 8, 1, 1),
('7:36', 8, 1, 1);

-- Insérer les liaisons entre la ligne et les stations
INSERT INTO desservir (id_ligne, id_station) VALUES
(1, 1), -- P+R Ouest
(1, 2), -- Fourchêne 1
(1, 3), -- Madeleine
(1, 4), -- République
(1, 5), -- PIBS 2
(1, 6), -- Petit Tohannic
(1, 7), -- Delestraint
(1, 8); -- Kersec

-- Insertion des données pour l'arrêt non desservi temporairement
-- Insertion des données pour l'arrêt non desservi temporairement
INSERT INTO arretsNonDesservis (nom_arret, arret_redirige) VALUES ('Petit Tohannic', 'Delestraint');

-- Mise à jour de la table Desservir pour indiquer que Petit Tohannic n'est plus desservi temporairement
UPDATE desservir
SET est_desservi_temporairement = FALSE
WHERE id_station = (SELECT id_station FROM Station WHERE nom_station = 'Petit Tohannic');

-- Requête pour mettre à jour l'arrêt Petit Tohannic
UPDATE arretsNonDesservis
SET nom_arret = 'Petit Tohannic', arret_redirige = 'Delestraint'
WHERE nom_arret = 'Petit Tohannic';

-- Insérer la ligne 2 dans la direction opposée 
INSERT INTO ligne (nom_ligne) VALUES ('2 Kersec direction P+R Ouest');

-- Insérer les liaisons entre la ligne 2 dans la direction opposée et les stations (en réutilisant les mêmes stations que pour l'autre direction)
INSERT INTO desservir (id_ligne, id_station) VALUES
(2, 8), -- Kersec
(2, 7), -- Delestraint
(2, 6), -- Petit Tohannic
(2, 5), -- PIBS
(2, 4), -- République
(2, 3), -- Madeleine
(2, 2), -- Fourchêne
(2, 1); -- P+R Ouest

-- Insérer les horaires pour la ligne 2 dans la direction opposée pour le premier trajet de la journée (en réutilisant les mêmes horaires que pour l'autre direction)
INSERT INTO horaire (heure_depart, id_station, id_jour, id_ligne) VALUES
('6:32', 8, 1, 2), -- Kersec
('6:42', 7, 1, 2), -- Delestraint
('6:52', 6, 1, 2), -- Petit Tohannic
('7:00', 5, 1, 2), -- PIBS
('7:10', 4, 1, 2), -- République
('7:16', 3, 1, 2), -- Madeleine
('7:24', 2, 1, 2), -- Fourchêne
('7:32', 1, 1, 2); -- P+R Ouest

COMMIT;