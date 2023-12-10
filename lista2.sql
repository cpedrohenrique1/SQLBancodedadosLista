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
    em.dept = 5;

-- 11 Mostre os nomes dos empregados supervisionados por Carlos Pedrosa
SELECT
    em.nome
FROM
    Empregado AS em
WHERE EXISTS (
    SELECT
        *
    FROM
        Empregado AS em2
    WHERE
        em2.cpf = em.cpf_supervisor
        AND em2.nome = 'Carlos Pedrosa'
);

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