CREATE TABLE Clientes (
    id INT PRIMARY KEY,
    CPF VARCHAR(14),
    nome VARCHAR(50),
    nascimento VARCHAR(10)
);

CREATE TABLE Veiculos (
    id INT PRIMARY KEY,
    veiculo VARCHAR(50),
    cor VARCHAR(50),
    placa VARCHAR(50),
    diaria DECIMAL(10, 2)
);

CREATE TABLE Alugueis (
    id INT PRIMARY KEY,
    veiculo_id INT,
    cliente_id INT,
    dias INT,
    total DECIMAL(10, 2),
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(id),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

INSERT INTO Clientes (id, CPF, nome, nascimento) VALUES 
(1, '123.456.789-01', 'Ariano Suassuna', '1022-05-21'),
(2, '543.765.987-23', 'Grace Hopper', '2002-04-29'),
(3, '987.654.321-90', 'Richard Feynman', '2001-10-12'),
(4, '432.765.678-67', 'Edgar Poe', '1998-12-14'),
(5, '927.384.284-44', 'Gordon Freeman', '1984-11-26');

INSERT INTO Veiculos (id, veiculo, cor, placa, diaria) VALUES 
(1, 'Fusca', 'Preto', 'WER-3456', 30.00),
(2, 'Variante', 'Rosa', 'FDS-8384', 60.00),
(3, 'Comodoro', 'Preto', 'CVB-9933', 20.00),
(4, 'Deloriam', 'Azul', 'FGH-2256', 80.00),
(5, 'Brasília', 'Amarela', 'DDI-3948', 45.00);

INSERT INTO Alugueis (id, veiculo_id, cliente_id, dias, total) VALUES 
(101, 1, 1, 3, 90.00),
(102, 2, 2, 7, 420.00),
(103, 3, 3, 1, 20.00),
(104, 4, 4, 3, 240.00),
(105, 5, 5, 7, 315.00);

-- View que seleciona todas as locações e seus respectivos veículos e clientes:

CREATE VIEW Locacoes AS
SELECT 
    a.id AS id_locacao,
    v.id AS id_veiculo,
    v.veiculo,
    v.cor,
    v.placa,
    v.diaria,
    c.id AS id_cliente,
    c.nome AS nome_cliente,
    c.CPF AS CPF_cliente,
    c.nascimento AS nascimento_cliente,
    a.dias,
    a.total
FROM 
    Alugueis a
JOIN 
    Veiculos v ON a.veiculo_id = v.id
JOIN 
    Clientes c ON a.cliente_id = c.id;

-- Testando a View:
Select * FROM Locacoes;
