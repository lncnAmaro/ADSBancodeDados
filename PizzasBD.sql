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
('Batata Palha'),
('Cream Cheese');

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

INSERT INTO Pizza_Ingredientes (pizza_id, ingrediente_id) VALUES
(1, 1), 
(1, 2), 
(1, 3), 
(2, 1), 
(2, 2), 
(2, 5), 
(3, 1), 
(3, 2), 
(3, 7), 
(3, 8), 
(3, 9), 
(4, 1), 
(4, 11),
(4, 12),
(5, 1), 
(5, 2), 
(5, 5), 
(5, 6), 
(5, 15),
(5, 16),
(5, 21),
(5, 24),
(6, 1),
(6, 2),
(6, 3),   
(6, 6),   
(6, 13),  
(6, 14),  
(6, 20),  
(6, 22),  
(6, 24);  

SELECT * FROM Pizza;
SELECT * FROM Pizzaiolos;
SELECT * FROM Receitas;
SELECT * FROM Ingredientes;
SELECT * FROM Embalagem;
SELECT * FROM Pizza_Ingredientes;

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
