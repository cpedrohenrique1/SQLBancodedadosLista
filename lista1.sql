-- 1 Criar um banco de dados Projetos
CREATE DATABASE Projetos;

\c Projetos;

-- 2 Crie o seguinte esquema do banco de dados Projetos
-- a Empregado (nome, cpf, data-nasc, sexo, salario, cpf_supervisor, dept)
CREATE TABLE Empregado (
	nome varchar(255) NOT NULL,
    cpf int PRIMARY KEY NOT NULL,
    data_nasc date NOT NULL,
    sexo char(1) NOT NULL,
    salario int NOT NULL,
    cpf_supervisor int,
    dept int
);

-- b Departamento (nome, numero, cpf_gerente, data_inicio_gerencia)
CREATE TABLE Departamento (
	nome varchar(255) NOT NULL,
    numero int PRIMARY KEY NOT NULL,
    cpf_gerente int NOT NULL,
    data_inicio_gerencia date NOT NULL
);

-- c Projeto (nome, numero, dept)
CREATE TABLE Projeto (
    nome varchar(255) NOT NULL,
    numero int PRIMARY KEY NOT NULL,
    dept int NOT NULL
);

-- d Trabalha_Para (empregado, projeto, horas)
CREATE TABLE Trabalha_Para (
    empregado int NOT NULL,
    projeto int NOT NULL,
    horas TIME,
    PRIMARY KEY (empregado, projeto),
    FOREIGN KEY (empregado) REFERENCES Empregado(cpf),
    FOREIGN KEY (projeto) REFERENCES Projeto(numero)
);

-- e Gerenciou (cpf, num-dept)
CREATE TABLE Gerenciou (
    cpf int,
    num_dep int,
    PRIMARY KEY (cpf, num_dep),
    FOREIGN KEY (cpf) REFERENCES Empregado(cpf),
    FOREIGN KEY (num_dep) REFERENCES Departamento(numero)
);

-- 3 Inserir os seguintes registros em empregado:
INSERT INTO Empregado (nome, cpf, data_nasc, sexo, salario, cpf_supervisor, dept)
VALUES
('Arnaldo Silva', 123456, '1928-02-21', 'm', 4000, 333333, 5),
('Bruna Souza', 654321, '1956-03-19', 'f', 2000, 123456, 5),
('Carlos Pedrosa', 333333, '1965-01-08', 'm', 1000, NULL, 5),
('Dulce Franco', 123123, '1969-04-02', 'f', 1500, 555555, 2),
('Eduardo Dias', 555555, '1955-05-06', 'm', 2500, NULL, 2),
('Fernanda Cabral', 444444, '1966-07-17', 'f', 3500, NULL, 1);

-- 4 Inserir os seguintes registros em Departamento:
INSERT INTO Departamento (nome, numero, cpf_gerente, data_inicio_gerencia)
VALUES
('Pesquisa', 5, 333333, '1985-06-22'),
('Administracao', 2, 555555, '1989-08-04'),
('Ensino', 1, 444444, '1992-09-29');

-- 5 Inserir os seguintes registros em Projeto:
INSERT INTO Projeto (nome, numero, dept)
VALUES
('P1', 1, 5),
('P2', 2, 5),
('P1', 3, 1),
('P1', 4, 2),
('P3', 5, 5),
('P2', 6, 2);

-- 6 Inserir os seguintes registros em Gerenciou
INSERT INTO Gerenciou (cpf, num_dep)
VALUES
(444444, 1),
(333333, 5),
(444444, 2),
(555555, 2),
(444444, 5);

-- 7 Inserir os seguintes registros em Trabalha_Para
INSERT INTO Trabalha_Para (empregado, projeto, horas)
VALUES
(123456, 1, 12),
(123456, 2, 6),
(123456, 5, 8),
(654321, 2, 20),
(333333, 1, 40),
(123123, 4, 20),
(123123, 6, 20),
(555555, 4, 10),
(444444, 3, 40);