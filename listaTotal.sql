-- LISTA 1
-- 1 Criar um banco de dados Projetos
CREATE DATABASE Projetos;

\c Projetos;

-- 2 Crie o seguinte esquema do banco de dados Projetos
-- a Empregado (nome, cpf, data-nasc, sexo, salario, cpf_supervisor, dept)
CREATE TABLE
    Empregado (
        nome varchar(255) NOT NULL,
        cpf int PRIMARY KEY NOT NULL,
        data_nasc date NOT NULL,
        sexo char(1) NOT NULL,
        salario int NOT NULL,
        cpf_supervisor int,
        dept int
    );

-- b Departamento (nome, numero, cpf_gerente, data_inicio_gerencia)
CREATE TABLE
    Departamento (
        nome varchar(255) NOT NULL,
        numero int PRIMARY KEY NOT NULL,
        cpf_gerente int NOT NULL,
        data_inicio_gerencia date NOT NULL
    );

-- c Projeto (nome, numero, dept)
CREATE TABLE
    Projeto (
        nome varchar(255) NOT NULL,
        numero int PRIMARY KEY NOT NULL,
        dept int NOT NULL
    );

-- d Trabalha_Para (empregado, projeto, horas)
CREATE TABLE
    Trabalha_Para (
        empregado int NOT NULL,
        projeto int NOT NULL,
        horas TIME,
        PRIMARY KEY (empregado, projeto),
        FOREIGN KEY (empregado) REFERENCES Empregado (cpf),
        FOREIGN KEY (projeto) REFERENCES Projeto (numero)
    );

-- e Gerenciou (cpf, num-dept)
CREATE TABLE
    Gerenciou (
        cpf int,
        num_dep int,
        PRIMARY KEY (cpf, num_dep),
        FOREIGN KEY (cpf) REFERENCES Empregado (cpf),
        FOREIGN KEY (num_dep) REFERENCES Departamento (numero)
    );

-- 3 Inserir os seguintes registros em empregado:
INSERT INTO
    Empregado (
        nome,
        cpf,
        data_nasc,
        sexo,
        salario,
        cpf_supervisor,
        dept
    )
VALUES
    (
        'Arnaldo Silva',
        123456,
        '1928-02-21',
        'm',
        4000,
        333333,
        5
    ),
    (
        'Bruna Souza',
        654321,
        '1956-03-19',
        'f',
        2000,
        123456,
        5
    ),
    (
        'Carlos Pedrosa',
        333333,
        '1965-01-08',
        'm',
        1000,
        NULL,
        5
    ),
    (
        'Dulce Franco',
        123123,
        '1969-04-02',
        'f',
        1500,
        555555,
        2
    ),
    (
        'Eduardo Dias',
        555555,
        '1955-05-06',
        'm',
        2500,
        NULL,
        2
    ),
    (
        'Fernanda Cabral',
        444444,
        '1966-07-17',
        'f',
        3500,
        NULL,
        1
    );

-- 4 Inserir os seguintes registros em Departamento:
INSERT INTO
    Departamento (nome, numero, cpf_gerente, data_inicio_gerencia)
VALUES
    ('Pesquisa', 5, 333333, '1985-06-22'),
    ('Administracao', 2, 555555, '1989-08-04'),
    ('Ensino', 1, 444444, '1992-09-29');

-- 5 Inserir os seguintes registros em Projeto:
INSERT INTO
    Projeto (nome, numero, dept)
VALUES
    ('P1', 1, 5),
    ('P2', 2, 5),
    ('P1', 3, 1),
    ('P1', 4, 2),
    ('P3', 5, 5),
    ('P2', 6, 2);

-- 6 Inserir os seguintes registros em Gerenciou
INSERT INTO
    Gerenciou (cpf, num_dep)
VALUES
    (444444, 1),
    (333333, 5),
    (444444, 2),
    (555555, 2),
    (444444, 5);

-- 7 Inserir os seguintes registros em Trabalha_Para
INSERT INTO
    Trabalha_Para (empregado, projeto, horas)
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

-- LISTA 2
-- 1 Mostre os dados dos funcionários do depto 5 que são mulheres e não ganham mais de 2500
SELECT
    *
FROM
    Empregado
WHERE
    dept = 5
    AND sexo = 'f'
    AND salario <= 2500;

-- 2 Mostre os nomes e salários de todos os funcionários
SELECT
    nome,
    salario
FROM
    Empregado;

-- 3 Liste o nome e o salário dos funcionários do departamento 2
SELECT
    nome,
    salario
FROM
    Empregado
WHERE
    dept = 2;

-- 4 Mostre o nome do gerente do departamento 1
SELECT
    em.nome
FROM
    Empregado AS em
    LEFT JOIN Departamento AS de ON de.numero = em.dept
WHERE
    de.numero = 1
    AND em.cpf = de.cpf_gerente;

-- 5 Liste os CPFs dos funcionários que são gerentes
SELECT
    cpf_gerente
FROM
    Departamento;

-- 6 Mostre os CPFs dos que não são gerentes
SELECT
    em.cpf
FROM
    Empregado AS em
    LEFT JOIN Departamento as de ON em.cpf = de.cpf_gerente
WHERE
    de.cpf_gerente IS NULL;

-- 7 Liste os CPFs dos funcionários que são gerentes ou que ganham acima de 3000
SELECT
    de.cpf_gerente
FROM
    Departamento AS de
WHERE
    de.cpf_gerente IS NOT NULL
UNION
SELECT
    cpf
FROM
    Empregado
WHERE
    salario > 3000;

-- 8 Mostre os nomes e os salários dos empregados do departamento de ensino
SELECT
    em.nome,
    em.salario
FROM
    Empregado AS em
    LEFT JOIN Departamento AS de ON em.dept = de.numero
WHERE
    de.nome LIKE '%Ensino%';

-- 9 Mostre os nomes dos empregados que trabalham no projeto número 1
SELECT
    em.nome
FROM
    Empregado AS em
    LEFT JOIN Trabalha_Para AS tp ON em.cpf = tp.empregado
WHERE
    tp.projeto = 1;

-- 10 Liste os CPFs dos empregados que trabalham em todos os projetos do departamento 5
SELECT
    em.cpf
FROM
    Empregado AS em
WHERE
    em.dept = 5
    AND NOT EXISTS (
        SELECT
            p.numero
        FROM
            Projeto AS p
        WHERE
            NOT EXISTS (
                SELECT
                    tp.projeto
                FROM
                    Trabalha_Para AS tp
                WHERE
                    tp.empregado = em.cpf
                    AND tp.projeto = p.numero
            )
    );

-- 11 Mostre os nomes dos empregados supervisionados por Carlos Pedrosa
SELECT
    em.nome
FROM
    Empregado AS em
WHERE
    em.cpf_supervisor = 333333;

-- 12 Liste os nomes dos empregados que não trabalham em qualquer projeto
SELECT
    em.nome
FROM
    Empregado AS em
WHERE
    NOT EXISTS (
        SELECT
            tp.empregado
        FROM
            Trabalha_Para AS tp
        WHERE
            tp.empregado = em.cpf
    );

-- 13 Mostre CPFs dos que trabalham em pelo menos um projeto
SELECT DISTINCT
    em.nome
FROM
    Empregado AS em
    LEFT JOIN Trabalha_Para AS tp ON em.cpf = tp.empregado;

-- 14 Mostre os CPFs dos empregados que gerenciam algum departamento ou que não participam de qualquer projeto
SELECT
    de.cpf_gerente
FROM
    Departamento AS de
WHERE
    de.cpf_gerente IS NOT NULL
UNION
SELECT
    em.cpf
FROM
    Empregado AS em
WHERE
    em.cpf NOT IN (
        SELECT DISTINCT
            tp.empregado
        FROM
            Trabalha_Para AS tp
    );

-- 15 Mostre o valor total dos salários em cada departamento
SELECT
    dept,
    SUM(salario) AS soma_salarios
FROM
    Empregado
GROUP BY
    dept;

-- 16 Mostre a média dos salários pagos por departamento que possua mais de 5 empregados
SELECT
    dept,
    AVG(salario) AS media_salarios
FROM
    Empregado
GROUP BY
    dept
HAVING
    COUNT(*) > 5;

-- 17 Liste o maior salário de mulher de cada departamento com mais de 5 empregados do sexo feminino
SELECT
    dept,
    MAX(salario) AS maior_salario
FROM
    Empregado
WHERE
    sexo = 'f'
    AND dept IN (
        SELECT
            dept
        FROM
            Empregado
        WHERE
            sexo = 'f'
        GROUP BY
            dept
        HAVING
            COUNT(*) > 5
    )
GROUP BY
    dept;

-- LISTA 3
-- 1 Selecionar o nome do cliente, o contato, endereço da tabela cliente em que não tem endereço descrito.
SELECT
    nome,
    contato,
    endereco
FROM
    cliente
WHERE
    endereco IN NULL;

-- 2 Selecionar o nome do Cidade onde moram os clientes que possuem endereço descrito.
SELECT
    cidade_cliente
FROM
    cliente
WHERE
    endereco IS NOT NULL;

-- 3 Selecionar o primeiro registro de fornecedor da tabela fornecedores em que o preço unitário da peça é menor que R$ 2,00.
SELECT
    *
FROM
    fornecedores
WHERE
    preco_unitario < 2.00
ORDER BY
    preco_unitario
LIMIT
    1;

-- 4 Selecionar o nome dos fornecedores que moram na mesma cidade dos clientes que moram em Goiânia
SELECT DISTINCT
    f.nome_fornecedor
FROM
    fornecedores AS f
    JOIN cliente AS c ON f.cidade_fornecedor = c.cidade_cliente
WHERE
    c.cidade_cliente = 'Goiânia';

-- 5 Criar uma tabela que se chama compras, que possui id_cliente, cod_fornecedor, produto, quantidade_vendida.
CREATE TABLE
    compras (
        id_cliente int,
        cod_fornecedor int,
        produto varchar(255),
        quantidade_vendida int PRIMARY KEY (id_cliente, cod_fornecedor) FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) FOREIGN KEY (cod_fornecedor) REFERENCES fornecedores (cod_fornecedor)
    );

INSERT INTO
    compras (
        id_cliente,
        cod_fornecedor,
        produto,
        quantidade_vendida
    )
VALUES
    (1, 1, 'pregos', 1500),
    (2, 2, 'porcas', 2000),
    (2, 3, 'parafusos', 2500),
    (3, 4, 'placas de metal', 950),
    (3, 1, 'pregos', 500),
    (3, 3, 'parafusos', 200),
    (3, 2, 'porcas', 750);

-- 6 Infomar o total geral da compra de cada cliente.
SELECT
    id_cliente,
    SUM(quantidade_vendida) AS total_geral
FROM
    compras
GROUP BY
    id_cliente;

-- 7 Informar o valor médio de compra por produtos (parafusos, porcas, pregos, placas)
SELECT
    produto,
    AVG(quantidade_vendida) AS media_compra
FROM
    compras
GROUP BY
    produto;

-- 8 Selecionar todos os produtos que possuem preços entre R$ 0,50 e R$ 2,00
SELECT
    produto
FROM
    compras
WHERE
    preco_unitario BETWEEN 0.50 AND 2.00;

-- 9 Selecione todos os nomes das cidades das tabelas clientes e fornecedores.
SELECT
    cidade_cliente
FROM
    cliente
UNION
SELECT
    cidade_fornecedor
FROM
    fornecedores;

-- 10 Selecionar o total da quantidade de clientes que moram em Porto Alegre da tabela cliente
SELECT
    COUNT(*) AS total_clientes_porto_alegre
FROM
    cliente
WHERE
    cidade_cliente = 'Porto Alegre';