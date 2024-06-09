CREATE TABLE Cargos (
    id INT PRIMARY KEY,
    Cargo VARCHAR(50),
    Jornada INT,
    Salario DECIMAL(10,2)
);

CREATE TABLE Endereco (
    id INT PRIMARY KEY,
    Endereco VARCHAR(50),
    Cidade	VARCHAR(50),
    Estado VARCHAR(50)
);

CREATE TABLE Funcionarios (
    id INT PRIMARY KEY,
    Nome VARCHAR(50),
    CargoID INT,
    EnderecoID INT,
    FOREIGN KEY (CargoID) REFERENCES Cargos(id),
    FOREIGN KEY (EnderecoID) REFERENCES Endereco(id)
);

CREATE TABLE Contato (
    id INT PRIMARY KEY,
    FuncionarioID INT,
    Email VARCHAR(50),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios(id)
);

INSERT INTO Cargos (id, Cargo, Jornada, Salario) VALUES (1, 'Contador', 40, 3000.00);
INSERT INTO Cargos (id, Cargo, Jornada, Salario) VALUES (2, 'Developer', 20, 15000.00);
INSERT INTO Cargos (id, Cargo, Jornada, Salario) VALUES (3, 'Linguista', 44, 8000.00);
INSERT INTO Cargos (id, Cargo, Jornada, Salario) VALUES (4, 'Developer', 20, 15000.00);

INSERT INTO Endereco (id, Endereco, Cidade, Estado) VALUES (1, 'Rua Suassuna, 30', 'João Pessoa', 'PB');
INSERT INTO Endereco (id, Endereco, Cidade, Estado) VALUES (2, 'Rua Lovelace, 67', 'London', '');
INSERT INTO Endereco (id, Endereco, Cidade, Estado) VALUES (3, 'Rua Substativo, 78 - Bairro Predicado','Mesóclise', 'AC');
INSERT INTO Endereco (id, Endereco, Cidade, Estado) VALUES (4, 'Rua Eurico, 50 - Apt 28 Bloco C', 'João Pessoa', 'PB');

INSERT INTO Funcionarios (id, Nome, CargoID, EnderecoID) VALUES (1, 'João Grilo', 1, 1);
INSERT INTO Funcionarios (id, Nome, CargoID, EnderecoID) VALUES (2, 'Ada Byron', 2, 2);
INSERT INTO Funcionarios (id, Nome, CargoID, EnderecoID) VALUES (3, 'Gerundino', 3, 3);
INSERT INTO Funcionarios (id, Nome, CargoID, EnderecoID) VALUES (4, 'Chicó', 4, 4);

INSERT INTO Contato (id, FuncionarioID, Email) VALUES (1, 1, 'grilo@email.com');
INSERT INTO Contato (id, FuncionarioID, Email) VALUES (2, 1, 'joaog@mk.com');
INSERT INTO Contato (id, FuncionarioID, Email) VALUES (3, 2, 'ada@email.com');
INSERT INTO Contato (id, FuncionarioID, Email) VALUES (4, 2, 'abyron@tech.com');
INSERT INTO Contato (id, FuncionarioID, Email) VALUES (5, 3, 'gerundino@gmail.com');
INSERT INTO Contato (id, FuncionarioID, Email) VALUES (6, 4, '');

CREATE VIEW InfosFuncionario AS
SELECT 
    f.Nome AS NomeFuncionario,
	e.Endereco AS Endereco,
    e.Cidade AS Cidade,
    e.Estado AS Estado,
	ct.Email AS Email,
    c.Cargo AS Cargo,
    c.Jornada AS Jornada,
    c.Salario AS Salario
FROM Funcionarios f
INNER JOIN Cargos c ON f.CargoID = c.id
INNER JOIN Endereco e ON f.EnderecoID = e.id
LEFT JOIN Contato ct ON f.id = ct.FuncionarioID;

SELECT * FROM InfosFuncionario;