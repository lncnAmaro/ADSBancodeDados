CREATE TABLE Pedidos (
IDPedido 		INT 		AUTO_INCREMENT		 PRIMARY KEY,
DataPedido 		DATETIME,
NomeCliente 	VARCHAR(100)
);
INSERT INTO Pedidos (DataPedido, NomeCliente) VALUES
(NOW(), 'Cliente 1'),
(NOW(), 'Cliente 2'),
(NOW(), 'Cliente 3');

/*Criando a Trigger*/
DELIMITER $
CREATE TRIGGER RegistroDataCriacaoPedido
BEFORE INSERT ON Pedidos
FOR EACH ROW
BEGIN
SET NEW.DataPedido = NOW();
END;
$
DELIMITER ;

/*Insere um novo cliente sem fornecer a data*/
INSERT INTO Pedidos (NomeCliente) VALUES ('Novo Cliente');

/*Testando a Trigger vendo o resultado*/
SELECT * FROM Pedidos;
