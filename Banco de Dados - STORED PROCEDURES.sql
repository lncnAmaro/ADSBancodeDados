CREATE TABLE Professores (
	id_prof			int				NOT NULL			PRIMARY KEY,
    nome_prof		varchar(50)		NOT NULL
);

CREATE TABLE Cursos (
    id_curso		int				NOT NULL			PRIMARY KEY,
    nome_curso		varchar(50),
    prof_id			int,
    
	FOREIGN KEY (prof_id) REFERENCES Professores(id_prof)
);

CREATE TABLE Alunos (
	id_aluno		int				NOT NULL			PRIMARY KEY,
    nome_aluno		varchar(50)		NOT NULL,
    sobrenome_aluno	varchar(50)		NOT NULL,
    curso_id		int				NOT NULL,
    email			varchar(100),
    
    FOREIGN KEY (curso_id) REFERENCES Cursos(id_curso)
);

-- Inserindo dados na tabela Professores
INSERT INTO Professores (id_prof, nome_prof) VALUES (1, "Daniel Ohata");
INSERT INTO Professores (id_prof, nome_prof) VALUES (2, "João Silva");
INSERT INTO Professores (id_prof, nome_prof) VALUES (3, "Maria Santos");

-- Inserindo dados na tabela Cursos
INSERT INTO Cursos (id_curso, nome_curso, prof_id) VALUES (1, "Análise e Desenvolvimento de Sistemas", 1);
INSERT INTO Cursos (id_curso, nome_curso, prof_id) VALUES (2, "Administração", 2);
INSERT INTO Cursos (id_curso, nome_curso, prof_id) VALUES (3, "Matemática", 3);

-- Inserindo dados na tabela Alunos
INSERT INTO Alunos (id_aluno, nome_aluno, sobrenome_aluno, curso_id) VALUES (1, "Lincon", "Amaro", 1);
INSERT INTO Alunos (id_aluno, nome_aluno, sobrenome_aluno, curso_id) VALUES (2, "Vanderleia", "Oliveira", 2);
INSERT INTO Alunos (id_aluno, nome_aluno, sobrenome_aluno, curso_id) VALUES (3, "Abel", "Arruda", 2);
INSERT INTO Alunos (id_aluno, nome_aluno, sobrenome_aluno, curso_id) VALUES (4, "Livia", "Alamino", 3);
INSERT INTO Alunos (id_aluno, nome_aluno, sobrenome_aluno, curso_id) VALUES (5, "Peter", "Parker", 1);

-- Utilizando Stored Procedures para automatizar a inserção e seleção dos cursos
DELIMITER $
CREATE PROCEDURE InserirCursos (IN id_curso int, nome_curso varchar(50), prof_id int)
BEGIN
	INSERT INTO Cursos (id_curso, nome_curso, prof_id) VALUES (id_curso, nome_curso, prof_id);
END $
DELIMITER ;

CALL InserirCursos (4, "Engenharia da Computação", 1);

DELIMITER $$
CREATE PROCEDURE SelecionarCursos ()
BEGIN
	SELECT * FROM Cursos;
END $$
DELIMITER ;

CALL SelecionarCursos();

-- Criando emails para alunos no seguinte formato: nome.sobrenome@dominio.com
-- Se já existir um outro aluno com o mesmo email, é adicionado um número na frente
DELIMITER $$$
CREATE PROCEDURE GerarEmail (IN aluno_id int)
BEGIN
	DECLARE contador int DEFAULT 1;
    DECLARE email_temporario varchar(100);
	DECLARE nome_temporario varchar(50);  
 	DECLARE sobrenome_temporario varchar(50);  
    
    SELECT nome_aluno, sobrenome_aluno INTO nome_temporario, sobrenome_temporario FROM Alunos WHERE id_aluno = aluno_id;
    
    SET email_temporario = CONCAT(nome_temporario, '.', sobrenome_temporario, '@dominio.com');
    
    WHILE EXISTS (SELECT * FROM Alunos WHERE email = email_temporario) DO 
		SET contador = contador + 1;
		SET email_temporario = CONCAT(nome_temporario, '.', sobrenome_temporario, contador, '@dominio.com');
	END WHILE;
    
    UPDATE Alunos SET email = email_temporario WHERE id_aluno = aluno_id;
END $$$
DELIMITER ;

-- Gera os emails dos alunos automaticamente e adiciona no campo existente da tabela
CALL GerarEmail (1);
CALL GerarEmail (2);
CALL GerarEmail (3);
CALL GerarEmail (4);
CALL GerarEmail (5);

SELECT * FROM Alunos
