create table Cidades (
	id		int			primary key,
	nome		varchar(60)		not null,
	populacao	int
);
create table Alunos (
	id		int			primary key,
	nome		varchar(60)		not null,
	data_nasc	date,
	cidade_id	int,

	foreign key (cidade_id) references Cidades (id)
);

insert into Cidades values (1, 'Arraial dos Tucanos', 42632);
insert into Cidades values (2, 'Springfield', 13820);
insert into Cidades values (3, 'Hill Valley', 27383);
insert into Cidades values (4, 'Coruscant', 19138);
insert into Cidades values (5, 'Minas Tirith', 31394);

insert into Alunos (id, nome, data_nasc, cidade_id) values (1, 'Immanuel Kant', '1724-04-22', 4);
insert into Alunos (id, nome, data_nasc, cidade_id) values (2, 'Alan Turing', '1912-06-23', 3);
Insert into Alunos (id, nome, data_nasc, cidade_id) values (3, 'George Boole', '2002-01-01', 1);
insert into Alunos (id, nome, data_nasc, cidade_id) values (4, 'Lynn Margulis', '1991-08-12', 3);
insert into Alunos (id, nome, data_nasc, cidade_id) values (5, 'Nicola Tesla', '2090-01-08', null);
insert into Alunos (id, nome, data_nasc, cidade_id) values (6, 'Ada Lovelace', '1976-05-28', 4);
insert into Alunos (id, nome, data_nasc, cidade_id) values (7, 'Claude Shannon', '1982-10-15', 3);
insert into Alunos (id, nome, data_nasc, cidade_id) values (8, 'Charles Darwin', '2010-02-06', null);
insert into Alunos (id, nome, data_nasc, cidade_id) values (9, 'Marie Curie', '2007-07-12', 3);
insert into Alunos (id, nome, data_nasc, cidade_id) values (10, 'Carl Sagan', '2000-11-20', 1);
insert into Alunos (id, nome, data_nasc, cidade_id) values (11, 'Tim Berners-Lee', '1973-12-05', 4);
insert into Alunos (id, nome, data_nasc, cidade_id) values (12, 'Richard Feynman', '1982-09-12', 1);
/*Seleciona todos os dados das tabelas:*/
SELECT * FROM Cidades;
SELECT * FROM Alunos;
/*Seleciona o Inner Join:*/
SELECT * FROM Alunos Inner Join Cidades ON cidade_id = Alunos.cidade_id;
/*Seleciona o Left Join:*/
Select * From Alunos left JOIN Cidades ON cidade_id = Alunos.cidade_id;
/*Seleciona o Right Join:*/
Select * From Alunos Right JOIN Cidades ON cidade_id = Alunos.cidade_id;
/*Seleciona uma coluna como Alias:*/
SELECT nome as "Nome", data_nasc as "Data de nascimento" from Alunos;

