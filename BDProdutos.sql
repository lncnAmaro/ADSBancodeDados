create table marcas(
	mrc_id			int			PRIMARY KEY,
  	mrc_nome		varchar(50)		not NULL,
	mrc_nacionalidade	varchar(50)
);

create table produtos(
	prd_id			int			PRIMARY KEY,
	prd_nome		varchar(50)		NOT NULL,
	prd_qtd_estoque		int 			NOT NULL		default 0,
	prd_estoque_mim		int 			NOT NULL		default 0,
	prd_data_fabricacao	timestamp			      		default CURRENT_TIMESTAMP,
	prd_perecivel		boolean,
	prd_valor		decimal(10,2),
	prd_marca_id		int,
  	FOREIGN KEY(prd_marca_id)             	REFERENCES marcas(mrc_id)
);

create table fornecedores(
	frn_id			int        		PRIMARY key,
	frn_nome		varchar(50)		not NULL,
  	frn_email		varchar(50)
);

CREATE TABLE produto_fornecedor(
	pf_prod_id		int		REFERENCES produtos(prd_id),
 	pf_forn_id		int		REFERENCES fornecedores(frn_id),
  
	primary key	(pf_prod_id, pf_forn_id)
);

/*Popula a tabela marcas*/
INSERT INTO marcas(mrc_id, mrc_nome, mrc_nacionalidade) VALUES (1, 'H2OH!', 'Brasil');
INSERT INTO marcas(mrc_id, mrc_nome, mrc_nacionalidade) VALUES (2, 'Nescafé', 'Suíça');

/*Popula a tabela produtos*/
INSERT INTO produtos(prd_id, prd_nome, prd_qtd_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id) VALUES (1, 'Refrigerante 500ml', 9, 10, false, 9.99, 1);
INSERT INTO produtos(prd_id, prd_nome, prd_qtd_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id) VALUES (2, 'Café Solúvel', 200, 20, true, 19.99, 2);

/*Popula a tabela fornecedores*/
INSERT INTO fornecedores(frn_id, frn_nome, frn_email) VALUES (1, 'PepsiCo', 'pepsico@email.com');
INSERT INTO fornecedores(frn_id, frn_nome, frn_email) VALUES (2, 'Nescafé do Brasil', 'nescafe@email.com');

/*Popula a tabela produto_fornecedor*/
INSERT INTO produto_fornecedor(pf_prod_id, pf_forn_id) VALUES (1, 1);
INSERT INTO produto_fornecedor(pf_prod_id, pf_forn_id) VALUES (2, 2);

/*Testa as tabelas*/
SELECT * from marcas;
SELECT * from produtos;
SELECT * from fornecedores;
SELECT * from produto_fornecedor;

/*Cria uma view que mostra todos os produtos e suas respectivas marcas*/
CREATE VIEW produtos_marcas AS
SELECT prd_nome AS Produto, mrc_nome AS Marca
FROM produtos
INNER JOIN marcas ON produtos.prd_marca_id = marcas.mrc_id;

SELECT * FROM produtos_marcas;

/*Cria uma view que mostra todos os produtos e seus respectivos fornecedores*/
CREATE VIEW produtos_fornecedores AS
SELECT prd_nome AS Produto, frn_nome AS Fornecedor
FROM produtos
INNER JOIN fornecedores ON produtos.prd_marca_id = fornecedores.frn_id;

SELECT * FROM produtos_fornecedores;

/*Cria uma view que mostra todos os produtos e seus respectivos fornecedores e marcas*/
CREATE VIEW produtos_marcas_fornecedores AS
SELECT prd_nome AS Produto, mrc_nome AS Marca, frn_nome AS Fornecedor
FROM produtos
INNER JOIN marcas ON produtos.prd_marca_id = marcas.mrc_id
INNER JOIN produto_fornecedor ON produtos.prd_id = produto_fornecedor.pf_prod_id
INNER JOIN fornecedores ON produto_fornecedor.pf_forn_id = fornecedores.frn_id;

SELECT * FROM produtos_marcas_fornecedores;

/*Cria uma view que mostra todos os produtos com estoque abaixo do mínimo*/
CREATE VIEW produtos_estoque_baixo AS
SELECT prd_nome AS Produto, prd_qtd_estoque AS Estoque, prd_estoque_mim AS Estoque_Minimo
FROM produtos
WHERE prd_qtd_estoque < prd_estoque_mim;

SELECT * FROM produtos_estoque_baixo;SELECT * FROM demo;

/*Adiciona o campo data de validade, insire novos produtos com essa informação e atualiza os existentes*/
ALTER TABLE produtos
ADD COLUMN prd_data_validade DATE;

INSERT INTO produtos(prd_id, prd_nome, prd_qtd_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id, prd_data_validade) 
VALUES (3, 'Suco', 150, 15, false, 1.99, 1, '2024-03-15');
INSERT INTO produto_fornecedor(pf_prod_id, pf_forn_id) VALUES (3, 1);

UPDATE produtos
SET prd_data_validade = '2024-12-31'
WHERE prd_id = 1;

UPDATE produtos
SET prd_data_validade = '2025-01-31'
WHERE prd_id = 2;

SELECT * FROM produtos;

/*Cria uma view que mostra todos os produtos e suas respectivas marcas com validade vencida;*/
CREATE VIEW produtos_marcas_vencidos AS
SELECT prd_nome AS Produto, mrc_nome AS Marca, prd_data_validade AS Data_Validade
FROM produtos
INNER JOIN marcas ON produtos.prd_marca_id = marcas.mrc_id
WHERE prd_data_validade < CURRENT_DATE;

SELECT * FROM produtos_marcas_vencidos;

/*Selecionar os produtos com preço acima da média.*/
CREATE VIEW produtos_preco_acima_media AS
SELECT prd_nome AS Produto, prd_valor AS Preco
FROM produtos
WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos);

SELECT * FROM produtos_preco_acima_media;
