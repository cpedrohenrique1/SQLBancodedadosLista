-- 1
SELECT * FROM Empregado
WHERE dept = 5
AND sexo = 'f'
AND salario <= 2500;

-- 2
SELECT * FROM Empregado;

-- 3
SELECT nome, salario FROM Empregado
WHERE dept = 2;

-- 4
SELECT DISTINCT em.nome
FROM Empregado AS em
LEFT JOIN  Departamento AS de ON de.numero = dept
WHERE de.numero = 1
AND cpf_gerente = em.cpf;

-- 5
SELECT cpf_gerente
FROM Departamento;

-- 6
SELECT em.cpf FROM Empregado AS em
LEFT JOIN Departamento as de ON em.cpf = de.cpf_gerente
WHERE de.cpf_gerente IS NULL;

-- 7
SELECT de.cpf_gerente FROM Departamento AS de
WHERE de.cpf_gerente IS NOT NULL
UNION
SELECT cpf FROM Empregado
WHERE salario > 3000;

-- 8
SELECT em.nome, em.salario FROM Empregado AS em
