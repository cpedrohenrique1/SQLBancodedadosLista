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