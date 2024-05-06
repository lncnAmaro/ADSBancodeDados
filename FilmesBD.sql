CREATE TABLE Filmes (
	id		int		PRIMARY KEY		AUTO_INCREMENT,
	titulo		varchar(60),
  	minutos		int
);

-- Valor vira NULL
DELIMITER $
CREATE TRIGGER chk_minutos BEFORE INSERT ON FIlmes FOR EACH ROW
BEGIN
	IF NEW.minutos < 0 THEN SET NEW.minutos = NULL;
    END IF;
END $
DELIMITER ;

INSERT INTO Filmes (titulo, minutos) VALUES ("The Terrible Trigger", 120);
INSERT INTO Filmes (titulo, minutos) VALUES ("O Alto da Compadecida", 135);
INSERT INTO Filmes (titulo, minutos) VALUES ("Faroeste Caboclo", 240);
INSERT INTO Filmes (titulo, minutos) VALUES ("The Matrix", 90);
INSERT INTO Filmes (titulo, minutos) VALUES ("Blade Runner", -88);
INSERT INTO Filmes (titulo, minutos) VALUES ("O Labirinto do Fauno", 110);
INSERT INTO Filmes (titulo, minutos) VALUES ("Metrópole", 0);
INSERT INTO Filmes (titulo, minutos) VALUES ("A Lista", 120);

-- Testa o NULL
SELECT * FROM Filmes;

-- Lança uma Exception
DELIMITER $
CREATE TRIGGER chk_minutos_exception BEFORE INSERT ON Filmes FOR EACH ROW
BEGIN
	IF NEW.minutos < 0 THEN
    
        -- Lançar um erro
        SIGNAL SQLSTATE '45000'			-- Exceção não tratada
        SET MESSAGE_TEXT = "Valor inválido para minutos",
        MYSQL_ERRNO = 2022;				-- Código do erro para controle
	END IF;
END $
DELIMITER ;

-- Tabela de informação de ocorrências
CREATE TABLE Log_Deletions (
	id		int		PRIMARY KEY		AUTO_INCREMENT,
  	titulo		varchar(50),
  	quando		datetime,
  	quem		varchar(50)
);

DELIMITER $
CREATE TRIGGER log_deletions AFTER DELETE ON Filmes FOR EACH ROW
BEGIN
	INSERT INTO Log_Deletions VALUES (OLD.titulo, NOW(), USER());
END $
DELIMITER ;

-- Teste da tabela de ocorrências
DELETE FROM Filmes WHERE id = 2;
DELETE FROM Filmes WHERE id = 4;

SELECT * FROM Log_Deletions;