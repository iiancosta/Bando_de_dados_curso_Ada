-- EXPLICAÇÃO DE TODOS OS CÓDIGOS NO READEME.md

-- Criando Tabelas
create table professores (
	id_professor integer,
	celular varchar (14),
	nome varchar (40),
	id_disciplinas integer,
	primary key (id_professor),
	foreign key (id_disciplinas)
	references disciplinas(id_disciplinas)
)

create table livro (
	id_livro integer,
	nome varchar (15),
	autor varchar (40),
	sinopse varchar (500),
	id_disciplinas integer,
	primary key (id_livro),
	foreign key (id_disciplinas)
	references disciplinas(id_disciplinas)
)

-- Inserindo dados
insert into disciplinas values
(1, 'portugues', 'literatura e gramatica'),
(2, 'matematica', 'algebra e geometria'),
(3, 'fisica', 'cinematica e dinamica');

COPY disciplinas(id_disciplinas, nome, ementa)
FROM '/caminho/para/seu/arquivo/dados.csv' 
DELIMITER ','
CSV HEADER;

-- Visualizando a tabela
select * from disciplinas;

-- Editando dados
update disciplinas set nome='biologia'
where id_disciplinas = 7

-- Removendo dados
delete from disciplinas
where id_disciplinas = 7

-- Criando uma View
CREATE VIEW diciplina_com_sigilo AS
SELECT nome, ementa
FROM disciplinas;

select * from diciplina_com_sigilo;

-- Permissão de acesso ao usuário
GRANT SELECT ON tabela TO usuario;
CREATE ROLE myrole;
GRANT myrole TO usuario;

-- Índices
CREATE INDEX indice_nome ON tabela_usada (coluna);

