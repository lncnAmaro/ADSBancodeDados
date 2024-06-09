CREATE TABLE Cursos (
    id				INT				AUTO_INCREMENT	PRIMARY KEY,
    Nome			VARCHAR(100)	UNIQUE,
    Area			VARCHAR(50)
);

CREATE TABLE Alunos (
    id				INT				AUTO_INCREMENT	UNIQUE	PRIMARY KEY,
    Nome			VARCHAR(50),
    Sobrenome		VARCHAR(50),
    Matricula		INT				UNIQUE,
    id_curso		INT,
    Email			VARCHAR(100),
    
    FOREIGN KEY (id_curso) REFERENCES Cursos(id)
);

-- Utilizando Stored Procedures para automatizar a inserção e seleção dos cursos:
DELIMITER //
CREATE PROCEDURE InserirCurso (
    IN p_nome VARCHAR(100),
    IN p_area VARCHAR(50)
)
BEGIN
    INSERT INTO Cursos (Nome, Area) VALUES (p_nome, p_area);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SelecionarCursos ()
BEGIN
    SELECT * FROM Cursos;
END //
DELIMITER ;

-- O aluno possui um e-mail que é gerado automaticamente antes da inserção no seguinte formato: nome.sobrenome@dominio.com:
DELIMITER //
CREATE TRIGGER GerarEmailAluno BEFORE INSERT ON Alunos
FOR EACH ROW
BEGIN
    DECLARE dominio VARCHAR(50);
    SET dominio = 'facens.com';
    SET NEW.Email = CONCAT(NEW.Nome, '.', NEW.Sobrenome, '@', dominio);
END //
DELIMITER ;

-- Criando uma rotina que recebe os dados de um novo curso e o insere no banco de dados:
DELIMITER //

CREATE PROCEDURE InserirNovoCurso (
    IN p_nome_curso VARCHAR(100),
    IN p_area_curso VARCHAR(50)
)
BEGIN
    INSERT INTO Cursos (Nome, Area) VALUES (p_nome_curso, p_area_curso);
END //

DELIMITER ;

-- Ao receber o nome de um curso e sua área, em seguida retorna o id do curso:
DELIMITER //

CREATE FUNCTION ObterIdCurso (
    p_nome_curso VARCHAR(100),
    p_area_curso VARCHAR(50)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE curso_id INT DEFAULT 0;
    
    SELECT id INTO curso_id
    FROM Cursos
    WHERE Nome = p_nome_curso AND Area = p_area_curso
    LIMIT 1;
    
    RETURN curso_id;
END //

DELIMITER ;

-- Criando uma procedure que recebe os dados do aluno e de um curso e faz sua matrícula, caso o aluno já esteja matriculado em um curso, essa matrícula não pode ser realizada:
DELIMITER //

CREATE PROCEDURE MatricularAluno(
    IN p_Nome VARCHAR(50),
    IN p_Sobrenome VARCHAR(50),
    IN p_NomeCurso VARCHAR(100),
    IN p_AreaCurso VARCHAR(50)
)
BEGIN
    DECLARE curso_id INT;
    DECLARE nova_matricula INT;
    
    -- Obtém o ID do curso
    SELECT id INTO curso_id FROM Cursos WHERE Nome = p_NomeCurso AND Area = p_AreaCurso;
    
    -- Se o curso não existe, retorna uma mensagem de erro
    IF curso_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O curso especificado não existe.';
    ELSE
        -- Obtém o máximo valor de matrícula atual e incrementa em 1
		SELECT IFNULL(MAX(Matricula), 0) + 1 INTO nova_matricula FROM Alunos;
        
        -- Insere o aluno com a nova matrícula
        INSERT INTO Alunos(Nome, Sobrenome, Matricula, id_curso) VALUES (p_Nome, p_Sobrenome, nova_matricula, curso_id);
    END IF;
END //

DELIMITER ;

-- Inserindo 25 cursos:
CALL InserirCurso('Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL InserirCurso('Gestão de TI', 'Tecnologia da Informação');
CALL InserirCurso('Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL InserirCurso('Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL InserirCurso('Introdução à Psicologia', 'Psicologia');
CALL InserirCurso('Psicologia Social', 'Psicologia');
CALL InserirCurso('Psicologia do Desenvolvimento', 'Psicologia');
CALL InserirCurso('Introdução à Economia', 'Economia');
CALL InserirCurso('Microeconomia', 'Economia');
CALL InserirCurso('Macroeconomia', 'Economia');
CALL InserirCurso('Introdução à Biologia', 'Biologia');
CALL InserirCurso('Genética e Biologia Molecular', 'Biologia');
CALL InserirCurso('Ecologia e Biologia Ambiental', 'Biologia');
CALL InserirCurso('Introdução à Literatura', 'Literatura');
CALL InserirCurso('Estudos Shakespeareanos', 'Literatura');
CALL InserirCurso('Literatura Americana Moderna', 'Literatura');
CALL InserirCurso('Introdução ao Marketing', 'Marketing');
CALL InserirCurso('Estratégias de Marketing Digital', 'Marketing');
CALL InserirCurso('Comportamento do Consumidor', 'Marketing');
CALL InserirCurso('Introdução à Física', 'Física');
CALL InserirCurso('Mecânica Clássica', 'Física');
CALL InserirCurso('Física Quântica', 'Física');
CALL InserirCurso('Introdução à História da Arte', 'História da Arte');
CALL InserirCurso('Arte Renascentista', 'História da Arte');
CALL InserirCurso('Movimentos de Arte Moderna', 'História da Arte');

-- Inserindo 200 alunos:
CALL MatricularAluno('Lincon', 'Amaro', 'Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL MatricularAluno('Maria', 'Santos', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');							
CALL MatricularAluno('Pedro', 'Oliveira', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Ana', 'Pereira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Lucas', 'Fernandes', 'Introdução à Psicologia', 'Psicologia');
CALL MatricularAluno('Juliana', 'Martins', 'Psicologia Social', 'Psicologia');
CALL MatricularAluno('Gabriel', 'Almeida', 'Psicologia do Desenvolvimento', 'Psicologia');
CALL MatricularAluno('Carla', 'Gonçalves', 'Introdução à Economia', 'Economia');
CALL MatricularAluno('Marcos', 'Ribeiro', 'Microeconomia', 'Economia');
CALL MatricularAluno('Mariana', 'Lima', 'Macroeconomia', 'Economia');
CALL MatricularAluno('Rafael', 'Costa', 'Introdução à Biologia', 'Biologia');
CALL MatricularAluno('Camila', 'Rodrigues', 'Genética e Biologia Molecular', 'Biologia');
CALL MatricularAluno('Fernando', 'Sousa', 'Ecologia e Biologia Ambiental', 'Biologia');
CALL MatricularAluno('Amanda', 'Cruz', 'Introdução à Literatura', 'Literatura');
CALL MatricularAluno('Paulo', 'Mendes', 'Estudos Shakespeareanos', 'Literatura');
CALL MatricularAluno('Laura', 'Dias', 'Literatura Americana Moderna', 'Literatura');
CALL MatricularAluno('Gustavo', 'Freitas', 'Introdução ao Marketing', 'Marketing');
CALL MatricularAluno('Isabela', 'Carvalho','Estratégias de Marketing Digital', 'Marketing');
CALL MatricularAluno('Thiago', 'Gomes', 'Comportamento do Consumidor', 'Marketing');
CALL MatricularAluno('Luiza', 'Nascimento', 'Introdução à Física', 'Física');
CALL MatricularAluno('Diego', 'Oliveira', 'Mecânica Clássica', 'Física');
CALL MatricularAluno('Raquel', 'Silveira', 'Física Quântica', 'Física');
CALL MatricularAluno('Felipe', 'Pereira', 'Introdução à História da Arte', 'História da Arte');
CALL MatricularAluno('Natália', 'Mendes', 'Arte Renascentista', 'História da Arte');
CALL MatricularAluno('Vinícius', 'Martins', 'Movimentos de Arte Moderna', 'História da Arte');
CALL MatricularAluno('Ana', 'Carvalho', 'Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL MatricularAluno('Bruno', 'Alves', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Carolina', 'Oliveira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Luciana', 'Santos', 'Introdução à Psicologia', 'Psicologia');
CALL MatricularAluno('Daniel', 'Pereira', 'Psicologia Social', 'Psicologia');
CALL MatricularAluno('Tatiane', 'Rodrigues', 'Psicologia do Desenvolvimento', 'Psicologia');
CALL MatricularAluno('Henrique', 'Ferreira', 'Introdução à Economia', 'Economia');
CALL MatricularAluno('Patrícia', 'Almeida', 'Microeconomia', 'Economia');
CALL MatricularAluno('Guilherme', 'Silva', 'Macroeconomia', 'Economia');
CALL MatricularAluno('Jéssica', 'Mendes', 'Introdução à Biologia', 'Biologia');
CALL MatricularAluno('Felipe', 'Santos', 'Genética e Biologia Molecular', 'Biologia');
CALL MatricularAluno('Vanessa', 'Lima', 'Ecologia e Biologia Ambiental', 'Biologia');
CALL MatricularAluno('Leonardo', 'Carvalho', 'Introdução à Literatura', 'Literatura');
CALL MatricularAluno('Isabela', 'Gomes', 'Estudos Shakespeareanos', 'Literatura');
CALL MatricularAluno('Rafael', 'Ferreira', 'Literatura Americana Moderna', 'Literatura');
CALL MatricularAluno('Aline', 'Santos', 'Introdução ao Marketing', 'Marketing');
CALL MatricularAluno('Marcelo', 'Oliveira', 'Estratégias de Marketing Digital', 'Marketing');
CALL MatricularAluno('Caroline', 'Silva', 'Comportamento do Consumidor', 'Marketing');
CALL MatricularAluno('Anderson', 'Rodrigues', 'Introdução à Física', 'Física');
CALL MatricularAluno('Bruna', 'Pereira', 'Mecânica Clássica', 'Física');
CALL MatricularAluno('Maria', 'Santos', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');							
CALL MatricularAluno('Pedro', 'Oliveira', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Ana', 'Pereira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Lucas', 'Fernandes', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Juliana', 'Martins', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Livia', 'Amaro', 'Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL MatricularAluno('Maria', 'Santos', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');							
CALL MatricularAluno('Pedro', 'Oliveira', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Ana', 'Pereira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Lucas', 'Fernandes', 'Introdução à Psicologia', 'Psicologia');
CALL MatricularAluno('Juliana', 'Martins', 'Psicologia Social', 'Psicologia');
CALL MatricularAluno('Gabriel', 'Almeida', 'Psicologia do Desenvolvimento', 'Psicologia');
CALL MatricularAluno('Carla', 'Gonçalves', 'Introdução à Economia', 'Economia');
CALL MatricularAluno('Marcos', 'Ribeiro', 'Microeconomia', 'Economia');
CALL MatricularAluno('Mariana', 'Lima', 'Macroeconomia', 'Economia');
CALL MatricularAluno('Rafael', 'Costa', 'Introdução à Biologia', 'Biologia');
CALL MatricularAluno('Camila', 'Rodrigues', 'Genética e Biologia Molecular', 'Biologia');
CALL MatricularAluno('Fernando', 'Sousa', 'Ecologia e Biologia Ambiental', 'Biologia');
CALL MatricularAluno('Amanda', 'Cruz', 'Introdução à Literatura', 'Literatura');
CALL MatricularAluno('Paulo', 'Mendes', 'Estudos Shakespeareanos', 'Literatura');
CALL MatricularAluno('Laura', 'Dias', 'Literatura Americana Moderna', 'Literatura');
CALL MatricularAluno('Gustavo', 'Freitas', 'Introdução ao Marketing', 'Marketing');
CALL MatricularAluno('Isabela', 'Carvalho','Estratégias de Marketing Digital', 'Marketing');
CALL MatricularAluno('Thiago', 'Gomes', 'Comportamento do Consumidor', 'Marketing');
CALL MatricularAluno('Luiza', 'Nascimento', 'Introdução à Física', 'Física');
CALL MatricularAluno('Diego', 'Oliveira', 'Mecânica Clássica', 'Física');
CALL MatricularAluno('Raquel', 'Silveira', 'Física Quântica', 'Física');
CALL MatricularAluno('Felipe', 'Pereira', 'Introdução à História da Arte', 'História da Arte');
CALL MatricularAluno('Natália', 'Mendes', 'Arte Renascentista', 'História da Arte');
CALL MatricularAluno('Vinícius', 'Martins', 'Movimentos de Arte Moderna', 'História da Arte');
CALL MatricularAluno('Ana', 'Carvalho', 'Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL MatricularAluno('Bruno', 'Alves', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Carolina', 'Oliveira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Luciana', 'Santos', 'Introdução à Psicologia', 'Psicologia');
CALL MatricularAluno('Daniel', 'Pereira', 'Psicologia Social', 'Psicologia');
CALL MatricularAluno('Tatiane', 'Rodrigues', 'Psicologia do Desenvolvimento', 'Psicologia');
CALL MatricularAluno('Henrique', 'Ferreira', 'Introdução à Economia', 'Economia');
CALL MatricularAluno('Patrícia', 'Almeida', 'Microeconomia', 'Economia');
CALL MatricularAluno('Guilherme', 'Silva', 'Macroeconomia', 'Economia');
CALL MatricularAluno('Jéssica', 'Mendes', 'Introdução à Biologia', 'Biologia');
CALL MatricularAluno('Felipe', 'Santos', 'Genética e Biologia Molecular', 'Biologia');
CALL MatricularAluno('Vanessa', 'Lima', 'Ecologia e Biologia Ambiental', 'Biologia');
CALL MatricularAluno('Leonardo', 'Carvalho', 'Introdução à Literatura', 'Literatura');
CALL MatricularAluno('Isabela', 'Gomes', 'Estudos Shakespeareanos', 'Literatura');
CALL MatricularAluno('Rafael', 'Ferreira', 'Literatura Americana Moderna', 'Literatura');
CALL MatricularAluno('Aline', 'Santos', 'Introdução ao Marketing', 'Marketing');
CALL MatricularAluno('Marcelo', 'Oliveira', 'Estratégias de Marketing Digital', 'Marketing');
CALL MatricularAluno('Caroline', 'Silva', 'Comportamento do Consumidor', 'Marketing');
CALL MatricularAluno('Anderson', 'Rodrigues', 'Introdução à Física', 'Física');
CALL MatricularAluno('Bruna', 'Pereira', 'Mecânica Clássica', 'Física');
CALL MatricularAluno('Maria', 'Santos', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');							
CALL MatricularAluno('Pedro', 'Oliveira', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Ana', 'Pereira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Lucas', 'Fernandes', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Juliana', 'Martins', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Léia', 'Amaro', 'Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL MatricularAluno('Maria', 'Santos', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');							
CALL MatricularAluno('Pedro', 'Oliveira', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Ana', 'Pereira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Lucas', 'Fernandes', 'Introdução à Psicologia', 'Psicologia');
CALL MatricularAluno('Juliana', 'Martins', 'Psicologia Social', 'Psicologia');
CALL MatricularAluno('Gabriel', 'Almeida', 'Psicologia do Desenvolvimento', 'Psicologia');
CALL MatricularAluno('Carla', 'Gonçalves', 'Introdução à Economia', 'Economia');
CALL MatricularAluno('Marcos', 'Ribeiro', 'Microeconomia', 'Economia');
CALL MatricularAluno('Mariana', 'Lima', 'Macroeconomia', 'Economia');
CALL MatricularAluno('Rafael', 'Costa', 'Introdução à Biologia', 'Biologia');
CALL MatricularAluno('Camila', 'Rodrigues', 'Genética e Biologia Molecular', 'Biologia');
CALL MatricularAluno('Fernando', 'Sousa', 'Ecologia e Biologia Ambiental', 'Biologia');
CALL MatricularAluno('Amanda', 'Cruz', 'Introdução à Literatura', 'Literatura');
CALL MatricularAluno('Paulo', 'Mendes', 'Estudos Shakespeareanos', 'Literatura');
CALL MatricularAluno('Laura', 'Dias', 'Literatura Americana Moderna', 'Literatura');
CALL MatricularAluno('Gustavo', 'Freitas', 'Introdução ao Marketing', 'Marketing');
CALL MatricularAluno('Isabela', 'Carvalho','Estratégias de Marketing Digital', 'Marketing');
CALL MatricularAluno('Thiago', 'Gomes', 'Comportamento do Consumidor', 'Marketing');
CALL MatricularAluno('Luiza', 'Nascimento', 'Introdução à Física', 'Física');
CALL MatricularAluno('Diego', 'Oliveira', 'Mecânica Clássica', 'Física');
CALL MatricularAluno('Raquel', 'Silveira', 'Física Quântica', 'Física');
CALL MatricularAluno('Felipe', 'Pereira', 'Introdução à História da Arte', 'História da Arte');
CALL MatricularAluno('Natália', 'Mendes', 'Arte Renascentista', 'História da Arte');
CALL MatricularAluno('Vinícius', 'Martins', 'Movimentos de Arte Moderna', 'História da Arte');
CALL MatricularAluno('Ana', 'Carvalho', 'Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL MatricularAluno('Bruno', 'Alves', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Carolina', 'Oliveira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Luciana', 'Santos', 'Introdução à Psicologia', 'Psicologia');
CALL MatricularAluno('Daniel', 'Pereira', 'Psicologia Social', 'Psicologia');
CALL MatricularAluno('Tatiane', 'Rodrigues', 'Psicologia do Desenvolvimento', 'Psicologia');
CALL MatricularAluno('Henrique', 'Ferreira', 'Introdução à Economia', 'Economia');
CALL MatricularAluno('Patrícia', 'Almeida', 'Microeconomia', 'Economia');
CALL MatricularAluno('Guilherme', 'Silva', 'Macroeconomia', 'Economia');
CALL MatricularAluno('Jéssica', 'Mendes', 'Introdução à Biologia', 'Biologia');
CALL MatricularAluno('Felipe', 'Santos', 'Genética e Biologia Molecular', 'Biologia');
CALL MatricularAluno('Vanessa', 'Lima', 'Ecologia e Biologia Ambiental', 'Biologia');
CALL MatricularAluno('Leonardo', 'Carvalho', 'Introdução à Literatura', 'Literatura');
CALL MatricularAluno('Isabela', 'Gomes', 'Estudos Shakespeareanos', 'Literatura');
CALL MatricularAluno('Rafael', 'Ferreira', 'Literatura Americana Moderna', 'Literatura');
CALL MatricularAluno('Aline', 'Santos', 'Introdução ao Marketing', 'Marketing');
CALL MatricularAluno('Marcelo', 'Oliveira', 'Estratégias de Marketing Digital', 'Marketing');
CALL MatricularAluno('Caroline', 'Silva', 'Comportamento do Consumidor', 'Marketing');
CALL MatricularAluno('Anderson', 'Rodrigues', 'Introdução à Física', 'Física');
CALL MatricularAluno('Bruna', 'Pereira', 'Mecânica Clássica', 'Física');
CALL MatricularAluno('Maria', 'Santos', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');							
CALL MatricularAluno('Pedro', 'Oliveira', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Ana', 'Pereira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Lucas', 'Fernandes', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Juliana', 'Martins', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Leandro', 'Amaro', 'Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL MatricularAluno('Maria', 'Santos', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');							
CALL MatricularAluno('Pedro', 'Oliveira', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Ana', 'Pereira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Lucas', 'Fernandes', 'Introdução à Psicologia', 'Psicologia');
CALL MatricularAluno('Juliana', 'Martins', 'Psicologia Social', 'Psicologia');
CALL MatricularAluno('Gabriel', 'Almeida', 'Psicologia do Desenvolvimento', 'Psicologia');
CALL MatricularAluno('Carla', 'Gonçalves', 'Introdução à Economia', 'Economia');
CALL MatricularAluno('Marcos', 'Ribeiro', 'Microeconomia', 'Economia');
CALL MatricularAluno('Mariana', 'Lima', 'Macroeconomia', 'Economia');
CALL MatricularAluno('Rafael', 'Costa', 'Introdução à Biologia', 'Biologia');
CALL MatricularAluno('Camila', 'Rodrigues', 'Genética e Biologia Molecular', 'Biologia');
CALL MatricularAluno('Fernando', 'Sousa', 'Ecologia e Biologia Ambiental', 'Biologia');
CALL MatricularAluno('Amanda', 'Cruz', 'Introdução à Literatura', 'Literatura');
CALL MatricularAluno('Paulo', 'Mendes', 'Estudos Shakespeareanos', 'Literatura');
CALL MatricularAluno('Laura', 'Dias', 'Literatura Americana Moderna', 'Literatura');
CALL MatricularAluno('Gustavo', 'Freitas', 'Introdução ao Marketing', 'Marketing');
CALL MatricularAluno('Isabela', 'Carvalho','Estratégias de Marketing Digital', 'Marketing');
CALL MatricularAluno('Thiago', 'Gomes', 'Comportamento do Consumidor', 'Marketing');
CALL MatricularAluno('Luiza', 'Nascimento', 'Introdução à Física', 'Física');
CALL MatricularAluno('Diego', 'Oliveira', 'Mecânica Clássica', 'Física');
CALL MatricularAluno('Raquel', 'Silveira', 'Física Quântica', 'Física');
CALL MatricularAluno('Felipe', 'Pereira', 'Introdução à História da Arte', 'História da Arte');
CALL MatricularAluno('Natália', 'Mendes', 'Arte Renascentista', 'História da Arte');
CALL MatricularAluno('Vinícius', 'Martins', 'Movimentos de Arte Moderna', 'História da Arte');
CALL MatricularAluno('Ana', 'Carvalho', 'Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação');
CALL MatricularAluno('Bruno', 'Alves', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Carolina', 'Oliveira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Luciana', 'Santos', 'Introdução à Psicologia', 'Psicologia');
CALL MatricularAluno('Daniel', 'Pereira', 'Psicologia Social', 'Psicologia');
CALL MatricularAluno('Tatiane', 'Rodrigues', 'Psicologia do Desenvolvimento', 'Psicologia');
CALL MatricularAluno('Henrique', 'Ferreira', 'Introdução à Economia', 'Economia');
CALL MatricularAluno('Patrícia', 'Almeida', 'Microeconomia', 'Economia');
CALL MatricularAluno('Guilherme', 'Silva', 'Macroeconomia', 'Economia');
CALL MatricularAluno('Jéssica', 'Mendes', 'Introdução à Biologia', 'Biologia');
CALL MatricularAluno('Felipe', 'Santos', 'Genética e Biologia Molecular', 'Biologia');
CALL MatricularAluno('Vanessa', 'Lima', 'Ecologia e Biologia Ambiental', 'Biologia');
CALL MatricularAluno('Leonardo', 'Carvalho', 'Introdução à Literatura', 'Literatura');
CALL MatricularAluno('Isabela', 'Gomes', 'Estudos Shakespeareanos', 'Literatura');
CALL MatricularAluno('Rafael', 'Ferreira', 'Literatura Americana Moderna', 'Literatura');
CALL MatricularAluno('Aline', 'Santos', 'Introdução ao Marketing', 'Marketing');
CALL MatricularAluno('Marcelo', 'Oliveira', 'Estratégias de Marketing Digital', 'Marketing');
CALL MatricularAluno('Caroline', 'Silva', 'Comportamento do Consumidor', 'Marketing');
CALL MatricularAluno('Anderson', 'Rodrigues', 'Introdução à Física', 'Física');
CALL MatricularAluno('Bruna', 'Pereira', 'Mecânica Clássica', 'Física');
CALL MatricularAluno('Maria', 'Santos', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');							
CALL MatricularAluno('Pedro', 'Oliveira', 'Estruturas de Dados e Algoritmos', 'Tecnologia da Informação');
CALL MatricularAluno('Ana', 'Pereira', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Lucas', 'Fernandes', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');
CALL MatricularAluno('Juliana', 'Martins', 'Fundamentos de Machine Learning', 'Tecnologia da Informação');


-- Testando a função ObterIdCurso:
SELECT ObterIdCurso('Análise e Desenvolvimento de Sistemas', 'Tecnologia da Informação') AS id_curso;

-- Testando a seleção de cursos:
CALL SelecionarCursos();

-- Testando se os alunos foram matriculados corretamente (com os emails gerados):
SELECT * FROM Alunos;