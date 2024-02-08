DROP TABLE IF EXISTS desservir;
DROP TABLE IF EXISTS horaire;
DROP TABLE IF EXISTS jour;
DROP TABLE IF EXISTS station;
DROP TABLE IF EXISTS ligne;

CREATE TABLE IF NOT EXISTS ligne (
   id_ligne INT AUTO_INCREMENT,
   nom_ligne VARCHAR(100),
   PRIMARY KEY(id_ligne)
);

CREATE TABLE IF NOT EXISTS station (
   id_station INT AUTO_INCREMENT,
   nom_station VARCHAR(200),
   PRIMARY KEY(id_station)
);

CREATE TABLE IF NOT EXISTS jour (
   id_jour INT AUTO_INCREMENT,
   nom_jour VARCHAR(50),
   PRIMARY KEY(id_jour)
);

CREATE TABLE IF NOT EXISTS horaire (
   id_horaire INT AUTO_INCREMENT,
   heure_depart VARCHAR(50),
   id_station INT NOT NULL,
   id_jour INT NOT NULL,
   id_ligne INT NOT NULL,
   PRIMARY KEY(id_horaire),
   FOREIGN KEY(id_station) REFERENCES station(id_station),
   FOREIGN KEY(id_jour) REFERENCES jour(id_jour),
   FOREIGN KEY(id_ligne) REFERENCES ligne(id_ligne)
);

CREATE TABLE IF NOT EXISTS desservir (
   id_ligne INT,
   id_station INT,
   PRIMARY KEY(id_ligne, id_station),
   FOREIGN KEY(id_ligne) REFERENCES ligne(id_ligne),
   FOREIGN KEY(id_station) REFERENCES station(id_station)
);

CREATE TABLE IF NOT EXISTS arretsNonDesservis (
    id_arret INT AUTO_INCREMENT PRIMARY KEY,
    nom_arret VARCHAR(100),
    arret_redirige VARCHAR(100)
);

-- Modification de la table Desservir pour prendre en compte les arrêts non desservis temporairement
ALTER TABLE desservir
ADD COLUMN est_desservi_temporairement BOOLEAN DEFAULT TRUE;