CREATE TABLE Produtos (
	id_produto 		  int,
	nome 			      VARCHAR(50) 		NOT NULL,
	preco 			    decimal(10,2)		NOT NULL,
	estoque 		    int			NOT NULL,
	perecivel		    VARCHAR(50)		NOT NULL,
	marca			      VARCHAR(50),
	nacionalidade		VARCHAR(50),	
  
	PRIMARY key(id_produto)
);

INSERT INTO Produtos (id_produto, nome, preco, estoque, perecivel, marca, nacionalidade) VALUES (01, 'Chocolate', 75.5, 30, 'Perecível', 'Läderach', 'Suíça');
INSERT INTO Produtos (id_produto, nome, preco, estoque, perecivel, marca, nacionalidade) VALUES (02, 'Farinha de trigo', 6.5, 75, 'Perecível', 'Dona Benta', 'Brasil');
INSERT INTO Produtos (id_produto, nome, preco, estoque, perecivel, marca, nacionalidade) VALUES (03, 'Leite condensado', 10.0, 150, 'Perecível', 'Nestlé', 'Suíça');
INSERT INTO Produtos (id_produto, nome, preco, estoque, perecivel, marca, nacionalidade) VALUES (04, 'Bico de confeitaria', 15.0, 15, 'Não perecível', 'Wilton', 'Brasil');
INSERT INTO Produtos (id_produto, nome, preco, estoque, perecivel, marca, nacionalidade) VALUES (05, 'Espátula de confeitaria', 35.0, 10, 'Não perecível', 'Wilton', 'Brasil');

/*Seleciona todos os produtos:*/
SELECT * FROM Produtos;

/*Gera um relatório informando quantos produtos estão cadastrados:*/
SELECT COUNT(id_produto) FROM Produtos;

/*Gera um relatório informando o preço médio dos produtos:*/
SELECT AVG(preco) as preco_medio FROM Produtos;

/*Seleciona a média dos preços dos produtos em 2 grupos: perecíveis e não perecíveis:*/
SELECT perecivel, AVG(preco) FROM Produtos GROUP BY perecivel;

/*Selecione a média dos preços dos produtos agrupados pelo nome do produto:*/
SELECT nome, AVG(preco) FROM Produtos GROUP BY nome;

/*Seleciona a média dos preços e total em estoque dos produtos:*/
SELECT AVG(preco), SUM(estoque) FROM Produtos;

/*Seleciona o nome, marca e quantidade em estoque do produto mais caro:*/
SELECT nome, marca, estoque FROM Produtos ORDER BY preco DESC LIMIT 1;

/*Seleciona os produtos com preço acima da média:*/
SELECT * FROM Produtos WHERE preco > (SELECT AVG(preco) FROM Produtos);

/*Seleciona a quantidade de produtos de cada nacionalidade:*/
SELECT nacionalidade, SUM(estoque) from Produtos group BY nacionalidade;
