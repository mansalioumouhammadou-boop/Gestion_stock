CREATE TABLE roles (
    id_role INT AUTO_INCREMENT PRIMARY KEY,
    nom_role VARCHAR(100) NOT NULL
);

CREATE TABLE utilisateurs(
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nom_user VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    id_role INT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_role) REFERENCES roles(id_role)
);

CREATE TABLE categories(
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(100) NOT NULL
);


CREATE TABLE fournisseurs(
    id_fournisseur INT AUTO_INCREMENT PRIMARY KEY,
    nom_fournisseur VARCHAR(100) NOT NULL,
    telephone VARCHAR(50),
    adresse TEXT
);

CREATE TABLE produits(
    id_produit INT AUTO_INCREMENT PRIMARY KEY,
    reference VARCHAR(50) UNIQUE NOT NULL,
    nom_produit VARCHAR(100) NOT NULL,
    description_produit TEXT,
    prix_achat DECIMAL(10,2),
    prix_vente DECIMAL(10,2),
    quantite INT DEFAULT 0,
    seuil_alerte INT DEFAULT 5,
    image_produit VARCHAR(255),
    id_categorie INT,
    FOREIGN KEY (id_categorie) REFERENCES categories(id_categorie)
);

CREATE TABLE entrees_stock(
    id_entree INT AUTO_INCREMENT PRIMARY KEY,
    id_produit INT,
    id_fournisseur INT,
    quantite_entree INT NOT NULL,
    date_entree TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_produit) REFERENCES produits(id_produit),
    FOREIGN KEY (id_fournisseur) REFERENCES fournisseurs(id_fournisseur)
);

CREATE TABLE sorties_stock(
    id_sortie INT AUTO_INCREMENT PRIMARY KEY,
    id_produit INT,
    quantite_sortie INT NOT NULL,
    motif ENUM('vente','perte','don','transfert') NOT NULL,
    date_sortie TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_produit) REFERENCES produits(id_produit)
);

CREATE TABLE commandes(
    id_commande INT AUTO_INCREMENT PRIMARY KEY,
    nom_client VARCHAR(100),
    date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut_commande ENUM('en_attente','validee','annulee') DEFAULT 'en_attente'
);

CREATE TABLE ligne_commande(
    id_ligne_commande INT AUTO_INCREMENT PRIMARY KEY,
    id_commande INT,
    id_produit INT,
    quantite_commande INT,
    prix DECIMAL(10,2),
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commande),
    FOREIGN KEY (id_produit) REFERENCES produits(id_produit)
);

CREATE TABLE logs(
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    action_menee VARCHAR(255),
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES utilisateurs(id_user)
);
