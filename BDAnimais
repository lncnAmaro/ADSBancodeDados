CREATE TABLE Especies (
  	especie 			VARCHAR(50),
	descricao			VARCHAR(100),
  
	PRIMARY KEY(especie)
);

CREATE TABLE Animais (
	id 					int,
	nome 				VARCHAR(50),
	nasc 				date,
	peso 				decimal(10,2),
	cor 				VARCHAR(50),
  	especie_animal		VARCHAR(50),	
  
	PRIMARY key(id),
	FOREIGN KEY(especie_animal) REFERENCES Especies(especie)
);

INSERT INTO Especies (especie, descricao) VALUES ('Gato', 'O gato doméstico é um felino popular como animal de estimação.');
INSERT INTO Especies (especie, descricao) VALUES ('Cachorro', 'O cachorro doméstico é um mamífero quadrúpede com cobertura de pelos.');
INSERT INTO Especies (especie, descricao) VALUES ('Ave', 'Aves são seres alados que habitam os céus.');

INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (01, 'Ágata', '2015-04-09', 13.9, 'branco', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (02, 'Félix', '2016-06-06', 14.3, 'preto', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (03, 'Tom', '2013-02-08', 11.2, 'azul', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (04, 'Garfield', '2015-07-06', 17.1, 'laranja', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (05, 'Frajola', '2013-08-01', 13.7, 'preto', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (06, 'Manda-chuva', '2012-02-03', 12.3, 'amarelo', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (07, 'Snowball', '2014-04-03', 13.2, 'preto', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (08, 'Ágata', '2015-08-03', 11.9, 'azul', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (09, 'Gato de Botas', '2012-12-10', 11.6, 'amarelo', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (10, 'Kitty', '2020-04-06', 11.6, 'amarelo', 'Gato');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (11, 'Pluto', '2012-01-03', 12.3, 'amarelo', 'Cachorro');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (12, 'Pateta', '2015-05-01', 17.7, 'preto', 'Cachorro');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (13, 'Snoopy', '2013-07-02', 17.1, 'branco', 'Cachorro');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (14, 'Rex', '2019-11-03', 19.7, 'beje', 'Cachorro');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (15, 'Bidu', '2012-09-08', 12.4, 'azul', 'Cachorro');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (16, 'Muttley', '2011-02-03', 14.3, 'laranja', 'Cachorro');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (17, 'Scooby', '2012-01-02', 19.9, 'marrom', 'Cachorro');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (18, 'Rex', '2020-08-19', 19.7, 'amarelo', 'Cachorro');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (19, 'Dum Dum', '2015-04-06', 11.2, 'laranja', 'Ave');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (20, 'Rufus', '2020-04-05', 19.7, 'amarelo', 'Ave');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (21, 'Milu', '2013-02-04', 17.9, 'branco', 'Ave');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (22, 'Pterodáctilo', NULL, 201, 'cinza', 'Ave');
INSERT INTO Animais (id, nome, nasc, peso, cor, especie_animal) VALUES (23, 'Cuco', '2024-01-20', 201, 'amarelo', 'Ave');

/*Seleciona todos os animais:*/
SELECT * FROM Animais;

/*Altera o nome do Pateta para Goofy:*/
UPDATE Animais SET nome = 'Goofy' WHERE id = '12';

/*Altera o peso do Garfield para 10 quilogramas:*/
UPDATE Animais SET peso = 10 WHERE id = '04';

/*Altera a cor de todos os gatos para laranja:*/
UPDATE Animais SET cor = 'laranja' WHERE especie_animal = 'Gato';

/*Cria um campo altura para os animais:*/
ALTER TABLE Animais ADD altura decimal;

/*Crie um campo observação para os animais:*/
ALTER TABLE Animais ADD observacao varchar(100);

/*Remove todos os animais que pesam mais que 200 quilogramas:*/
DELETE FROM Animais WHERE peso > 200;
SELECT * FROM Animais;

/*Remove todos os animais que o nome inicie com a letra ‘C’:*/
DELETE FROM Animais WHERE nome Like 'C%';

/*Remove o campo cor dos animais:*/
ALTER TABLE Animais DROP COLUMN cor;

/*Aumenta o tamanho do campo nome dos animais para 80 caracteres:*/
ALTER TABLE Animais MODIFY nome VARCHAR(80);

/*Remove todos os gatos e cachorros:*/
DELETE FROM Animais WHERE especie_animal = 'Gato' OR especie_animal = 'Cachorro';

/*Remove o campo data de nascimento dos animais:*/
ALTER TABLE Animais DROP COLUMN nasc;

/*Remove todos os animais:*/
Drop DATABASE Animais;

/*Remove a tabela especies:*/
DROP TABLE Especies;
