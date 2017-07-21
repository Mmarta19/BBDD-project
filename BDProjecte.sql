-- Projecte Bases de Dades (Q3 2015/2016)
-- Marta Barrachina, Mateu Camps, Jennifer Arias

/* ## ORÍGENS DE LES DADES ##
NOMS I COGNOMS:
	behindthename.com/random, familiars i inventats.
    
ATRIBUTS DNI’S, DATES DE NAIXEMENTS, SALDOS, TELÈFONS I POBLACIONS:
	Aleatòries
    
ATRIBUT D’EMAIL:
	A partir del primer cognom i del nom (cognom1+nom@domini.com)
    
VÍDEOJOCS I DESCRIPCIONS:
	Wikipedia.com, IGN.com, metacritic.com
    
GÈNERES DE VÍDEOJOCS, PELICULES I ÀLBUMS:
	Classificació segons Wikipedia.com
    
DADES NUMÈRIQUES DE TRANSACCIONS I REGISTRES:
	Majoritàriament aleatories amb funcions de full de càlcul (=RAND() i =RANDBETWEEN(m,n))
    
PELICULES:
	Base de Dades AllMyMovies
    
ALBUMS:
	Col·lecció pròpia
    
NOMS DE FRANQUICIES I DIRECCIONS:
	Botigues existents que també operen en el sector de la compra-venda
    de pel·lícules, videojocs i discs de música
	
*/

-- -----------------------------------------------------------------------------------------------
--  0. PREÀMBUL ----------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
DROP DATABASE IF EXISTS BDProjecte;
CREATE DATABASE BDProjecte;
USE BDProjecte;

-- -----------------------------------------------------------------------------------------------
-- 1. SENTENCIES CREATE --------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
CREATE TABLE tSoci (
	IDsoci 		INT AUTO_INCREMENT NOT NULL,
	dni			VARCHAR(11) DEFAULT NULL,
	nom			VARCHAR(20) DEFAULT NULL,
	cognom1		VARCHAR(20) DEFAULT NULL,
	cognom2		VARCHAR(20) DEFAULT NULL,
	naixement	DATE DEFAULT NULL,
	saldo		FLOAT(15,2) DEFAULT NULL,
	telefon		INT(11) DEFAULT NULL,
	email		VARCHAR(50) DEFAULT NULL,
	ciutat	VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (IDsoci)
);


CREATE TABLE tFranquicia (
	IDfranquicia	INT AUTO_INCREMENT NOT NULL,
	nom				VARCHAR(20) DEFAULT NULL,
	direccio		VARCHAR(100) DEFAULT NULL,
	ciutat		VARCHAR(50) DEFAULT NULL, 
	telefon			INT(11) DEFAULT NULL,
	PRIMARY KEY (IDfranquicia)
);


CREATE TABLE tEmpleat (
	IDempleat		INT AUTO_INCREMENT NOT NULL,
	IDfranquicia	INT NULL,
	dni				VARCHAR(11) DEFAULT NULL,
	nom				VARCHAR(20) DEFAULT NULL,
	cognom1			VARCHAR(20) DEFAULT NULL,
	cognom2			VARCHAR(20) DEFAULT NULL,
	naixement		DATE DEFAULT NULL,
	ciutat		VARCHAR(50) DEFAULT NULL,
	email			VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (IDempleat)
);


CREATE TABLE tRegistre (
	IDregistre	INT AUTO_INCREMENT NOT NULL,
	IDempleat	INT NULL,
	EntraSurt	TINYINT(1) DEFAULT NULL,
	data		DATE DEFAULT NULL,
	hora		TIME DEFAULT NULL,
    PRIMARY KEY (IDregistre)
);

CREATE TABLE tTransaccio (
	IDtransaccio	INT AUTO_INCREMENT NOT NULL,
	IDsoci			INT NULL,
	IDfranquicia	INT DEFAULT NULL,
	IDempleat		INT DEFAULT NULL,
	data			DATE DEFAULT NULL,
	hora			TIME DEFAULT NULL,
	CompraVenda		TINYINT(1) DEFAULT NULL,
	cost			FLOAT(15,2) DEFAULT NULL,
    PRIMARY KEY (IDtransaccio)
);

CREATE TABLE tTransaccio_te_tProducte (
	IDtransaccio 	INT NOT NULL DEFAULT '0',
    IDproducte 		INT NOT NULL DEFAULT '0',
    PRIMARY KEY (IDtransaccio, IDproducte)
);

CREATE TABLE tProducte (
	IDproducte		INT AUTO_INCREMENT  NOT NULL,
	IDanticSoci		INT NULL DEFAULT NULL,
	descripcio		LONGTEXT DEFAULT NULL,
	observacions	LONGTEXT DEFAULT NULL,
	cost			FLOAT(15,2) DEFAULT NULL,
    PRIMARY KEY (IDproducte)
);

CREATE TABLE tVideojoc (
	IDvideojoc			INT AUTO_INCREMENT NOT NULL,
	IDproducte			INT NULL,
	IDconsolaVideojoc	INT DEFAULT NULL ,
	titol				VARCHAR(100) DEFAULT NULL ,
	any					INT(11) DEFAULT NULL ,
	idioma				VARCHAR(20) DEFAULT NULL ,
	PRIMARY KEY (IDvideojoc)
);

CREATE TABLE tGenereVideojoc (
	IDgenereVideojoc	INT AUTO_INCREMENT NOT NULL,
	genere				VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY(IDgenereVideojoc)
);

CREATE TABLE tVideojoc_te_tGenereVideojoc (
	IDvideojoc			INT NOT NULL DEFAULT '0',	
    IDgenereVideojoc	INT NOT NULL DEFAULT '0',
    PRIMARY KEY(IDvideojoc, IDgenereVideojoc)
);

CREATE TABLE tConsolaVideojoc (
	IDconsolaVideojoc	INT AUTO_INCREMENT NOT NULL,
	consola				VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY(IDconsolaVideojoc)
);

CREATE TABLE tAlbum (
	IDalbum			INT AUTO_INCREMENT NOT NULL,
	IDproducte		INT NULL,
	IDformatAlbum	INT DEFAULT NULL,
	titol			VARCHAR(100) DEFAULT NULL,
	artista			VARCHAR(50) DEFAULT NULL,
	discografica	VARCHAR(50) DEFAULT NULL,
	any				INT(11) DEFAULT NULL,
	discs			INT(11) DEFAULT NULL,
	idioma			VARCHAR(50) DEFAULT NULL,
	PRIMARY KEY(IDalbum)
);

CREATE TABLE tGenereAlbum (
	IDgenereAlbum INT AUTO_INCREMENT NOT NULL,
    genere VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY(IDgenereAlbum)
);

CREATE TABLE tAlbum_te_tGenereAlbum (
	IDalbum 		INT NOT NULL DEFAULT '0',
    IDgenereAlbum 	INT NOT NULL DEFAULT '0',
    PRIMARY KEY(IDalbum, IDgenereAlbum)
);

CREATE TABLE tFormatAlbum (
	IDformatAlbum 	INT AUTO_INCREMENT NOT NULL,
    format 			VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY(IDformatAlbum)
);

CREATE TABLE tPelicula (
    IDpelicula INT AUTO_INCREMENT NOT NULL,
    IDproducte INT NULL,
    IDformatPelicula INT DEFAULT NULL,
    titol VARCHAR(100) DEFAULT NULL,
    titolOriginal VARCHAR(100) DEFAULT NULL,
    director VARCHAR(50) DEFAULT NULL,
    any INT(11) DEFAULT NULL,
    actors LONGTEXT  DEFAULT NULL,
    durada INT(11)  DEFAULT NULL,
    pais VARCHAR(50)  DEFAULT NULL,
    PRIMARY KEY (IDpelicula)
);

CREATE TABLE tGenerePelicula (
	IDgenerePelicula 	INT AUTO_INCREMENT NOT NULL,
    genere				VARCHAR(20) DEFAULT NULL,
	PRIMARY KEY(IDgenerePelicula)
);

CREATE TABLE tPelicula_te_tGenerePelicula (
	IDpelicula 			INT NOT NULL DEFAULT '0',
    IDgenerePelicula 	INT NOT NULL DEFAULT '0',
    PRIMARY KEY(IDpelicula, IDgenerePelicula)
);

CREATE TABLE tFormatPelicula (
	IDformatPelicula 	INT AUTO_INCREMENT NOT NULL,
    format 				VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY(IDformatPelicula)
);

-- -----------------------------------------------------------------------------------------------
--  2. INSERTS/LOADS -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tSoci.csv' 
INTO TABLE tSoci
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tFranquicia.csv' 
INTO TABLE tFranquicia
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tEmpleat.csv' 
INTO TABLE tEmpleat
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tRegistre.csv' 
INTO TABLE tRegistre
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tTransaccio.csv' 
INTO TABLE tTransaccio
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tTransaccio_te_tProducte.csv' 
INTO TABLE tTransaccio_te_tProducte
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tProducte.csv' 
INTO TABLE tProducte
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tVideojoc.csv' 
INTO TABLE tVideojoc
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tGenereVideojoc.csv' 
INTO TABLE tGenereVideojoc
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tVideojoc_te_tGenereVideojoc.csv' 
INTO TABLE tVideojoc_te_tGenereVideojoc
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tConsolaVideojoc.csv' 
INTO TABLE tConsolaVideojoc
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tAlbum.csv' 
INTO TABLE tAlbum
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tGenereAlbum.csv' 
INTO TABLE tGenereAlbum
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tAlbum_te_tGenereAlbum.csv' 
INTO TABLE tAlbum_te_tGenereAlbum
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tFormatAlbum.csv' 
INTO TABLE tFormatAlbum
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tPelicula.csv' 
INTO TABLE tPelicula
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tGenerePelicula.csv' 
INTO TABLE tGenerePelicula
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tPelicula_te_tGenerePelicula.csv' 
INTO TABLE tPelicula_te_tGenerePelicula
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/Marta/Desktop/UNI/csv/tFormatPelicula.csv' 
INTO TABLE tFormatPelicula
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


-- -----------------------------------------------------------------------------------------------
-- 3. CORRECCIONS  ------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------

-- El valor de CompraVenda de la taula tTransaccio diu:
--    La franquicia ha efectuat una compra(1), i per tant l'article SI està disponible a la botiga
--    La franquicia ha efectuat una venda(0), i per tant l'article NO està disponible a la botiga

-- Canvia tots els IDanticsoci de la taula tProducte de 0 a NULL
UPDATE tProducte
SET IDanticsoci = NULL
WHERE IDanticsoci = 0;


-- S'adjunta a cada producte la IDfranquicia a la qual pertanyen
ALTER TABLE tProducte
ADD COLUMN IDfranquicia INT DEFAULT NULL AFTER IDanticsoci;

UPDATE tProducte P1
SET P1.IDfranquicia = (
	SELECT IDfranquicia
    FROM tTransaccio T2 JOIN tTransaccio_te_tProducte TP2
	ON T2.IDtransaccio = TP2.IDtransaccio
	WHERE IDproducte = P1.IDproducte
);

-- Actualitza els costos de les transaccions segons els productes
-- que s'hagin comprat o venut
UPDATE tTransaccio T1
SET T1.cost = (
	SELECT sum(cost) FROM tTransaccio_te_tProducte TP2 JOIN tProducte P2
    ON TP2.IDproducte = P2.IDproducte
    WHERE TP2.IDtransaccio = T1.IDtransaccio
    GROUP BY T1.IDtransaccio
);

-- Eliminem les transaccions que no tenen preu
DELETE FROM tTransaccio
WHERE cost IS NULL;

-- Sincronitzar IDanticSoci (de tProducte) i IDsoci (de transaccio) dels que han efectuat venda
UPDATE tProducte P1
SET IDanticSoci = (
	SELECT IDsoci FROM ttransaccio_te_tproducte TP2 JOIN tTransaccio T2
    ON T2.IDtransaccio = TP2.IDtransaccio
    WHERE TP2.IDproducte = P1.IDproducte
);

-- Els productes que estiguin en una transacció de CompraVenda = 0,
-- eliminar-ne l'antic soci
UPDATE tProducte P0
SET P0.IDanticSoci = NULL
WHERE (
		SELECT T1.CompraVenda
		FROM tTransaccio T1 JOIN ttransaccio_te_tproducte TP1
		ON TP1.IDtransaccio = T1.IDtransaccio
		WHERE TP1.IDproducte = P0.IDproducte
	) = 0;
    
        alter table tproducte
add column ESTA_A_LA_BOTIGA TINYINT(1) DEFAULT 1;  

-- 		El prodcute està a la botiga		(1)
-- 		El producte no està a la botiga		(0)

update tproducte P1
set ESTA_A_LA_BOTIGA = (select CompraVenda 
						from ttransaccio t join ttransaccio_te_tproducte ttp1
                        on t.idtransaccio=ttp1.idtransaccio
                        where ttp1.idproducte=P1.idproducte
                        );


create table limits_CLIETNTS ( idclient int not null, idtipus int not null, primary key (idclient,idtipus));


alter table tfranquicia 
add column num_empleats int default null;

update tfranquicia tf
set num_empleats = ( select count(*) from tEmpleat e1 where e1.idfranquicia= tf.idfranquicia);

-- -----------------------------------------------------------------------------------------------
-- 4. CLAUS FORÀNIES  ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
ALTER TABLE tEmpleat
ADD CONSTRAINT FOREIGN KEY (IDfranquicia)
REFERENCES tFranquicia(IDfranquicia)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
ALTER TABLE tRegistre
ADD CONSTRAINT FOREIGN KEY (IDempleat)
REFERENCES tEmpleat(IDempleat)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE tTransaccio
ADD CONSTRAINT FOREIGN KEY (IDsoci)
REFERENCES tSoci(IDsoci)
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  
ADD CONSTRAINT FOREIGN KEY (IDfranquicia)
REFERENCES tFranquicia(IDfranquicia)
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  
ADD CONSTRAINT FOREIGN KEY (IDempleat)
REFERENCES tEmpleat(IDempleat)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

-- TALLAR RELACIÓ DE FKs PER CREAR HISTORIAL DE Transaccions i Productes
/*
ALTER TABLE tTransaccio_te_tProducte
ADD CONSTRAINT FOREIGN KEY (IDtransaccio)
REFERENCES tTransaccio(IDtransaccio)
  ON DELETE no action
  ON UPDATE no action,
  
ADD CONSTRAINT FOREIGN KEY (IDproducte)
REFERENCES tProducte(IDproducte)
  ON DELETE restrict
  ON UPDATE restrict;
*/

ALTER TABLE tProducte
ADD CONSTRAINT FOREIGN KEY (IDanticSoci)
REFERENCES tSoci(IDsoci)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE tVideojoc
ADD CONSTRAINT FOREIGN KEY (IDproducte)
REFERENCES tProducte(IDproducte)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
ADD CONSTRAINT FOREIGN KEY (IDconsolaVideojoc)
REFERENCES tConsolaVideojoc(IDconsolaVideojoc)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE tVideojoc_te_tGenereVideojoc
ADD CONSTRAINT FOREIGN KEY (IDvideojoc)
REFERENCES tVideojoc(IDvideojoc)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
ADD CONSTRAINT FOREIGN KEY (IDgenereVideojoc)
REFERENCES tGenereVideojoc(IDgenereVideojoc)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE tAlbum
ADD CONSTRAINT FOREIGN KEY (IDproducte)
REFERENCES tProducte(IDproducte)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
ADD CONSTRAINT FOREIGN KEY (IDformatAlbum)
REFERENCES tFormatAlbum(IDformatAlbum)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE tAlbum_te_tGenereAlbum
ADD CONSTRAINT FOREIGN KEY (IDalbum)
REFERENCES tAlbum(IDalbum)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
ADD CONSTRAINT FOREIGN KEY (IDgenereAlbum)
REFERENCES tGenereAlbum(IDgenereAlbum)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE tPelicula
ADD CONSTRAINT FOREIGN KEY (IDproducte)
REFERENCES tProducte(IDproducte)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
ADD CONSTRAINT FOREIGN KEY (IDformatPelicula)
REFERENCES tFormatPelicula(IDformatPelicula)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
ALTER TABLE tPelicula_te_tGenerePelicula
ADD CONSTRAINT FOREIGN KEY (IDpelicula)
REFERENCES tPelicula(IDpelicula)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
ADD CONSTRAINT FOREIGN KEY (IDgenerePelicula)
REFERENCES tGenerePelicula(IDgenerePelicula)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


/* 
TRIGGERS:
	[FET] Triggers producte
	[FET]Nombre d'empleats a cada franquicia (afegir columna a tFranquicia)
	Tipus de clients (taula limits)

P.E:
	[FET] REBAIXES!! CUAN HI H AN REBAIXES S'APLICARA UN  DESCOMPTE A CADA PRODUCTE DEPENENT DEL SEU PREU.
	[FET] Afegir/Actualitzar preu de la transacció. Cal tenir en compte la suma del preu dels productes implicats. (AQUEST NO FA SERVIR CURSORS!)
    [FET] Afegir i controlar nova columna als productes que mostri si esta a la botiga o no, segons si s'ha venut o comprat.

*/

-- -----------------------------------------------------------------------------------------------
-- 5. TRIGGERS -----------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------

-- MARTA: CREAR UN TRIGER QUE ATUALITZI EL NUMERO DE EMPLEATS QUE HI HA A LES FRANQUICIES
-- 1- SI ES FA UN INSERT:
DELIMITER $$

DROP TRIGGER IF EXISTS em_fran$$
-- USE `bdprojecte`$$
CREATE TRIGGER em_fran AFTER INSERT ON templeat FOR EACH ROW
BEGIN

    update tfranquicia
    set num_empleats=num_empleats+1
    where new.idfranquicia=idfranquicia;
    
    

END$$

-- 2. SI ES FA UNA MODIFICACIO
DELIMITER $$

DROP TRIGGER IF EXISTS em_fran2$$
-- USE `bdprojecte`$$
CREATE TRIGGER em_fran2 AFTER UPDATE ON templeat FOR EACH ROW
BEGIN

    update tfranquicia
    set num_empleats=num_empleats+1
    where new.idfranquicia=idfranquicia;
    
    update tfranquicia
    set num_empleats=num_empleats-1
    where old.idfranquicia=idfranquicia;
    

END$$

-- 3. SI S'ESBORRA
DELIMITER $$

DROP TRIGGER IF EXISTS em_fran3$$
-- USE `bdprojecte`$$
CREATE TRIGGER em_fran3 AFTER DELETE ON templeat FOR EACH ROW
BEGIN

    update tfranquicia
    set num_empleats=num_empleats-1
    where old.idfranquicia=idfranquicia;
    

END$$

DELIMITER ;


-- MATEU: Crear PRODUCTE quan s'insereixi VIDEOJOC
		DELIMITER $$

		DROP TRIGGER IF EXISTS bdprojecte.tvideojoc_BEFORE_INSERT$$
		-- AQUEST TRIGGER CREA UN NOU PRODUCTE BUIT QUAN ES CREA UN NOU VIDEOJOC
		-- I INTRODUEIX LA NOVA ID DEL PRODUCTE CREAT EN EL CAMP IDproducte DEL 
		-- VIDEOJOC

		CREATE TRIGGER `bdprojecte`.`tvideojoc_BEFORE_INSERT`
		BEFORE INSERT ON `tvideojoc`
		FOR EACH ROW
		BEGIN
			INSERT INTO tProducte (IDanticSoci, IDfranquicia, descripcio, observacions, cost) VALUES
			(null, null, 'desc_buit(VIDEOJOC)', 'obs_buit(VIDEOJOC)', null);
			
			SET NEW.IDproducte = (SELECT max(IDproducte) FROM tProducte);
		END$$
		DELIMITER ;

-- MATEU: Crear PRODUCTE quan s'insereixi ALBUM
		DELIMITER $$

		DROP TRIGGER IF EXISTS bdprojecte.talbum_BEFORE_INSERT$$
		-- AQUEST TRIGGER CREA UN NOU PRODUCTE BUIT QUAN ES CREA UN NOU ALBUM
		-- I INTRODUEIX LA NOVA ID DEL PRODUCTE CREAT EN EL CAMP IDproducte DEL 
		-- ALBUM
		CREATE TRIGGER `bdprojecte`.`talbum_BEFORE_INSERT`
		BEFORE INSERT ON `talbum`
		FOR EACH ROW
		BEGIN
			INSERT INTO tProducte (IDanticSoci, IDfranquicia, descripcio, observacions, cost) VALUES
			(null, null, 'desc_buit(ALBUM)', 'obs_buit(ALBUM)', null);
			
			SET NEW.IDproducte = (SELECT max(IDproducte) FROM tProducte);

		END$$
		DELIMITER ;

-- MATEU: Crear PRODUCTE quan s'insereixi PELICULA
		DELIMITER $$

		DROP TRIGGER IF EXISTS bdprojecte.tpelicula_BEFORE_INSERT$$
		-- AQUEST TRIGGER CREA UN NOU PRODUCTE BUIT QUAN ES CREA UNA NOVA PELICULA
		-- I INTRODUEIX LA NOVA ID DEL PRODUCTE CREAT EN EL CAMP IDproducte DE LA
		-- PELICULA

		CREATE TRIGGER `bdprojecte`.`tpelicula_BEFORE_INSERT`
		BEFORE INSERT ON `tpelicula`
		FOR EACH ROW
		BEGIN
			INSERT INTO tProducte (IDanticSoci, IDfranquicia, descripcio, observacions, cost) VALUES
			(null, null, 'desc_buit(PELICULA)', 'obs_buit(PELICULA)', null);
			
			SET NEW.IDproducte = (SELECT max(IDproducte) FROM tProducte);
		END$$
		DELIMITER ;

-- -----------------------------------------------------------------------------------------------
-- 6. STORED PROCEDURES --------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------

-- MARTA: 
-- 		El prodcute està a la botiga		(1)
-- 		El producte no està a la botiga		(0)

DROP procedure IF EXISTS actualitza_localitzacio;

	DELIMITER $$
	CREATE PROCEDURE actualitza_localitzacio (idpro int,idtrans int)
	BEGIN
    
		insert into ttrasaccio_te_tproducte values (idtrans,idpro);
        
        
		update tproducte P1
		set ESTA_A_LA_BOTIGA = (select CompraVenda 
						from ttransaccio t 
                        
                        where idtransaccio=idtrans
                        )
		where P1.idproducte=idpro;
        
        
	END$$
	DELIMITER ;


-- MATEU: Afegir/Actualitzar preu de la transacció. Cal tenir en compte la suma del preu dels productes implicats.
	DROP procedure IF EXISTS `actualitza_cost_transaccio`;
	DELIMITER $$
	CREATE PROCEDURE `actualitza_cost_transaccio` (IDtrans INT)
	BEGIN
		UPDATE tTransaccio T0
		SET T0.cost = (
			SELECT sum(cost) FROM tProducte P1 JOIN tTransaccio_te_tProducte TP1
			ON TP1.IDproducte = P1.IDproducte
			WHERE TP1.IDtransaccio = IDtrans
		)
		WHERE T0.IDtransaccio = IDtrans;
	END$$
	DELIMITER ;
    
-- MATEU: Rebaixes, es demana un preu mínim i un descompte que s'aplicarà als que superin aquest preu. Si el preu descomptat
-- és més petit que el preu mínim, es posarà el preu mínim al producte.
DROP procedure IF EXISTS `rebaixes`;
DELIMITER $$
USE `bdprojecte`$$
CREATE PROCEDURE `rebaixes` (cost_min FLOAT(15,2), descompte INT)
BEGIN
	DECLARE _idprod INT;
    DECLARE _cost FLOAT(15,2);
    
    DECLARE final BOOL DEFAULT FALSE;
    DECLARE cur CURSOR FOR (
		SELECT IDproducte, cost FROM tProducte
	);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
    
    OPEN cur;
    
    WHILE (!final) DO
    
        FETCH cur INTO _idprod, _cost;
        IF(_cost > cost_min) THEN

			UPDATE tProducte
            SET cost = cost - cost * (descompte/100)
            WHERE IDproducte = _idprod;
			
            IF( (_cost - _cost * (descompte/100) < cost_min) ) THEN
				UPDATE tProducte
				SET cost = cost_min
				WHERE IDproducte = _idprod;
			END IF;
            
		END IF;
        
    END WHILE;
    CLOSE cur;
END$$
DELIMITER ;
