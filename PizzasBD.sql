CREATE TABLE Embalagem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    material VARCHAR(50) NOT NULL,
    tamanho VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Ingredientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Receitas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    instrucoes TEXT,
    autor VARCHAR(255)
);

CREATE TABLE Pizzaiolos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Pizza (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sabor VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    descricao TEXT,
    tamanho VARCHAR(50) NOT NULL,
    embalagem_id INT,
    receita_id INT,
    pizzaiolo_id INT,
    FOREIGN KEY (embalagem_id) REFERENCES Embalagem(id),
    FOREIGN KEY (receita_id) REFERENCES Receitas(id),
    FOREIGN KEY (pizzaiolo_id) REFERENCES Pizzaiolos(id)
);

CREATE TABLE Pizza_Ingredientes (
    pizza_id INT,
    ingrediente_id INT,
    PRIMARY KEY (pizza_id, ingrediente_id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id),
    FOREIGN KEY (ingrediente_id) REFERENCES Ingredientes(id)
);

/*Inserindo dados para Embalagem*/
INSERT INTO Embalagem (material, tamanho, preco) VALUES
('Papelão', 'Pequena', 0.50),
('Plástico', 'Média', 1.00),
('Isopor', 'Grande', 1.50);

/*Inserindo dados para Ingredientes*/
INSERT INTO Ingredientes (nome) VALUES
('Molho de Tomate'),
('Queijo Mussarela'),
('Manjericão'),
('Azeite'),
('Calabresa'),
('Cebola'),
('Azeitonas'),
('Queijo Provolone'),
('Queijo Gorgonzola'),
('Parmesão'),
('Frango Desfiado'),
('Catupiry'),
('Milho'),
('Ervilha'),
('Presunto'),
('Ovos'),
('Pimentão'),
('Pepperoni'),
('Palmito'),
('Brócolis'),
('Champignon'),
('Muçarela'),
('Tomate'),
('Anchovas'),
('Orégano'),
('Pimentões Coloridos'),
('Cebola Roxa'),
('Requeijão'),
('Batata Palha');

/*Inserindo dados para Receitas*/
INSERT INTO Receitas (instrucoes, autor) VALUES
('Misture a farinha, o fermento e o sal. Adicione água e óleo, amasse até obter uma massa homogênea. Deixe descansar por 30 minutos. Abra a massa, adicione molho de tomate, queijo e os ingredientes desejados. Asse em forno pré-aquecido a 200°C por 20 minutos.', 'Chef José'),
('Misture a farinha, o fermento e o sal. Adicione água morna e óleo, amasse até obter uma massa homogênea. Deixe descansar por 1 hora. Abra a massa, adicione molho de tomate, queijo e os ingredientes desejados. Asse em forno pré-aquecido a 220°C por 25 minutos.', 'Chef Maria'),
('Prepare uma massa fina com farinha, fermento, sal, água e azeite. Deixe descansar por 2 horas. Abra a massa, adicione molho de tomate, queijo e os ingredientes desejados. Asse em forno pré-aquecido a 230°C por 15 minutos.', 'Chef Joana');

/*Inserindo dados para Pizzaiolos*/
INSERT INTO Pizzaiolos (nome, salario) VALUES
('João', 2000.00),
('Maria', 1800.00),
('Pedro', 2200.00),
('Ana', 1900.00),
('Carlos', 2100.00),
('Marta', 1950.00),
('Luiz', 2050.00),
('Camila', 1980.00),
('Fernando', 2250.00),
('Amanda', 1850.00),
('Rafael', 2300.00),
('Juliana', 1920.00),
('Gustavo', 2150.00),
('Larissa', 1975.00),
('Diego', 2100.00),
('Beatriz', 1820.00),
('Felipe', 2400.00),
('Luciana', 2050.00),
('Rodrigo', 2130.00),
('Carolina', 1880.00),
('Daniel', 2200.00),
('Tatiane', 1990.00),
('Paulo', 2350.00),
('Jessica', 1910.00),
('Marcos', 2170.00),
('Fernanda', 2030.00),
('Gabriel', 2270.00),
('Isabela', 1950.00),
('Biatriz', 1920.00),
('Thiago', 2230.00);

/*Inserindo dados para Pizza*/
INSERT INTO Pizza (sabor, preco, descricao, tamanho, embalagem_id, receita_id, pizzaiolo_id) VALUES
('Margherita', 25.00, 'Pizza tradicional italiana com molho de tomate, queijo mussarela, manjericão e azeite.', 'Média', 1, 1, 1),
('Calabresa', 30.00, 'Pizza com molho de tomate, queijo, calabresa fatiada, cebola e azeitonas.', 'Grande', 2, 2, 2),
('Quatro Queijos', 28.00, 'Pizza com molho de tomate, queijo mussarela, queijo provolone, queijo gorgonzola e parmesão.', 'Grande', 1, 3, 3),
('Frango com Catupiry', 32.00, 'Pizza com molho de tomate, frango desfiado, catupiry, milho e ervilha.', 'Grande', 2, 2, 4),
('Portuguesa', 30.00, 'Pizza com molho de tomate, queijo, presunto, ovos, cebola, azeitonas e pimentão.', 'Grande', 1, 1, 5),
('Pepperoni', 28.00, 'Pizza com molho de tomate, queijo mussarela e pepperoni fatiado.', 'Média', 2, 3, 6),
('Vegetariana', 27.00, 'Pizza com molho de tomate, queijo, palmito, brócolis, champignon, pimentão e cebola.', 'Média', 1, 1, 7),
('Margherita', 25.00, 'Pizza tradicional italiana com molho de tomate, queijo mussarela, manjericão e azeite.', 'Pequena', 1, 1, 8),
('Calabresa', 28.00, 'Pizza com molho de tomate, queijo, calabresa fatiada, cebola e azeitonas.', 'Média', 2, 2, 9),
('Frango com Catupiry', 30.00, 'Pizza com molho de tomate, frango desfiado, catupiry, milho e ervilha.', 'Pequena', 1, 2, 10),
('Quatro Queijos', 28.00, 'Pizza com molho de tomate, queijo mussarela, queijo provolone, queijo gorgonzola e parmesão.', 'Média', 2, 3, 11),
('Portuguesa', 30.00, 'Pizza com molho de tomate, queijo, presunto, ovos, cebola, azeitonas e pimentão.', 'Pequena', 1, 1, 12),
('Pepperoni', 26.00, 'Pizza com molho de tomate, queijo mussarela e pepperoni fatiado.', 'Pequena', 2, 3, 13),
('Vegetariana', 27.00, 'Pizza com molho de tomate, queijo, palmito, brócolis, champignon, pimentão e cebola.', 'Grande', 1, 1, 14),
('Margherita', 23.00, 'Pizza tradicional italiana com molho de tomate, queijo mussarela, manjericão e azeite.', 'Média', 1, 1, 15),
('Muçarela', 20.00, 'Pizza clássica com molho de tomate e queijo muçarela derretido.', 'Pequena', 1, 1, 16),
('Frango com Catupiry', 30.00, 'Pizza cremosa com molho de tomate, frango desfiado, catupiry e milho.', 'Grande', 2, 2, 17),
('Napolitana', 25.00, 'Pizza com molho de tomate, queijo, tomate, anchovas, azeitonas pretas e orégano.', 'Média', 1, 1, 18),
('Margarita', 22.00, 'Pizza clássica com molho de tomate, queijo muçarela, tomate fresco e manjericão.', 'Pequena', 1, 3, 19),
('Peperonata', 27.00, 'Pizza com molho de tomate, queijo, pimentões coloridos, cebola roxa, azeitonas e orégano.', 'Média', 2, 2, 20),
('Frango com Requeijão', 32.00, 'Pizza cremosa com molho de tomate, frango desfiado, requeijão e batata palha.', 'Grande', 1, 1, 21),
('Margherita', 23.00, 'Pizza clássica com molho de tomate, queijo muçarela, manjericão e azeite.', 'Pequena', 2, 3, 22),
('Calabresa', 26.00, 'Pizza com molho de tomate, queijo, calabresa fatiada, cebola e azeitonas.', 'Média', 1, 2, 23),
('Quatro Queijos', 28.00, 'Pizza com molho de tomate, queijo mussarela, queijo provolone, queijo gorgonzola e parmesão.', 'Grande', 2, 1, 24),
('Portuguesa', 30.00, 'Pizza com molho de tomate, queijo, presunto, ovos, cebola, azeitonas e pimentão.', 'Média', 1, 3, 25),
('Pepperoni', 28.00, 'Pizza com molho de tomate, queijo mussarela e pepperoni fatiado.', 'Grande', 2, 2, 26),
('Vegetariana', 27.00, 'Pizza com molho de tomate, queijo, palmito, brócolis, champignon, pimentão e cebola.', 'Pequena', 1, 1, 27),
('Muçarela', 20.00, 'Pizza clássica com molho de tomate e queijo muçarela derretido.', 'Média', 1, 3, 28),
('Frango com Catupiry', 30.00, 'Pizza cremosa com molho de tomate, frango desfiado, catupiry e milho.', 'Grande', 2, 2, 29),
('Napolitana', 25.00, 'Pizza com molho de tomate, queijo, tomate, anchovas, azeitonas pretas e orégano.', 'Média', 1, 1, 30);

/*Criando um relatório com todas as pizzas e os pizzaiolos aptos a produzi-las*/
SELECT 
    p.id AS id_pizza,
    p.sabor AS sabor_pizza,
    pz.id AS id_pizzaiolo,
    pz.nome AS nome_pizzaiolo
FROM 
    Pizza p
JOIN 
    Pizzaiolos pz ON p.pizzaiolo_id = pz.id
WHERE 
    p.sabor IN ('Muçarela', 'Margherita', 'Calabresa') OR
    (pz.nome = 'João' AND p.sabor = 'Frango com Catupiry') OR
    (pz.nome = 'Maria' AND p.sabor = 'Quatro Queijos');

/*Criando um relatório com todas as pizzas e seus ingredientes*/
SELECT 
    p.id AS id_pizza,
    p.sabor AS sabor_pizza,
    GROUP_CONCAT(i.nome SEPARATOR ', ') AS ingredientes
FROM 
    Pizza p
JOIN 
    Pizza_Ingredientes pi ON p.id = pi.pizza_id
JOIN 
    Ingredientes i ON pi.ingrediente_id = i.id
GROUP BY 
    p.id, p.sabor;

/*Criando um relatório com todos os ingredientes e as pizzas onde são utilizados*/
SELECT 
    p.sabor AS Pizza,
    i.nome AS Ingrediente
FROM 
    Pizza_Ingredientes pi
JOIN 
    Pizza p ON pi.pizza_id = p.id
JOIN 
    Ingredientes i ON pi.ingrediente_id = i.id
ORDER BY 
    p.sabor;

/*Criando um relatório com os sabores de todas as pizzas, os pizzaiolos que as fazem e as instruções para produzi-las*/
SELECT 
    Pizza.sabor AS Sabor_da_Pizza,
    Pizzaiolos.nome AS Nome_do_Pizzaiolo,
    Receitas.instrucoes AS Instrucoes_da_Receita
FROM 
    Pizza
JOIN 
    Pizzaiolos ON Pizza.pizzaiolo_id = Pizzaiolos.id
JOIN 
    Receitas ON Pizza.receita_id = Receitas.id;
